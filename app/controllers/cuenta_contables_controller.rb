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
        format.html { redirect_to new_cuenta_contable_path , notice: 'Fue añadida una nueva Cuenta contable' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /cuenta_contables/1
  # PATCH/PUT /cuenta_contables/1.json
  def update
    respond_to do |format|
      if @cuenta_contable.update(cuenta_contable_params)
        format.html { redirect_to new_cuenta_contable_path , notice: 'Fue actualizada la Cuenta contable' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /cuenta_contables/1
  # DELETE /cuenta_contables/1.json
  def destroy
    @cuenta_contable.destroy
    respond_to do |format|
      format.html { redirect_to cuenta_contables_url, notice: 'La Cuenta contable fue borrada' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cuenta_contable
      @cuenta_contable = CuentaContable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cuenta_contable_params
      params.require(:cuenta_contable).permit(:nombre, :tipo)
    end
end
