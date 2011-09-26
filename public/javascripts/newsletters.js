jQuery(document).ready(function($) {


  if (top.Mercury) {
  window.Mercury = top.Mercury;
  Mercury.PageEditor.prototype.save = function() {
    var data = this.serialize();
    var newsletter_id = $("#newsletter").attr('data-id');
    $.ajax({
      url:  $("#newsletter").attr('data-url'),
      type: 'POST',
      data: {newsletter: {title: data.title.value, body: data.body.value}, '_method': 'PUT'},
      success: function(data){
        $('#saved').html(data);
      }
    });
  }};

  $('a#deliver').click(function(e){
  	e.preventDefault();
    top.Mercury.trigger('action', {action: 'save'});
		var newsletter_id = $("#newsletter").attr('data-id');
  	var answer = prompt('Are you sure? Type "DELIVER"');
    var url = $(this).attr('href');
  	if(answer == "DELIVER"){
  		$.ajax({
        url:  url,        
  			type: 'POST',
  			data: {'_method': 'PUT', 'answer': answer},
  			success: function(data){
  				alert(data);
  			}
  		});
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
				alert(data);
			}
		});	
  });

});