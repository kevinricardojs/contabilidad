class CompraLibrosController < ApplicationController
  before_action :set_compra_libro, only: [:show, :edit, :update, :destroy]
  before_action :set_compras
  before_action :validar_datos_para_trabajar
  before_action :set_libro_diario
  before_action :partidas_primarias

  # GET /compra_libros
  def index
  end

  # GET /compra_libros/1
  def show
  end

  # GET /compra_libros/new
  def new
    @compra_libro = CompraLibro.new
  end

  # GET /compra_libros/1/edit
  def edit
  end

  # POST /compra_libros
  def create
    @compra_libro = CompraLibro.new(compra_libro_params)
    @compra_libro.contribuyente_id = @u.contribuyente_id
    @compra_libro.establecimiento_id  = @u.establecimiento_id 

    respond_to do |format|
      if @compra_libro.save
        format.html { redirect_to new_compra_libro_path, notice: 'La Compra fue añadida exitosamente' }
        # Hacer la cuenta para la partida 2 Compras

        partida = @libro_diario.partidas.find_by(numero_partida: 2)
        cuenta = partida.cuentas.find_by(nombre_: @compra_libro.tipo_de_gasto.downcase.split(" ").join("_"))
        ultimo = partida.cuentas.minimum(:posicion) - 1
        if cuenta == nil
          cuenta = Cuenta.new(nombre: @compra_libro.tipo_de_gasto,libro_diario_id:  @libro_diario,  debe: @compra_libro.base.to_f.round(2), haber:0.0, partida_id: partida.id, posicion: ultimo)
          cuenta.save
        else  
          cuenta.debe = (cuenta.debe.to_f + @compra_libro.base.to_f).round(2)
          cuenta.save
        end
        
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /compra_libros/1
  def update
    respond_to do |format|
      if @compra_libro.update(compra_libro_params)
        format.html { redirect_to new_compra_libro_path, notice: 'La Compra fue actualizada exitosamente' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /compra_libros/1
  def destroy
    partida = @libro_diario.partidas.find_by(numero_partida: 2)
    cuenta = partida.cuentas.find_by(nombre_: @compra_libro.tipo_de_gasto.downcase.split(" ").join("_"))
    cuenta.debe = cuenta.debe.to_f - @compra_libro.base.to_f
    if cuenta.debe == "0.0"
      cuenta.destroy
    else
      cuenta.save
    end
    @compra_libro.destroy
    respond_to do |format|
      format.html { redirect_to new_compra_libro_path, notice: 'La Compra fue borrada' }
    end
  end
  def reporte
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compra_libro
      @compra_libro = CompraLibro.find(params[:id])
    end
    def set_compras
      @compras = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes)      
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def compra_libro_params
      params.require(:compra_libro).permit(:documento, :serie, :numero, :proveedor_nit, :proveedor_nombre , :dia, :mes, :year, :gravado_bienes, :gravado_servicios, :exento_bienes, :exento_servicios, :contribuyente_id, :establecimiento_id, :base, :iva, :tipo_de_gasto)
    end
  end
