import { Controller } from "@hotwired/stimulus"
import {createConsumer} from "@rails/actioncable";
// Connects to data-controller="websocket-currency"
export default class extends Controller {
  containerTarget;
  connect() {
    this.channel = createConsumer().subscriptions.create({channel: "CurrencyChannel"}, {
      received: this.actualizarCurrency.bind(this)
    })
  }

  actualizarCurrency(data){
    debugger
    const currency = data
    this.containerTarget.innerHTML = `
      <p>productId ${currency.product_id} </p>
      <p>price: ${currency.price} </p>
    `
  }

}
