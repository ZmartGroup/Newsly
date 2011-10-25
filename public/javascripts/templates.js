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
        data: {template: {subject: data.subject.value, body: data.body.value}, '_method': 'PUT'},
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

  $('.type_tabs a').click(function(e){
    e.preventDefault();
    template_type = ''+$(this).attr('data-type')+'';
    $('.type_tabs li').removeClass('active'); 
    $('table#templates tr').hide();
    $(this).parent('li').addClass('active');
    if(template_type != "undefined"){
      $('table#templates tr.'+template_type+'').show();
    } else {
      $('table#templates tr').show();
    }
  });

});