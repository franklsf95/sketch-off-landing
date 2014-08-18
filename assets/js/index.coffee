---
---
modes = {
    ADR: 0,
    iOS: 1
}
submit_mode = modes.ADR
# base_url = 'http://0.0.0.0:3000'
base_url = 'http://inception-landing.herokuapp.com'
$input = $('#input-text')
$output = $('#output')
$prefix = $('#input-prefix')
$btnSubmit = $('#btn-submit')
$appstore = $('.appstore')
$android = $('.android')
$boxes = $('.boxes').children()

renderMode = ->
    uaStr = navigator.userAgent
    if submit_mode == modes.ADR
        $android.addClass 'active'
        $appstore.removeClass 'active'
    else if submit_mode == modes.iOS
        $appstore.addClass 'active'
        $android.removeClass 'active'

slider = $('.bxslider').bxSlider
    mode: 'fade'
    controls: false
    pager: false
    auto: true
    pause: 3000
    onSlideNext: (_, o, n) -> slideChange(o, n)
    onSlidePrev: (_, o, n) -> slideChange(o, n)

slideChange = (oldIndex, newIndex) ->
    $($boxes[oldIndex]).removeClass 'active'
    $($boxes[newIndex]).addClass 'active'

$boxes.click ->
    slider.goToSlide this.dataset.index
    $boxes.removeClass 'active'
    $(this).addClass 'active'

$('#appstore').click (e) ->
    # if iOS, allow link
    if submit_mode == modes.ADR
        submit_mode = modes.iOS
        e.preventDefault()
    renderMode()

$('#android').click ->
    # if ADR, do nothing
    if submit_mode == modes.iOS
        submit_mode = modes.ADR
    renderMode()

$btnSubmit.click -> submitEmail()

submitEmail = ->
    $output.slideUp()
    $.ajax
        type: 'POST'
        url: base_url + '/submit'
        crossDomain: true
        data:
            email: $input.val()
        error: (xhr) ->
            err = $.parseJSON xhr.responseText
            console.log err
            if err.name == 'MongoError' and err.code == 11000
                $output.html 'You have already signed up!'
            else
                $output.html 'Error occured when signing up.'
            $output.slideDown()
        success: (xhr) ->
            $output.html 'Great! We will send you an email when we launch!'
            $output.slideDown()
