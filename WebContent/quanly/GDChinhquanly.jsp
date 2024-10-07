<%@page import="model.Thanhvien"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Rạp Chiếu Phim</title>
    <style>
        body {
            font-family: Arial, sans-serif;
		    background-color: #f0f0f0; /* Màu nền chính */
		    background-image: radial-gradient(circle, rgba(255, 255, 255, 0.2) 20%, transparent 20%), radial-gradient(circle, rgba(255, 255, 255, 0.2) 20%, transparent 20%);
		    background-size: 50px 50px; /* Kích thước họa tiết */
		    margin: 0;
		    padding: 0;
        }
        .header {
            background-color: #ff9800;
            color: white;
            padding: 10px 0px;
            text-align: center;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .header .user-info {
		    position: absolute;
		    top: 50%; /* Đặt phần tử ở giữa theo chiều dọc */
		    right: 20px;
		    transform: translateY(-50%); /* Căn giữa theo chiều dọc bằng cách dịch chuyển phần tử */
		    cursor: pointer;
		}

        .header .user-info .dropdown {
            display: none;
            position: absolute;
            width: 150px;
            right: 0px;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }
        .header .user-info:hover .dropdown {
            display: block;
        }
        .header .user-info .dropdown a {
            display: block;
            padding: 10px;
            text-align: left;
            color: #333;
            text-decoration: none;
        }
        .header .user-info .dropdown a:hover {
            background-color: #f0f0f0;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 100px);
            flex-direction: column;
        }
        .card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 20px;
            padding: 20px;
            width: 300px;
            text-align: center;
        }
        .card h3 {
            color: #333;
        }
        .card a {
            display: inline-block;
            padding: 10px 15px;
            margin-top: 10px;
            background-color: #007bff;
            color: white;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .card a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Chào Mừng Đến Với Quản Lý Rạp Chiếu Phim</h2>
        
        <div class="user-info">
            <span>
                <% 
                    HttpSession isession = request.getSession(false);
                    String hoten = (isession != null && isession.getAttribute("user") != null) 
                                      ? ((Thanhvien) isession.getAttribute("user")).getHoten() 
                                      : "Khách";
                %>
                Xin chào, <%= hoten %> ▼
            </span>
            <div class="dropdown">
                <a href="/pttkht/quanly/GDChinhquanly.jsp">Thông tin cá nhân</a>
                <a href="/pttkht/GDDangnhap.jsp">Đăng xuất</a>
            </div>
        </div>
    </div>
    
    <div class="container">
        <div class="card">
            <h3>Quản Lý Thông Tin Phim</h3>
            <a href="/pttkht/quanly/GDQuanlythongtinphim.jsp">Quản Lý</a>
        </div>
        <div class="card">
            <h3>Lên Lịch Chiếu Phim</h3>
            <a href="/pttkht/quanly/GDLenlichchieuphim.jsp">Lên Lịch</a>
        </div>
    </div>
</body>
</html>
