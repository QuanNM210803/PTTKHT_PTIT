<%@page import="model.Phim"%>
<%@page import="model.Ve"%>
<%@page import="dao.VeDAO"%>
<%@page import="dao.PhimDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Lichchieuphim"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Thanhvien"%>
<%
	HttpSession httpSession = request.getSession(false);

	int lichchieuphimid=Integer.parseInt(request.getParameter("lichchieuphimid"));
	List<Lichchieuphim> dslichchieuphim = httpSession.getAttribute("dslichchieuphim")!=null ? (List<Lichchieuphim>) httpSession.getAttribute("dslichchieuphim") : new ArrayList<>();
	Lichchieuphim lichchieuphim=null;
	for(Lichchieuphim lichchieuphim2: dslichchieuphim){
		if(lichchieuphimid==lichchieuphim2.getId()){
			lichchieuphim=lichchieuphim2;
			break;
		}
	}
	Phim phim=lichchieuphim.getPhim();
	
	String[] seats=request.getParameter("seats").split(",");
	List<Ve> dsve = httpSession.getAttribute("dsve")!=null ? (List<Ve>) httpSession.getAttribute("dsve") : new ArrayList<>();
	
	List<Ve> ghengoidachon=new ArrayList<>();
	int tongtien=0;
	for(Ve ve:dsve){
		for(String seatid: seats){
			if(ve.getId()==Integer.parseInt(seatid)){
				ghengoidachon.add(ve);
				tongtien+=ve.getGiave();
			}
		}
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận thanh toán</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style type="text/css">
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
		    background-color: white;
		    padding: 20px;
		    max-width: 500px;
		    margin: 20px auto;
		    border: 1px solid #ccc;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    border-radius: 5px;
		    text-align: center;
		}
		
		table {
		    width: 100%;
		    margin-top: 20px;
		    border-collapse: collapse;
		}
		
		table, th, td {
		    border: 1px solid #ccc;
		}
		
		th, td {
		    padding: 10px;
		    text-align: center;
		}
		
		h2 {
            text-align: center;
        }
		p {
            text-align: left;
            padding-left: 10px;
        }
		
		.submit-button {
		    background-color: #4CAF50;
		    color: white;
		    padding: 10px 20px;
		    border: none;
		    cursor: pointer;
		    border-radius: 5px;
		    margin-top: 20px;
		}
		
		.submit-button:hover {
		    background-color: #45a049;
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
        <h2>Xác nhận thanh toán</h2>
        <p><strong>Phim: </strong><%= phim.getTenphim() %></p>
        <p><strong>Phòng chiếu: </strong><%= lichchieuphim.getPhongchieu().getTenphongchieu() %></p>
        <p><strong>Thời điểm chiếu: </strong><%= lichchieuphim.getNgaychieu() + " " + lichchieuphim.getGiochieu().getThoigianchieu() %></p>

        <table>
            <thead>
                <tr>
                    <th>TT</th>
                    <th>Số ghế</th>
                    <th>Giá vé</th>
                </tr>
            </thead>
            <tbody>
		        <% 
		            if (ghengoidachon != null && !ghengoidachon.isEmpty()) {
		                int count = 1;
		                for (Ve ve : ghengoidachon) {
		        %>
		                    <tr>
		                        <td><%= count++ %></td>
		                        <td><%= ve.getGhengoi().getSoghe() %></td>
		                        <td><%= ve.getGiave() %></td>
		                    </tr>
		        <% 
		                } 
		            } else { 
		        %>
		                <tr>
		                    <td colspan="3">Không có ghế nào được chọn.</td>
		                </tr>
		        <% 
		            } 
		        %>
		    </tbody>
        </table>

        <p><strong>Nhân viên thanh toán:</strong> <%= hoten %> </p>
        <p><strong>Tổng tiền:</strong> <%= tongtien %> </p>

        <button class="submit-button" onclick="showPopup()">Thanh toán</button>
    </div>
    <div id="popup" class="popup-container">
        <div class="popup-content">
            <h3>Bạn có chắc chắn muốn đặt vé?</h3>
            <div class="popup-buttons">
                <button class="confirm" onclick="submit()">Xác nhận</button>
                <button class="cancel" onclick="closePopup()">Hủy</button>
            </div>
        </div>
    </div>
    <script>
	    function submit() {
	        $.ajax({
    	        url: '/pttkht/ve',
    	        type: 'GET',
    	        data: {
    	            dsveid: "<%=request.getParameter("seats")%>"
    	        },
    	        success: function(response) {
    	            const isTrangthaive = response.isTrangthaive;
    	            if(!isTrangthaive) {
    	                alert("Không thể hoàn tất do vé đã được đặt bởi người khác!");
    	                closePopup();
    	            } else {
    	                $.ajax({
    	                    url: '/pttkht/ve',
    	                    type: 'POST',
    	                    data: {
    	        	            dsveid: "<%=request.getParameter("seats")%>"
    	        	        },
    	                    success: function(response) {
    	                    	if(response.isLuudatve){
    	                    		window.location.href = "/pttkht/nhanvienbanve/GDChinhnhanvienbanve.jsp";
    	                    	}else{
    	                    		alert("Không thể hoàn tất!");
    	        	                closePopup();
    	                    	}
    	                    },
    	                    error: function(xhr, status, error) {
    	                        alert('Có lỗi xảy ra: ' + error);
    	                    }
    	                });
    	            }
    	        },
    	        error: function(xhr, status, error) {
    	            alert('Có lỗi xảy ra khi kiểm tra trạng thái vé: ' + error);
    	        }
    	    });
	    }
	    function showPopup() {
	        document.getElementById("popup").style.display = "flex";
	    }
	
	    function closePopup() {
	        document.getElementById("popup").style.display = "none";
	    }
    </script>
</body>
</html>
