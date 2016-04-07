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
      respond_to do |format|
        if @partida.save
          format.html { redirect_to libro_diario_partidas_path, notice: 'La Partida fue añadida.' }
        else
          format.html { redirect_to libro_diario_partidas_path }
        end

      end
      #  redirect_to libro_diario_partidas_path
      # flash[:alert] = 'Debes Añadir al menos una Cuenta'
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
      params.require(:partida).permit( :dia, :descripcion, :numero_partida, cuentas_attributes: [:nombre, :debe, :haber, :posicion])
    end
  end
