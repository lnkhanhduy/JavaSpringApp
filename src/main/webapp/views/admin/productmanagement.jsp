<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="m-5">
        <div class="d-flex justify-content-end mb-3">
            <button class="btn btn-outline-success" onclick="openNewProductModal()"><i class="fa-solid fa-plus"></i> Thêm sản phẩm mới</button>
        </div>
        <table class="table table-hover">
            <thead class="text-center">
                <tr>
                    <th>STT</th>
                    <th>Tên</th>
                    <th>Giá</th>
                    <th>Mô tả</th>
                    <th>Số lượng</th>
                    <th>Chủ đề</th>
                    <th></th>
                </tr>
            </thead>
            <tbody class="text-center">
                <c:forEach var="flower" items="${flowers}" varStatus="loop">
                    <tr data-name="${flower.getName()}" data-price="${flower.getPrice()}" data-desc="${flower.getDescription()}" data-quantity="${flower.getQuantity()}" data-category="${flower.getCategory()}" data-image1="${flower.getImage1()}" data-image2="${flower.getImage2()}" data-image3="${flower.getImage3()}" data-image4="${flower.getImage4()}" data-image5="${flower.getImage5()}" onclick="openMoreInfoModal(this, event)">
                        <td>${loop.index+1}</td>
                        <td>${flower.getName()}</td>
                        <td>${flower.getPrice()}</td>
                        <td>${flower.getDescription()}</td>
                        <td>${flower.getQuantity()}</td>
                        <td>${flower.getCategory()}</td>
                        <td>
                            <div>
                                <a data-id="${flower.getId()}" data-name="${flower.getName()}" data-price="${flower.getPrice()}" data-desc="${flower.getDescription()}" data-quantity="${flower.getQuantity()}" data-category="${flower.getCategory()}" class="text-info me-2" href="#" onclick="openEditProductModal(this); return false;">Sửa</a>
                                <a data-id="${flower.getId()}" data-name="${flower.getName()}" class="text-danger" href="#" onclick="openDeleteProductModal(this)">Xoá</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>    
            </tbody>
        </table>
    </div>
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Thêm sản phẩm mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>    
                </div>
                <div class="modal-body">
                    <form action="/admin/productmanagement/add" id="addform" method="post" class="needs-validation" enctype="multipart/form-data" novalidate>
                        <div class="mb-3">
                            <label for="name-product" class="form-label">Tên</label>
                            <input type="text" class="form-control" id="name-product" name="name-product" value="" required>
                            <div class="invalid-feedback">
                              Vui lòng điền tên sản phẩm!
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="price-product" class="form-label">Price</label>
                            <input type="text" class="form-control" id="price-product" name="price-product" value="" required>
                            <div class="invalid-feedback">
                                Vui lòng điền giá sản phẩm!
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="desc-product" class="form-label">Description</label>
                            <textarea class="form-control" id="desc-product" name="desc-product" required></textarea>
                            <div class="invalid-feedback">
                                Vui lòng điền mô tả sản phẩm!
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="quantity-product" class="form-label">Số lượng</label>
                            <input type="text" class="form-control" id="quantity-product" name="quantity-product" value="" required>
                            <div class="invalid-feedback">
                                Vui lòng điền giá sản phẩm!
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="category" class="form-label">Chủ đề</label>
                            <select id="category" class="form-select" aria-label="category" name="category-product">
                                <option value="Mặc định" selected>Mặc định</option>
                                <option value="Hoa sinh nhật">Hoa sinh nhật</option>
                                <option value="Hoa chúc mừng">Hoa chúc mừng</option>
                                <option value="Hoa tình yêu">Hoa tình yêu</option>
                                <option value="Hoa khai trương">Hoa khai trương</option>
                                <option value="Hoa đám cưới">Hoa đám cưới</option>
                                <option value="Hoa ngoại nhập">Hoa ngoại nhập</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="images-product" class="form-label">Hình ảnh</label>
                            <input type="file" class="form-control" id="images-product" name="images-product" multiple required accept="image/*">
                            <div class="invalid-feedback">
                              Tối đa 5 hình ảnh!
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-outline-secondary" data-bs-dismiss="modal">Quay lại</button>
                    <input type="submit" form="addform" class="btn btn-outline-success" value="Thêm">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Sửa sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/admin/productmanagement/edit" id="editform" method="post" enctype="multipart/form-data">
                        <input type="text" class="form-control" id="id-product" name="id-product" value="" hidden>
                        <div class="mb-3">
                            <label for="name-product" class="form-label">Tên</label>
                            <input type="text" class="form-control" id="name-product" name="name-product" value="Mark">
                            
                        </div>
                        <div class="mb-3">
                            <label for="price-product" class="form-label">Giá</label>
                            <input type="text" class="form-control" id="price-product" name="price-product" value="Mark">
                            
                        </div>
                        <div class="mb-3">
                            <label for="desc-product" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="desc-product" name="desc-product"></textarea>
                            
                        </div>
                        <div class="mb-3">
                            <label for="quantity-product" class="form-label">Số lượng</label>
                            <input type="text" class="form-control" id="quantity-product" name="quantity-product" value="Mark">
                        </div>
                        <div class="mb-3">
                            <label for="category" class="form-label">Chủ đề</label>
                            <select id="category-product" class="form-select" aria-label="category" name="category-product">
                                <option value="Mặc định">Mặc định</option>
                                <option value="Hoa sinh nhật">Hoa sinh nhật</option>
                                <option value="Hoa chúc mừng">Hoa chúc mừng</option>
                                <option value="Hoa tình yêu">Hoa tình yêu</option>
                                <option value="Hoa khai trương">Hoa khai trương</option>
                                <option value="Hoa đám cưới">Hoa đám cưới</option>
                                <option value="Hoa ngoại nhập">Hoa ngoại nhập</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="images-product" class="form-label">Hình ảnh</label>
                            <input type="file" class="form-control" id="images-product" name="images-product" multiple accept="image/*">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-outline-secondary" data-bs-dismiss="modal">Quay lại</button>
                    <input type="submit" form="editform" class="btn btn-outline-success" value="Sửa" data-bs-dismiss="modal">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="moreInfoProductModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Thông tin sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="name-product" class="form-label">Tên</label>
                        <input type="text" class="form-control" id="name-product" value="" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="price-product" class="form-label">Giá</label>
                        <input type="text" class="form-control" id="price-product" value="" disabled> 
                    </div>
                    <div class="mb-3">
                        <label for="desc-product" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="desc-product" placeholder="Description" disabled></textarea>
                        
                    </div>
                    <div class="mb-3">
                        <label for="quantity-product" class="form-label">Số lượng</label>
                        <input type="text" class="form-control" id="quantity-product" value="" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="category-product" class="form-label">Chủ đề</label>
                        <input type="text" class="form-control" id="category-product" value="" disabled> 
                    </div>
                    <div class="mb-3">
                        <label for="images-product" class="form-label">Hình ảnh</label>
                        <div class="row">
                            <div class="col-2"><img id="image1" src="" alt="" width="100%" style="object-fit: cover;"></div>
                            <div class="col-2"><img id="image2" src="" alt="" width="100%" style="object-fit: cover;"></div>
                            <div class="col-2"><img id="image3" src="" alt="" width="100%" style="object-fit: cover;"></div>
                            <div class="col-2"><img id="image4" src="" alt="" width="100%" style="object-fit: cover;"></div>
                            <div class="col-2"><img id="image5" src="" alt="" width="100%" style="object-fit: cover;"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <input type="button" class="btn btn-outline-success" value="Ok" data-bs-dismiss="modal">
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../../components/confirmModal.jsp">
        <jsp:param name="idModal" value="deleteProductModal" />
        <jsp:param name="titleModal" value="Xoá sản phẩm" />
        <jsp:param name="contentModal" value="Bạn có chắc muốn xoá sản phẩm này?" />
        <jsp:param name="idBtn" value="btn-delete-flower" />
    </jsp:include>
    <script src="../../js/admin/productmanagement.js"></script>
    <script src="../../js/formvalidation.js"></script>