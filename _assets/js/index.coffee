# base_url = 'http://0.0.0.0:3000'
base_url = 'http://inception-landing.herokuapp.com'
$out = $('#output')

submitForm = ->
    $out.hide()
    $.ajax
        type: 'POST'
        url: base_url + '/submit'
        crossDomain: true
        data:
            name: $('#input-name').val()
            email: $('#input-email').val()
            school: $('#input-school').val()
        error: (xhr) ->
            err = $.parseJSON xhr.responseText
            if err.name == 'MongoError' and err.code == 11000
                $out.html 'You have already subscribed!'
            else
                $out.html 'Error occured when subscribing.'
            $out.slideDown()
        success: (xhr) ->
            $out.html 'You have successfully signed up!'
            $out.slideDown()

$ ->
    # slider = $('.slider').bxSlider
    #     mode: 'vertical'
    #     controls: false
    #     auto: true
    # $('body').keydown (e) ->
    #     k = e.keyCode
    #     if k >= 37 and k <= 40
    #         e.preventDefault()
    #     switch (k)
    #         when 37 then slider.goToPrevSlide()  # left
    #         when 38 then slider.goToPrevSlide()  # up
    #         when 39 then slider.goToNextSlide()  # right
    #         when 40 then slider.goToNextSlide()  # down
    $('#input-submit').click (e) ->
        e.preventDefault()
        submitForm()


    # prevScrollTop = 0
    # $(window).scroll (e) ->
    #     e.preventDefault()
    #     st = $(this).scrollTop()
    #     if st - prevScrollTop > 10
    #         slider.goToNextSlide()
    #     else if st - prevScrollTop < -10
    #         slider.goToPrevSlide()
    #     prevScrollTop = st
    #     window.scrollTo 0, 0
