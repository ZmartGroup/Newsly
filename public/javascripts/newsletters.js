jQuery(document).ready(function($) {


  if (top.Mercury) {
  window.Mercury = top.Mercury;
  Mercury.PageEditor.prototype.save = function() {
    var data = this.serialize();
    var newsletter_id = $("#newsletter").attr('data-id');
    $.ajax({
      url:  $("#newsletter").attr('data-url'),
      type: 'POST',
      data: {newsletter: {title: data.title.value, body: data.body.value, text_body: data.text_body.value}, '_method': 'PUT'},
      success: function(data){
        $('#saved').html(data);
      }
    });
  }};

  $('a#deliver').click(function(e){
  	e.preventDefault();
    top.Mercury.trigger('action', {action: 'save'});
    
    var recipient_groups = [];

    $('#groupform input[type=checkbox]').each(function(){
      if($(this).is(':checked')){
        recipient_groups.push($(this).val());
      }
    });
    
    if(recipient_groups.length > 0){
      var newsletter_id = $("#newsletter").attr('data-id');
      var answer = prompt('Are you sure? Type "DELIVER"');
      var url = $(this).attr('href');
      if(answer == "DELIVER"){
        $.ajax({
          url:  url,        
          type: 'POST',
          data: {'_method': 'PUT', 'answer': answer, 'recipient_groups[]': recipient_groups},
          success: function(data){
            $("#flash").html(data).hide("fade", {}, 1000);
          }
        });
      } 
    } else{
      alert('You have to select atleast one group to send to!');
    }
  });

  $('a#send_test').click(function(e){
  	e.preventDefault();
    top.Mercury.trigger('action', {action: 'save'});    
	 	var newsletter_id = $("#newsletter").attr('data-id');
    var url = $(this).attr('href');    
  	$.ajax({
      url:  url,
			type: 'POST',
			data: {'_method': "PUT"},
			success: function(data){
				$("#flash").html(data).hide("fade", {}, 1000);
			}
		});	
  });

});