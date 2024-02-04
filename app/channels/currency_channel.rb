class CurrencyChannel < ApplicationCable::Channel

  private
  def subscribed
    stream_from "currency_channel"
  end

end