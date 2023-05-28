const btn_pay_ct2 = document.querySelector("#btn-ct2");
const cart_total = document.querySelector("#cart-total");
const cart_status = document.querySelector("#cart-status");
const quantity_flower = document.querySelector("#quantity-flower");
const name_flower = document.querySelector("#name-flower");
const id_flower = document.querySelector("#id-flower");
const fullname = document.querySelector("#fullname");
const email = document.querySelector("#email");
const pnumber = document.querySelector("#pnumber");
const address = document.querySelector("#address");
const form_ct2 = document.querySelector("#form-ct2");

btn_pay_ct2.addEventListener("click", () => {
  if (
    fullname.value != "" &&
    email.value != "" &&
    email.value.includes("@") &&
    pnumber.value != "" &&
    address.value != ""
  ) {
    if (cart_status.value == "ordernow") {
      form_ct2.setAttribute("action", "/cart-step-3/ordernow");
      const FN = document.createElement("input");
      FN.setAttribute("type", "text");
      FN.setAttribute("name", "total");
      FN.setAttribute("value", cart_total.value);
      FN.hidden = true;
      form_ct2.appendChild(FN);
      const FN1 = document.createElement("input");
      FN1.setAttribute("type", "text");
      FN1.setAttribute("name", "cart-status");
      FN1.setAttribute("value", cart_status.value);
      FN1.hidden = true;
      form_ct2.appendChild(FN1);
      const FN2 = document.createElement("input");
      FN2.setAttribute("type", "text");
      FN2.setAttribute("name", "quantity-flower");
      FN2.setAttribute("value", quantity_flower.value);
      FN2.hidden = true;
      form_ct2.appendChild(FN2);
      const FN3 = document.createElement("input");
      FN3.setAttribute("type", "text");
      FN3.setAttribute("name", "id-flower");
      FN3.setAttribute("value", id_flower.value);
      FN3.hidden = true;
      form_ct2.appendChild(FN3);
      const FN4 = document.createElement("input");
      FN4.setAttribute("type", "text");
      FN4.setAttribute("name", "name-flower");
      FN4.setAttribute("value", name_flower.value);
      FN4.hidden = true;
      form_ct2.appendChild(FN4);
      form_ct2.submit();
    } else {
      form_ct2.setAttribute("action", "/cart-step-3");
      const FN = document.createElement("input");
      FN.setAttribute("type", "text");
      FN.setAttribute("name", "total");
      FN.setAttribute("value", cart_total.value);
      FN.hidden = true;
      form_ct2.appendChild(FN);
      form.submit();
    }
  }
});
