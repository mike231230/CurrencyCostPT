import { Controller } from "@hotwired/stimulus"
import {createConsumer} from "@rails/actioncable";
// Connects to data-controller="websocket-currency"
export default class extends Controller {
  static targets = ["container", "priceBitcoin", "priceEther", "priceCardano"]
  connect() {
    this.channel = createConsumer().subscriptions.create({channel: "CurrencyChannel"}, {
      received: this.actualizarCurrency.bind(this)
    })
  }

  actualizarCurrency(data){

    const currency = data

    if (currency.product_id === "BTC-USD") {
      this.priceBitcoinTarget.innerHTML = `
      <th>${currency.price} </th>`
    }
    if (currency.product_id === "ETH-USD") {
      this.priceEtherTarget.innerHTML = `
      <th>${currency.price} </th>`
    }
    if (currency.product_id === "ADA-USD") {
      this.priceCardanoTarget.innerHTML = `
      <th>${currency.price} </th>`
    }


  }

}
