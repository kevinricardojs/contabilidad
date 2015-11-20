$(document).ready(function(){
	$("select").addClass('form-control');
	var noticia = $('#notice');
	var alerta = $('#alert');

	if (!$(notice).text()  == "") {
		$("#notice").animate({
			top: "10%"});
		$('#notice').delay(4000).fadeOut(2000);
	};

	var objeto = $('.jumbotron .objeto');

	$(objeto).click(function() {
		var popover = $(this).children("div");
		$(popover).slideToggle(400);
	});

	var popover = $(objeto).children("div");
	
	$(popover).mouseleave(function() {
		$(this).slideUp(400);
	});

	$('a').click(function  () {
		if ($(this).attr("href") !== "#") 
		{
			if ($(this).attr("href") !== "/") 
			{
				if ($(this).attr("rel") !== "nofollow") 
				{
					window.open(this.href,'ventana','width=800,height=500'); return false;        
				};
			};

		}


	})



var establecimientos = $('#venta_establecimiento_id').html();
$('#venta_establecimiento_id').parent().hide();
$('#venta_contribuyente_id').change(function() {
	var contribuyente = $('#venta_contribuyente_id option:selected').text();
	var opcion = $(establecimientos).filter("optgroup[label="+ contribuyente +"]").html();
	console.log(opcion);
	if (opcion) 
	{
		$('#venta_establecimiento_id').html(opcion);
		$('#venta_establecimiento_id').parent().show();
	}
	else
	{
		$('#venta_establecimiento_id').empty();
		$('#venta_establecimiento_id').parent().hide();
	}



});




})