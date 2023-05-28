const moreInfoOrderModal = new bootstrap.Modal(
  document.querySelector("#moreInfoOrderModal"),
  {}
);
const btn_delivery = document.querySelector("#btn-delivery");
const btn_success = document.querySelector("#btn-success");
const btn_deny = document.querySelector("#btn-deny");
const tbody_order_management = document.querySelector("#tbody-ordermanagement");
let idOrder;
let statusOrder;
let check_btn_allOrder = true;
let check_btn_deliveryOrder = false;
let check_btn_waitingOrder = false;

function openOrderInfoModal(e) {
  idOrder = e.dataset.id;
  statusOrder = e.dataset.status;
  document.querySelector("#moreInfoOrderModal #id-order").value = e.dataset.id;
  document.querySelector("#moreInfoOrderModal #price-product").value =
    e.dataset.total;
  document.querySelector("#moreInfoOrderModal #shipment-order").value =
    e.dataset.shipment;
  document.querySelector("#moreInfoOrderModal #status-order").value =
    e.dataset.status;
  document.querySelector("#moreInfoOrderModal #owner-order").value =
    e.dataset.fullname;
  document.querySelector("#moreInfoOrderModal #phone-order").value =
    e.dataset.pnumber;
  document.querySelector("#moreInfoOrderModal #email-order").value =
    e.dataset.email;
  document.querySelector("#moreInfoOrderModal #address-order").value =
    e.dataset.address;
  $.ajax({
    type: "GET",
    contentType: "application/json",
    url: "/admin/ordermanagement/detail/" + e.dataset.id,
    dataType: "json",
    cache: false,
    timeout: 600000,
    success: function (data) {
      const tbody_order = document.querySelector("#tbody-order");
      tbody_order.innerHTML = "";
      for (let i = 0; i < data.length; i++) {
        let tr = document.createElement("tr");
        let td_id = document.createElement("td");
        let td_name = document.createElement("td");
        let td_quantity = document.createElement("td");
        let td_price = document.createElement("td");

        let text_id = document.createTextNode(data[i].idFlower);
        let text_name = document.createTextNode(data[i].nameFlower);
        let text_quantity = document.createTextNode(data[i].quantityFlower);
        let text_price = document.createTextNode(data[i].totalPriceFlower);

        td_id.appendChild(text_id);
        td_name.appendChild(text_name);
        td_quantity.appendChild(text_quantity);
        td_price.appendChild(text_price);

        tr.appendChild(td_id);
        tr.appendChild(td_name);
        tr.appendChild(td_quantity);
        tr.appendChild(td_price);
        tbody_order.appendChild(tr);
      }
    },
    error: function (e) {
      console.log("ERROR : ", e);
    },
  });
  moreInfoOrderModal.show();

  btn_deny.disabled = false;
  btn_delivery.disabled = false;
  btn_success.disabled = false;

  if (statusOrder == "Đang giao hàng") {
    btn_deny.disabled = true;
    btn_delivery.disabled = true;
  } else if (statusOrder == "Thành công" || statusOrder == "Đã huỷ") {
    btn_deny.disabled = true;
    btn_delivery.disabled = true;
    btn_success.disabled = true;
  } else if (statusOrder == "Chờ xác nhận") {
    btn_success.disabled = true;
  }
}

