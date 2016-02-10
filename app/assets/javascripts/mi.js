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
				window.open(this.href,'usuario','width=1024'); return false;        
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
	$.post('/peticion_json/contribuyentes.json', function(data) {
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
		$.post( "/peticion_json/establecimientos.json", { id: contribuyente_id}, function(data) {
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
/**/
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
	$('#venta_libro_base').val(base);
	$('#venta_libro_iva').val(iva);
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
});


/*Autocompletado Proveedor CompraLibros#new*/
$('#compras_proveedor_nit').keyup(function () {
	var nit_escrito = $(this).val();
	$.post( "/peticion_json/proveedores.json", { nit: nit_escrito }, function(data) {
		var nit_proveedores = [];
		var nombre_proveedores = [];
		data.map(function(elem) {
			nit_proveedores.push(elem.nit);
			nombre_proveedores.push(elem.nombre);
		});
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
	});
});
/*Autocompletado Tipo de Gastos CompraLibros#new*/
$('#compra_libro_tipo_de_gasto').keyup(function (){
	var busqueda = $(this).val();
	var datos = [];
	$.post( "/peticion_json/tipos_de_gastos.json", { nombre: busqueda }, function(data) {
		data.map(function(elem) {
			datos.push(elem.nombre);
		})
	});
	$('#compra_libro_tipo_de_gasto').autocomplete({
		source: datos
	});
})

});