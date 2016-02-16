class VentaLibrosController < ApplicationController
  before_action :set_venta_libro, only: [:show, :edit, :update, :destroy]
  before_action :set_ventas
  before_action :validar_datos_para_trabajar

  # GET /venta_libros
  def index
    @venta_libros = VentaLibro.all
  end

  # GET /venta_libros/1
  def show
  end

  # GET /venta_libros/new
  def new
    @venta_libro = VentaLibro.new
  end

  # GET /venta_libros/1/edit
  def edit
  end

  # POST /venta_libros
  def create
    @venta_libro = VentaLibro.new(venta_libro_params)
    @venta_libro.contribuyente_id = @u.contribuyente_id
    @venta_libro.establecimiento_id  = @u.establecimiento_id 

    respond_to do |format|
      if @venta_libro.save
        format.html { redirect_to new_venta_libro_path, notice: 'La Venta fue añadida exitosamente' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /venta_libros/1
  def update
    respond_to do |format|
      if @venta_libro.update(venta_libro_params)
        format.html { redirect_to new_venta_libro_path, notice: 'La Venta fue actualizada exitosamente' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /venta_libros/1
  def destroy
    @venta_libro.destroy
    respond_to do |format|
      format.html { redirect_to new_venta_libro_path, notice: 'La Venta fue borrada' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venta_libro
      @venta_libro = VentaLibro.find(params[:id])
    end
    def set_ventas
      @ventas = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def venta_libro_params
      params.require(:venta_libro).permit(:documento, :serie, :numero, :dia, :mes, :year, :nit, :nombre, :gravado_bienes, :gravado_servicios, :exento_bienes, :exento_servicios, :base, :iva, :total, :contribuyente_id, :establecimiento_id)
    end
end
