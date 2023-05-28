<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.2/jquery.min.js" integrity="sha512-tWHlutFnuG0C6nQRlpvrEhE4QpkG1nn2MOUMWmUeRePl4e3Aki0VB6W1v3oLjFtd0hVOtRQ9PHpSfN6u6/QXkQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<div class="m-5 overflow-auto">
    <div class="d-flex justify-content-end mb-3 flex-wrap">
        <button class="btn btn-info ms-2" onclick="getAllOrder()">Tất cả</button>
        <button class="btn btn-success ms-2" onclick="getSuccessOrder()">Đã giao</button>
        <button class="btn btn-primary ms-2" onclick="getDeliveryOrder()">Đang giao</button>
        <button class="btn btn-secondary ms-2" onclick="getWaitingOrder()">Chờ xác nhận</button>
        <button class="btn btn-danger ms-2" onclick="getDenyOrder()">Đơn huỷ</button>      
    </div>
    <table class="table table-hover">
        <thead class="text-center">
            <tr>
                <th>STT</th>
                <th>Mã đơn hàng</th>
                <th>Tổng tiền</th>
                <th>Phương thức vận chuyển</th>
                <th>Trạng thái</th>
            </tr>
        </thead>
        <tbody class="text-center" id="tbody-ordermanagement">
            <c:forEach var="order" items="${ordersGroupBy}" varStatus="loop">
                <tr onclick="openOrderInfoModal(this)" data-id="${order.getIdOrder()}" data-total="${order.getTotal()}" data-shipment="${order.getShipment()}" data-status="${order.getStatus()}" data-fullname="${order.getFullname()}" data-pnumber="${order.getPhonenumber()}" data-email="${order.getEmail()}" data-address="${order.getAddress()}">
                    <td>${loop.index+1}</td>
                    <td>${order.getIdOrder()}</td>
                    <td>${order.getTotal()}</td>
                    <td>${order.getShipment()}</td>
                    <td>${order.getStatus()}</td>
                </tr>
            </c:forEach>    
        </tbody>
    </table>
</div>

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
                <input id="btn-delivery" type="button" class="btn btn-outline-primary" value="Giao hàng" data-bs-dismiss="modal">
                <input id="btn-success" type="button" class="btn btn-outline-success" value="Thành công" data-bs-dismiss="modal">
                <input id="btn-deny" type="button" class="btn btn-outline-warning" value="Huỷ đơn" data-bs-dismiss="modal">
            </div>
        </div>
    </div>
</div>
<script src="../../js/admin/ordermanagement.js"></script>
<script src="../../js/formvalidation.js"></script>