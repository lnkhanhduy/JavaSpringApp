<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="ct-dashboard">
    <div class="ct-card-box">
        <div class="ct-card">
            <div>
                <div class="ct-number">${flower_sold}</div>
                <div class="ct-card-name">Sản phẩm bán hôm nay</div>
            </div>
            <div class="ct-icon-card" style="--i: #0000ff">
                <i class="fa-solid fa-check" ></i>
            </div>
        </div>
        <div class="ct-card">
            <div>
                <div class="ct-number">${order_waiting}</div>
                <div class="ct-card-name">Đơn hàng chờ duyệt</div>
            </div>
            <div class="ct-icon-card" style="--i: #0000ff">
                <i class="fa-solid fa-question"></i>
            </div>
        </div>
        <div class="ct-card">
            <div>
                <div class="ct-number">${total_today}</div>
                <div class="ct-card-name">Doanh thu hôm nay</div>
            </div>
            <div class="ct-icon-card" style="--i: #0000ff">
                <i class="fa-solid fa-money-bill"></i>
            </div>
        </div>
    </div>
</div>