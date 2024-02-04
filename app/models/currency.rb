# frozen_string_literal: true
require 'websocket-client-simple'

class Currency
  def initialize(url)
    @url = url
  end

  def subscribe(params)
    client = WebSocket::Client::Simple.connect(@url)

    client.on(:message) do |msg|
      puts msg.data
      puts "Mensaje recibido"
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
        sleep 1
      end
    end
  end

end
