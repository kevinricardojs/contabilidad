$(document).ready(function(){

	var noticia = $('#notice');
	var alerta = $('#alert');

	if (!$(notice).text()  == "") {
		$("#notice").animate({
			top: "10%"});
		$('#notice').delay(4000).fadeOut(2000);
	};

	var objeto = $('.jumbotron .objeto');

	$(objeto).mouseenter(function() {
		var popover = $(this).children("div");
		$(popover).slideDown(400);
	});

	$(objeto).mouseleave(function() {
		var popover = $(this).children("div");
		$(popover).mouseleave(function() {
			$(this).slideUp(400);
		});;
	});

})