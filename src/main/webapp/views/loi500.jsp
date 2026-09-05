<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi 500 - Lỗi Máy Chủ Nội Bộ</title>
    <style>
        body { font-family: Arial, sans-serif; background: #0f172a; color: #f8fafc; text-align: center; padding: 60px 20px; }
        .error-container { max-width: 650px; margin: auto; background: #1e293b; padding: 40px; border-radius: 16px; border: 1px solid #334155; }
        h1 { font-size: 80px; color: #fbbf24; margin-bottom: 10px; }
        h2 { font-size: 24px; margin-bottom: 16px; color: #e2e8f0; }
        p { color: #94a3b8; font-size: 15px; margin-bottom: 24px; }
        a { display: inline-block; background: #3b82f6; color: white; padding: 12px 24px; border-radius: 8px; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>500</h1>
        <h2>Đã xảy ra lỗi máy chủ nội bộ (Server Error)!</h2>
        <p>Hệ thống đã bắt được ngoại lệ (Theo slide 104 - Error Handler trong Servlet).</p>
        <p>Mã lỗi: <code>${statusCode}</code> | Ngoại lệ: <code>${exception}</code></p>
        <a href="${pageContext.request.contextPath}/">&larr; Quay về Trang Chủ</a>
    </div>
</body>
</html>
