class LibroDiarioController < ApplicationController
  before_action :set_libro_diario
  before_action :partidas_libro, only: :resumen
  before_action :partidas_primarias

# Accion Partidas que busca o crea la partida 1 && 2
def partidas
  @partida = @libro_diario.partidas.new
  @partida.cuentas.build
end

# Accion resumen solo para ver las partidas creadas
def resumen

end

private
def partidas_libro
  @partidas_libro_diario  = @libro_diario.partidas.order(:numero_partida)
end

def partidas_primarias
  ventas_base = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:base)
  ventas_iva = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:iva)
  ventas_caja = ventas_base + ventas_iva
  compras_base = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:base)
  compras_iva = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:iva)
  compras_caja = compras_base + compras_iva


  partida1 = @libro_diario.partidas.find_by(numero_partida: 1)
  if partida1 == nil
    params = { partida:{
      numero_partida: 1,
      establecimiento_id: @libro_diario.establecimiento_id,
      cuentas_attributes: [
        { nombre: "Caja", debe: ventas_caja, haber: 0.00, posicion: 1 },
        { nombre: "Ventas", debe: 0.00, haber: ventas_base, posicion: 2 },
        { nombre: "Iva por Pagar", debe: 0.00, haber: ventas_iva, posicion: 3 }],
        descripcion: "Para registrar las ventas de mercaderia mas IVA"
        }}
        partida1 = @libro_diario.partidas.new(params[:partida])
        partida1.save
      else
        caja = partida1.cuentas.find_by(posicion: 1)
        ventas = partida1.cuentas.find_by(posicion: 2)
        iva = partida1.cuentas.find_by(posicion: 3)
        caja.debe = ventas_caja
        ventas.haber = ventas_base
        iva.haber = ventas_iva
        caja.save
        ventas.save
        iva.save
      end

      partida2 = @libro_diario.partidas.find_by(numero_partida: 2)
      if partida2 == nil
        params = { partida:{
          numero_partida: 2,
          establecimiento_id: @libro_diario.establecimiento_id,
          cuentas_attributes: [
            { nombre: "Compras", debe: compras_base, haber: 0.00, posicion: 1 },
            { nombre: "Iva por cobrar", debe: compras_iva, haber: 0.00, posicion: 2 },
            { nombre: "Caja", debe: 0.00, haber: compras_caja, posicion: 3 }],
            descripcion: "Por compras mas IVA"
            }}
            partida2 = @libro_diario.partidas.new(params[:partida])
            partida2.save
          else
            caja2 = partida2.cuentas.find_by(posicion: 3)
            compras2 = partida2.cuentas.find_by(posicion: 1)
            iva2 = partida2.cuentas.find_by(posicion: 2)
            caja2.debe = compras_caja
            compras2.haber = compras_base
            iva2.haber = compras_iva
            caja2.save
            compras2.save
            iva2.save
          end
        end

      end
