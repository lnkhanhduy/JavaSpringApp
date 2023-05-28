const btn_pay_ct3 = document.querySelector("#btn-ct3");
const cart_status = document.querySelector("#cart-status");
const form_ct3 = document.querySelector("#form-ct3");
const price_ship = document.querySelector("#price-ship");
const total_pay = document.querySelector("#total-pay");
const total_flower = document.querySelector("#total-flower");
const shipment1 = document.querySelector("#shipment1");
const shipment2 = document.querySelector("#shipment2");

function changeTotal(e) {
  if (e.value == "fast") {
    price_ship.innerHTML = "60000 VND";
    total_pay.innerHTML =
      parseInt(total_flower.innerHTML.split(" ")[0]) + 60000 + " VND";
  } else {
    price_ship.innerHTML = "30000 VND";
    total_pay.innerHTML =
      parseInt(total_flower.innerHTML.split(" ")[0]) + 30000 + " VND";
  }
}

btn_pay_ct3.addEventListener("click", () => {
  if (cart_status.value == "ordernow") {
    form_ct3.setAttribute("action", "/cart-step-4/ordernow");
    form_ct3.submit();
  } else {
    form_ct3.setAttribute("action", "/cart-step-4");
    form.submit();
  }
});
