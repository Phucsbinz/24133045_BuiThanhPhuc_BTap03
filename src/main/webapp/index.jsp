<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Kiểm tra session người dùng
    if (session != null && session.getAttribute("account") != null) {
        response.sendRedirect(request.getContextPath() + "/waiting");
    } else {
        response.sendRedirect(request.getContextPath() + "/login");
    }
%>
