jQuery(document).ready(function($) {


  if (top.Mercury) {
  window.Mercury = top.Mercury;
  Mercury.PageEditor.prototype.save = function() {
    var data = this.serialize();
    var template_id = $("#template").attr('data-id');
    $.ajax({
      url:  $("#template").attr('data-url'),
      type: 'POST',
      data: {template: {subject: data.subject.value, body: data.body.value}, '_method': 'PUT'},
      success: function(data){
        alert(data);
        //window.location = "/templates";
      }
    });
  }};

  $('a#send_template_test').click(function(e){
  	e.preventDefault();
		var template_id = $("#template").attr('data-id');
    var url = $(this).attr('href');    
  	$.ajax({
			url:  url,
			type: 'POST',
			data: {'_method': "PUT", },
			success: function(data){
				alert(data);
			}
		});
  });

});