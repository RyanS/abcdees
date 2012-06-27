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

  #i think it save to assume that 'z' will always fall below the fold so fix that
  columns += 1
  width = Math.floor(innerWidth/columns)

  $letters.css(
    width: "#{width}px"
    height: "#{height}px"
    'font-size': "#{if horizontal then height else width}px"
    'line-height': "#{height}px"
  )

setupLetters()
setupGrid()

$(window).on('orientationchange', setupGrid)
$(document.body).on('doubleTap', randomizeLetters)

  
