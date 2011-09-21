jQuery(document).ready(function($) {


  if (top.Mercury) {
  window.Mercury = top.Mercury;
  Mercury.PageEditor.prototype.save = function() {
    var data = this.serialize();
    var template_id = $("#template").attr('data-id');
    var title   = data.title.value;
    var body    = data.body.value;
    $.ajax({
      url: '/templates/'+template_id,
      type: 'POST',
      data: {template: {subject: title, body: body}, '_method': 'PUT'},
      success: function(data){
        alert(data);
        //window.location = "/templates";
      }
    });
  }};

  $('a#deliver').click(function(e){
  	e.preventDefault();
  	saveNewsletter();
		var newsletter_id = $("#newsletter").attr('data-id');
  	var answer = prompt('Are you sure? Type "DELIVER"');
  	if(answer == "DELIVER"){
  		$.ajax({
  			url: '/newsletters/'+newsletter_id+'/deliver',
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
  	saveNewsletter();
	 	var newsletter_id = $("#newsletter").attr('data-id');
  	$.ajax({
			url: '/newsletters/'+newsletter_id+'/send_test',
			type: 'POST',
			data: {'_method': "PUT"},
			success: function(data){
				alert(data);
			}
		});	
  });

  $('a#send_template_test').click(function(e){
  	e.preventDefault();
		var template_id = $("#template").attr('data-id');
  	$.ajax({
			url: '/templates/'+template_id+'/send_test',
			type: 'POST',
			data: {'_method': "PUT", },
			success: function(data){
				alert(data);
			}
		});
  });

});

function saveNewsletter(){
	var newsletter_id = $("#newsletter").attr('data-id');
	var title 	= $("title").html();
	var body 		= $("body").html();
	$.ajax({
		url: '/newsletters/'+newsletter_id,
		type: 'PUT',
		data: {newsletter: {title: title, body: body}},
		success: function(data){
			$("#saved").html(data);
		}
	});
}