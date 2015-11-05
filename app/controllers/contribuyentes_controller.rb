class ContribuyentesController < ApplicationController
  before_action :set_contribuyente, only: [:show, :edit, :update, :destroy]

  # GET /contribuyentes
  # GET /contribuyentes.json
  def index
    @contribuyentes = Contribuyente.all
  end

  # GET /contribuyentes/1
  # GET /contribuyentes/1.json
  def show
  end

  # GET /contribuyentes/new
  def new
    @contribuyente = Contribuyente.new
  end

  # GET /contribuyentes/1/edit
  def edit
  end

  # POST /contribuyentes
  # POST /contribuyentes.json
  def create
    @contribuyente = Contribuyente.new(contribuyente_params)

    respond_to do |format|
      if @contribuyente.save
        format.html { redirect_to new_contribuyente_path, notice: 'El nuevo Contribuyente fue ingresado.' }
        format.json { render :show, status: :created, location: @contribuyente }
      else
        format.html { render :new }
        format.json { render json: @contribuyente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contribuyentes/1
  # PATCH/PUT /contribuyentes/1.json
  def update
    respond_to do |format|
      if @contribuyente.update(contribuyente_params)
        format.html { redirect_to new_contribuyente_path, notice: 'El Contribuyente fue actualizado exitosamente' }
        format.json { render :show, status: :ok, location: @contribuyente }
      else
        format.html { render :edit }
        format.json { render json: @contribuyente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contribuyentes/1
  # DELETE /contribuyentes/1.json
  def destroy
    @contribuyente.destroy
    respond_to do |format|
      format.html { redirect_to contribuyentes_url, notice: 'El Contribuyente ha sido eliminado' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribuyente
      @contribuyente = Contribuyente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribuyente_params
      params.require(:contribuyente).permit(:nit, :nombre, :calle, :no_casa, :apto_similar, :zona, :colonia, :departamento, :municipio, :telefono, :fax, :apto_postal, :email)
    end
end
