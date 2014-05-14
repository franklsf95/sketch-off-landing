(function() {
  var $out, base_url, slider, submit;

  slider = $('.bxslider').bxSlider({
    mode: 'fade',
    controls: false,
    pager: false,
    auto: true,
    pause: 3000,
    autoHover: true
  });

  base_url = 'http://inception-landing.herokuapp.com';

  $out = $('#output');

  submit = function() {
    $out.slideUp();
    return $.ajax({
      type: 'POST',
      url: base_url + '/submit',
      crossDomain: true,
      data: {
        email: $('#input-email').val()
      },
      error: function(xhr) {
        var err;
        err = $.parseJSON(xhr.responseText);
        if (err.name === 'MongoError' && err.code === 11000) {
          $out.html('You have already signed up!');
        } else {
          $out.html('Error occured when signing up.');
        }
        return $out.slideDown();
      },
      success: function(xhr) {
        $out.html('Great! We will send you an email when we launch!');
        return $out.slideDown();
      }
    });
  };

  $('#btn-sign-up').click(function() {
    return submit();
  });

}).call(this);
