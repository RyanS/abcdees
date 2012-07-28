window.app = {}
numOfBoxes = 26
$main = $('#main')
letterCodes = [97..122]

randomizeLetters = ->
  arr = letterCodes
  i = arr.length
  if i is 0 then return false

  while --i
    j = Math.floor(Math.random() * (i+1))
    [arr[i], arr[j]] = [arr[j], arr[i]] # use pattern matching to swap

  init()

resetLetters = ->
  letterCodes = [97..122]
  init()

setupLetters = ->
  app.$container = $('<div id="container"/>')
  app.$container.append("<div class='grid-box'><span>&\##{letter.toString()}</span></div>") for letter in letterCodes

  $main.append(app.$container)

setupGrid = ->
  $letters = app.$container.children()
  horizontal = innerWidth > innerHeight
  totalArea = innerWidth * innerHeight
  area = totalArea/numOfBoxes
  whRatio = innerWidth / innerHeight
  
  height = Math.floor(Math.sqrt(area/whRatio))
  width = Math.floor(height * whRatio)

  #Need to account for rounding and float issues
  columns = Math.floor innerWidth/width
  rows = Math.ceil numOfBoxes/columns

  #i think it safe to assume that 'z' will always fall below the fold so fix that
  columns += 1
  width = Math.floor(innerWidth/columns)

  app.height = height
  app.width  = width

  $letters.css(
    width: "#{width}px"
    height: "#{height}px"
    'font-size': "#{if horizontal then height else width}px"
    'line-height': "#{height}px"
  )
  
  app.grid = []
  rowPos = 0
  $letters.each((i) ->
    app.grid[rowPos] = [] if i%columns is 0
    app.grid[rowPos][i%columns] = $(@)
    rowPos += 1 if i%columns is columns - 1
  )

init = ->
  app.$container?.remove()
  setupLetters()
  setupGrid()

init()

#Ganked from http://underscorejs.org/docs/underscore.html#section-58
debounce = (func, wait, immediate) ->
    timeout = null
    ->
      context = @
      args = arguments
      later = ->
        timeout = null
        func.apply(context, args) unless immediate

      func.apply(context, args) if (immediate && !timeout)
      clearTimeout(timeout)
      timeout = setTimeout(later, wait)


if Modernizr.deviceorientation
  $(window).on('orientationchange', setupGrid)
else
  $(window).on('resize', debounce(setupGrid, 250))

app.Events =
  down: if Modernizr.touch then "touchstart" else "mousedown"
  up:   if Modernizr.touch then "touchend"   else "mouseup"
  move: if Modernizr.touch then "touchmove"  else "mousemove"

gridIndex = (x, y) ->
  [Math.floor(y/app.height), Math.floor(x/app.width)]

locateLetter = (x, y) ->
  gi = gridIndex(x,y)
  app.grid[gi[0]][gi[1]]

$selected = ''
selectElement = (e) ->
  e = e.touches[0] if Modernizr.touch
  $el = locateLetter(e.pageX, e.pageY)
  return if $el is $selected
  $selected.removeClass('selected').addClass('fade') if $selected
  $selected = $el.addClass('selected')

app.$db = $(document.body)
app.$db.
  on(app.Events.down, '#container div', selectElement).
  on('touchmove.finding', '#container div', selectElement)

#prevent rubber band scrolling
$(document).on('touchmove', (e) -> e.preventDefault())

$config = $('#config')
$('#launch_config').on(app.Events.down, -> $config.toggleClass('visible'))

$('#shuffle').on(app.Events.down, randomizeLetters)
$('#reset').on(app.Events.down, resetLetters)

$('#font').on 'change', ->
  app.$db.css('font-family', $(@).val())
  



  
