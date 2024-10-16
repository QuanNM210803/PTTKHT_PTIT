<%@page import="model.Lichchieuphim"%>
<%@page import="dao.LichchieuphimDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Phim"%>
<%@page import="java.util.List"%>
<%@page import="dao.PhimDAO"%>
<%@page import="model.Thanhvien"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
	int phimid=Integer.parseInt(request.getParameter("phimid"));
	HttpSession httpSession = request.getSession(false);
	List<Phim> dsphimbanve= httpSession.getAttribute("dsphimbanve")!=null ? (List<Phim>) httpSession.getAttribute("dsphimbanve") : new ArrayList<>();
	String tenphim="";
	for (Phim phim : dsphimbanve) {
	    if (phim.getId() == phimid) {
	        tenphim = phim.getTenphim();
	        break;
	    }
	}
	LichchieuphimDAO lichchieuphimDAO=new LichchieuphimDAO();
	List<Lichchieuphim> dslichchieuphim = lichchieuphimDAO.getDSLichchieuphim(phimid);
	httpSession.setAttribute("dslichchieuphim", dslichchieuphim);
	
%>
<!DOCTYPE html>
<html>
<head>
    <title>Chọn lịch chiếu phim</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            background-image: radial-gradient(circle, rgba(255, 255, 255, 0.2) 20%, transparent 20%), radial-gradient(circle, rgba(255, 255, 255, 0.2) 20%, transparent 20%);
            background-size: 50px 50px;
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
            top: 50%;
            right: 20px;
            transform: translateY(-50%);
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
            margin: 20px auto;
            width: 50%;
            background-color: white;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        p {
            text-align: left;
            padding-left: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
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
        tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
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

    <div class="container">
        <h2>Chọn lịch chiếu</h2>
        <p><strong>Phim:</strong> <%= tenphim %></p>
        <table>
            <tr>
                <th>TT</th>
                <th>Thời điểm chiếu</th>
            </tr>
            <% 
                int tt = 1;
                for (Lichchieuphim lichchieuphim : dslichchieuphim) {
            %>
	                <tr onclick="location.href='/pttkht/nhanvienbanve/GDChonghengoi.jsp?lichchieuphimid=<%= lichchieuphim.getId() %>'">
	                    <td><%= tt++ %></td>
	                    <td><%= lichchieuphim.getNgaychieu() + " " + lichchieuphim.getGiochieu().getThoigianchieu() %></td>
	                </tr>
            <% 
                } 
            %>
            <!-- Kết thúc vòng lặp -->
        </table>
    </div>
</body>
</html>
