<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Sản Phẩm Mới - Add Product</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f9f9f9; }
        .form-card { max-width: 680px; margin: 20px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 1px 4px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<jsp:include page="../topbar.jsp" />

<div class="container">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/admin/home"><i class="fa fa-dashboard"></i> Admin Home</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/products">Quản lý Sản phẩm</a></li>
        <li class="active">Thêm mới</li>
    </ol>

    <div class="form-card">
        <h3 style="margin-top: 0; color: #337ab7;"><i class="fa fa-plus-circle"></i> Thêm Sản Phẩm Mới</h3>
        <hr>

        <form action="<c:url value="/admin/product/insert"/>" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="productName">Tên sản phẩm (*):</label>
                <input type="text" class="form-control" id="productName" name="productName" placeholder="Nhập tên sản phẩm..." required>
            </div>

            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="categoryId">Danh mục sản phẩm (*):</label>
                        <select class="form-control" id="categoryId" name="categoryId" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.categoryid}">${c.categoryname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="price">Giá bán (VNĐ) (*):</label>
                        <input type="number" class="form-control" id="price" name="price" min="0" step="1000" placeholder="Ví dụ: 15000000" required>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="quantity">Số lượng tồn kho:</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" min="0" value="10" required>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label>Trạng thái kinh doanh:</label><br>
                        <label class="radio-inline">
                            <input type="radio" name="status" value="1" checked> Đang bán
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="status" value="0"> Ngừng bán
                        </label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="images">Đường dẫn ảnh Online (nếu có):</label>
                <input type="text" class="form-control" id="images" name="images" placeholder="https://example.com/product.jpg">
            </div>

            <div class="form-group">
                <label for="images1">Tải ảnh sản phẩm từ máy tính:</label>
                <input type="file" class="form-control" id="images1" name="images1">
            </div>

            <div class="form-group">
                <label for="description">Mô tả sản phẩm:</label>
                <textarea class="form-control" id="description" name="description" rows="4" placeholder="Nhập thông tin chi tiết cấu hình, tính năng của sản phẩm..."></textarea>
            </div>

            <hr>
            <button type="submit" class="btn btn-primary btn-lg">
                <i class="fa fa-save"></i> Lưu Sản Phẩm (Insert)
            </button>
            <a href="<c:url value="/admin/products"/>" class="btn btn-default btn-lg">Hủy / Quay lại</a>
        </form>
    </div>
</div>

</body>
</html>
