<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Quản Lý - Manager Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<jsp:include page="topbar.jsp" />

<div class="container">
    <div class="panel panel-warning">
        <div class="panel-heading">
            <h3 class="panel-title">Trang Quản Lý (Manager Panel - Role ID = 2)</h3>
        </div>
        <div class="panel-body">
            <div class="alert alert-warning">
                Xin chào Quản lý: <b>${sessionScope.account.fullName}</b> (${sessionScope.account.userName})
            </div>
            <p>Trang này được điều hướng tự động bởi <code>WaitingController.java</code> khi người dùng có <code>roleid == 2</code>.</p>
            <hr>
            <a href="${pageContext.request.contextPath}/" class="btn btn-default">Về Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Đăng Xuất</a>
        </div>
    </div>
</div>

</body>
</html>
