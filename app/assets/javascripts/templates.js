jQuery(document).ready(function($) {

  $('a.remote').click(function(e){
    e.preventDefault();
    top.Mercury.trigger('action', {action: 'save'});
    var template_id = $("#template").attr('data-id');
    if($(this).attr('id') != "publish"){
      var to = prompt('to what email?');
    } else {
      var to = "";
    }
    var url = $(this).attr('href');
    $.ajax({
      url:  url,
      type: 'POST',
      data: {'_method': "PUT", 'to': to},
      success: function(data){
        $("#flash").html(data).show().hide("fade", {}, 1000);
      }
    });
  });

});