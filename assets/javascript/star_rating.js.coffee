# provides a rating-bar with stars
# requires jQuery
# depends on custom radio buttons, overlayed by labels, see partial views/star_rating

$.fn.star_rating = () ->
  el = $(@)
  labels = $('label', el)
  
  # hover effects
  starOver = ->  
    clicked = labels.filter(".clicked") 
    index_hovered = labels.index(@) + 1
    
    # if a star is already clicked, only apply hover-effect to stars to the right
    if clicked.length > 0
      index_clicked = labels.index(clicked) + 1
      if index_clicked >= index_hovered
        labels.filter(":lt(" + index_clicked + ")").addClass "hover"
        labels.filter(":gt(" + index_clicked + ")").removeClass "hover clicked"
      else
        labels.filter(":lt(" + index_hovered + ")").addClass "hover"
    else
      labels.removeClass "hover"
      labels.filter(":lt(" + index_hovered + ")").addClass "hover"

  starOut = ->
    labels.filter(":gt(#{labels.index(@)} - 1)").removeClass('hover clicked')

  #reset to the last clicked state after mouse leaves the bar
  starReset = ->
    clicked = el.find(".clicked")
    if clicked.length > 0
      clicked_index = labels.index(clicked)
      labels.removeClass "hover"
      labels.filter(":lt(" + clicked_index + ")").addClass "hover"
    else
      labels.removeClass "hover clicked"


  starClick = () ->
    if $(@).hasClass('clicked')
      # unselect/reset when clicking upon the clicked star
      labels.removeClass('clicked hover')
      # the browser-internal click event has a delay, so a little timeout is required
      self.setTimeout =>   
        $('input[type=radio]:checked', el).attr('checked', false)
      , 50
    else
      labels.removeClass('clicked hover')
      $(@).addClass('clicked')
      _index = labels.index(@) 
      labels.filter(":lt(" + _index + ")").addClass "hover"

  #init hover and click events
  labels.hover(starOver, starOut).click starClick
  el.mouseleave(starReset) 
