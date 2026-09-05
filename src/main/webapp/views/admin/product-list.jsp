<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sản Phẩm - Admin Product Management</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f9f9f9; }
        .table img { object-fit: contain; background: #fff; padding: 4px; border: 1px solid #ddd; }
    </style>
</head>
<body>

<jsp:include page="../topbar.jsp" />

<div class="container" style="padding-top: 10px;">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/admin/home"><i class="fa fa-dashboard"></i> Admin Home</a></li>
        <li class="active">Quản lý Sản phẩm</li>
    </ol>

    <div class="panel panel-info">
        <div class="panel-heading">
            <h3 class="panel-title" style="font-size: 18px; font-weight: bold;">
                <i class="fa fa-cubes"></i> Quản Lý Sản Phẩm (JPA 3.0 Products - 1:N Category)
            </h3>
        </div>
        <div class="panel-body">
            <p>
                <a href="<c:url value="/admin/product/add"/>" class="btn btn-success">
                    <i class="fa fa-plus"></i> Thêm Sản Phẩm Mới (Add Product)
                </a>
                <a href="<c:url value="/admin/categories"/>" class="btn btn-default" style="margin-left: 10px;">
                    <i class="fa fa-folder"></i> Sang Quản lý Danh mục
                </a>
                <a href="<c:url value="/product"/>" class="btn btn-warning pull-right" target="_blank">
                    <i class="fa fa-external-link"></i> Xem Trang Sản Phẩm Khách (/product)
                </a>
            </p>
            <hr>

            <table class="table table-bordered table-striped table-hover">
                <thead>
                    <tr class="info">
                        <th style="width: 50px;">STT</th>
                        <th style="width: 140px;">Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th style="width: 130px;">Giá bán</th>
                        <th style="width: 130px;">Danh mục</th>
                        <th style="width: 80px; text-align: center;">Số lượng</th>
                        <th style="width: 100px; text-align: center;">Trạng thái</th>
                        <th style="width: 140px; text-align: center;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listproduct}" var="prod" varStatus="STT">
                        <tr>
                            <td><b>${STT.index + 1}</b></td>
                            <td>
                                <c:choose>
                                    <c:when test="${prod.images != null && prod.images.startsWith('http')}">
                                        <c:url value="${prod.images}" var="imgUrl"></c:url>
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${prod.images}" var="imgUrl"></c:url>
                                    </c:otherwise>
                                </c:choose>
                                <img height="80" width="110" src="${imgUrl}" alt="${prod.productName}" />
                            </td>
                            <td>
                                <span style="font-size: 15px; font-weight: bold; color: #337ab7;">
                                    ${prod.productName}
                                </span>
                                <div style="font-size: 12px; color: #888;">ID: #${prod.productId} | Ngày tạo: ${prod.createdDate}</div>
                                <div style="font-size: 13px; color: #555; margin-top: 4px;">
                                    ${prod.description != null ? (prod.description.length() > 60 ? prod.description.substring(0, 60).concat('...') : prod.description) : ''}
                                </div>
                            </td>
                            <td>
                                <span style="color: #d9534f; font-weight: bold; font-size: 15px;">
                                    <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </span>
                            </td>
                            <td>
                                <c:if test="${prod.category != null}">
                                    <span class="label label-primary" style="font-size: 12px;">
                                        ${prod.category.categoryname}
                                    </span>
                                </c:if>
                                <c:if test="${prod.category == null}">
                                    <span class="text-muted">Chưa phân loại</span>
                                </c:if>
                            </td>
                            <td style="text-align: center;">
                                <b>${prod.quantity}</b>
                            </td>
                            <td style="text-align: center;">
                                <c:if test="${prod.status == 1}">
                                    <span class="label label-success">Đang bán</span>
                                </c:if>
                                <c:if test="${prod.status != 1}">
                                    <span class="label label-default">Ngừng bán</span>
                                </c:if>
                            </td>
                            <td style="text-align: center;">
                                <a href="<c:url value='/admin/product/edit?id=${prod.productId}'/>" class="btn btn-primary btn-xs">
                                    <i class="fa fa-pencil"></i> Sửa
                                </a>
                                <a href="<c:url value='/admin/product/delete?id=${prod.productId}'/>" class="btn btn-danger btn-xs" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
                                    <i class="fa fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty listproduct}">
                        <tr>
                            <td colspan="8" class="text-center" style="padding: 40px; color: #888;">
                                <i class="fa fa-box-open fa-2x"></i><br>
                                Chưa có sản phẩm nào. Hãy bấm <b>Thêm Sản Phẩm Mới</b> để tạo sản phẩm đầu tiên!
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
