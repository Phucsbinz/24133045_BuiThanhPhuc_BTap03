<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu Mới</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .reset-box { max-width: 480px; margin: 50px auto; background: #fff; padding: 35px 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .reset-icon { font-size: 50px; color: #27ae60; margin-bottom: 15px; text-align: center; }
        .otp-input { font-size: 24px; font-weight: bold; letter-spacing: 8px; text-align: center; border-radius: 6px; }
    </style>
</head>
<body>

<div class="container">
    <div class="reset-box">
        <div class="reset-icon">
            <i class="fa fa-shield"></i>
        </div>
        <h3 class="text-center" style="font-weight: bold; color: #333; margin-top: 0;">Đặt Lại Mật Khẩu</h3>
        <p class="text-center" style="color: #666; font-size: 14px;">
            Nhập mã OTP 6 số đã nhận từ email và mật khẩu mới cho tài khoản:
        </p>

        <c:if test="${not empty sessionScope.msgInfo}">
            <div class="alert alert-info">
                <i class="fa fa-info-circle"></i> ${sessionScope.msgInfo}
            </div>
            <c:remove var="msgInfo" scope="session" />
        </c:if>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-triangle"></i> ${alert}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post" style="margin-top: 20px;">
            <div class="form-group">
                <label style="color: #444;">Tài khoản:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" class="form-control" name="username" value="${username}" required ${not empty username ? 'readonly' : ''} style="background: #fdfdfd; font-weight: bold;">
                </div>
            </div>

            <div class="form-group">
                <label for="otp" style="color: #444;">Mã OTP xác nhận (6 số):</label>
                <input type="text" class="form-control otp-input" id="otp" name="otp" maxlength="6" pattern="[0-9]{6}" placeholder="------" required autofocus>
                <small class="text-muted"><i class="fa fa-clock-o"></i> Mã có hiệu lực trong vòng 5 phút.</small>
            </div>

            <div class="form-group">
                <label for="newPassword" style="color: #444;">Mật khẩu mới:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới..." required>
                </div>
            </div>

            <div class="form-group">
                <label for="confirmPassword" style="color: #444;">Nhập lại mật khẩu mới:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận lại mật khẩu mới..." required>
                </div>
            </div>

            <button type="submit" class="btn btn-success btn-block btn-lg" style="margin-top: 25px; font-weight: bold;">
                <i class="fa fa-check"></i> Xác Nhận &amp; Cập Nhật Mật Khẩu
            </button>
        </form>

        <hr style="margin: 25px 0 15px 0;">

        <div class="text-center">
            Chưa nhận được mã?
            <a href="${pageContext.request.contextPath}/forgot-password" style="font-weight: bold; color: #e67e22;">
                <i class="fa fa-repeat"></i> Gửi lại OTP
            </a>
            &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/login" style="color: #888;">
                <i class="fa fa-sign-in"></i> Đăng nhập
            </a>
        </div>
    </div>
</div>

</body>
</html>
