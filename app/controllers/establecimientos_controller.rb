class EstablecimientosController < ApplicationController
  before_action :set_establecimiento, only: [:show, :edit, :update, :destroy]
  # GET /establecimientos
  # GET /establecimientos.json
  def index
    @establecimientos = Establecimiento.all
  end

  # GET /establecimientos/1
  # GET /establecimientos/1.json
  def show
  end

  # GET /establecimientos/new
  def new
    @establecimiento = Establecimiento.new
    @contribuyentes = Contribuyente.all
  end

  # GET /establecimientos/1/edit
  def edit
        @contribuyentes = Contribuyente.all
  end

  # POST /establecimientos
  # POST /establecimientos.json
  def create
    @establecimiento = Establecimiento.new(establecimiento_params)

    respond_to do |format|
      if @establecimiento.save
        format.html { redirect_to @establecimiento, notice: 'Establecimiento was successfully created.' }
        format.json { render :show, status: :created, location: @establecimiento }
      else
        format.html { render :new }
        format.json { render json: @establecimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /establecimientos/1
  # PATCH/PUT /establecimientos/1.json
  def update
    respond_to do |format|
      if @establecimiento.update(establecimiento_params)
        format.html { redirect_to @establecimiento, notice: 'Establecimiento was successfully updated.' }
        format.json { render :show, status: :ok, location: @establecimiento }
      else
        format.html { render :edit }
        format.json { render json: @establecimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /establecimientos/1
  # DELETE /establecimientos/1.json
  def destroy
    @establecimiento.destroy
    respond_to do |format|
      format.html { redirect_to establecimientos_url, notice: 'Establecimiento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_establecimiento
      @establecimiento = Establecimiento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def establecimiento_params
      params.require(:establecimiento).permit(:nombre, :calle, :numero_casa, :apto_similar, :zona, :colonia, :departamento, :municipio, :telefono, :fax, :apto_postal, :contribuyente_id)
    end
end
