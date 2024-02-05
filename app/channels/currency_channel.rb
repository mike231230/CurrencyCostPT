class CurrencyChannel < ApplicationCable::Channel

  private
  def subscribed
    stream_from "currency_channel"
    sleep 5000
  end

end