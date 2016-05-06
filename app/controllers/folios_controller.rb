class FoliosController < ApplicationController
	before_action :set_establecimiento
	before_action :set_folio, only: [:show, :edit, :update, :destroy]


	def index
		@folios = @establecimiento.folios.order(:year)
	end

	def new
		@folio = @establecimiento.folios.new
	end

	def edit

	end

	def create
		@folio = Folio.new(folio_params)
		respond_to do |format|
			if @folio.save
				format.html { redirect_to @establecimiento, notice: 'Folio añadido' }
			else
				format.html { render :new }
			end
		end
	end

	def update
		respond_to do |format|
			if @folio.update(folio_params)
				format.html { redirect_to @establecimiento, notice: 'El Folio fue actualizado' }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@folio.destroy
		respond_to do |format|
			format.html { redirect_to @establecimiento, notice: 'El Folio fue borrado' }
		end
	end

	private


	def set_folio
		@folio = Folio.find(params[:id])	
	end

	def set_establecimiento
		@establecimiento = Establecimiento.find(params[:establecimiento_id])
	end

	def folio_params
		params.require(:folio).permit(:libro, :paginas, :year, :establecimiento_id)
	end
end
