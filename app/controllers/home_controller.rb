require 'csv'
require 'websocket-client-simple'

class HomeController < ApplicationController
  expose :investment


  def index
    @monedas = []
    @monedas = llenado_monedas
    websocket_listener
  end

  private

  def llenado_monedas
    csv_text = File.read("app/assets/csv/origen.csv")
    csv = CSV.parse(csv_text, headers: true, header_converters: :symbol)
    monedas = []
    csv.each do |row|
      monedas.push CurrencyRate.new(row[0], row[1], row[2])
    end
    monedas
  end


  def websocket_listener
    url = "wss://ws-feed.exchange.coinbase.com"

    params = {
      "type": "subscribe",
      "product_ids":[
        "BTC-USD",
        "ADA-USD",
        "ETH-USD"],
      "channels": ["ticker"]
    }

    client = WebSocket::Client::Simple.connect(url)

    client.on(:message) do |msg|
      # Aquí puedes manejar los mensajes recibidos
      mensaje_recibido = JSON.parse(msg.data)

      objeto = ObjetoVirtual.new(product_id: mensaje_recibido['product_id'], price: mensaje_recibido['price'] )

      # Transmitir el objeto a través de Action Cable
      ActionCable.server.broadcast('currency_channel', objeto)
      sleep 5
    end

    client.on(:open) do
      puts "Conexion establecida"
      client.send(params.to_json)
    end

    client.on(:close) do |e|
      puts "Conexion cerrada #{e}"
    end

    client.on(:error) do |e|
      puts "Error: #{e}"
    end

    Thread.new do
      loop do
        sleep 1000
      end
    end
  end

  def investment_params
    params.require(:investment).permit(
    :amount
    )
  end




end
