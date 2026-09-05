<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Quản Trị - Admin Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<jsp:include page="topbar.jsp" />

<div class="container">
    <div class="panel panel-danger">
        <div class="panel-heading">
            <h3 class="panel-title" style="font-size: 18px; font-weight: bold;">
                <i class="fa fa-dashboard"></i> Trang Quản Trị Viên (Admin Panel - Role ID = 1)
            </h3>
        </div>
        <div class="panel-body">
            <div class="alert alert-danger">
                Xin chào Quản trị viên: <b>${sessionScope.account.fullName}</b> (${sessionScope.account.userName})
            </div>
            <p>Trang này được điều hướng tự động bởi <code>WaitingController.java</code> khi người dùng có <code>roleid == 1</code>.</p>
            <hr>
            <h4><i class="fa fa-cogs"></i> Chức năng quản lý:</h4>
            <div style="margin: 15px 0;">
                <div style="margin-bottom: 12px;">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-success btn-lg" style="margin-right: 10px;">
                        <i class="fa fa-cubes"></i> Quản Lý Sản Phẩm (Products)
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-default btn-lg" style="margin-right: 10px;">
                        <i class="fa fa-plus"></i> Thêm Sản Phẩm Mới
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-primary btn-lg" style="margin-right: 10px;">
                        <i class="fa fa-list"></i> Quản Lý Danh Mục (Categories)
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-default btn-lg" style="margin-right: 10px;">
                        <i class="fa fa-plus"></i> Thêm Danh Mục Mới
                    </a>
                </div>
            </div>
            <hr>
            <a href="${pageContext.request.contextPath}/product" class="btn btn-warning" target="_blank">
                <i class="fa fa-external-link"></i> Xem Trang Khách Hàng (/product)
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-default">
                <i class="fa fa-home"></i> Về Trang Chủ
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                <i class="fa fa-sign-out"></i> Đăng Xuất
            </a>
        </div>
    </div>
</div>

</body>
</html>
