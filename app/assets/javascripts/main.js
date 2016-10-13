/*price range*/

 // $('#sl2').slider();

	// var RGBChange = function() {
	//   $('#RGB').css('background', 'rgb('+r.getValue()+','+g.getValue()+','+b.getValue()+')')
	// };
/*scroll to top*/

// $(document).ready(function(){
// 	$(function () {
// 		$.scrollUp({
// 	        scrollName: 'scrollUp', // Element ID
// 	        scrollDistance: 300, // Distance from top/bottom before showing element (px)
// 	        scrollFrom: 'top', // 'top' or 'bottom'
// 	        scrollSpeed: 300, // Speed back to top (ms)
// 	        easingType: 'linear', // Scroll to top easing (see http://easings.net/)
// 	        animation: 'fade', // Fade, slide, none
// 	        animationSpeed: 200, // Animation in speed (ms)
// 	        scrollTrigger: false, // Set a custom triggering element. Can be an HTML string or jQuery object
// 					//scrollTarget: false, // Set a custom target element for scrolling to the top
// 	        scrollText: '<i class="fa fa-angle-up"></i>', // Text for element, can contain HTML
// 	        scrollTitle: false, // Set a custom <a> title if required.
// 	        scrollImg: false, // Set true to use image
// 	        activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
// 	        zIndex: 2147483647 // Z-Index for the overlay
// 		});
// 	});
// });
$(function () {
  var all_classes = "";
  var timer = undefined;
  $.each($('li', '.social-class'), function (index, element) {
    all_classes += " btn-" + $(element).data("code");
  });
  $('li', '.social-class').mouseenter(function () {
    var icon_name = $(this).data("code");
    if ($(this).data("icon")) {
      icon_name = $(this).data("icon");
    }
    var icon = "<i class='fa fa-" + icon_name + "'></i>";
    $('.btn-social', '.social-sizes').html(icon + "Sign in with " + $(this).data("name"));
    $('.btn-social-icon', '.social-sizes').html(icon);
    $('.btn', '.social-sizes').removeClass(all_classes);
    $('.btn', '.social-sizes').addClass("btn-" + $(this).data('code'));
  });
  $($('li', '.social-class')[Math.floor($('li', '.social-class').length * Math.random())]).mouseenter();
});