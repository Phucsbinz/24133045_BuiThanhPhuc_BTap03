<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi 404 - Không Tìm Thấy Trang</title>
    <style>
        body { font-family: Arial, sans-serif; background: #0f172a; color: #f8fafc; text-align: center; padding: 60px 20px; }
        .error-container { max-width: 600px; margin: auto; background: #1e293b; padding: 40px; border-radius: 16px; border: 1px solid #334155; }
        h1 { font-size: 80px; color: #f87171; margin-bottom: 10px; }
        h2 { font-size: 24px; margin-bottom: 16px; color: #e2e8f0; }
        p { color: #94a3b8; font-size: 15px; margin-bottom: 24px; }
        a { display: inline-block; background: #3b82f6; color: white; padding: 12px 24px; border-radius: 8px; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>404</h1>
        <h2>Xảy ra lỗi: Trang không tồn tại!</h2>
        <p>Đường dẫn tài nguyên bạn yêu cầu không tìm thấy trên hệ thống máy chủ (Theo slide 104 - Error Handler trong Servlet).</p>
        <p>URI lỗi: <code>${requestUri}</code></p>
        <a href="${pageContext.request.contextPath}/">&larr; Quay về Trang Chủ</a>
    </div>
</body>
</html>
