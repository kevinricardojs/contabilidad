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
		window.open(this.href,'Accion',"scrollbars=yes, resizable=yes, fullscreen=yes,width=1080 height=660"); return false;
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

			$(select_contribuyentes).append("<option value=''>No hay ningun Contribuyente</option>");
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

var documento = [];
documento["DA"] = "DECLARACION ADUANERA";
documento["FA"] = "FAUCA";
documento["FC"] = "FACTURA";
documento["FE"] = "FACTURA ESPECIAL";
documento["FO"] = "FORMULARIO SAT";
documento["NC"] = "NOTA CREDITO";
documento["ND"] = "NOTA DEBITO";
var dato = $(".select").data('edit');
$(".select option[value='" +dato +"']").attr('selected', 'selected');
$('#tipo-documento').attr('value', documento[dato]);
$('.select').change(function() {
	var inicialesDocumento = $('.select option:selected').attr('value');

	$('#tipo-documento').attr('value', documento[inicialesDocumento]);
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
		console.log(nit_proveedores);
		if (nit_proveedores.length == 0)
		{
			$('#compras_proveedor_nombre').removeAttr('readonly');
			$('#compras_proveedor_nombre').val('');
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
//var new_tipos = ["Caja", "Caja Chica", "Bancos", "Caja y Bancos", "Clientes", "Deudores", "Cuentas por Cobrar", "Corresponsales", "Documentos por Cobrar", "Iva por Cobrar", "Mercaderias", "Inversiones", "Papeleria y Utiles", "Utiles y Enseres", "Mobiliario y Equipo", "Vehiculos", "Equipo de Computacion", "Maquinaria", "Terrenos", "Edificios", "Inmuebles", "Herramientas", "Gastos de Organizacion", "Gastos de Instalacion", "Gastos de Institucion", "Derecho de Llave y toda Cuenta Pagada por Anticipado", "Alquileres",  ];
var estado = undefined;
var tipos_con_tipo = [ "Caja,H", "Caja,D", "Banco,D", "Clientes,D", "Deudores,D", "Acciones Suscritas,D", "Suscriptores De Acciones,Pendiente", "Hipoteca,H", "Prestamos Fiduciarios,H", "Documentos Por Cobrar,D", "Documentos Por Pagar,H", "Cuentas Por Cobrar,D", "Cuentas Por Pagar,H", "Proveedores,H", "Acreedores,H", "Inmuebles,D", "Mobiliario y Equipo,D", "Equipo De Computacion,D", "Maquinaria,D", "Herramientas,D", "Vehiculos,D", "Cristaleria,D", "Depreciacion Acumulada Mobiliario y Equipo,H", "Depreciacion Acumulada Equipo De Computacion,H", "Depreciacion Acumulada Maquinaria,H", "Depreciacion Acumulada Herramienta,H", "Depreciacion Acumulada Vehiculos,H", "Depreciacion Acumulada Cristaleria,H", "Capital,PENDIENTE", "Capital Autorizado,PENDIENTE", "Reserva Legal,PENDIENTE", "Ventas,H", "Servicios Prestados,H", "Comisiones Devengadas,H", "Alquileres Devengados,H", "Arrendamiento De Maquinaria,D", "Alquileres Pagados,D", "Gastos Generales,D", "Viaticos,D", "Seguros Pagados,D", "Servicios Pagados,D", "Reparacion y Mantenimiento Gastos,D", "Repuestos y Accesorios Gastos,D", "Combustibles y Lubricantes,D", "Costo Por Servicio,D", "Telefono,D", "Energia Electrica,D", "Medicina y Medicamentos,D", "Depreciacion Mobiliario y Equipo,D", "Depreciacion Equipo De Computacion,D", "Depreciacion Maquinaria,D", "Depreciacion Herramienta,D", "Depreciacion Vehiculos,D", "Depreciacion Cristaleria,D", "Compras,D", "Intereses Devengados,H", "Intereses Pagados,D", "Terrenos,D", "Edificios,D", "Gastos Constitucion,D", "Sueldos y Salarios,D", "Retencion Igss Laboral,H", "Cuota Patronal,D", "Bonificacion E Incentivo Laboral,D", "Bono 14,D", "Aguinaldo,D", "Fletes Sobre Compras,D", "Indemnizaciones,D", "Perdidas y Ganancias,H", "Publicidad y Propaganda,D", "Vacaciones,D", "Descuentos Sobre Compras,H", "Devoluciones y Rebajas Sobre Ventas,D"];
// var lista_haber = [];
// var lista_debe = [];
var tabla = $('#tbody-partida'); //Seleccion del formulario para la partida!
var formulario = $('#new_partida');

// tipos_con_tipo.forEach(function(elemento) {
// 	if (elemento.includes(",H")) {
// 		elemento = elemento.split(",")[0];
// 		lista_haber.push(elemento);
// 	}
// 	else if(elemento.includes(",D"))
// 	{
// 		elemento = elemento.split(",")[0];
// 		lista_debe.push(elemento);
// 	}
// });


$('#nombre-de-campo').autocomplete({
	source: tipos
});

function crear_partida(nombre_de_cuenta, nombre_,valor, position,number){

	if (tipos.indexOf(nombre_de_cuenta) != -1 ) {
		var left_nombre_ = "left_" + nombre_;
		var div = "#" + nombre_;
		var numero = $(div).data('numero');
		var right_nombre_ = "right_" + nombre_;
		var dinero_nombre_ = "dinero_" + nombre_;

		if ($(div).length == 0)
		{
			$(formulario).append("<div id='" + nombre_ + "' data-numero='" + number + "'></div>");
			$(div).append("<input type='hidden' name='partida[cuentas_attributes][" + number +"][nombre]' value='" + nombre_de_cuenta + "'>");
			$(div).append("<input type='hidden' name='partida[cuentas_attributes][" + number +"][posicion]' value=" + number + ">");
			if ( position == "debe")
			{
				var tr = "<tr data-cuenta=" + nombre_ + "><td class='left'>" + nombre_de_cuenta + "</td><td id='" + dinero_nombre_ + "' class='reasignable tipo_debe'><span class='quetzal'>Q</span><span class='monto' id='cuenta_" + nombre_ +"'>" + valor + "</span></td><td class='td-btn' id='" + left_nombre_+ "'><span class='btn btn-primary '><i class='fa fa-chevron-right'></i></span></td><td class='td-btn' id ='" + right_nombre_ + "'></td><td class='vacio' id='vacio_" + nombre_ +"'></td></tr>";
				$("tr#total").before(tr);
				$(div).append("<input type='hidden' name='partida[cuentas_attributes][" + number +"][debe]' id='input_" + nombre_ + "_debe'value=" + valor + ">");
				$(div).append("<input type='hidden' name='partida[cuentas_attributes][" + number +"][haber]' id='input_" + nombre_ + "_haber' value=''>");
				sumar(position, valor);
				numero_actual_cuentas += 1;
			}
			else
			{
				var tr = "<tr data-cuenta=" + nombre_ + "><td class='left'>" + nombre_de_cuenta + "</td><td class='vacio' id='vacio_" + nombre_ +"'></td><td class='td-btn' id='" + left_nombre_ + "'></td><td class='td-btn' id='" + right_nombre_ + "'><span class='btn btn-primary'><i class='fa fa-chevron-left'></i></span></td><td id='" + dinero_nombre_ + "'class='reasignable tipo_haber'><span class='quetzal'>Q</span><span class='monto' id='cuenta_" + nombre_ +"'>" + valor + "</span></td></tr>";
				$("tr#total").before(tr);
				$(div).append("<input type='hidden' name='partida[cuentas_attributes][" + number +"][haber]' id='input_" + nombre_ + "_haber' value=" + valor + ">");
				$(div).append("<input type='hidden' name='partida[cuentas_attributes][" + number +"][debe]' id='input_" + nombre_ + "_debe' value=''>");
				sumar(position, valor);
				numero_actual_cuentas += 1;
			}
		}

		else
		{
			var suma = to_dinero($("input[name='partida[cuentas_attributes][" + numero + "][" + position + "]']").val()) + to_dinero(valor);
			suma = suma.toFixed(2);
			$("input[name='partida[cuentas_attributes][" + numero + "][" + position + "]']").val(suma);
			$("#cuenta_" + nombre_).text($("input[name='partida[cuentas_attributes][" + numero + "][" + position + "]']").val());
			sumar();
		}
		limpiar();
	}
	else
	{
		alert("Esta cuenta no existe");
	};
};

function limpiar(){
	$('#nombre-de-campo').parent("div").removeClass('has-error');
	$('#nombre-de-campo').val("").focus() ;
	$('#valor-de-campo').val("");
};

$('#agregar').click(function(e) {
	e.preventDefault();
	var nombre_de_cuenta, valor_de_cuenta, nombre_;
	var position = $('input:radio[name=tipo]:checked').val();
	nombre_de_cuenta = $('#nombre-de-campo').val();
	valor_de_cuenta = $('#valor-de-campo').val();
	valor_de_cuenta = parseFloat(valor_de_cuenta).toFixed(2)
	nombre_ = nombre_de_cuenta.split(" ").join("_").toLowerCase();

	if (nombre_de_cuenta != "" && valor_de_cuenta != "")
	{
		if (!isNaN(valor_de_cuenta)) {
			crear_partida( nombre_de_cuenta, nombre_,valor_de_cuenta, position, numero_actual_cuentas);
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

var numero_actual_cuentas = $('.cuenta').length;
// Cambio de debe a haber
$("body").on("click", '.td-btn span', function(){
	var nombre_ = $(this).parent().parent().data('cuenta');
	var debe = "#input_" + nombre_ + "_debe";
	var haber = "#input_" + nombre_ + "_haber";
	var nombre_cuenta = "#vacio_" + nombre_;
	var dinero_nombre_ = "#dinero_" + nombre_;
	var vacio_nombre_ = "#vacio_" + nombre_;
	var left_btn = "#left_" + nombre_;
	var right_btn = "#right_" + nombre_;
	var hijo = $(this).children("i");
	$(this).parent().empty();
	if ($(hijo).hasClass('fa-chevron-left'))
	{
		$(left_btn).html("<span class='btn btn-primary '><i class='fa fa-chevron-right'></i></span>")
		$(right_btn).after($(vacio_nombre_));
		$(left_btn).before($(dinero_nombre_));
		$(dinero_nombre_).removeClass('tipo_haber');
		$(dinero_nombre_).addClass('tipo_debe');
		$(debe).val($(haber).val());
		$(haber).val("");
	}
	else if($(hijo).hasClass('fa-chevron-right'))
	{
		$(right_btn).html("<span class='btn btn-primary '><i class='fa fa-chevron-left'></i></span>")
		$(left_btn).before($(vacio_nombre_));
		$(right_btn).after($(dinero_nombre_));
		$(dinero_nombre_).removeClass('tipo_debe');
		$(dinero_nombre_).addClass('tipo_haber');
		$(haber).val($(debe).val());
		$(debe).val("");
	}
	else
	{
		alert("Invalido");
	};
	sumar();
});
/**/

function sumar(tipo, valor){
	if (tipo != null && valor != null) {
		var viejo = 0;
		var selector = "#total-" + tipo + " span.monto";
		if ( !isNaN(parseFloat($(selector).text())) ) {
			var viejo = parseFloat($(selector).text());
		}
		var monto =  parseFloat(viejo) + parseFloat(valor);
		monto = monto.toFixed(2);
		$(selector).text(monto);
	}
	else
	{
		var debe = 0;
		var haber = 0;

		$('.tipo_debe .monto').each(function() {
			debe = debe + parseFloat($(this).text());
		});
		$('.tipo_haber .monto').each(function() {
			haber = haber + parseFloat($(this).text());
		});
		$('#total-debe span.monto').text(debe.toFixed(2));
		$('#total-haber span.monto').text(haber.toFixed(2));
	}
	verificar_totales();
};

function verificar_totales(){
	var debe = parseFloat($('#total-debe span.monto').text());
	var haber = parseFloat($('#total-haber span.monto').text());

	if (debe == haber) {
		$('.termina-partida').removeClass('text-danger');
		$('.termina-partida').addClass('text-success');
		$('#submit-partida').removeAttr('disabled');
	}
	else
	{
		$('#submit-partida').attr('disabled', 'disabled');
		$('.termina-partida').removeClass('text-success');
		$('.termina-partida').addClass('text-danger');
	}
};

$('#reboot').click(function(e) {
	window.location.reload();
});

$('#sumar').keyup( function(event) {
	var cantidad = parseFloat($(this).val());
	if (!isNaN(cantidad))
	{
		if ( !isNaN(cantidad) && event.keyCode == 13 )
		{
			$('.calculadora label input:radio:not(:checked)').attr('disabled', 'disabled');
			var selected = "." + $('.calculadora label input:radio:checked').data('quien');
			console.log(selected);
			var previa = parseFloat($(selected).val()) || 0;
			nueva = previa + cantidad;
			total = parseFloat(nueva);
			$(selected).val(total.toFixed(2));
			$(this).val("");
			$(this).parent().removeClass("has-error");
		}
	}
	else
	{
		$(this).parent().addClass("has-error");
	}
});

$('.toggle-calc').click(function() {
	var direccion = $(this).data('direccion');
	if (direccion == "right") {
		$('.calculadora .mandos').animate({left: 0});
		$(this).children('.fa-arrow-right').removeClass('right');
		$(this).children('.fa-arrow-right').addClass('left');
		$(this).data('direccion', 'left');
		$('.calculadora').css('z-index', '100');
	}
	else{
		$('.calculadora .mandos').animate({left: "-110%"});
		$(this).children('.fa-arrow-right').removeClass('left');
		$(this).children('.fa-arrow-right').addClass('right');
		$(this).data('direccion', 'right');
		setTimeout(function() {
			$('.calculadora').css('z-index', '-1');
		}, 1000);
	};
});

var meses =  ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
var mes = $('#compra_libro_dato_mes').data('mes');
var current = meses.indexOf(mes);
var primero, segundo, tercero;
if(current == 0)
{

	primero = "11"
	segundo = "12"
	tercero = "01"
}

else if(current == 1)
{

	primero = "12"
	segundo = "01"
	tercero = "02"
}
else
{

	primero = meses[current - 2 ];
	segundo = meses[current - 1 ];
	tercero = meses[current];
};


var mesesValidos = [ primero, segundo, tercero];
var regex = primero + "|" + segundo + "|" + tercero;
$('#compra_libro_dato_mes').attr('pattern', regex );
$('#compra_libro_dato_mes').autocomplete({
	source: mesesValidos
});

	//Crear enlace a mayor o balance
	var libro, mes;
	$('#operacion-libro').change(function() {
		$('#link-to-libro').children('a').remove();
		libro = $('#escoger-libro option:selected').val();
		mes = $('#escoger-mes option:selected').val();
		if ( libro !="nulo" && mes != "nulo") {
			var link = "/libro/" + libro + ".pdf?mes=" + mes;
			var boton = "<a class='btn btn-info col-md-12 window' href='" + link + "'>Ver</a>";
			$('#link-to-libro').append(boton);
		};

		$('#link-to-libro a').click(function(e) {
			window.open(this.href,'Accion',"scrollbars=yes, resizable=yes, fullscreen=yes,width=1080 height=660"); return false;
		});
	});

});
