jQuery(document).ready(function($) {

  if (top.Mercury) {
    //top.Mercury.saveURL = $("#template").attr('data-url');
    //top.Mercury.saveStyle = "form";
    window.Mercury = top.Mercury;
    Mercury.PageEditor.prototype.save = function() {
      var data = this.serialize();
      var template_id = $("#template").attr('data-id');
      $.ajax({
        url:  $("#template").attr('data-url'),
        type: 'POST',
        data: {template: {subject: data.subject.value, body: data.body.value, text_body: data.text_body.value}, '_method': 'PUT'},
        success: function(data){
          $('#saved').html(data);
        }
      });
    }
  }

  $('a.remote').click(function(e){
    e.preventDefault();
    top.Mercury.trigger('action', {action: 'save'});
    var template_id = $("#template").attr('data-id');
    var url = $(this).attr('href');
    $.ajax({
      url:  url,
      type: 'POST',
      data: {'_method': "PUT", },
      success: function(data){
        $("#flash").html(data).effect('fade');
      }
    });
  });

});