function getAllOrder() {
  check_btn_allOrder = true;
  check_btn_deliveryOrder = false;
  check_btn_waitingOrder = false;
  $.ajax({
    type: "GET",
    contentType: "application/json",
    url: "/admin/ordermanagement/getall",
    dataType: "json",
    cache: false,
    timeout: 600000,
    success: function (data) {
      tbody_order_management.innerHTML = "";
      for (let i = 0; i < data.length; i++) {
        let tr = document.createElement("tr");

        tr.setAttribute("onclick", "openOrderInfoModal(this)");
        tr.setAttribute("data-id", data[i].idOrder);
        tr.setAttribute("data-total", data[i].total);
        tr.setAttribute("data-shipment", data[i].shipment);
        tr.setAttribute("data-status", data[i].status);
        tr.setAttribute("data-fullname", data[i].fullname);
        tr.setAttribute("data-pnumber", data[i].pnumber);
        tr.setAttribute("data-email", data[i].email);
        tr.setAttribute("data-address", data[i].address);

        let td_stt = document.createElement("td");
        let td_id = document.createElement("td");
        let td_total = document.createElement("td");
        let td_shipment = document.createElement("td");
        let td_status = document.createElement("td");

        let text_stt = document.createTextNode(i + 1);
        let text_id = document.createTextNode(data[i].idOrder);
        let text_total = document.createTextNode(data[i].total);
        let text_shipment = document.createTextNode(data[i].shipment);
        let text_status = document.createTextNode(data[i].status);

        td_stt.appendChild(text_stt);
        td_id.appendChild(text_id);
        td_total.appendChild(text_total);
        td_shipment.appendChild(text_shipment);
        td_status.appendChild(text_status);

        tr.appendChild(td_stt);
        tr.appendChild(td_id);
        tr.appendChild(td_total);
        tr.appendChild(td_shipment);
        tr.appendChild(td_status);
        tbody_order_management.appendChild(tr);
      }
    },
    error: function (e) {
      console.log("ERROR : ", e);
    },
  });
}

function getSuccessOrder() {
  check_btn_allOrder = false;
  check_btn_deliveryOrder = false;
  check_btn_waitingOrder = false;
  $.ajax({
    type: "GET",
    contentType: "application/json",
    url: "/admin/ordermanagement/getsuccess",
    dataType: "json",
    cache: false,
    timeout: 600000,
    success: function (data) {
      tbody_order_management.innerHTML = "";
      for (let i = 0; i < data.length; i++) {
        let tr = document.createElement("tr");

        tr.setAttribute("onclick", "openOrderInfoModal(this)");
        tr.setAttribute("data-id", data[i].idOrder);
        tr.setAttribute("data-total", data[i].total);
        tr.setAttribute("data-shipment", data[i].shipment);
        tr.setAttribute("data-status", data[i].status);
        tr.setAttribute("data-fullname", data[i].fullname);
        tr.setAttribute("data-pnumber", data[i].pnumber);
        tr.setAttribute("data-email", data[i].email);
        tr.setAttribute("data-address", data[i].address);

        let td_stt = document.createElement("td");
        let td_id = document.createElement("td");
        let td_total = document.createElement("td");
        let td_shipment = document.createElement("td");
        let td_status = document.createElement("td");

        let text_stt = document.createTextNode(i + 1);
        let text_id = document.createTextNode(data[i].idOrder);
        let text_total = document.createTextNode(data[i].total);
        let text_shipment = document.createTextNode(data[i].shipment);
        let text_status = document.createTextNode(data[i].status);

        td_stt.appendChild(text_stt);
        td_id.appendChild(text_id);
        td_total.appendChild(text_total);
        td_shipment.appendChild(text_shipment);
        td_status.appendChild(text_status);

        tr.appendChild(td_stt);
        tr.appendChild(td_id);
        tr.appendChild(td_total);
        tr.appendChild(td_shipment);
        tr.appendChild(td_status);
        tbody_order_management.appendChild(tr);
      }
    },
    error: function (e) {
      console.log("ERROR : ", e);
    },
  });
}

