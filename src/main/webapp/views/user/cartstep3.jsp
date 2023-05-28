<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán</title>
    <link rel="stylesheet" href="../../css/user/cartstep3.css">
    <link rel="stylesheet" href="../../css/user/header.css">
</head>

<body>
    <%@include file="../../components/header.jsp" %>
    <section class="cart step-3 container m-header">
        <div class="cart-progress">
            <div class="cart-step1 step-active">
                <i class="fa fa-cart-shopping"></i>
            </div>
            <div class="cart-line line-active"></div>
            <div class="cart-step2 step-active">
                <i class="fa fa-location-dot"></i>
            </div>
            <div class="cart-line line-active"></div>
            <div class="cart-step3 step-active">
                <i class="fa fa-money-check"></i>
            </div>
        </div>
        <div class="cart-step-title">
            <p>Thanh toán</p>
        </div>
        <div class="row row-cols-1 row-cols-lg-2 g-4">
            <div class="col-12 col-lg-8">
                <form action="" method="post" class="row g-3 needs-validation" id="form-ct3" novalidate>
                    <div class="col-12">
                        <label for="shipment" class="form-label fs-5 ct-label d-block">Phương thức giao hàng</label>
                        <div class="form-check">
                            <input checked class="form-check-input" type="radio" name="shipment" id="shipment1" value="normal" onclick="changeTotal(this)">
                            <label class="form-check-label" for="shipment1">
                                Giao hàng thường
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="shipment" id="shipment2" value="fast" onclick="changeTotal(this)">
                            <label class="form-check-label" for="shipment2">
                                Giao hàng chuyển phát nhanh
                            </label>
                        </div>
                        <div class="invalid-feedback">
                            Vui lòng chọn phương thức giao hàng!
                        </div>
                    </div>
                    <div class="col-12">
                        <label for="payment" class="form-label fs-5 ct-label d-block">Phương thức thanh toán</label>
                        <div class="form-check">
                            <input checked class="form-check-input" type="radio" name="payment" id="payment1">
                            <label class="form-check-label" for="payment1">
                                Tiền mặt
                            </label>
                        </div>
                    </div>
                    <div class="col-12">
                        <a href="" class="d-block text-warning">&lt;&lt; Quay lại thông tin giao hàng</a>
                        <button id="btn-ct3" class="ms-auto float-end ct-btn-cart" style="--ct-color: #0000ff">Xác nhận thanh
                            toán</button>
                        <div class="clearfix"></div>
                    </div>
                    <input type="text" name="cart-status" id="cart-status" value="${cart_status}" hidden>
                    <input type="text" name="quantity-flower" value="${quantity_flower}" hidden>
                    <input type="text" name="id-flower" value="${id_flower}" hidden>
                    <input type="text" name="fullname" value="${fullname}" hidden>
                    <input type="text" name="pnumber" value="${pnumber}" hidden>
                    <input type="text" name="email" value="${email}" hidden>
                    <input type="text" name="address" value="${address}" hidden>
                    <input type="text" name="total" value="${total}" hidden>
                    <input type="text" name="name-flower" value="${name_flower}" hidden>
                </form>
            </div>
            <div class="col-12 col-lg-4">
                <table class="table table-hover w-100">
                    <tbody class="ct-table-body" style="vertical-align: middle;">
                        <tr>
                            <td>Tổng tiền hàng</td>
                            <td id="total-flower">${total} VND</td>
                        </tr>
                        <tr>
                            <td>Phí vận chuyển</td>
                            <td id="price-ship">30000 VND</td>
                        </tr>
                    </tbody>
                    <tfoot class="ct-table-footer" style="vertical-align: middle;">
                        <tr>
                            <th>Tổng tiền thanh toán</th>
                            <th id="total-pay">${total+30000} VND</th>
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
    <script src="../../js/user/cartstep3.js"></script>
</body>

</html>