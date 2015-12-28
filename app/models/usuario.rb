class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  enum mes: %w[Selecciona\ un\ Mes Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre]
  enum year: %w[Selecciona\ un\ Año 2015 2016 2017 2018 2019 2020]
  

  attr_accessor :login
  validates :username, :presence => true, :uniqueness => {:case_sensitive => false  }
  validate :validate_username

  def validate_username
  	if Usuario.where(email: username).exists?
  		errors.add(:username, :invalid)
  	end
  end

  def self.find_for_database_authentication(warden_conditions)
  	conditions = warden_conditions.dup
  	if login = conditions.delete(:login)
  		where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  	else
  		where(conditions.to_h).first
  	end
  end

end