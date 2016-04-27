class Folio < ActiveRecord::Base
	has_one :establecimiento


	enum libro: %w{compras ventas diario mayor balance}
	validates :paginas, numericality:true
end
