class CuentaContablesController < ApplicationController
  before_action :set_cuenta_contable, only: [:show, :edit, :update, :destroy]

  # GET /cuenta_contables
  # GET /cuenta_contables.json
  def index
    @cuenta_contables = CuentaContable.all
  end

  # GET /cuenta_contables/1
  # GET /cuenta_contables/1.json
  def show
  end

  # GET /cuenta_contables/new
  def new
    @cuenta_contable = CuentaContable.new
  end

  # GET /cuenta_contables/1/edit
  def edit
  end

  # POST /cuenta_contables
  # POST /cuenta_contables.json
  def create
    @cuenta_contable = CuentaContable.new(cuenta_contable_params)

    respond_to do |format|
      if @cuenta_contable.save
        format.html { redirect_to @cuenta_contable, notice: 'Cuenta contable was successfully created.' }
        format.json { render :show, status: :created, location: @cuenta_contable }
      else
        format.html { render :new }
        format.json { render json: @cuenta_contable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cuenta_contables/1
  # PATCH/PUT /cuenta_contables/1.json
  def update
    respond_to do |format|
      if @cuenta_contable.update(cuenta_contable_params)
        format.html { redirect_to @cuenta_contable, notice: 'Cuenta contable was successfully updated.' }
        format.json { render :show, status: :ok, location: @cuenta_contable }
      else
        format.html { render :edit }
        format.json { render json: @cuenta_contable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuenta_contables/1
  # DELETE /cuenta_contables/1.json
  def destroy
    @cuenta_contable.destroy
    respond_to do |format|
      format.html { redirect_to cuenta_contables_url, notice: 'Cuenta contable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cuenta_contable
      @cuenta_contable = CuentaContable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cuenta_contable_params
      params.require(:cuenta_contable).permit(:caja, :banco, :clientes, :deudores, :acciones_suscritas, :suscriptores_de_acciones, :hipoteca, :prestamos_fiduciarios, :documentos_por_cobrar, :documentos_por_pagar, :cuentas_por_cobrar, :cuentas_por_pagar, :proveedores, :acreedores, :inmuebles, :mobiliario_y_equipo, :equipo_de_computacion, :maquinaria, :herramientas, :vehiculos, :cristaleria, :depreciacion_acumulada_mobiliario_y_equipo, :depreciacion_acumulada_equipo_de_computacion, :depreciacion_acumulada_maquinaria, :depreciacion_acumulada_herramienta, :depreciacion_acumulada_vehiculos, :depreciacion_acumulada_cristaleria, :capital, :capital_autorizado, :reserva_legal, :ventas, :servicios_prestados, :comisiones_devengadas, :alquileres_devengados, :arrendamiento_de_maquinaria, :alquileres_pagados, :gastos_generales, :viaticos, :seguros_pagados, :servicios_pagados, :reparacion_y_mantenimiento_gastos, :repuestos_y_accesorios_gastos, :combustibles_y_lubricantes, :costo_por_servicio, :telefono, :energia_electrica, :medicina_y_medicamentos, :depreciacion_mobiliario_y_equipo, :depreciacion_equipo_de_computacion, :depreciacion_maquinaria, :depreciacion_herramienta, :depreciacion_vehiculos, :depreciacion_cristaleria, :compras, :intereses_devengados, :intereses_pagados, :terrenos, :edificios, :gastos_constitucion, :sueldos_y_salarios, :retenci¾n_igss_laboral, :cuota_patronal, :bonificacion_e_incentivo_laboral, :bono_14, :aguinaldo, :fletes_sobre_compras, :indemnizaciones, :perdidas_y_ganancias, :publicidad_y_propaganda, :vacaciones, :descuentos_sobre_compras, :devoluciones_y_rebajas_sobre_ventas)
    end
end
