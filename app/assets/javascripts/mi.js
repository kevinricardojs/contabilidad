$(document).ready(function(){
	//Alertas
	var noticia = $('#notice');
	var alerta = $('#alert');

	if (!$(notice).text()  == "") {
		$("#notice").animate({
			top: "10%"});
		$('#notice').delay(4000).fadeOut(2000);
	};
	/* */
	var objeto = $('.jumbotron .objeto');

	$(objeto).click(function() {
		var popover = $(this).children("div");
		$(popover).slideToggle(400);
	});

	var popover = $(objeto).children("div");
	
	$(popover).mouseleave(function() {
		$(this).delay(500).slideUp(500);
	});

//Abrir links en Ventanas
$('a').click(function  () {
	if ($(this).attr("href") !== "#") 
	{
		if ($(this).attr("href") !== "/") 
		{
			if ($(this).attr("rel") !== "nofollow") 
			{
				window.open(this.href,'usuario','width=auto'); return false;        
			};
		};

	};
});

/**/



/*ajax contribuyentes*/
$('#boton-cambiar').click(function() {
	var select_contribuyentes = $('#select_contribuyentes');
	var select_establecimientos = $('#select_establecimientos');
	var borrar = $('.borrar-option')
	$(borrar).children('option').remove();
	$(borrar).html("<option disabled selected> Selecciona una opción</option>");
	$.get('/inicio/contribuyentes.json', function(data) {
		if (data.length !== 0) 
		{ 
			for (var i = data.length - 1; i >= 0; i--) {
				id = data[i].id
				nit = data[i].nit
				option = "<option value="+ id + ">" + nit +"</option>"
				$(select_contribuyentes).append(option)
			};
		}
		else
		{
			
			$(select_contribuyentes).append("<option value=''>No hay ningun establecimiento</option>");
		}
	});
	select_contribuyentes.change(function() {
		var contribuyente_id = $('#select_contribuyentes option:selected').val();
		$.post( "/inicio/establecimientos.json", { id: contribuyente_id}, function(data) {
			if (data.length !== 0) 
			{ 
				$(select_establecimientos).children('option').remove();
				for (var i = data.length - 1; i >= 0; i--) {
					console.log(i);
					id = data[i].id
					nombre = data[i].nombre
					option = "<option value="+ id + ">" + nombre +"</option>"
					$(select_establecimientos).append(option)
				};
			}
			else
			{

				$(select_establecimientos).append("<option value=''>No hay ningun establecimiento</option>");
			}
		});
	});
});

$('#compra_libro_proveedor_id').change(function() {
	var proveedorNit = parseInt($('#compra_libro_proveedor_id option:selected').attr('value'));
	var proveedores = $('.proveedor-nombre').text().split("-");
	var proveedorNit = proveedorNit - 1;
	$('#proveedor-nombre').attr('value', proveedores[proveedorNit]);
});


$('#compra_libro_documento').change(function() {
	var inicialesDocumento = $('#compra_libro_documento option:selected').attr('value');
	var documento = [];
	documento["DA"] = "DECLARACION ADUANERA";
	documento["FA"] = "FAUCA";
	documento["FC"] = "FACTURA"; 
	documento["FE"] = "FACTURA ESPECIAL";
	documento["FO"] = "FORMULARIO SAT";
	documento["NC"] = "NOTA CREDITO";
	documento["ND"] = "NOTA DEBITO";
	$('#tipo-documento').attr('value', documento[inicialesDocumento]);
});


if ($('.base-iva').val() == "") {
	$('.base-iva').val("0.00");
};
function CalculoBaseIva(neto){ 

	var totalFac 	= neto.val();
	var base 		= totalFac / 1.12;
	var iva 		= base * 0.12;
	iva 		= iva.toFixed(2);
	base 		= base.toFixed(2);
	var total 		= (parseFloat(iva) + parseFloat(base)).toFixed(2);
	$('#compra_libro_base').val(base);
	$('#compra_libro_iva').val(iva);
	$('#compra_libro_total').val(total);
	$('#venta_libro_base').val(base);
	$('#venta_libro_iva').val(iva);
	$('#venta_libro_total').val(total);
}
var gravado 		= $('.gravado');
var exento 			= $('.exento');
gravado.change(function(){
	exento.val("0.00");
	if ($(this).hasClass('gravado-bienes')) 
	{
		$('.gravado-servicios').val("0.00");
	}
	else
	{
		$('.gravado-bienes').val("0.00");
	}
	CalculoBaseIva($(this));
});

exento.change(function (){
	var precio = $(this).val();
	gravado.val("0.00");
	$('.base-iva').val("0.00");
	if ($(this).hasClass('exento-bienes')) 
	{
		$('.exento-servicios').val("0.00");
	}
	else
	{
		$('.exento-bienes').val("0.00");
	}

	$('#venta_libro_total').val(precio);
	$('#compra_libro_total').val(precio);

});


/*Autocompletado*/
$('#compras_proveedor_nit').keyup(function  () {
	var nit_proveedores = $('#compras_proveedor_nit').data('autocomplete-source');
	var nombre_proveedores = $('#compras_proveedor_nombre').data('proveedor-nombre');

	$('#compras_proveedor_nit').autocomplete({
		source: nit_proveedores
	});

	var nit_seleccionado = $('#compras_proveedor_nit').val();
	var index_nit = nit_proveedores.indexOf(nit_seleccionado);

	if ($('.ui-helper-hidden-accessible div:last-child').text() == "No search results.")
	{
		$('#compras_proveedor_nombre').removeAttr('readonly');
		$('#compras_proveedor_nombre').attr('placeholder' ,'Escribe el nombre del nuevo Proveedor');
	}
	else if(nit_seleccionado == "")
	{
		$('#compras_proveedor_nombre').val("");
		$('#compras_proveedor_nombre').removeAttr('placeholder');
		$('#compras_proveedor_nombre').attr('readonly', 'readonly');	
	}
	else
	{
		$('#compras_proveedor_nombre').val(nombre_proveedores[index_nit]);
		$('#compras_proveedor_nombre').attr('readonly', 'readonly');
	}

})

});