function getDeliveryOrder() {
  check_btn_allOrder = false;
  check_btn_deliveryOrder = true;
  check_btn_waitingOrder = false;
  $.ajax({
    type: "GET",
    contentType: "application/json",
    url: "/admin/ordermanagement/getdelivery",
    dataType: "json",
    cache: false,
    timeout: 600000,
    success: function (data) {
      tbody_order_management.innerHTML = "";
      for (let i = 0; i < data.length; i++) {
        let tr = document.createElement("tr");

        tr.setAttribute("onclick", "openOrderInfoModal(this)");
        tr.setAttribute("data-id", data[i].idOrder);
        tr.setAttribute("data-total", data[i].total);
        tr.setAttribute("data-shipment", data[i].shipment);
        tr.setAttribute("data-status", data[i].status);
        tr.setAttribute("data-fullname", data[i].fullname);
        tr.setAttribute("data-pnumber", data[i].pnumber);
        tr.setAttribute("data-email", data[i].email);
        tr.setAttribute("data-address", data[i].address);

        let td_stt = document.createElement("td");
        let td_id = document.createElement("td");
        let td_total = document.createElement("td");
        let td_shipment = document.createElement("td");
        let td_status = document.createElement("td");

        let text_stt = document.createTextNode(i + 1);
        let text_id = document.createTextNode(data[i].idOrder);
        let text_total = document.createTextNode(data[i].total);
        let text_shipment = document.createTextNode(data[i].shipment);
        let text_status = document.createTextNode(data[i].status);

        td_stt.appendChild(text_stt);
        td_id.appendChild(text_id);
        td_total.appendChild(text_total);
        td_shipment.appendChild(text_shipment);
        td_status.appendChild(text_status);

        tr.appendChild(td_stt);
        tr.appendChild(td_id);
        tr.appendChild(td_total);
        tr.appendChild(td_shipment);
        tr.appendChild(td_status);
        tbody_order_management.appendChild(tr);
      }
    },
    error: function (e) {
      console.log("ERROR : ", e);
    },
  });
}

function getWaitingOrder() {
  check_btn_allOrder = false;
  check_btn_deliveryOrder = false;
  check_btn_waitingOrder = true;
  $.ajax({
    type: "GET",
    contentType: "application/json",
    url: "/admin/ordermanagement/getwaiting",
    dataType: "json",
    cache: false,
    timeout: 600000,
    success: function (data) {
      tbody_order_management.innerHTML = "";
      for (let i = 0; i < data.length; i++) {
        let tr = document.createElement("tr");

        tr.setAttribute("onclick", "openOrderInfoModal(this)");
        tr.setAttribute("data-id", data[i].idOrder);
        tr.setAttribute("data-total", data[i].total);
        tr.setAttribute("data-shipment", data[i].shipment);
        tr.setAttribute("data-status", data[i].status);
        tr.setAttribute("data-fullname", data[i].fullname);
        tr.setAttribute("data-pnumber", data[i].pnumber);
        tr.setAttribute("data-email", data[i].email);
        tr.setAttribute("data-address", data[i].address);

        let td_stt = document.createElement("td");
        let td_id = document.createElement("td");
        let td_total = document.createElement("td");
        let td_shipment = document.createElement("td");
        let td_status = document.createElement("td");

        let text_stt = document.createTextNode(i + 1);
        let text_id = document.createTextNode(data[i].idOrder);
        let text_total = document.createTextNode(data[i].total);
        let text_shipment = document.createTextNode(data[i].shipment);
        let text_status = document.createTextNode(data[i].status);

        td_stt.appendChild(text_stt);
        td_id.appendChild(text_id);
        td_total.appendChild(text_total);
        td_shipment.appendChild(text_shipment);
        td_status.appendChild(text_status);

        tr.appendChild(td_stt);
        tr.appendChild(td_id);
        tr.appendChild(td_total);
        tr.appendChild(td_shipment);
        tr.appendChild(td_status);
        tbody_order_management.appendChild(tr);
      }
    },
    error: function (e) {
      console.log("ERROR : ", e);
    },
  });
}

