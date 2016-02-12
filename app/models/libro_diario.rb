class LibroDiario < ActiveRecord::Base
  belongs_to :establecimiento
  has_many :partidas

  
end
