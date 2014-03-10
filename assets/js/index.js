(function() {
  var $out, base_url, submitForm;

  base_url = 'http://inception-landing.herokuapp.com';

  $out = $('#output');

  submitForm = function() {
    $out.hide();
    return $.ajax({
      type: 'POST',
      url: base_url + '/submit',
      crossDomain: true,
      data: {
        name: $('#input-name').val(),
        email: $('#input-email').val(),
        school: $('#input-school').val()
      },
      error: function(xhr) {
        var err;
        err = $.parseJSON(xhr.responseText);
        if (err.name === 'MongoError' && err.code === 11000) {
          $out.html('You have already subscribed!');
        } else {
          $out.html('Error occured when subscribing.');
        }
        return $out.slideDown();
      },
      success: function(xhr) {
        $out.html('You have successfully signed up!');
        return $out.slideDown();
      }
    });
  };

  $(function() {
    return $('#input-submit').click(function(e) {
      e.preventDefault();
      return submitForm();
    });
  });

}).call(this);
