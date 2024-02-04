# frozen_string_literal: true

class CurrencyRate
  attr_reader :moneda, :interes_mensual,:balance_ini

  def initialize(moneda, interes_mensual, balance_ini)
    @moneda = moneda
    @interes_mensual = interes_mensual
    @balance_ini = balance_ini
  end
end
