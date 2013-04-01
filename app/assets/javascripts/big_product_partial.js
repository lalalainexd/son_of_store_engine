$(document).ready(function(){
  $(".small_product").click(function(){
    $('.big_product').hide();
    var current_id = $(this).attr('id');
    $("#big_product_"+current_id).css({
      "position":"absolute", 
      "top": "200px",
      "left": "350px",
    });
    $("#big_product_"+current_id).fadeIn(200);
  });

  $(".big_product_title").click(function(){
    $('.big_product').fadeOut(200);
  });

  $(document).click(function(e){
    var elem = $(e.target).attr('class');
    if((elem == 'big_product') || (elem == 'small_product')){
      //nothing
    }else{
      $('.big_product').fadeOut(200)
    }
  });

});
