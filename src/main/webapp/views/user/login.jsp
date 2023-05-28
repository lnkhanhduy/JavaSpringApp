<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="../../css/user/login.css">
    <link rel="stylesheet" href="../../css/popup.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.2/jquery.min.js" integrity="sha512-tWHlutFnuG0C6nQRlpvrEhE4QpkG1nn2MOUMWmUeRePl4e3Aki0VB6W1v3oLjFtd0hVOtRQ9PHpSfN6u6/QXkQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
    crossorigin="anonymous"></script>
</head>
<body>
    <div id="pp-toast">
    </div>
    <section class="validation-box">
        <div class="validation-container">
            <div class="bg-container">
                <div class="box signin">
                    <div class="fs-5 text-white mb-2">Bạn đã có tài khoản?</div>
                    <button class="ct-btn changeSigninFormBtn" style="--ct-color: #f43648">Đăng nhập</button>
                </div>
                <div class="box signup">
                    <div class="fs-5 text-white mb-2">Bạn chưa có tài khoản?</div>
                    <button class="ct-btn changeSignupFormBtn" style="--ct-color: #03a9f4">Đăng kí</button>
                </div>
            </div>
            <div class="formBox">
                <div class="form siginForm">
                    <form action="/login" method="post">
                        <div class="fs-4 form-title">Đăng nhập</div>
                        <input id="login-username" name="login-username" value=""  class="form-input" type="text" placeholder="Tên đăng nhập" autocomplete="off">
                        <input id="login-password" name="login-password" class="form-input" type="password" placeholder="Mật khẩu">
                        <div id="login-message" class="text-danger mb-2"></div>
                        <input id="btnLogin" class="form-input" type="submit" value="Đăng nhập" style="--ct-color: #03a9f4">
                        <a href="#" onclick="openForgotModal(this)">Quên mật khẩu</a>
                    </form>
                </div>

                <div class="form signupForm">
                    <form action="/signup" method="post">
                        <div class="fs-4 form-title">Đăng ký</div>
                        <input id="signup-username" name="signup-username" value="${signup-username!=0?signup-username:''}" class="form-input" type="text" placeholder="Tên đăng nhập" autocomplete="off">
                        <input id="signup-fullname" name="signup-fullname" value="${signup-fullname!=0?signup-fullname:''}" class="form-input" type="text" placeholder="Họ và tên" autocomplete="off">
                        <input id="signup-email" name="signup-email" value="${signup-email!=0?signup-email:''}"  class="form-input" type="email" placeholder="Email" autocomplete="off">
                        <input id="signup-password" name="signup-password" class="form-input" type="password" placeholder="Mật khẩu">
                        <input id="signup-confirmPassword" name="signup-confirmPassword" class="form-input" type="password" placeholder="Nhập lại mật khẩu">
                        <div id="signup-message" class="text-danger mb-2"></div>
                        <input id="btnSignup" class="form-input" type="submit" value="Đăng kí" style="--ct-color: #f43648">
                    </form>
                </div>
            </div>                    	
        </div>
    </section>
  
    <div class="modal fade" id="forgotpasswordmodal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Quên mật khẩu</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="forgot-email" class="form-label">Nhập email của bạn</label>
                        <input type="email" class="form-control" id="forgot-email" value="">
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-outline-danger" value="Quay lại" data-bs-dismiss="modal">
                    <input id="btn-send" type="button" class="btn btn-outline-success" value="Gửi" data-bs-dismiss="modal">
                </div>
            </div>
        </div>
    </div>
    <script src="../../js/login.js"></script>
    <script src="../../js/popup.js"></script>
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