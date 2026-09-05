<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách danh mục - Category List</title>
    <!-- Bootstrap 3 & Font Awesome -->
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
        <li class="active">Quản lý Danh mục</li>
    </ol>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title" style="font-size: 18px; font-weight: bold;">
                <i class="fa fa-list"></i> Quản Lý Danh Mục (JPA 3.0 &amp; Jakarta 6.0)
            </h3>
        </div>
        <div class="panel-body">
            <p>
                <a href="<c:url value="/admin/category/add"/>" class="btn btn-success">
                    <i class="fa fa-plus"></i> Add Category (Thêm danh mục)
                </a>
                <a href="<c:url value="/admin/home"/>" class="btn btn-default pull-right">
                    <i class="fa fa-arrow-left"></i> Quay lại Admin Home
                </a>
            </p>
            <hr>

            <!-- Bảng Category theo đúng noidung.txt -->
            <table class="table table-bordered table-striped table-hover">
                <thead>
                    <tr class="info">
                        <th style="width: 60px;">STT</th>
                        <th style="width: 220px;">Images</th>
                        <th>Category name</th>
                        <th style="width: 140px;">Status</th>
                        <th style="width: 150px; text-align: center;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listcate}" var="cate" varStatus="STT">
                        <tr>
                            <td><b>${STT.index + 1}</b></td>

                            <c:choose>
                                <c:when test="${cate.images != null && cate.images.startsWith('http')}">
                                    <c:url value="${cate.images}" var="imgUrl"></c:url>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                                </c:otherwise>
                            </c:choose>

                            <td>
                                <img height="120" width="180" src="${imgUrl}" alt="${cate.categoryname}" />
                            </td>
                            <td>
                                <span style="font-size: 16px; font-weight: 600;">${cate.categoryname}</span>
                                <div style="font-size: 12px; color: #888;">ID: #${cate.categoryid}</div>
                            </td>
                            <td>
                                <c:if test="${cate.status == 1}">
                                    <span class="label label-success">Hoạt động</span>
                                </c:if>
                                <c:if test="${cate.status != 1}">
                                    <span class="label label-danger">Khóa</span>
                                </c:if>
                            </td>
                            <td style="text-align: center;">
                                <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-primary btn-sm">
                                    <i class="fa fa-edit"></i> Sửa
                                </a>
                                <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                    <i class="fa fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty listcate}">
                        <tr>
                            <td colspan="5" class="text-center" style="padding: 30px; color: #888;">
                                Chưa có danh mục nào. Hãy bấm <b>Add Category</b> để thêm mới!
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
