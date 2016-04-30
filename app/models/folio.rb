class Folio < ActiveRecord::Base
	has_one :establecimiento
	has_many :consumidos, dependent: :destroy


	enum libro: %w{compras ventas diario mayor balance}
	validates :paginas, numericality:true

end
