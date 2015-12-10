class VentaLibrosController < ApplicationController
  before_action :set_venta_libro, only: [:show, :edit, :update, :destroy]
  before_action :set_ventas

  # GET /venta_libros
  # GET /venta_libros.json
  def index
    @venta_libros = VentaLibro.all
  end

  # GET /venta_libros/1
  # GET /venta_libros/1.json
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
  # POST /venta_libros.json
  def create
    @venta_libro = VentaLibro.new(venta_libro_params)

    respond_to do |format|
      if @venta_libro.save
        format.html { redirect_to new_venta_libro_path, notice: 'Venta libro was successfully created.' }
        format.json { render :show, status: :created, location: @venta_libro }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /venta_libros/1
  # PATCH/PUT /venta_libros/1.json
  def update
    respond_to do |format|
      if @venta_libro.update(venta_libro_params)
        format.html { redirect_to new_venta_libro_path, notice: 'Venta libro was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /venta_libros/1
  # DELETE /venta_libros/1.json
  def destroy
    @venta_libro.destroy
    respond_to do |format|
      format.html { redirect_to new_venta_libro_path, notice: 'Venta libro was successfully destroyed.' }
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
