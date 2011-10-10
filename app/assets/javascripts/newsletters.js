jQuery(document).ready(function($) {

  $('a#deliver_batch').click(function(e){
    e.preventDefault();
    top.Mercury.trigger('action', {action: 'save'});

    var url = $(this).attr('href');
    var recipient_groups = get_recipient_groups();
    if($('#batch_size').val() <= 0){ alert('Batch size cant be 0!'); return false;}
    if($('#batch_size').val() > parseInt($('#batch_size').attr('data-max'))){ alert('Batch size cant be over group count!'); return false;}
    if(recipient_groups.length == 1){
      var newsletter_id = $("#newsletter").attr('data-id');
      var answer = prompt('Are you sure? Type "BATCH"');
      var batch_size = parseInt($('#batch_size').val());
      if(answer == "BATCH"){
        $.ajax({
          url:  url,
          type: 'POST',
          data: {'_method': 'PUT', 'answer': answer, 'recipient_group': recipient_groups[0], 'batch_size': batch_size},
          success: function(data){
            $("#flash").html(data).show().hide("fade", {}, 1000);
            $(".deliverbutton").remove();
            $('.groups').remove();
          }
        });
      }
    } else{
      alert('You have to select 1 (one) group to send to!');
    }
  });

  $('a#deliver').click(function(e){
    e.preventDefault();
    top.Mercury.trigger('action', {action: 'save'});
    var url = $(this).attr('href');
    var recipient_groups = get_recipient_groups();
    if(recipient_groups.length > 0){
      var newsletter_id = $("#newsletter").attr('data-id');
      var answer = prompt('Are you sure? Type "DELIVER"');
      if(answer == "DELIVER"){
        $.ajax({
          url:  url,
          type: 'POST',
          data: {'_method': 'PUT', 'answer': answer, 'recipient_groups[]': recipient_groups},
          success: function(data){
            $("#flash").html(data).show().hide("fade", {}, 1000);
            $(".deliverbutton").remove();
            $('.groups').remove();
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
    var to = prompt('to what email?');
    $.ajax({
      url:  url,
      type: 'POST',
      data: {'_method': "PUT", 'to': to},
      success: function(data){
        $("#flash").html(data).show().hide("fade", {}, 1000);
      }
    });
  });

  $('#groupform input[type=checkbox]').change(function(){
    group_length = get_recipient_groups().length;
    if(group_length > 0){
      $('.deliverbutton').show();
      if(group_length > 1){
        $('li.range').hide();
      }
      set_batch_size();
    } else {
      $('.deliverbutton').hide();
    }
  });

});


var set_batch_size = function(){
  max_batch_size = get_maximum_batch_size();
  $('#batch_size').val(0);
  $('#batch_size').attr('data-max', max_batch_size);
}

var get_recipient_groups = function(){
  var recipient_groups = [];

  $('#groupform input[type=checkbox]').each(function(){
    if($(this).is(':checked')){
      recipient_groups.push($(this).val());
    }
  });
  return recipient_groups;
}

var get_maximum_batch_size = function(){
  var max_size = 0;
  $('#groupform input[type=checkbox]').each(function(){
    if($(this).is(':checked')){
      max_size = max_size + parseInt($(this).attr('data-max'));
    }
  });
  console.log('MAXIMUM SIZE '+ max_size);
  return max_size;
}