<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập Vào Hệ Thống</title>
    <!-- Bootstrap 3 & Font Awesome theo giáo trình của Thầy -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            color: #555;
            padding-top: 50px;
        }
        .login-box {
            width: 420px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border: 1px solid #e5e5e5;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .login-title {
            text-align: center;
            font-size: 20px;
            font-weight: 300;
            color: #777;
            margin-bottom: 25px;
            margin-top: 0;
        }
        .input-group {
            margin-bottom: 15px;
            width: 100%;
        }
        .input-group-addon {
            background-color: #eee;
            border: 1px solid #ccc;
            color: #999;
            width: 40px;
            text-align: center;
        }
        .form-control {
            height: 38px;
            border-radius: 0 4px 4px 0;
            box-shadow: none;
            border-color: #ccc;
        }
        .form-control:focus {
            border-color: #66afe9;
            box-shadow: none;
        }
        .login-options {
            margin-bottom: 15px;
            font-size: 12px;
            color: #777;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .login-options label {
            font-weight: normal;
            cursor: pointer;
            margin-bottom: 0;
        }
        .login-options a {
            color: #0088cc;
            text-decoration: none;
        }
        .login-options a:hover {
            text-decoration: underline;
        }
        .btn-login {
            width: 100%;
            background-color: #0088cc;
            color: #fff;
            border: none;
            height: 38px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: normal;
        }
        .btn-login:hover {
            background-color: #0077b3;
            color: #fff;
        }
        .login-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 12px;
            color: #777;
        }
        .login-footer a {
            color: #0088cc;
        }
        .alert {
            padding: 10px;
            font-size: 13px;
            margin-bottom: 15px;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="login-box">
        <h2 class="login-title">Đăng Nhập Vào Hệ Thống</h2>

        <!-- Thông báo lỗi hoặc thông tin -->
        <c:if test="${alert != null}">
            <div class="alert alert-danger text-center">
                ${alert}
            </div>
        </c:if>

        <c:if test="${not empty inactiveUsername}">
            <div class="alert alert-warning text-center">
                <i class="fa fa-exclamation-triangle"></i> Tài khoản của bạn chưa được kích hoạt.<br>
                <a href="${pageContext.request.contextPath}/verify-otp?username=${inactiveUsername}" class="btn btn-warning btn-xs" style="margin-top: 8px; font-weight: bold; color: #fff;">
                    <i class="fa fa-key"></i> Bấm vào đây để nhập mã OTP kích hoạt
                </a>
            </div>
        </c:if>

        <c:if test="${sessionScope.msgSuccess != null}">
            <div class="alert alert-success text-center">
                ${sessionScope.msgSuccess}
            </div>
            <c:remove var="msgSuccess" scope="session" />
        </c:if>

        <!-- Form theo Slide 9 trong 06_MVC_3tier.pdf -->
        <form action="${pageContext.request.contextPath}/login" method="post">
            <section>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" placeholder="Tài khoản" name="username" class="form-control" autofocus required>
                </div>
            </section>

            <section>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" placeholder="Mật khẩu" name="password" class="form-control" required>
                </div>
            </section>

            <div class="login-options">
                <label>
                    <input type="checkbox" name="remember" value="on"> Nhớ tôi
                </label>
                <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
            </div>

            <button type="submit" class="btn btn-login">Đăng nhập</button>
        </form>

        <div class="login-footer">
            Nếu bạn chưa có tài khoản trên hệ thống, thì hãy <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
        </div>
    </div>
</div>

</body>
</html>
