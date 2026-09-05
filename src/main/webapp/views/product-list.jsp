<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm - Phân Trang 6sp/Trang</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f8f9fa; }
        .product-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 30px;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            display: flex;
            flex-direction: column;
            height: 400px;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.12);
            border-color: #007bff;
        }
        .product-img-wrap {
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #ffffff;
            padding: 15px;
            border-bottom: 1px solid #f1f5f9;
        }
        .product-img-wrap img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }
        .product-info {
            padding: 15px;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .product-name {
            font-size: 16px;
            font-weight: 600;
            color: #1e293b;
            margin: 0 0 5px 0;
            height: 44px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .product-price {
            font-size: 20px;
            font-weight: bold;
            color: #e11d48;
            margin-bottom: 10px;
        }
        .pagination > .active > a, .pagination > .active > a:focus, .pagination > .active > a:hover {
            background-color: #007bff;
            border-color: #007bff;
        }
    </style>
</head>
<body>

<jsp:include page="topbar.jsp" />

<div class="container">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/home"><i class="fa fa-home"></i> Trang chủ</a></li>
        <li class="active">Danh sách sản phẩm (URL: /product)</li>
    </ol>

    <div class="row" style="margin-bottom: 20px;">
        <div class="col-sm-8">
            <h2 style="margin: 0; font-weight: bold; color: #1e293b;">
                <i class="fa fa-shopping-bag" style="color: #007bff;"></i> TẤT CẢ SẢN PHẨM
            </h2>
            <p class="text-muted" style="margin-top: 5px;">
                Hiển thị phân trang <b>6 sản phẩm / trang</b> (Tổng số: <b>${totalProducts}</b> sản phẩm)
            </p>
        </div>
        <div class="col-sm-4 text-right">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-default">
                <i class="fa fa-arrow-left"></i> Về Trang Chủ
            </a>
        </div>
    </div>

    <!-- Lưới 6 sản phẩm mỗi trang -->
    <div class="row">
        <c:forEach items="${productList}" var="prod">
            <div class="col-xs-12 col-sm-6 col-md-4">
                <div class="product-card">
                    <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="product-img-wrap">
                        <c:choose>
                            <c:when test="${prod.images != null && prod.images.startsWith('http')}">
                                <c:url value="${prod.images}" var="imgUrl"></c:url>
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${prod.images}" var="imgUrl"></c:url>
                            </c:otherwise>
                        </c:choose>
                        <img src="${imgUrl}" alt="${prod.productName}" />
                    </a>
                    <div class="product-info">
                        <div>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <c:if test="${prod.category != null}">
                                    <span class="label label-primary" style="font-size: 11px;">
                                        ${prod.category.categoryname}
                                    </span>
                                </c:if>
                                <span class="text-muted" style="font-size: 12px;">
                                    Còn: <b>${prod.quantity}</b>
                                </span>
                            </div>
                            <h4 class="product-name" style="margin-top: 8px;">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" style="color: inherit; text-decoration: none;">
                                    ${prod.productName}
                                </a>
                            </h4>
                        </div>
                        <div>
                            <div class="product-price">
                                <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </div>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="btn btn-primary btn-block" style="font-weight: 600;">
                                <i class="fa fa-info-circle"></i> Xem Chi Tiết Sản Phẩm
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty productList}">
            <div class="col-xs-12 text-center" style="padding: 60px; color: #888;">
                <i class="fa fa-folder-open-o fa-3x"></i>
                <p style="margin-top: 15px; font-size: 16px;">Hiện chưa có sản phẩm nào để hiển thị.</p>
            </div>
        </c:if>
    </div>

    <!-- Thanh phân trang 6 sản phẩm / trang -->
    <c:if test="${totalPages > 1}">
        <div class="text-center" style="margin: 30px 0 50px 0;">
            <ul class="pagination pagination-lg">
                <!-- Nút Trang trước -->
                <c:if test="${currentPage > 1}">
                    <li>
                        <a href="<c:url value='/product?page=${currentPage - 1}'/>" aria-label="Previous">
                            <span aria-hidden="true">&laquo; Trước</span>
                        </a>
                    </li>
                </c:if>

                <!-- Các trang số -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="${currentPage == i ? 'active' : ''}">
                        <a href="<c:url value='/product?page=${i}'/>">${i}</a>
                    </li>
                </c:forEach>

                <!-- Nút Trang sau -->
                <c:if test="${currentPage < totalPages}">
                    <li>
                        <a href="<c:url value='/product?page=${currentPage + 1}'/>" aria-label="Next">
                            <span aria-hidden="true">Tiếp &raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </c:if>
</div>

</body>
</html>
