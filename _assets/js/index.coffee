slider = $('.bxslider').bxSlider
    mode: 'fade'
    controls: false
    pager: false
    # auto: true
    pause: 3000

base_url = 'http://inception-landing.herokuapp.com'
$out = $('#output')
submit = ->
    $out.slideUp()
    $.ajax
        type: 'POST'
        url: base_url + '/submit'
        crossDomain: true
        data:
            email: $('#input-email').val()
        error: (xhr) ->
            err = $.parseJSON xhr.responseText
            if err.name == 'MongoError' and err.code == 11000
                $out.html 'You have already signed up!'
            else
                $out.html 'Error occured when signing up.'
            $out.slideDown()
        success: (xhr) ->
            $out.html 'Great! We will send you an email when we launch!'
            $out.slideDown()


$('#btn-sign-up').click -> submit()
