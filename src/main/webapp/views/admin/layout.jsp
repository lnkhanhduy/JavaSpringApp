<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Admin</title>
    <link rel="stylesheet" href="../../css/admin/layout.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
</head>
<body>
    <section class="admin-page ct-container">
        <div class="ct-navigation">
            <%int active = (int)request.getAttribute("active");%>
            <ul>
                <li>
                    <a href="#">
                        <span class="ct-title ct-page-title">Quản lý</span>
                    </a>
                </li>
                <li <%if(active == 0) {%> class="active" <%}%>>
                    <a href="/admin/">
                        <i class="fa-solid fa-house ct-icon"></i>
                        <span class="ct-title">Tổng quan</span>
                    </a>
                </li>
                <li <%if(active == 1) {%> class="active" <%}%>>
                    <a href="/admin/usermanagement">
                        <i class="fa-solid fa-user ct-icon"></i>
                        <span class="ct-title">Quản lí tài khoản</span>
                    </a>
                </li>
                <li <%if(active == 2) {%> class="active" <%}%>>
                    <a href="/admin/productmanagement">
                        <i class="fa-solid fa-book ct-icon"></i>
                        <span class="ct-title">Quản lí sản phẩm</span>
                    </a>
                </li>
                <li <%if(active == 3) {%> class="active" <%}%>>
                    <a href="/admin/ordermanagement">
                        <i class="fa-solid fa-clock-rotate-left ct-icon"></i>
                        <span class="ct-title">Quản lí đơn hàng</span>
                    </a>
                </li>
                <li>
                    <a href="/admin/logout" >
                        <i class="fa-solid fa-right-from-bracket ct-icon"></i>
                        <span class="ct-title">Đăng xuất</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="ct-content">
            <div class="ct-topbar">
                <!-- <div class="ct-toggle">
                    <i class="fa-solid fa-bars"></i>
                </div> -->
                <div></div>
                <div class="ct-user">
                    <span>Xin chào, </span>
                    <span style="color: red;">${sessionScope.fullname}</span>
                </div>
            </div>

            <section class="ct-tab-content">
                <jsp:include page='${content}'>
                    <jsp:param name="data" value=""/>
                </jsp:include>
            </section>
        </div>
    </section>

    
    <script src="../../js/admin/layout.js"></script>
</body>
</html>