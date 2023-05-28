<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tất cả hoa</title>
    <link rel="stylesheet" href="../../css/user/flowerlist.css">
    <link rel="stylesheet" href="../../css/user/header.css">
    <link rel="stylesheet" href="../../css/popup.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
    crossorigin="anonymous"></script>
</head>

<body>
    <%@include file="../../components/header.jsp" %>
    <div id="pp-toast">
    </div>
    <section class="flower-list container m-header">
        <div class="row">
            <div class="col-4">
                <div class="filter-title">Tìm kiếm sản phẩm</div>
                <form action="../flowers" method="post">
                    <div class="mb-3">
                        <label for="sort-asc-desc" class="form-label">Sắp xếp theo giá</label>
                        <select id="sort-asc-desc" class="form-select" aria-label="Sort" name="sort-price">
                            <c:set var="val" value="${sort_price}"/>
                            <c:choose> 
                            <c:when test="${val == '1'}">
                                <option value="0">Chọn thứ tự</option>
                                <option value="1" selected>Thấp đến cao</option>
                                <option value="2">Cao đến thấp</option>
                            </c:when>
                            <c:when test="${val == '2'}">
                                <option value="0">Chọn thứ tự</option>
                                <option value="1">Thấp đến cao</option>
                                <option value="2" selected>Cao đến thấp</option>
                            </c:when>
                            <c:otherwise>
                                <option value="0" selected>Chọn thứ tự</option>
                                <option value="1">Thấp đến cao</option>
                                <option value="2">Cao đến thấp</option>
                            </c:otherwise>
                            </c:choose>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="sort-price-inrange" class="form-label">Khoảng giá</label>
                        <div class="input-group">
                            <span class="ct-input-group-text">Từ</span>
                            <input type="text" class="form-control" name="price-from" placeholder="From" value="${price_from}"
                                aria-label="form">
                            <span class="ct-input-group-text ms-2">Đến</span>
                            <input type="text" class="form-control" name="price-to" placeholder="To" value="${price_to}" aria-label="to">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="sort-az" class="form-label">Sắp xếp theo tên</label>
                        <select id="sort-az" class="form-select" aria-label="sort-az" name="sort-name">
                            <c:set var="val" value="${sort_name}"/>
                            <c:choose> 
                            <c:when test="${val == '1'}">
                                <option value="0">Từ A->Z</option>
                                <option value="1" selected>Từ Z->A</option>
                            </c:when>
                            <c:otherwise>
                                <option value="0" selected>Từ A->Z</option>
                                <option value="1">Từ Z->A</option>
                            </c:otherwise>
                            </c:choose>  
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="byname" class="form-label">Tìm theo tên</label>
                        <input id="byname" type="text" class="form-control" name="byname" value="${name}">
                    </div>
                    <button class="ct-outline-button" style="--ct-color: blue">Tìm kiếm</button>
                </form>
            </div>  
            <div class="col-8">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-2">
                    <c:forEach var="flower" items="${flowers}">
                        <div class="col">
                            <div class="card" style="width: 100%; height: 300px;">
                                <img src="../../images/${flower.getImage1()}" class="card-img-top" alt="Hình ảnh" style="object-fit: cover; height: 185px;">
                                <div class="ct-card-flip">
                                    <div class="ct-flip-box">
                                        <div class="card-body ct-card-front">
                                            <div class="card-title text-center">${flower.getName()}</div>
                                            <p class="ct-text-gray text-center text-danger">${flower.getPrice()} VND</p>
                                        </div>
                                        <div class="card-body ct-card-back">
                                            <a href="/flowerinfo/${flower.getId()}" class="ct-outline-button" style="--ct-color: green">Xem chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
    
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