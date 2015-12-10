class CompraLibrosController < ApplicationController
  before_action :set_compra_libro, only: [:show, :edit, :update, :destroy]
  before_action :set_compras

  # GET /compra_libros
  # GET /compra_libros.json
  def index
  end

  # GET /compra_libros/1
  # GET /compra_libros/1.json
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
  # POST /compra_libros.json
  def create
    @compra_libro = CompraLibro.new(compra_libro_params)

    respond_to do |format|
      if @compra_libro.save
        format.html { redirect_to new_compra_libro_path, notice: 'La compra fua añadida exitosamente' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /compra_libros/1
  # PATCH/PUT /compra_libros/1.json
  def update
    respond_to do |format|
      if @compra_libro.update(compra_libro_params)
        format.html { redirect_to new_compra_libro_path, notice: 'La compra fue actualizada exitosamente' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /compra_libros/1
  # DELETE /compra_libros/1.json
  def destroy
    @compra_libro.destroy
    respond_to do |format|
      format.html { redirect_to new_compra_libro_path, notice: 'La compra fue borrada' }
    end
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
      params.require(:compra_libro).permit(:documento, :serie, :numero, :proveedor_id, :dia, :mes, :year, :gravado_bienes, :gravado_servicios, :exento_bienes, :exento_servicios, :contribuyente_id, :establecimiento_id, :base, :iva, :total)
    end
end
