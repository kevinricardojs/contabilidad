class PartidasController < ApplicationController
  before_action :set_partida, only: [:show, :edit, :update, :destroy]
  before_action :set_libro_diario


  # GET /partidas/1/edit
  def edit
  end

  # POST /partidas
  # POST /partidas.json
  def create
    @partida = @libro_diario.partidas.new(partida_params)
    @partida.establecimiento_id = current_usuario.establecimiento_id
    @partida.numero_partida = LibroDiario.find(@libro_diario).partidas.last.numero_partida + 1 || 3
    if @partida.caja_h  != nil || @partida.caja_d != nil
      respond_to do |format|
        if @partida.save
          format.html { redirect_to libro_diario_partidas_path, notice: 'La Partida fue añadida.' }
        else
          format.html { redirect_to libro_diario_partidas_path }
        end

      end
    else
       redirect_to libro_diario_partidas_path
      flash[:alert] = 'Debes Añadir al menos una Cuenta' 
    end
  end

  # PATCH/PUT /partidas/1
  # PATCH/PUT /partidas/1.json
  def update
    respond_to do |format|
      if @partida.update(partida_params)
        format.html { redirect_to libro_diario_resumen_path, notice: "La Partida # " +  "#{@partida.numero_partida}"  + " fue editada exitosamente." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /partidas/1
  # DELETE /partidas/1.json
  def destroy
    @partida.destroy
    respond_to do |format|
      format.html { redirect_to libro_diario_resumen_path, notice: 'La Partida fue borrada.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partida
      @partida = Partida.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partida_params
      params.require(:partida).permit(:banco, :clientes, :deudores, :acciones_suscritas, :suscriptores_de_acciones, :hipoteca, :prestamos_fiduciarios, :documentos_por_cobrar, :documentos_por_pagar, :cuentas_por_cobrar, :cuentas_por_pagar, :proveedores, :acreedores, :inmuebles, :mobiliario_y_equipo, :equipo_de_computacion, :maquinaria, :herramientas, :vehiculos, :cristaleria, :depreciacion_acumulada_mobiliario_y_equipo, :depreciacion_acumulada_equipo_de_computacion, :depreciacion_acumulada_maquinaria, :depreciacion_acumulada_herramienta, :depreciacion_acumulada_vehiculos, :depreciacion_acumulada_cristaleria, :capital, :capital_autorizado, :reserva_legal, :ventas, :servicios_prestados, :comisiones_devengadas, :alquileres_devengados, :arrendamiento_de_maquinaria, :alquileres_pagados, :gastos_generales, :viaticos, :seguros_pagados, :servicios_pagados, :reparacion_y_mantenimiento_gastos, :repuestos_y_accesorios_gastos, :combustibles_y_lubricantes, :costo_por_servicio, :telefono, :energia_electrica, :medicina_y_medicamentos, :depreciacion_mobiliario_y_equipo, :depreciacion_equipo_de_computacion, :depreciacion_maquinaria, :depreciacion_herramienta, :depreciacion_vehiculos, :depreciacion_cristaleria, :compras, :intereses_devengados, :intereses_pagados, :terrenos, :edificios, :gastos_constitucion, :sueldos_y_salarios, :retenci¾n_igss_laboral, :cuota_patronal, :bonificacion_e_incentivo_laboral, :bono_14, :aguinaldo, :fletes_sobre_compras, :indemnizaciones, :perdidas_y_ganancias, :publicidad_y_propaganda, :vacaciones, :descuentos_sobre_compras, :devoluciones_y_rebajas_sobre_ventas,:libro_diario_id, :caja_d, :caja_h, :descripcion, :numero_partida)
    end
  end
