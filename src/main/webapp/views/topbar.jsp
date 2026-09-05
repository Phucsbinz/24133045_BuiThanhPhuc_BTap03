<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
    .topbar-wrapper {
        background-color: #f8f8f8;
        border-bottom: 1px solid #e7e7e7;
        padding: 10px 0;
        margin-bottom: 20px;
    }
    .right-topbar {
        margin: 0;
    }
    .right-topbar li {
        padding: 0 6px;
    }
    .right-topbar a {
        color: #333;
        text-decoration: none;
    }
    .right-topbar a:hover {
        color: #0088cc;
    }
</style>

<div class="topbar-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-sm-5">
                <a href="${pageContext.request.contextPath}/home" style="font-weight:bold; color:#333; text-decoration:none; font-size:16px;">
                    <i class="fa fa-university"></i> HCMUTE - JPA Store
                </a>
                <a href="${pageContext.request.contextPath}/home" style="margin-left: 15px; color: #555; text-decoration: none;">
                    <i class="fa fa-home"></i> Trang chủ
                </a>
                <a href="${pageContext.request.contextPath}/product" style="margin-left: 12px; color: #007bff; font-weight: bold; text-decoration: none;">
                    <i class="fa fa-shopping-bag"></i> Sản phẩm (6sp/trang)
                </a>
            </div>

            <!-- Phân quyền hiển thị theo tài khoản đăng nhập -->
            <c:choose>
                <c:when test="${sessionScope.account == null}">
                    <div class="col-sm-7">
                        <ul class="list-inline right-topbar pull-right">
                            <li><a href="${pageContext.request.contextPath}/login"><i class="fa fa-sign-in"></i> Đăng nhập</a></li>
                            <li>|</li>
                            <li><a href="${pageContext.request.contextPath}/register"><i class="fa fa-user-plus"></i> Đăng ký (Kích hoạt OTP)</a></li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="col-sm-7">
                        <ul class="list-inline right-topbar pull-right">
                            <c:if test="${sessionScope.account.roleid == 1}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/admin/products" class="text-success" style="font-weight: bold;">
                                        <i class="fa fa-cubes"></i> QL Sản phẩm
                                    </a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/admin/categories" class="text-primary" style="font-weight: bold;">
                                        <i class="fa fa-folder-open"></i> QL Danh mục
                                    </a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/admin/home">
                                        <i class="fa fa-dashboard"></i> Admin
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${sessionScope.account.roleid == 2}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/manager/home">
                                        <i class="fa fa-briefcase"></i> Manager
                                    </a>
                                </li>
                            </c:if>
                            <li>
                                <a href="${pageContext.request.contextPath}/profile">
                                    <i class="fa fa-user"></i> <b>${sessionScope.account.fullName}</b>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/logout" class="text-danger">
                                    <i class="fa fa-sign-out"></i> Đăng Xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
