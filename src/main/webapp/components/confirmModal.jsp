<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%  String idModal = (String)request.getParameter("idModal");
    String titleModal = (String)request.getParameter("titleModal");
    String contentModal = (String)request.getParameter("contentModal");
    String idBtn = (String)request.getParameter("idBtn");
%>
    <div class="modal fade" id="<%=idModal%>" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel"><%=titleModal%></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <%=contentModal%>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="button" class="btn btn-outline-danger" id="<%=idBtn%>">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>