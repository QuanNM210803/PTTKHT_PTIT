
<%@page import="model.Phim"%>
<%@page import="java.util.List"%>
<%@page import="dao.PhimDAO"%>
<%@page import="model.Thanhvien"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<% 
	PhimDAO phimDAO=new PhimDAO();
	List<Phim> dsphimbanve = phimDAO.getDSPhimbanve();
	HttpSession httpSession=request.getSession();
	httpSession.setAttribute("dsphimbanve", dsphimbanve);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bán vé tại quầy cho khách</title>
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
		tr:hover{
			background-color: #f1f1f1;
			cursor: pointer;
		}

        h1 {
            text-align: center;
            margin: 20px 0;
            padding: 10px;
            border-radius: 5px;
            font-size: 24px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Bán vé tại quầy cho khách</h2>
        
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
                <a href="/pttkht/nhanvienbanve/GDChinhnhanvienbanve.jsp">Thông tin cá nhân</a>
                <a href="/pttkht/GDDangnhap.jsp">Đăng xuất</a>
            </div>
        </div>
    </div>
    
    <h1>Chọn phim</h1>

    <table>
        <tr>
            <th>TT</th>
            <th>Tên phim</th>
            <th>Đạo diễn</th>
            <th>Diễn viên chính</th>
            <th>Thời lượng</th>
            <th>Thể loại</th>
        </tr>
        	<%
        		
	            int index = 1;
	            if (dsphimbanve != null) {
	                for (Phim phim : dsphimbanve) {
        				%>
		                    <tr onclick="location.href='/pttkht/nhanvienbanve/GDChonlichchieu.jsp?phimid=<%= phim.getId() %>'">
		                        <td><%= index++ %></td>
		                        <td><%= phim.getTenphim() %></td>
		                        <td><%= phim.getDaodien() %></td>
		                        <td><%= phim.getDienvienchinh() %></td>
		                        <td><%= phim.getThoiluong() %></td>
		                        <td><%= phim.getTheloai().getTentheloai() %></td>
		                    </tr>
	        			<%
	                }
            	}
        	%>
    </table>

</body>
</html>

