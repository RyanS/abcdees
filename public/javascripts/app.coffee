app = {}
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

  $('ul').remove()
  setupLetters()
  setupGrid()

setupLetters = ->
  $ul = $('<ul/>')
  $ul.append("<li><span>&\##{letter.toString()}</span></li>") for letter in letterCodes

  $main.append($ul)

setupGrid = ->
  $letters = $main.find('li')
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
    app.grid[rowPos][i%columns] = $(this)
    rowPos += 1 if i%columns is columns - 1
  )

setupLetters()
setupGrid()

$(window).on('orientationchange', setupGrid)

$selected = ''


app.Events =
  down: if Modernizr.touch then "touchstart" else "mousedown"
  up:   if Modernizr.touch then "touchend"   else "mouseup"
  move: if Modernizr.touch then "touchmove"  else "mousemove"

selectElement = (e) ->
  e = e.touches[0] if Modernizr.touch
  $el = app.grid[Math.floor(e.pageY/app.height)][Math.floor(e.pageX/app.width)]
  return if $el is $selected
  $selected.removeClass('selected').addClass('fade') if $selected
  $selected = $el.addClass('selected')

$(document.body).
  on(app.Events.down, 'li', selectElement).
  on('touchmove', 'li', selectElement)

#prevent rubber band scrolling
$(document).on('touchmove', (e) -> e.preventDefault())

$config = $('#config')
$('#launch_config').on(app.Events.down, -> $config.toggleClass('visible'))

$('#shuffle').on(app.Events.down, randomizeLetters)


$('#font').on 'change', ->
  $(document.body).css('font-family', $(this).val())
  



  
