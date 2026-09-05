<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tạo tài khoản mới</title>
    <!-- Bootstrap 3 & Font Awesome theo giáo trình của Thầy -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            color: #555;
            padding-top: 40px;
        }
        .register-box {
            width: 440px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border: 1px solid #e5e5e5;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .register-title {
            text-align: left;
            font-size: 20px;
            font-weight: 300;
            color: #777;
            margin-bottom: 25px;
            margin-top: 0;
        }
        .input-group {
            margin-bottom: 12px;
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
        .btn-register {
            width: 100%;
            background-color: #0088cc;
            color: #fff;
            border: none;
            height: 38px;
            border-radius: 4px;
            font-size: 14px;
            margin-top: 10px;
        }
        .btn-register:hover {
            background-color: #0077b3;
            color: #fff;
        }
        .register-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 12px;
            color: #777;
        }
        .register-footer a {
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
    <div class="register-box">
        <h2 class="register-title">Tạo tài khoản mới</h2>

        <!-- Thông báo lỗi theo slide 21 -->
        <c:if test="${alert != null}">
            <div class="alert alert-danger text-center">
                ${alert}
            </div>
        </c:if>

        <!-- Form theo Slide 21 trong 06_MVC_3tier.pdf -->
        <form action="${pageContext.request.contextPath}/register" method="post">
            <section>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" placeholder="Tài khoản" name="username" class="form-control" required autofocus>
                </div>
            </section>

            <section>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" placeholder="Họ tên" name="fullname" class="form-control">
                </div>
            </section>

            <section>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    <input type="email" placeholder="Nhập Email" name="email" class="form-control" required>
                </div>
            </section>

            <section>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    <input type="text" placeholder="Điện thoại" name="phone" class="form-control">
                </div>
            </section>

            <section>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" placeholder="Mật khẩu" name="password" class="form-control" required>
                </div>
            </section>

            <section>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" placeholder="Nhập lại mật khẩu" name="repassword" class="form-control">
                </div>
            </section>

            <button type="submit" class="btn btn-register">Tạo tài khoản</button>
        </form>

        <div class="register-footer">
            Nếu bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
        </div>
    </div>
</div>

</body>
</html>