function getDenyOrder() {
  check_btn_allOrder = false;
  check_btn_deliveryOrder = false;
  check_btn_waitingOrder = false;
  $.ajax({
    type: "GET",
    contentType: "application/json",
    url: "/admin/ordermanagement/getdeny",
    dataType: "json",
    cache: false,
    timeout: 600000,
    success: function (data) {
      tbody_order_management.innerHTML = "";
      for (let i = 0; i < data.length; i++) {
        let tr = document.createElement("tr");

        tr.setAttribute("onclick", "openOrderInfoModal(this)");
        tr.setAttribute("data-id", data[i].idOrder);
        tr.setAttribute("data-total", data[i].total);
        tr.setAttribute("data-shipment", data[i].shipment);
        tr.setAttribute("data-status", data[i].status);
        tr.setAttribute("data-fullname", data[i].fullname);
        tr.setAttribute("data-pnumber", data[i].pnumber);
        tr.setAttribute("data-email", data[i].email);
        tr.setAttribute("data-address", data[i].address);

        let td_stt = document.createElement("td");
        let td_id = document.createElement("td");
        let td_total = document.createElement("td");
        let td_shipment = document.createElement("td");
        let td_status = document.createElement("td");

        let text_stt = document.createTextNode(i + 1);
        let text_id = document.createTextNode(data[i].idOrder);
        let text_total = document.createTextNode(data[i].total);
        let text_shipment = document.createTextNode(data[i].shipment);
        let text_status = document.createTextNode(data[i].status);

        td_stt.appendChild(text_stt);
        td_id.appendChild(text_id);
        td_total.appendChild(text_total);
        td_shipment.appendChild(text_shipment);
        td_status.appendChild(text_status);

        tr.appendChild(td_stt);
        tr.appendChild(td_id);
        tr.appendChild(td_total);
        tr.appendChild(td_shipment);
        tr.appendChild(td_status);
        tbody_order_management.appendChild(tr);
      }
    },
    error: function (e) {
      console.log("ERROR : ", e);
    },
  });
}

btn_delivery.addEventListener("click", () => {
  $.ajax({
    type: "POST",
    contentType: "application/json",
    url: "/admin/ordermanagement/delivery",
    data: idOrder,
    dataType: "json",
    cache: false,
    timeout: 600000,
    success: function (data) {
      console.log(data);
      if (data == "Update delivery") {
        if (check_btn_allOrder) {
          getAllOrder();
        } else if (check_btn_waitingOrder) {
          getWaitingOrder();
        }
      }
    },
    error: function (e) {
      console.log("ERROR : ", e);
      if (e.status == 200) {
        if (check_btn_allOrder) {
          getAllOrder();
        } else if (check_btn_waitingOrder) {
          getWaitingOrder();
        }
      }
    },
  });
});

btn_success.addEventListener("click", () => {
  $.ajax({
    type: "POST",
    contentType: "application/json",
    url: "/admin/ordermanagement/success",
    data: idOrder,
    dataType: "json",
    cache: false,
    timeout: 600000,
    success: function (data) {
      console.log(data);
      if (data == "Update success") {
        if (check_btn_allOrder) {
          getAllOrder();
        } else if (check_btn_deliveryOrder) {
          getDeliveryOrder();
        }
      }
    },
    error: function (e) {
      console.log("ERROR : ", e);
      if (e.status == 200) {
        if (check_btn_allOrder) {
          getAllOrder();
        } else if (check_btn_deliveryOrder) {
          getDeliveryOrder();
        }
      }
    },
  });
});

btn_deny.addEventListener("click", () => {
  $.ajax({
    type: "POST",
    contentType: "application/json",
    url: "/admin/ordermanagement/deny",
    data: idOrder,
    dataType: "json",
    cache: false,
    timeout: 600000,
    success: function (data) {
      console.log(data);
      if (data == "Update deny") {
        if (check_btn_allOrder) {
          getAllOrder();
        } else if (check_btn_waitingOrder) {
          getWaitingOrder();
        }
      }
    },
    error: function (e) {
      console.log("ERROR : ", e);
      if (e.status == 200) {
        if (check_btn_allOrder) {
          getAllOrder();
        } else if (check_btn_deliveryOrder) {
          getDeliveryOrder();
        } else if (check_btn_waitingOrder) {
          getWaitingOrder();
        } else if (check_btn_denyOrder) {
          getDenyOrder();
        }
      }
    },
  });
});
