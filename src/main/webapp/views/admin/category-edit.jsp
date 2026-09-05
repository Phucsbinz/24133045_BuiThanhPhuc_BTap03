<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Danh Mục - Edit Category</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f9f9f9; }
        .form-box { max-width: 600px; margin: 20px auto; background: #fff; padding: 25px; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .preview-img { object-fit: contain; margin-bottom: 12px; border: 1px solid #ccc; padding: 4px; background: #fff; }
    </style>
</head>
<body>

<jsp:include page="../topbar.jsp" />

<div class="container">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/admin/home"><i class="fa fa-dashboard"></i> Admin Home</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/categories">Quản lý Danh mục</a></li>
        <li class="active">Chỉnh sửa #${cate.categoryid}</li>
    </ol>

    <div class="form-box">
        <h3 style="margin-top: 0; color: #337ab7;"><i class="fa fa-pencil"></i> Chỉnh Sửa Danh Mục</h3>
        <hr>

        <!-- Form theo đúng noidung.txt -->
        <form action="<c:url value="/admin/category/update"/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="categoryid" value="${cate.categoryid}">

            <div class="form-group">
                <label for="categoryname">Category name (Tên danh mục):</label>
                <input type="text" class="form-control" id="categoryname" name="categoryname" value="${cate.categoryname}" required>
            </div>

            <div class="form-group">
                <label for="images">Link images (Đường dẫn ảnh Online nếu có):</label>
                <input type="text" class="form-control" id="images" name="images" value="${cate.images}">
            </div>

            <div class="form-group">
                <label>Ảnh hiện tại:</label><br>
                <c:choose>
                    <c:when test="${cate.images != null && cate.images.startsWith('http')}">
                        <c:url value="${cate.images}" var="imgUrl"></c:url>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                    </c:otherwise>
                </c:choose>
                <img height="120" width="180" src="${imgUrl}" class="preview-img" alt="${cate.categoryname}"><br>

                <label for="images1">Upload images mới (nếu muốn thay đổi):</label>
                <input type="file" class="form-control" id="images1" name="images1">
            </div>

            <div class="form-group">
                <label>Status (Trạng thái):</label><br>
                <label class="radio-inline">
                    <input type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}> Hoạt động
                </label>
                <label class="radio-inline">
                    <input type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}> Khóa
                </label>
            </div>

            <hr>
            <input type="submit" class="btn btn-primary" value="Update">
            <a href="<c:url value="/admin/categories"/>" class="btn btn-default">Hủy / Quay lại</a>
        </form>
    </div>
</div>

</body>
</html>
