<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin tài khoản</title>
    <link rel="stylesheet" href="../css/user/profile.css">
    <link rel="stylesheet" href="../css/user/header.css">
    <link rel="stylesheet" href="../../css/popup.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.2/jquery.min.js" integrity="sha512-tWHlutFnuG0C6nQRlpvrEhE4QpkG1nn2MOUMWmUeRePl4e3Aki0VB6W1v3oLjFtd0hVOtRQ9PHpSfN6u6/QXkQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
    crossorigin="anonymous"></script>
</head>
<body>
    <%@include file="../../components/header.jsp" %>
    <div id="pp-toast">
    </div>
    <section class="personal-info container m-header">
        <div class="image-user">
            <img src="../../imgs/defaultimg.png" alt="" width="100%">
        </div>
        <div class="name-user">
            <p>${account.getFullname()}</p>
        </div>
        <div class="row mt-5 g-5">
            <div class="col-12 col-md-6 info-item" style="--delay: 0s">
                <label for="">Họ tên</label>
                <input type="text" autocomplete="off" value="${account.getFullname()}" disabled>
            </div>
            <div class="col-12 col-md-6 info-item" style="--delay: 0.3s">
                <label for="">Tên đăng nhập</label>
                <input type="text" autocomplete="off" value="${account.getUsername()}" disabled>
            </div>
            <div class="col-12 col-md-6 info-item" style="--delay: 0.6s">
                <label for="">Email</label>
                <input type="text" autocomplete="off" value="${account.getEmail()}" disabled>
            </div>
            <div class="col-12 col-md-6 info-item" style="--delay: 0.9s">
                <label for="">Số điện thoại</label>
                <input type="text" autocomplete="off" value="0123456789" disabled>
            </div>
            <div class="col-12 d-flex flex-row-reverse">
                <button onclick="openchangePasswordModal()" class="ct-btn-profile ms-3" style="--ct-color: #05e841">Đổi mật khẩu</button>
                <button onclick="openEditModal()" id="btn-edit-account" class="ct-btn-profile ms-3" style="--ct-color: #0000ff">Chỉnh sửa</button>
                <button onclick="openDeleteModal()" class="ct-btn-profile" style="--ct-color: #ff0000">Xóa tài khoản</button>
            </div>
        </div>
    </section>

    <div class="modal fade" id="changepassword" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Đổi mật khẩu</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="password" class="form-label">Nhập mật khẩu mới</label>
                        <input type="password" class="form-control" id="password" value="" placeholder="Mật khẩu mới">
                    </div>
                    <div class="mb-3">
                        <label for="confirm-password" class="form-label">Nhập lại mật khẩu mới</label>
                        <input type="password" class="form-control" id="confirm-password" value="" placeholder="Mật lại khẩu mới">
                    </div>
                    <div id="check-confirm" style="color: ff0000;" hidden></div>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-outline-danger" value="Quay lại" data-bs-dismiss="modal">
                    <input id="btn-confirm" type="button" class="btn btn-outline-success" value="Xác nhận" data-bs-dismiss="modal">
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editaccount" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Sửa thông tin</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="username" class="form-label">Tên đăng nhập</label>
                        <input type="text" class="form-control" value="${account.getUsername()}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="fullname" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="fullname" value="${account.getFullname()}">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="text" class="form-control" id="email" value="${account.getEmail()}">
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-outline-danger" value="Quay lại" data-bs-dismiss="modal">
                    <input id="btn-edit" type="button" class="btn btn-outline-success" value="Sửa" data-bs-dismiss="modal">
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="deleteaccount" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Xoá tài khoản</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        Bạn có chắc muốn xoá tài khoản không?
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-outline-danger" value="Quay lại" data-bs-dismiss="modal">
                    <input id="btn-delete" type="button" class="btn btn-outline-success" value="Xác nhận" data-bs-dismiss="modal">
                </div>
            </div>
        </div>
    </div>
    <script src="../../js/popup.js"></script>
    <script src="../../js/user/profile.js"></script>
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