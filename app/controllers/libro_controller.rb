class LibroController < ApplicationController
  before_action :set_libro_diario
  before_action :set_nombres_all_cuentas

  def mayor
  end

  def balance
  end

  private

  def set_nombres_all_cuentas
    @cuentas = []
    @libro_diario.cuentas.group(:nombre_).count.each { |c| @cuentas.push c[0]}
  end
end
