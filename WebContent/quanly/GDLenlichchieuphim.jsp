<%@page import="dto.response.Thoidiemchieu"%>
<%@page import="dao.GiochieuDAO"%>
<%@page import="model.Phongchieu"%>
<%@page import="dao.PhongchieuDAO"%>
<%@page import="model.Phim"%>
<%@page import="java.util.List"%>
<%@page import="dao.PhimDAO"%>
<%@page import="model.Thanhvien"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Lịch Chiếu Phim</title>
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
        }
        .form-card {
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 20px;
            padding: 20px;
            width: 400px;
            text-align: center;
            flex-direction: column;
        }
        
        .form-card label {
            display: block;
            margin: 10px 0 5px;
            font-size: 16px;
            text-align: left;
        }
 
        .form-card h2 {
            color: #333;
        }
        .form-card select, .form-card input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* padding và border nằm trong chiều rộng */
        }
        
		.form-card button {
		    width: 100%;
		    padding: 10px 15px;
		    background-color: #007bff;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    margin-top: 10px;
		}

        .form-card button:hover {
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
                Xin chào, <%=hoten%> ▼
            </span>
            <div class="dropdown">
                <a href="/pttkht/quanly/GDChinhquanly.jsp">Thông tin cá nhân</a>
                <a href="/pttkht/GDDangnhap.jsp">Đăng xuất</a>
            </div>
        </div>
    </div>
    
    <div class="container">
	    <div class="form-card">
	        <h2>Lên Lịch Chiếu Phim</h2>
	        <form id="lenlichchieuphimForm" action="GDXacnhanlichchieumoi.jsp" method="post">
	            <label for="phim">Chọn Phim:</label>
	            <select id="phim" name="phim">
	                <option value="">-- Chọn Phim --</option>
	                <%
	                	PhimDAO phimDAO = new PhimDAO();
   	                    List<Phim> phimList = phimDAO.getDSPhim();
   	                    for (Phim phim : phimList) {
	                %>
		                	<option value="<%= phim.getId() + "&&" + phim.getTenphim() %>">
		                		<%=phim.getTenphim()%>
		                	</option>
	                <%
	                	}
	                %>
	            </select>
	
	            <label for="phongchieu">Chọn Phòng Chiếu:</label>
	            <select id="phongchieu" name="phongchieu">
	                <option value="">-- Chọn Phòng --</option>
	                <%
	                	PhongchieuDAO phongchieuDAO = new PhongchieuDAO();
   	                    List<Phongchieu> phongchieuList = phongchieuDAO.getDSPhongchieu();
   	                    for (Phongchieu phongchieu : phongchieuList) {
	                %>
		                	<option value="<%= phongchieu.getId() + "&&" + phongchieu.getTenphongchieu()%>">
		                		<%=phongchieu.getTenphongchieu()%>
		                	</option>
		            <%
		                }
		            %>
	            </select>
	
	            <label for="thoidiemchieu">Chọn Thời Điểm Chiếu:</label>
	            <select id="thoidiemchieu" name="thoidiemchieu">
	                <option value="">-- Chọn Thời Điểm --</option>
	                <%
	                	GiochieuDAO thoidiemchieuDAO = new GiochieuDAO();
   	                    List<Thoidiemchieu> thoidiemchieus = thoidiemchieuDAO.getDSThoidiemchieu();
   	                    for (Thoidiemchieu thoidiemchieu : thoidiemchieus) {
	                %>
						<option value="<%= thoidiemchieu.getGiochieu().getId() + "&&" + thoidiemchieu.getNgaychieu() + " " + thoidiemchieu.getGiochieu().getThoigianchieu() %>">
						    <%= thoidiemchieu.getGiochieu().getThoigianchieu() + " " + thoidiemchieu.getNgaychieu() %>
						</option>
	                <%
	                    }
	                %>
	            </select>
	
	            <label for="giavechung">Giá Vé Chung:</label>
	            <input type="number" id="giavechung" name="giavechung" placeholder="Nhập giá vé" required>
	
	            <button type="button" onclick="validateForm()">Tiếp Tục</button>
	        </form>
	    </div>
	</div>
	<script>
	    function validateForm() {
	        var phim = document.getElementById('phim').value;
	        var phongchieu = document.getElementById('phongchieu').value;
	        var thoidiemchieu = document.getElementById('thoidiemchieu').value;
	        var giavechung = document.getElementById('giavechung').value;
	        if (phim && phongchieu && thoidiemchieu && giavechung) {
	        	submitForm();
	        } else {
	            alert('Hãy điền đầy đủ thông tin.');
	        }
	    }

	    function submitForm() {
	        document.getElementById("lenlichchieuphimForm").submit();
	    }
    </script>
</body>
</html>
