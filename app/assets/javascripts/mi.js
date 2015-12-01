$(document).ready(function(){
	
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
		$(popover).slideDown(400);
	});

	var popover = $(objeto).children("div");
	
	$(popover).mouseleave(function() {
		$(this).delay(500).slideUp(500);
	});


	$('a').click(function  () {
		if ($(this).attr("href") !== "#") 
		{
			if ($(this).attr("href") !== "/") 
			{
				if ($(this).attr("rel") !== "nofollow") 
				{
					window.open(this.href,'usuario','width=800,height=500'); return false;        
				};
			};

		};


	});



	var establecimientos = $('#usuario_establecimiento_id').html();
	
	$('#usuario_contribuyente_id').change(function() {
		var contribuyente = $('#usuario_contribuyente_id option:selected').text();
		var opcion = $(establecimientos).filter("optgroup[label="+ contribuyente +"]").html();
		if (opcion) 
		{
			$('#usuario_establecimiento_id').html(opcion);
			$('#usuario_establecimiento_id').parent().show();
		}
		else if( opcion == "" )
		{
			$('#usuario_establecimiento_id').empty();
			$('#usuario_establecimiento_id').html("<option value=''>No hay ningun establecimiento</option>");

		}
		else
		{
			$('#usuario_establecimiento_id').empty();
			$('#usuario_establecimiento_id').parent().hide();
		}
	});

	/*ajax*/
	$('#boton-cambiar').click(function() {
		$.get('/inicio/operacion', function(data) {
			$('#receptor-cambiar').html(data)
		});
	});
})