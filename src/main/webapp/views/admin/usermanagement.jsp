<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <div class="m-5">
    <table class="table table-hover">
      <thead class="text-center">
        <tr>
          <th>STT</th>
          <th>Tên đăng nhập</th>
          <th>Họ và tên</th>
          <th>Email</th>
          <th></th>
        </tr>
      </thead>
      <tbody class="text-center">
        <c:forEach var="account" items="${accounts}" varStatus="loop">
          <tr>
            <td>${loop.index+1}</td>
            <td>${account.getUsername()}</td>
            <td>${account.getFullname()}</td>
            <td>${account.getEmail()}</td>
            <!-- <td>Hash Password</td> -->
            <td><a onclick="resetAccount(this)" data-username="${account.getUsername()}" class="text-info me-2" href="#" data-bs-toggle="modal" data-bs-target="#modalHandleReset">Đặt lại mật khẩu</a>
              <a onclick="deleteAccount(this)" data-username="${account.getUsername()}" class="text-danger" href="#" data-bs-toggle="modal" data-bs-target="#modalHandleRDelete">Xoá</a></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

  <jsp:include page="../../components/confirmModal.jsp">
    <jsp:param name="idModal" value="modalHandleReset" />
    <jsp:param name="titleModal" value="Đặt lại mật khẩu" />
    <jsp:param name="contentModal" value="Bạn có chắc muốn đặt lại mật khẩu tài khoản này?" />
    <jsp:param name="idBtn" value="btn-reset-account" />
  </jsp:include>
  <jsp:include page="../../components/confirmModal.jsp">
    <jsp:param name="idModal" value="modalHandleRDelete" />
    <jsp:param name="titleModal" value="Xoá tài khoản" />
    <jsp:param name="contentModal" value="Bạn có chắc muốn xoá tài khoản này?" />
    <jsp:param name="idBtn" value="btn-delete-account" />
  </jsp:include>

  <script src="../../js/admin/usermanagement.js"></script>
