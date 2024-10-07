<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Quản Lý Rạp Phim</title>
    <style>
        body {
	        font-family: Arial, sans-serif;
	        background-image: url('${pageContext.request.contextPath}/images/cinema-background.png');
	        background-size: cover;
	        background-position: center;
	        height: 100vh;
	        margin: 0;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        position: relative; /* Đảm bảo các phần tử con được định vị chính xác */
	    }
	
	    /* Lớp phủ mờ */
	    .background-overlay {
	        position: absolute;
	        top: 0;
	        left: 0;
	        width: 100%;
	        height: 100%;
	        background-color: rgba(0, 0, 0, 0.6); /* Màu đen với độ mờ 50% */
	        z-index: 1; /* Đảm bảo lớp phủ nằm dưới nội dung */
	    }
	
	    .container {
		    position: relative;
		    background-color: rgba(255, 255, 255, 0.2); /* Màu nền trắng với độ mờ nhẹ */
		    padding: 30px;
		    border-radius: 8px;
		    box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
		    width: 350px;
		    box-sizing: border-box;
		    color: #333333; /* Màu chữ tối để dễ nhìn trên nền sáng */
		    z-index: 2;
		}

        h2 {
            text-align: center;
            color: #CBD021;
            margin-bottom: 20px;
        }
        label {
            display: block;
            color: #CBD021;
            font-weight: bold;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #444444;
            border-radius: 4px;
            background-color: rgba(255, 255, 255, 0.3);
            color: #ffffff;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #CBD021;
            border: none;
            border-radius: 4px;
            color: #000000;
            font-size: 18px;
            cursor: pointer;
        }
        button:hover {
            background-color: #e6b800;
        }
        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
        .cinema-icon {
            display: block;
            margin: 0 auto 20px;
            width: 50px;
            height: 50px;
        }
    </style>
</head>
<body>
	<div class="background-overlay"></div>
    <div class="container">
        <h2>Đăng Nhập Hệ Thống Rạp Phim</h2>

        <% 
            HttpSession isession = request.getSession(false);
            if (isession != null) {
                isession.invalidate();
            }
        %>

        <form action="dangnhap" method="post">
            <label for="username">Tên tài khoản:</label>
            <input type="text" id="username" name="username" required>
            
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>
            
            <button type="submit">Đăng nhập</button>
            
            <% if (request.getParameter("error") != null) { %>
                <p class="error">Tài khoản hoặc mật khẩu không đúng!</p>
            <% } %>
        </form>
    </div>
</body>
</html>
