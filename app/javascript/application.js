// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./jquery"
import "controllers"
$(document).ready(function() {

  $('form').on('click', '.remove_order_item', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('div').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_order_item', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('#tasks').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });

  $(function () {
    $("#onchange").on('change', function(){
      var value = $(".select").val();
      var quantity = $(".quantity").val();
      var dis = $("#discounts").data('discounts');  
      var disc_quant = $("#discounts").data('disc_quant');   
      console.log(disc_quant); 
      for(var i = 0; i <= dis.length; i++){
        if (value == dis[i])// && quantity == disc_quant ) { 
        {
        alert ("offer apply");
        }
      }
    }); 
  });
});