<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin giao hàng</title>
    <link rel="stylesheet" href="../../css/user/cartstep2.css">
    <link rel="stylesheet" href="../../css/user/header.css">
</head>

<body>
    <%@include file="../../components/header.jsp" %>
    <section class="cart step-2 container m-header">
        <div class="cart-progress">
            <div class="cart-step1 step-active">
                <i class="fa fa-cart-shopping"></i>
            </div>
            <div class="cart-line line-active"></div>
            <div class="cart-step2 step-active">
                <i class="fa fa-location-dot"></i>
            </div>
            <div class="cart-line"></div>
            <div class="cart-step3">
                <i class="fa fa-money-check"></i>
            </div>
        </div>
        <div class="cart-step-title">
            <p>Thông Tin Giao Hàng</p>
        </div>

        <div class="row row-cols-1 row-cols-lg-2 g-4">
            <div class="col-12 col-lg-8">
                <div>Vui lòng điền đầy đủ thông tin giao hàng</div>
                <form action="" method="post" class="row g-3 needs-validation" id="form-ct2" novalidate>
                    <div class="col-12 col-lg-6">
                        <label for="fullname" class="form-label">Họ tên</label>
                        <input type="text" name="fullname" class="form-control" id="fullname" value="" required
                            autocomplete="off">
                        <div class="invalid-feedback">
                            Vui lòng nhập tên!
                        </div>
                    </div>
                    <div class="col-12 col-lg-6">
                        <label for="pnumber" class="form-label">Số điện thoại</label>
                        <input type="number" name="pnumber" class="form-control" id="pnumber" value="" required
                            autocomplete="off">
                        <div class="invalid-feedback">
                            Vui lòng nhập số điện thoại!
                        </div>
                    </div>
                    <div class="col-12 col-lg-6">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" id="email" value="" required
                            autocomplete="off">
                        <div class="invalid-feedback">
                            Email không hợp lệ!
                        </div>
                    </div>
                    <div class="col-12 col-lg-6">
                        <label for="address" class="form-label">Địa chỉ</label>
                        <input type="text" name="address" class="form-control" id="address" value="" required
                            autocomplete="off">
                        <div class="invalid-feedback">
                            Vui lòng nhập địa chỉ chính xác!
                        </div>
                    </div>
                    <div class="col-12">
                        <a href="" class="d-block text-warning">&lt;&lt; Quay lại giỏ hàng</a>
                        <button id="btn-ct2" class="ms-auto float-end ct-btn-cart" style="--ct-color: #0000ff">Tiếp tục Thanh toán</button>
                        <div class="clearfix"></div>
                    </div>
                </form>
            </div>
            <div class="col-12 col-lg-4">
                <table class="table table-hover w-100">
                    <thead class="text-center">
                        <tr>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Số lượng</th>
                            <th scope="col">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody class="ct-table-body" style="vertical-align: middle;">
                        <c:forEach var="cart" items="${carts}">
                        <tr>
                            <input type="text" id="cart-status" value="${cart.getStatus()}" hidden>
                            <input type="text" id="quantity-flower" value="${cart.getQuantityFlower()}" hidden>
                            <input type="text" id="id-flower" value="${cart.getIdFlower()}" hidden>
                            <input type="text" id="name-flower" value="${cart.getNameFlower()}" hidden>
                            <td>${cart.getNameFlower()}</td>
                            <td>${cart.getQuantityFlower()}</td>
                            <td>${cart.getTotal()} VND</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot class="ct-table-footer">
                        <tr>
                            <th colspan="2">Tạm tính</th>
                            <th>${total} VND</th>
                            <input type="text" id="cart-total" value="${total}" hidden>                        
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
    <script src="../../js/formvalidation.js"></script>
    <script src="../../js/user/cartstep2.js"></script>
</body>

</html>