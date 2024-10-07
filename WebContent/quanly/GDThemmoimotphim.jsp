<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Theloai" %>
<%@ page import="dao.TheloaiDAO" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="model.Thanhvien" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Mới Một Phim</title>
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
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            text-align: center;
        }
        .form-container label {
            display: block;
            margin: 10px 0 5px;
            font-size: 16px;
        }
        .form-container input, .form-container select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .form-container button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 4px;
            width: 100%;
            font-size: 16px;
        }
        .form-container button:hover {
            background-color: #0056b3;
        }

        
        .popup-container {
		    display: none;
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0, 0, 0, 0.5);
		    align-items: center; /* Căn giữa theo trục dọc */
		    justify-content: center; /* Căn giữa theo trục ngang */
		}
        .popup-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
            width: 300px;
        }
        .popup-content h3 {
            margin: 0;
            margin-bottom: 20px;
        }
        .popup-buttons button {
            padding: 8px 20px;
            margin: 0 10px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }
        .popup-buttons .confirm {
		    background-color: #007bff;
		    color: white;
		}
		
		.popup-buttons .confirm:hover {
		    background-color: #0056b3; /* Màu xanh đậm hơn khi hover */
		}
		
		.popup-buttons .cancel {
		    background-color: #e0e0e0;
		    color: black;
		}
		
		.popup-buttons .cancel:hover {
		    background-color: #b0b0b0; /* Màu xám đậm hơn khi hover */
		}

		.error-message {
            color: red;
            margin-bottom: 20px;
            font-weight: bold;
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

    <div class="form-container">
        <h2>Thêm Mới Một Phim</h2>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="error-message"><%= errorMessage %></div>
        <%
            }
        %>
        <form id="phimForm" action="phim" method="post">
            <label for="tenphim">Tên Phim:</label>
            <input type="text" id="tenphim" name="tenphim" required>

            <label for="daodien">Đạo Diễn:</label>
            <input type="text" id="daodien" name="daodien" required>

            <label for="dienvienchinh">Diễn Viên Chính:</label>
            <input type="text" id="dienvienchinh" name="dienvienchinh" required>

            <label for="thoiluong">Thời Lượng (phút):</label>
            <input type="number" id="thoiluong" name="thoiluong" required>

            <label for="theloai">Thể Loại:</label>
            <select id="theloai" name="theloaiid" required>
                <option value="">Chọn Thể Loại</option>
                <%
                    // Lấy danh sách thể loại từ cơ sở dữ liệu
                    TheloaiDAO theloaiDAO = new TheloaiDAO();
                    List<Theloai> theloaiList = theloaiDAO.getDanhsachtheloai();
                    for (Theloai theloai : theloaiList) {
		                %>
		                	<option value="<%= theloai.getId() %>"><%= theloai.getTentheloai() %></option>
		                <%
                    }
                %>
            </select>

            <button type="button" onclick="validateForm()">Lưu Thông Tin Phim</button>
        </form>
    </div>

    <div id="popup" class="popup-container">
        <div class="popup-content">
            <h3>Xác nhận lưu thông tin phim?</h3>
            <div class="popup-buttons">
                <button class="confirm" onclick="submitForm()">Xác nhận</button>
                <button class="cancel" onclick="closePopup()">Hủy</button>
            </div>
        </div>
    </div>

    <script>
	    function validateForm() {
	        var tenphim = document.getElementById('tenphim').value;
	        var daodien = document.getElementById('daodien').value;
	        var dienvienchinh = document.getElementById('dienvienchinh').value;
	        var thoiluong = document.getElementById('thoiluong').value;
	        var theloai = document.getElementById('theloai').value;
	
	        if (tenphim && daodien && dienvienchinh && thoiluong && theloai) {
	            showPopup();
	        } else {
	            alert('Hãy điền đầy đủ thông tin.');
	        }
	    }
	
	    function showPopup() {
	        document.getElementById("popup").style.display = "flex";
	    }
	
	    function closePopup() {
	        document.getElementById("popup").style.display = "none";
	    }
	
	    function submitForm() {
	        document.getElementById("phimForm").submit();
	    }
    </script>
</body>
</html>
