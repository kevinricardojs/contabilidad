class LibroC < ActiveRecord::Base
  belongs_to :establecimiento
  has_many :compra_libros
end
