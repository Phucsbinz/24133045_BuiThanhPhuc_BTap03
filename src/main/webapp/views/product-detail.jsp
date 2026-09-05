<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.productName} - Chi Tiết Sản Phẩm</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f8f9fa; }
        .detail-card {
            background: #fff;
            border-radius: 12px;
            padding: 35px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            margin-bottom: 35px;
        }
        .main-img-box {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            height: 380px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .main-img-box img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }
        .detail-price {
            font-size: 32px;
            font-weight: bold;
            color: #e11d48;
            margin: 15px 0;
        }
        .desc-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
            line-height: 1.7;
            font-size: 15px;
            color: #475569;
        }
        .related-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
            padding: 10px;
            text-align: center;
            height: 250px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .related-card img {
            height: 120px;
            object-fit: contain;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<jsp:include page="topbar.jsp" />

<div class="container">
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/home"><i class="fa fa-home"></i> Trang chủ</a></li>
        <li><a href="${pageContext.request.contextPath}/product">Sản phẩm</a></li>
        <c:if test="${product.category != null}">
            <li><span class="text-muted">${product.category.categoryname}</span></li>
        </c:if>
        <li class="active">${product.productName}</li>
    </ol>

    <div class="detail-card">
        <div class="row">
            <!-- Hình ảnh chi tiết lớn bên trái -->
            <div class="col-md-5 col-sm-6">
                <div class="main-img-box">
                    <c:choose>
                        <c:when test="${product.images != null && product.images.startsWith('http')}">
                            <c:url value="${product.images}" var="imgUrl"></c:url>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${product.images}" var="imgUrl"></c:url>
                        </c:otherwise>
                    </c:choose>
                    <img src="${imgUrl}" alt="${product.productName}" />
                </div>
            </div>

            <!-- Thông tin sản phẩm bên phải -->
            <div class="col-md-7 col-sm-6">
                <c:if test="${product.category != null}">
                    <span class="label label-primary" style="font-size: 13px; padding: 5px 10px;">
                        <i class="fa fa-tag"></i> ${product.category.categoryname}
                    </span>
                </c:if>

                <h1 style="font-size: 26px; font-weight: bold; margin: 15px 0 10px 0; color: #1e293b;">
                    ${product.productName}
                </h1>

                <div style="font-size: 13px; color: #888; margin-bottom: 10px;">
                    Mã sản phẩm: <b>#${product.productId}</b> | Ngày đăng: ${product.createdDate}
                </div>

                <div class="detail-price">
                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                </div>

                <div style="margin-bottom: 15px; font-size: 14px;">
                    Trạng thái:
                    <c:if test="${product.status == 1}">
                        <span class="label label-success"><i class="fa fa-check"></i> Còn hàng (Số lượng: ${product.quantity})</span>
                    </c:if>
                    <c:if test="${product.status != 1}">
                        <span class="label label-default"><i class="fa fa-ban"></i> Tạm hết hàng</span>
                    </c:if>
                </div>

                <h4><b>Mô tả sản phẩm:</b></h4>
                <div class="desc-box">
                    <c:choose>
                        <c:when test="${not empty product.description}">
                            ${product.description}
                        </c:when>
                        <c:otherwise>
                            <i>(Chưa có mô tả chi tiết cho sản phẩm này)</i>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div style="margin-top: 25px;">
                    <button type="button" class="btn btn-danger btn-lg" style="font-weight: bold; margin-right: 10px;" onclick="alert('Đã thêm [${product.productName}] vào giỏ hàng!');">
                        <i class="fa fa-cart-plus"></i> Thêm Vào Giỏ Hàng
                    </button>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-default btn-lg">
                        <i class="fa fa-arrow-left"></i> Danh Sách Sản Phẩm
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Sản phẩm cùng danh mục gợi ý -->
    <c:if test="${not empty relatedProducts}">
        <div class="panel panel-default" style="border-radius: 8px;">
            <div class="panel-heading" style="background: #fff; font-weight: bold; font-size: 16px;">
                <i class="fa fa-th-large" style="color: #007bff;"></i> Sản Phẩm Liên Quan Cùng Danh Mục
            </div>
            <div class="panel-body">
                <div class="row">
                    <c:forEach items="${relatedProducts}" var="rel" end="3">
                        <div class="col-xs-6 col-sm-3">
                            <div class="related-card">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${rel.productId}">
                                    <c:choose>
                                        <c:when test="${rel.images != null && rel.images.startsWith('http')}">
                                            <c:url value="${rel.images}" var="relImg"></c:url>
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${rel.images}" var="relImg"></c:url>
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${relImg}" alt="${rel.productName}">
                                </a>
                                <div>
                                    <h5 style="margin: 5px 0; font-weight: 600; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${rel.productId}" style="color: inherit;">
                                            ${rel.productName}
                                        </a>
                                    </h5>
                                    <div style="color: #e11d48; font-weight: bold;">
                                        <fmt:formatNumber value="${rel.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:if>
</div>

</body>
</html>
