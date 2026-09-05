<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu - Khôi Phục Tài Khoản</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .box-card { max-width: 460px; margin: 70px auto; background: #fff; padding: 35px 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .box-icon { font-size: 50px; color: #e67e22; margin-bottom: 15px; text-align: center; }
    </style>
</head>
<body>

<div class="container">
    <div class="box-card">
        <div class="box-icon">
            <i class="fa fa-key"></i>
        </div>
        <h3 class="text-center" style="font-weight: bold; color: #333; margin-top: 0;">Quên Mật Khẩu</h3>
        <p class="text-center" style="color: #666; font-size: 14px; margin-bottom: 25px;">
            Nhập <b>Tên đăng nhập</b> hoặc <b>Địa chỉ Email</b> đã đăng ký. Hệ thống sẽ gửi mã OTP đến email của bạn để đặt lại mật khẩu mới.
        </p>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle"></i> ${alert}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <label for="account" style="color: #444;">Username hoặc Email:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" class="form-control input-lg" id="account" name="account" value="${account}" placeholder="Nhập username hoặc email..." required autofocus>
                </div>
            </div>

            <button type="submit" class="btn btn-warning btn-block btn-lg" style="margin-top: 20px; font-weight: bold; color: #fff;">
                <i class="fa fa-paper-plane"></i> Gửi Mã OTP Xác Nhận
            </button>
        </form>

        <hr style="margin: 25px 0 15px 0;">

        <div class="text-center">
            <a href="${pageContext.request.contextPath}/login" style="color: #666; text-decoration: none;">
                <i class="fa fa-arrow-left"></i> Quay lại trang Đăng nhập
            </a>
        </div>
    </div>
</div>

</body>
</html>
