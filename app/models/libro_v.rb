class LibroV < ActiveRecord::Base
  belongs_to :establecimiento
  has_many :venta_libros
end
