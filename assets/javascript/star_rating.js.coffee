#provides an rating-bar with stars
# depends on custom radio buttons with checkboxes, see partial shared/star_rating

$.fn.star_rating = () ->
  el = $(@)
  labels = $('label', el)
  
  starOver = ->  
    clicked = labels.filter(".clicked") 
    index_hovered = labels.index(@) + 1
    
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
  #TODO: make this method available externaly!
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
      # the internal click event has a delay
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
