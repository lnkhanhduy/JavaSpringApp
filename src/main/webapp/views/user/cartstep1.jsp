<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="../../css/user/cartstep1.css">
    <link rel="stylesheet" href="../../css/user/header.css">
    <link rel="stylesheet" href="../../css/popup.css">
</head>

<body>
    <%@include file="../../components/header.jsp" %>
    <div id="pp-toast">
    </div>
    <section class="cart step-1 container m-header">
        <div class="cart-progress">
            <div class="cart-step1 step-active">
                <i class="fa fa-cart-shopping"></i>
            </div>
            <div class="cart-line"></div>
            <div class="cart-step2">
                <i class="fa fa-location-dot"></i>
            </div>
            <div class="cart-line"></div>
            <div class="cart-step3">
                <i class="fa fa-money-check"></i>
            </div>
        </div>
        <div class="cart-step-title">
            <p>Giỏ hàng</p>
        </div>

        <div class="row row-cols-1 row-cols-lg-2 g-4">
            <div class="col-12 col-lg-8">
                <table class="table table-hover w-100">
                    <thead class="text-center">
                        <tr>
                            <th scope="col">Hình ảnh</th>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Số lượng</th>
                            <th scope="col">Tổng tiền</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody class="text-center" style="vertical-align: middle;">
                        <c:forEach var="cart" items="${carts}">
                            <tr>
                                <td><img class="ct-img" src="../../images/${cart.getImageFlower()}" alt="" width="50" height="50" style="object-fit: cover;"></td>
                                <td>${cart.getNameFlower()}</td>
                                <td>${cart.getQuantityFlower()}</td>
                                <td>${cart.getPriceFlower()}</td>
                                <td data-id="${cart.getId()}" class="btn-delete-order"><i class="fa-solid fa-trash-can text-danger ct-icon"></i></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="col-12 col-lg-4">
                <table class="table w-100">
                    <thead class="text-center">
                      <tr>
                        <th colspan="2" scope="col">Tổng tiền giỏ hàng</th>
                      </tr>
                    </thead>
                    <tbody class="ct-table-body">
                        <input type="text" value="${totalFlower}" id="totalFlower" hidden>
                        <input type="text" value="${total}" id="total" hidden>
                        <input type="text" value="${cart_status}" id="cart-status" hidden>
                        <input type="text" value="${id_flower}" id="id-flower" hidden>
                        <input type="text" value="${name_flower}" id="name-flower" hidden>
                      <tr>
                        <td>Tổng sản phẩm</td>
                        <td>${totalFlower}</td>
                      </tr>
                      <tr>
                        <td>Tổng tiền hàng</td>
                        <td>${total} <span>VND</span></td>
                      </tr>
                    </tbody>
                    <tfoot class="ct-table-footer">
                        <tr>
                            <td>Tạm tính</td>
                            <td>${total} <span>VND</span></td>
                        </tr>
                    </tfoot>
                  </table>
                  <a href="/" class="d-inline-block ct-btn-cart me-2" style="--ct-color: #0000ff">Tiếp tục mua hàng</a>
                  <a href="#" class="d-inline-block ct-btn-cart me-2" id="btn-pay-ct1" style="--ct-color: #ff0000">Thanh toán</a>
            </div>
        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
    <script src="../../js/popup.js"></script>
    <script src="../../js/user/cartstep1.js"></script>
    <c:forEach var="msg" items="${message}">
        <script>
            createToastPopup({color:"#0000ff", type:"info", title: "Thành công", content: "${msg}"});
        </script>
    </c:forEach> 
    <c:forEach var="err" items="${error}">
        <script>
            createToastPopup({color:"#ff0000", type:"info", title: "Lỗi", content: "${err}"});
        </script>
    </c:forEach>    
</body>

</html>