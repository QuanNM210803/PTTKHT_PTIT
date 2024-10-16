<%@page import="dao.PhimDAO"%>
<%@page import="model.Phim"%>
<%@page import="java.util.List"%>
<%@ page import="model.Thanhvien" %>
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
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: white;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #ff9800;
            color: white;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .edit-button {
            background-color: #2196F3;
        }
        .delete-button {
            background-color: #f44336;
        }
        .button:hover {
            opacity: 0.8;
        }
        .button-container {
            text-align: center;
            margin: 20px;
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
    
    <div class="button-container">
	    <a href="/pttkht/quanly/GDThemmoimotphim.jsp">
	        <button class="button">Thêm mới một phim</button>
	    </a>
	</div>

    <table>
        <tr>
            <th>TT</th>
            <th>Tên phim</th>
            <th>Đạo diễn</th>
            <th>Diễn viên chính</th>
            <th>Thời lượng</th>
            <th>Thể loại</th>
            <th>Tùy chọn</th>
        </tr>
        	<%
        		PhimDAO phimDAO=new PhimDAO();
	            List<Phim> danhSachPhim = phimDAO.getDSPhim();
	            int index = 1;
	            if (danhSachPhim != null) {
	                for (Phim phim : danhSachPhim) {
        				%>
		                    <tr>
		                        <td><%= index++ %></td>
		                        <td><%= phim.getTenphim() %></td>
		                        <td><%= phim.getDaodien() %></td>
		                        <td><%= phim.getDienvienchinh() %></td>
		                        <td><%= phim.getThoiluong() %></td>
		                        <td><%= phim.getTheloai().getTentheloai() %></td>
		                        <td>
		                            <button class="button edit-button">Sửa</button>
		                            <button class="button delete-button">Xóa</button>
		                        </td>
		                    </tr>
	        			<%
	                }
            	}
        	%>
    </table>

</body>
</html>
