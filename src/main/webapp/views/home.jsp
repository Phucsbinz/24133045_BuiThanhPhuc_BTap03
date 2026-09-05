<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Cửa Hàng Trực Tuyến</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f8f9fa; }
        .hero-banner {
            background: linear-gradient(135deg, #007bff 0%, #00c6ff 100%);
            color: white;
            padding: 30px 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .product-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 25px;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            display: flex;
            flex-direction: column;
            height: 380px;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            border-color: #007bff;
        }
        .product-img-wrap {
            height: 190px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #ffffff;
            padding: 10px;
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
            font-size: 15px;
            font-weight: 600;
            color: #1e293b;
            margin: 0 0 5px 0;
            height: 40px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .product-price {
            font-size: 18px;
            font-weight: bold;
            color: #e11d48;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<jsp:include page="topbar.jsp" />

<div class="container">
    <!-- Hero Banner -->
    <div class="hero-banner text-center">
        <h1 style="font-weight: bold; margin-top: 0;">Chào Mừng Đến Với Cửa Hàng Công Nghệ</h1>
        <p style="font-size: 16px;">Khám phá các sản phẩm công nghệ mới nhất với mức giá ưu đãi nhất hôm nay!</p>
        <div style="margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/product" class="btn btn-warning btn-lg" style="font-weight: bold; color: #111;">
                <i class="fa fa-shopping-bag"></i> Xem Tất Cả Sản Phẩm (Phân trang 6sp/trang)
            </a>
            <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-default btn-lg" style="margin-left: 10px;">
                    <i class="fa fa-cogs"></i> Quản Trị Sản Phẩm
                </a>
            </c:if>
        </div>
    </div>

    <!-- Thông báo nếu có -->
    <c:if test="${sessionScope.account != null}">
        <div class="alert alert-success" style="border-radius: 6px;">
            <i class="fa fa-smile-o"></i> Xin chào <b>${sessionScope.account.fullName}</b>! Chúc bạn có trải nghiệm mua sắm tuyệt vời.
        </div>
    </c:if>

    <!-- Khối 10 Sản phẩm mới nhất -->
    <div class="panel panel-default" style="border-radius: 8px; border-color: #cbd5e1;">
        <div class="panel-heading" style="background-color: #fff; border-bottom: 2px solid #007bff; padding: 15px 20px;">
            <h3 class="panel-title" style="font-size: 20px; font-weight: bold; color: #007bff;">
                <i class="fa fa-bolt" style="color: #e67e22;"></i> 10 SẢN PHẨM MỚI NHẤT TRÊN TRANG CHỦ
            </h3>
        </div>
        <div class="panel-body" style="padding: 25px 15px;">
            <div class="row">
                <c:forEach items="${top10Products}" var="prod">
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="margin-bottom: 20px;">
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
                                    <c:if test="${prod.category != null}">
                                        <span class="label label-info" style="font-size: 11px;">
                                            ${prod.category.categoryname}
                                        </span>
                                    </c:if>
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
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" class="btn btn-primary btn-block btn-sm" style="font-weight: 600;">
                                        <i class="fa fa-eye"></i> Xem Chi Tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty top10Products}">
                    <div class="col-xs-12 text-center" style="padding: 40px; color: #888;">
                        <i class="fa fa-shopping-basket fa-3x" style="color: #ccc;"></i>
                        <p style="margin-top: 10px; font-size: 16px;">Hiện chưa có sản phẩm nào được cập nhật.</p>
                    </div>
                </c:if>
            </div>

            <div class="text-center" style="margin-top: 15px;">
                <a href="${pageContext.request.contextPath}/product" class="btn btn-default btn-lg" style="border: 2px solid #007bff; color: #007bff; font-weight: bold; border-radius: 25px; padding: 10px 30px;">
                    Xem Thêm Các Sản Phẩm Khác <i class="fa fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
