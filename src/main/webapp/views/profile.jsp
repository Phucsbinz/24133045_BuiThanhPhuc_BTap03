<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Tài Khoản - Profile</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<jsp:include page="topbar.jsp" />

<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title"><i class="fa fa-id-badge"></i> Trang Thông Tin Tài Khoản (/member/myaccount)</h3>
        </div>
        <div class="panel-body">
            <div class="alert alert-success">
                <i class="fa fa-check-circle"></i> <b>Session vẫn được duy trì!</b> Bạn đang ở trang <code>/member/myaccount</code>.
            </div>

            <table class="table table-bordered table-striped" style="max-width: 600px;">
                <tr>
                    <th style="width: 200px;">ID Người Dùng</th>
                    <td><b>#${sessionScope.account.id}</b></td>
                </tr>
                <tr>
                    <th>Họ và Tên</th>
                    <td><span style="color: #0088cc; font-weight: bold;">${sessionScope.account.fullName}</span></td>
                </tr>
                <tr>
                    <th>Tên Tài Khoản</th>
                    <td>${sessionScope.account.userName}</td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td>${sessionScope.account.email}</td>
                </tr>
                <tr>
                    <th>Số Điện Thoại</th>
                    <td>${sessionScope.account.phone != null ? sessionScope.account.phone : 'Chưa có'}</td>
                </tr>
                <tr>
                    <th>Mã Phân Quyền (Role ID)</th>
                    <td>
                        <c:choose>
                            <c:when test="${sessionScope.account.roleid == 1}"><span class="label label-danger">Admin (Mức 1)</span></c:when>
                            <c:when test="${sessionScope.account.roleid == 2}"><span class="label label-warning">Manager (Mức 2)</span></c:when>
                            <c:otherwise><span class="label label-success">User thường (Mức 3)</span></c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>Ngày Tạo Tài Khoản</th>
                    <td>${sessionScope.account.createdDate}</td>
                </tr>
            </table>

            <hr>
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary"><i class="fa fa-arrow-left"></i> Chuyển về Trang Chủ (/home)</a>
                <a href="${pageContext.request.contextPath}/member/myaccount" class="btn btn-default"><i class="fa fa-refresh"></i> Tải lại trang này</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger"><i class="fa fa-sign-out"></i> Đăng Xuất</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
