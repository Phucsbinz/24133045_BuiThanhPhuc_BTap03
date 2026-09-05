<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP - Kích Hoạt Tài Khoản</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .otp-container { max-width: 480px; margin: 60px auto; background: #fff; padding: 35px 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .otp-icon { font-size: 54px; color: #007bff; margin-bottom: 15px; }
        .otp-input { font-size: 28px; font-weight: bold; letter-spacing: 12px; text-align: center; height: 55px; border-radius: 8px; border: 2px solid #ced4da; }
        .otp-input:focus { border-color: #007bff; box-shadow: 0 0 8px rgba(0,123,255,0.25); }
    </style>
</head>
<body>

<div class="container">
    <div class="otp-container text-center">
        <div class="otp-icon">
            <i class="fa fa-envelope-open-o"></i>
        </div>
        <h3 style="font-weight: bold; color: #333; margin-top: 0;">Xác Thực Tài Khoản</h3>
        <p style="color: #666; font-size: 14px;">
            Mã xác thực OTP gồm 6 chữ số đã được gửi qua email. Vui lòng nhập mã bên dưới để kích hoạt tài khoản của bạn:
        </p>

        <c:if test="${not empty sessionScope.msgInfo}">
            <div class="alert alert-info text-left">
                <i class="fa fa-info-circle"></i> ${sessionScope.msgInfo}
            </div>
            <c:remove var="msgInfo" scope="session" />
        </c:if>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger text-left">
                <i class="fa fa-exclamation-triangle"></i> ${alert}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post" style="margin-top: 25px;">
            <input type="hidden" name="username" value="${username}">

            <div class="form-group text-left">
                <label style="color: #555;">Tài khoản cần kích hoạt:</label>
                <div class="well well-sm" style="margin-bottom: 15px; font-weight: bold; color: #007bff; background: #f8f9fa;">
                    <i class="fa fa-user"></i> ${username}
                    <c:if test="${not empty userEmail}">
                        <span style="color: #666; font-weight: normal; font-size: 13px;"> (${userEmail})</span>
                    </c:if>
                </div>
            </div>

            <div class="form-group">
                <label for="otp" style="color: #555; display: block;" class="text-left">Nhập mã OTP (6 số):</label>
                <input type="text" class="form-control otp-input" id="otp" name="otp" maxlength="6" pattern="[0-9]{6}" placeholder="------" autocomplete="off" required autofocus>
                <small class="text-muted" style="display: block; margin-top: 8px;">
                    <i class="fa fa-clock-o"></i> Mã OTP có hiệu lực trong vòng 5 phút.
                </small>
            </div>

            <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top: 20px; font-weight: bold;">
                <i class="fa fa-check-circle"></i> Kích Hoạt Tài Khoản
            </button>
        </form>

        <hr style="margin: 25px 0 15px 0;">

        <div style="font-size: 14px;">
            Chưa nhận được mã?
            <a href="${pageContext.request.contextPath}/resend-otp?username=${username}" style="font-weight: bold; color: #007bff;">
                <i class="fa fa-repeat"></i> Gửi lại mã OTP
            </a>
        </div>
        <div style="margin-top: 10px;">
            <a href="${pageContext.request.contextPath}/login" style="color: #888;">
                <i class="fa fa-arrow-left"></i> Quay lại Đăng nhập
            </a>
        </div>
    </div>
</div>

</body>
</html>
