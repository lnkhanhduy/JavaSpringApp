<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lịch sử mua hàng</title>
    <link rel="stylesheet" href="../css/user/profile.css" />
    <link rel="stylesheet" href="../css/user/header.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.2/jquery.min.js" integrity="sha512-tWHlutFnuG0C6nQRlpvrEhE4QpkG1nn2MOUMWmUeRePl4e3Aki0VB6W1v3oLjFtd0hVOtRQ9PHpSfN6u6/QXkQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  </head>
  <body>
    <%@include file="../../components/header.jsp" %>
    <section class="personal-info container m-header">
        <div class="m-5 overflow-auto">
            <table class="table table-hover">
                <thead class="text-center">
                <tr>
                    <th>STT</th>
                    <th>Mã đơn hàng</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                </tr>
                </thead>
                <tbody class="text-center" id="tbody-ordermanagement">
                <c:forEach var="order" items="${orders}" varStatus="loop">
                    <tr
                    onclick="openOrderInfoModal(this)"
                    data-id="${order.getIdOrder()}"
                    data-total="${order.getTotal()}"
                    data-shipment="${order.getShipment()}"
                    data-status="${order.getStatus()}"
                    data-fullname="${order.getFullname()}"
                    data-pnumber="${order.getPhonenumber()}"
                    data-email="${order.getEmail()}"
                    data-address="${order.getAddress()}"
                    >
                    <td>${loop.index+1}</td>
                    <td>${order.getIdOrder()}</td>
                    <td>${order.getTotal()}</td>
                    <td>${order.getStatus()}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <div class="modal fade" id="moreInfoOrderModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Thông tin đơn đặt hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="id-order" class="form-label">Mã đơn hàng</label>
                        <input type="text" class="form-control" id="id-order" value="" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="price-product" class="form-label">Tổng tiền</label>
                        <input type="text" class="form-control" id="price-product" value="" disabled>
                        
                    </div>
                    <div class="mb-3">
                        <label for="shipment-order" class="form-label">Phương thức vận chuyển</label>
                        <input class="form-control" id="shipment-order" placeholder="" disabled></input>
                    </div>
                    <div class="mb-3">
                        <label for="status-order" class="form-label">Trạng thái</label>
                        <input type="text" class="form-control" id="status-order" value="" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="order-components" class="form-label">Sản phẩm</label>
                        <div class="">
                            <table class="table table-hover table-borderless">
                                <thead class="text-center">
                                    <tr>
                                        <th>Mã sản phẩm</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Số lượng</th>
                                        <th>Tổng tiền sản phẩm</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center" id="tbody-order">
    
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="owner-order" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="owner-order" value="sarito" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="phone-order" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="phone-order" value="0987654321" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="email-order" class="form-label">Email</label>
                        <input type="text" class="form-control" id="email-order" value="abc@gmail.com" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="address-order" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="address-order" value="786A, District 7, TP.HCM" disabled>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-outline-danger" value="Quay lại" data-bs-dismiss="modal">
                    <input id="btn-deny" type="button" class="btn btn-outline-warning" value="Huỷ đơn" data-bs-dismiss="modal">
                </div>
            </div>
        </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
      crossorigin="anonymous"
    ></script>
    <script src="../../js/user/historyorder.js"></script>
  </body>
</html>
