$(document).ready(function(){

	function to_dinero(cantidad) {
		return parseFloat(cantidad)
	};

//Alertas
var noticia = $('#notice');
var alerta = $('#alert');

if (!$(noticia).text()  == "") {
	$("#notice").animate({
		top: "10%"});
	$('#notice').delay(4000).fadeOut(2000);
};
if (!$(alerta).text()  == "") {
	$("#alert").animate({
		top: "10%"});
	$('#alert').delay(4000).fadeOut(2000);
};
/* */
/*lista desplegable en index*/
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
	if ($(this).hasClass('no-window') != true)
	{
		window.open(this.href,'usuario','width=1024'); return false;        
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
});


/*Partidas*/
var tipos = [ "Caja", "Banco", "Clientes", "Deudores", "Acciones Suscritas", "Suscriptores De Acciones", "Hipoteca", "Prestamos Fiduciarios", "Documentos Por Cobrar", "Documentos Por Pagar", "Cuentas Por Cobrar", "Cuentas Por Pagar", "Proveedores", "Acreedores", "Inmuebles", "Mobiliario y Equipo", "Equipo De Computacion", "Maquinaria", "Herramientas", "Vehiculos", "Cristaleria", "Depreciacion Acumulada Mobiliario y Equipo", "Depreciacion Acumulada Equipo De Computacion", "Depreciacion Acumulada Maquinaria", "Depreciacion Acumulada Herramienta", "Depreciacion Acumulada Vehiculos", "Depreciacion Acumulada Cristaleria", "Capital", "Capital Autorizado", "Reserva Legal", "Ventas", "Servicios Prestados", "Comisiones Devengadas", "Alquileres Devengados", "Arrendamiento De Maquinaria", "Alquileres Pagados", "Gastos Generales", "Viaticos", "Seguros Pagados", "Servicios Pagados", "Reparacion y Mantenimiento Gastos", "Repuestos y Accesorios Gastos", "Combustibles y Lubricantes", "Costo Por Servicio", "Telefono", "Energia Electrica", "Medicina y Medicamentos", "Depreciacion Mobiliario y Equipo", "Depreciacion Equipo De Computacion", "Depreciacion Maquinaria", "Depreciacion Herramienta", "Depreciacion Vehiculos", "Depreciacion Cristaleria", "Compras", "Intereses Devengados", "Intereses Pagados", "Terrenos", "Edificios", "Gastos Constitucion", "Sueldos y Salarios", "Retencion Igss Laboral", "Cuota Patronal", "Bonificacion E Incentivo Laboral", "Bono 14", "Aguinaldo", "Fletes Sobre Compras", "Indemnizaciones", "Perdidas y Ganancias", "Publicidad y Propaganda", "Vacaciones", "Descuentos Sobre Compras", "Devoluciones y Rebajas Sobre Ventas"];
var estado = undefined;
var tipos_con_tipo = [ "Caja,H", "Caja,D", "Banco,D", "Clientes,D", "Deudores,D", "Acciones Suscritas,D", "Suscriptores De Acciones,Pendiente", "Hipoteca,H", "Prestamos Fiduciarios,H", "Documentos Por Cobrar,D", "Documentos Por Pagar,H", "Cuentas Por Cobrar,D", "Cuentas Por Pagar,H", "Proveedores,H", "Acreedores,H", "Inmuebles,D", "Mobiliario y Equipo,D", "Equipo De Computacion,D", "Maquinaria,D", "Herramientas,D", "Vehiculos,D", "Cristaleria,D", "Depreciacion Acumulada Mobiliario y Equipo,H", "Depreciacion Acumulada Equipo De Computacion,H", "Depreciacion Acumulada Maquinaria,H", "Depreciacion Acumulada Herramienta,H", "Depreciacion Acumulada Vehiculos,H", "Depreciacion Acumulada Cristaleria,H", "Capital,PENDIENTE", "Capital Autorizado,PENDIENTE", "Reserva Legal,PENDIENTE", "Ventas,H", "Servicios Prestados,H", "Comisiones Devengadas,H", "Alquileres Devengados,H", "Arrendamiento De Maquinaria,D", "Alquileres Pagados,D", "Gastos Generales,D", "Viaticos,D", "Seguros Pagados,D", "Servicios Pagados,D", "Reparacion y Mantenimiento Gastos,D", "Repuestos y Accesorios Gastos,D", "Combustibles y Lubricantes,D", "Costo Por Servicio,D", "Telefono,D", "Energia Electrica,D", "Medicina y Medicamentos,D", "Depreciacion Mobiliario y Equipo,D", "Depreciacion Equipo De Computacion,D", "Depreciacion Maquinaria,D", "Depreciacion Herramienta,D", "Depreciacion Vehiculos,D", "Depreciacion Cristaleria,D", "Compras,D", "Intereses Devengados,H", "Intereses Pagados,D", "Terrenos,D", "Edificios,D", "Gastos Constitucion,D", "Sueldos y Salarios,D", "Retencion Igss Laboral,H", "Cuota Patronal,D", "Bonificacion E Incentivo Laboral,D", "Bono 14,D", "Aguinaldo,D", "Fletes Sobre Compras,D", "Indemnizaciones,D", "Perdidas y Ganancias,H", "Publicidad y Propaganda,D", "Vacaciones,D", "Descuentos Sobre Compras,H", "Devoluciones y Rebajas Sobre Ventas,D"];
var lista_haber = [];
var lista_debe = [];
var tabla = $('#tbody-partida'); //Seleccion del formulario para la partida!
var formulario = $('#new_partida');

tipos_con_tipo.forEach(function(elemento) {
	if (elemento.includes(",H")) {
		elemento = elemento.split(",")[0];
		lista_haber.push(elemento);
	}
	else if(elemento.includes(",D"))
	{	
		elemento = elemento.split(",")[0];
		lista_debe.push(elemento);
	}
});

$('#nombre-de-campo').keyup(function() {
	if (estado == undefined) {
		$('#nombre-de-campo').autocomplete({
			source: tipos
		});	
	}
	else if(estado == "D")
	{
		$('#nombre-de-campo').autocomplete({
			source: lista_debe
		});	
	}
	else if(estado == "H")
	{
		$('#nombre-de-campo').autocomplete({
			source: lista_haber
		});	
	}	
});

function crear_partida(nombre_de_cuenta, nombre_,valor, position){

	if (tipos.indexOf(nombre_de_cuenta) != -1 ) {
		estado = position;
		if (position == "H") {
			if (lista_haber.indexOf(nombre_de_cuenta) != -1) {
				crear_caja(position, valor);
				if ($("input[name='partida[" + nombre_ + "]']").length == 0)
				{
					$("#caja").before("<tr class='cuenta' ><td class='left'>" + nombre_de_cuenta + "</td><td></td> <td id='cuenta_" + nombre_ + "'>" + valor + "</td></tr>");
					$(formulario).prepend("<input type='hidden' name=partida[" + nombre_ + "] value=" + valor + ">");
				}
				else
				{
					var suma = to_dinero($("input[name='partida[" + nombre_ + "]']").val()) + to_dinero(valor);
					$("input[name='partida[" + nombre_ + "]']").val(suma);
					$("#cuenta_" + nombre_).text($("input[name='partida[" + nombre_ + "]']").val());
				}
				
				limpiar();	
			}
			else
			{
				Alert("Esta cuenta no perteneces a Haber");
			};

		}
		else if (position == "D") 
		{
			if (lista_debe.indexOf(nombre_de_cuenta) != -1) {
				crear_caja(position, valor);

				if ($("input[name='partida[" + nombre_ + "]']").length == 0)
				{
					$('#total').before("<tr class='cuenta' ><td class='left'>" + nombre_de_cuenta + "</td><td id='cuenta_" + nombre_ + "'>" + valor + "</td><td></td></tr>");
				$(formulario).prepend("<input type='hidden' name=partida[" + nombre_ + "] value=" + valor + ">");
				}
				else
				{
					var suma = to_dinero($("input[name='partida[" + nombre_ + "]']").val()) + to_dinero(valor);
					$("input[name='partida[" + nombre_ + "]']").val(suma);
					$("#cuenta_" + nombre_).text($("input[name='partida[" + nombre_ + "]']").val());
				}
				
				limpiar();	
			}
			else
			{
				Alert("Esta cuenta no perteneces a Debe");
			};

		}
	}
	else if(position == undefined)
	{
		$('#nombre-de-campo').parent("div").addClass('has-error');
	}


	function limpiar(){
		$('#nombre-de-campo').parent("div").removeClass('has-error');
		$('#nombre-de-campo').val("").focus() ;
		$('#valor-de-campo').val("");
	};
	function crear_caja(position, valor) {
		if (position == "H") {
			if ($('#current_input_caja').val() == undefined) {
				$(formulario).prepend("<input type='hidden' name=partida[caja_d] id='current_input_caja' value=" + valor + ">");	
				$('#total').before( "<tr id='caja' ><td class='left'>Caja</td><td class='reset' id='current_caja'>" + valor + "</td><td></td></tr>");
			}
			else
			{
				$('#current_input_caja').val( to_dinero($('#current_input_caja').val()) + to_dinero(valor));
				$('#current_caja').text($('#current_input_caja').val());
			}

		}
		else if (position == "D") {
			if ($('#current_input_caja').val() == undefined) {
				$(formulario).prepend("<input type='hidden' name=partida[caja_h] id='current_input_caja' class='reset' value=" + valor + ">");
				$(tabla).prepend( "<tr><td class='left'>Caja</td><td></td><td id='current_caja'>" + valor + "</td></tr>");
			}
			else
			{
				$('#current_input_caja').val(to_dinero($('#current_input_caja').val()) + to_dinero(valor));
				$('#current_caja').text($('#current_input_caja').val());
			}

		};

		$('#total-debe').text($('#current_input_caja').val());
		$('#total-haber').text($('#current_input_caja').val());
	}
};
$('#agregar').click(function(e) {
	e.preventDefault();
	var nombre_de_cuenta, valor_de_cuenta, nombre_;
	var position = undefined;
	nombre_de_cuenta = $('#nombre-de-campo').val();
	valor_de_cuenta = $('#valor-de-campo').val();
	nombre_ = nombre_de_cuenta.split(" ").join("_").toLowerCase();

	tipos_con_tipo.forEach(function(elem) 
	{
		elem = elem.split(",");
		if (elem[0].includes(nombre_de_cuenta))
		{
			position =  elem[1];
		}
	});
	
	if (nombre_de_cuenta != "" && valor_de_cuenta != "") 
	{
		if (!isNaN(valor_de_cuenta)) {
			crear_partida( nombre_de_cuenta, nombre_,valor_de_cuenta, position);
			$('#valor-de-campo').parent().removeClass('has-error');				
		}
		else
		{
			$('#valor-de-campo').parent().addClass('has-error');
		}
	}
	else 
	{
		alert("Debes Rellenar los dos Campos Necesarios");
	};
	
	
});
$('#reboot').click(function(e) {
	window.location.reload();
});

$('#new_partida').on('ajax:success', function(event) {
	event.preventDefault();
	alert("pollo");
});
});