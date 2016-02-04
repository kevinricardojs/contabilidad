class TipoDeGastosController < ApplicationController
  before_action :set_tipo_de_gasto, only: [:show, :edit, :update, :destroy]

  # GET /tipo_de_gastos
  # GET /tipo_de_gastos.json
  def index
    @tipo_de_gastos = TipoDeGasto.all
  end

  # GET /tipo_de_gastos/1
  # GET /tipo_de_gastos/1.json
  def show
  end

  # GET /tipo_de_gastos/new
  def new
    @tipo_de_gasto = TipoDeGasto.new
  end

  # GET /tipo_de_gastos/1/edit
  def edit
  end

  # POST /tipo_de_gastos
  # POST /tipo_de_gastos.json
  def create
    @tipo_de_gasto = TipoDeGasto.new(tipo_de_gasto_params)

    respond_to do |format|
      if @tipo_de_gasto.save
        format.html { redirect_to @tipo_de_gasto, notice: 'Tipo de gasto was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_de_gasto }
      else
        format.html { render :new }
        format.json { render json: @tipo_de_gasto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_de_gastos/1
  # PATCH/PUT /tipo_de_gastos/1.json
  def update
    respond_to do |format|
      if @tipo_de_gasto.update(tipo_de_gasto_params)
        format.html { redirect_to @tipo_de_gasto, notice: 'Tipo de gasto was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_de_gasto }
      else
        format.html { render :edit }
        format.json { render json: @tipo_de_gasto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_de_gastos/1
  # DELETE /tipo_de_gastos/1.json
  def destroy
    @tipo_de_gasto.destroy
    respond_to do |format|
      format.html { redirect_to tipo_de_gastos_url, notice: 'Tipo de gasto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_de_gasto
      @tipo_de_gasto = TipoDeGasto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_de_gasto_params
      params.require(:tipo_de_gasto).permit(:nombre)
    end
end
