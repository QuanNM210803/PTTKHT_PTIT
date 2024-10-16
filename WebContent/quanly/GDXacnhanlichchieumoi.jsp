<%@page import="com.fasterxml.jackson.core.type.TypeReference"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="dao.LichchieuphimDAO"%>
<%@page import="model.Ve"%>
<%@page import="dao.GhengoiDAO"%>
<%@page import="model.Ghengoi"%>
<%@page import="dto.response.Thoidiemchieu"%>
<%@page import="dao.GiochieuDAO"%>
<%@page import="model.Phongchieu"%>
<%@page import="dao.PhongchieuDAO"%>
<%@page import="model.Phim"%>
<%@page import="java.util.List"%>
<%@page import="dao.PhimDAO"%>
<%@page import="model.Thanhvien"%>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	int phimid= Integer.parseInt(request.getParameter("phim").split("&&")[0]);
    int phongchieuid=Integer.parseInt(request.getParameter("phongchieu").split("&&")[0]);
    int giochieuid=Integer.parseInt(request.getParameter("thoidiemchieu").split("&&")[0]);
    
    String thoidiemchieu= request.getParameter("thoidiemchieu").split("&&")[1];
    String[] parts = thoidiemchieu.split(" ");
    
    DateTimeFormatter formatterDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate ngaychieu = LocalDate.parse(parts[0], formatterDate);

    DateTimeFormatter formatterTime = DateTimeFormatter.ofPattern("HH:mm:ss");
    LocalTime thoigianchieu = LocalTime.parse(parts[1]+":00", formatterTime);
    
    int giavechung=Integer.parseInt(request.getParameter("giavechung"));
    
    
    GhengoiDAO ghengoiDAO=new GhengoiDAO();
    List<Ghengoi> ghengois=ghengoiDAO.getDSGhengoi(phongchieuid);
    List<Ve> ves=ghengois.stream().map(ghengoi -> {
    	return new Ve(true, giavechung, ghengoi);
    }).toList();
    LichchieuphimDAO lichchieuphimDAO=new LichchieuphimDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Xác Nhận Lịch Chiếu Mới</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* CSS styles cho header, body và bảng giá vé */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0; 
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #ff9800;
            color: white;
            padding: 10px 0;
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
            width: 600px;
            text-align: center;
            flex-direction: column;
        }
        
        .form-card p {
		    text-align: left; /* Căn lề trái chỉ cho thẻ <p> */
		}
        
        .form-card h2 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 5px;
            text-align: center;
        }
        th {
            background-color: #ff9800;
            color: white;
        }
        .button-submit {
		    margin-top: 20px;
		    display: flex;
		    justify-content: space-between;
		    padding-left: 70px;
		    padding-right: 70px;
		}
		
		.ghengoi{
			cursor: pointer;
		}
		
		.button-submit button {
		    padding: 10px 20px;
		    font-size: 16px;
		    border-radius: 5px;
		    border: none;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		

		.btn-primary {
		    background-color: #4CAF50;
		    color: white;
		}
		
		.btn-primary:hover {
		    background-color: #45a049;
		}
		

		.btn-secondary {
		    background-color: #007bff;
		    color: white;
		}
		
		.btn-secondary:hover {
		    background-color: #0056b3;
		}
		.modal {
		    display: none;
		    position: fixed;
		    z-index: 1000;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0, 0, 0, 0.5);
		    justify-content: center;
		    align-items: center;
		}
		
		.modal-content {
		    background-color: white;
		    padding: 20px;
		    border-radius: 8px;
		    width: 300px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
		    position: relative;
		    margin: auto;
		}
		
		.input-container {
		    margin-bottom: 15px;
		}
		
		input[type="number"] {
		    width: 100%;
		    padding: 10px;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    font-size: 16px;
		    box-sizing: border-box;
		}
		
		input[type="number"]:focus {
		    border-color: #007bff;
		    outline: none;
		}
		
		.btn-ok {
		    width: 100%;
		    padding: 10px;
		    background-color: #007bff; 
		    color: white;
		    border: none;
		    border-radius: 4px;
		    font-size: 16px;
		    cursor: pointer;
		}
		
		.btn-ok:hover {
		    background-color: #0056b3;
		}
		
		.close {
		    position: absolute;
		    right: 10px;
		    top: 10px;
		    cursor: pointer;
		    font-size: 25px;
		    color: #333;
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
            <h2>Xác Nhận Lịch Chiếu Mới</h2>
            <p>Phim: <%= request.getParameter("phim").split("&&")[1] %></p>
            <p>Phòng chiếu: <%= request.getParameter("phongchieu").split("&&")[1] %></p>
            <p>Thời điểm chiếu: <%= request.getParameter("thoidiemchieu").split("&&")[1] %></p>

            <table border="1" cellpadding="10" cellspacing="0">
			    <thead>
			        <tr>
			            <th>Ghế</th>
			            <th>1</th>
			            <th>2</th>
			            <th>3</th>
			            <th>4</th>
			            <th>5</th>
			            <th>6</th>
			        </tr>
			    </thead>
			    <tbody id="seatTable"></tbody>
			</table>
			    
		    <div class="button-submit">
		        <button type="button" onclick="thaydoigiave()" class="btn-primary">Thay đổi giá vé</button>
		        <button type="button" onclick="showPopup()" class="btn-secondary">Thêm Lịch Chiếu</button>
		    </div>

        </div>
    </div>
    
    <div class="modal" id="priceChangeModal" style="display:none;">
	    <div class="modal-content">
	        <span class="close" onclick="closeModal()">&times;</span>
	        <h3>Nhập Giá Vé Mới</h3>
	        <div class="input-container">
	            <input type="number" id="newPrice" placeholder="Nhập giá vé mới" required/>
	        </div>
	        <button class="btn-ok" onclick="changePrice()">OK</button>
	    </div>
	</div>

    <div id="popup" class="popup-container">
        <div class="popup-content">
            <h3>Bạn có chắc chắn muốn lưu?</h3>
            <div class="popup-buttons">
                <button class="confirm" onclick="submitForm()">Xác nhận</button>
                <button class="cancel" onclick="closePopup()">Hủy</button>
            </div>
        </div>
    </div>
    
    <script>
	    let ghengoidachon = [];
        var ves = JSON.parse('<%= new com.fasterxml.jackson.databind.ObjectMapper().writeValueAsString(ves) %>');
	    function renderSeats() {
	    	var count =0;
	    	const gheList=["A","B","C","D"]
	    	
	        var tbody = document.getElementById('seatTable');
	    	tbody.innerHTML = '';
	        gheList.forEach(function(ghe) {
	            var row = document.createElement('tr');
	
	            // Tạo ô chứa tên ghế (A, B, C, D)
	            var nameCell = document.createElement('td');
	            nameCell.innerHTML = ghe;
	            row.appendChild(nameCell);
	
	            for (var i = 1; i <= 6; i++) {
	                var seatCell = document.createElement('td');
	                seatCell.id = 'ghengoi_' + count;
	                seatCell.className = 'ghengoi';
	                seatCell.setAttribute('onclick', 'toggleSeat(' + count + ')');
	                
	                // Hiển thị giá vé
	                var price = document.createElement('p');
	                price.innerHTML = ves[count].giave;
	                seatCell.appendChild(price);
	
	                row.appendChild(seatCell);
	                count++;
	            }
	
	            tbody.appendChild(row);
	        });
	    }
	    renderSeats();
	    
	    function submitForm() {
	    	 $.ajax({
	    	        url: '/pttkht/lenlichchieuphim',
	    	        type: 'GET',
	    	        data: {
	    	            phimid: <%=phimid%>,
	    	            phongchieuid: <%=phongchieuid%>,
	    	            ngaychieu: "<%=ngaychieu %>",
	    	            thoigianchieu: "<%=thoigianchieu%>"
	    	        },
	    	        success: function(response) {
	    	            const isTrunglichchieu = response.isTrunglichchieu;
	    	            if(isTrunglichchieu) {
	    	                alert("Trùng lịch chiếu!");
	    	                closePopup();
	    	            } else {
	    	                var vesJson = JSON.stringify(ves);
	    	                $.ajax({
	    	                    url: '/pttkht/lenlichchieuphim',
	    	                    type: 'POST',
	    	                    data: {
	    	                        vesJson: vesJson,
	    	                        phimid: <%=phimid%>,
	    	                        phongchieuid: <%=phongchieuid%>,
	    	                        ngaychieu: "<%=ngaychieu %>",
	    	                        giochieuid: <%=giochieuid%>
	    	                    },
	    	                    success: function(response) {
	    	                        window.location.href = "/pttkht/quanly/GDChinhquanly.jsp";
	    	                    },
	    	                    error: function(xhr, status, error) {
	    	                        alert('Có lỗi xảy ra: ' + error);
	    	                    }
	    	                });
	    	            }
	    	        },
	    	        error: function(xhr, status, error) {
	    	            alert('Có lỗi xảy ra khi kiểm tra lịch chiếu: ' + error);
	    	        }
	    	    });
	    	
	    }

        
        function changePrice(){
        	const newPrice = parseInt(document.getElementById('newPrice').value);
            if (newPrice < 0) {
                alert("Vui lòng nhập giá vé là số dương.");
                return;
            }
            ghengoidachon.forEach(ghengoiid => {
            	ves[ghengoiid].giave=newPrice
            	const ghengoi="ghengoi_" + ghengoiid
            	const seatElement = document.getElementById(ghengoi);
                seatElement.style.backgroundColor = "";
            });
            ghengoidachon = [];
            renderSeats();
            closeModal();
        }
        
        function thaydoigiave(){
        	if (ghengoidachon.length === 0) {
                alert("Vui lòng chọn ghế trước khi thay đổi giá vé!");
            }else{
            	document.getElementById("priceChangeModal").style.display = "flex";
            }
        }
        
        function closeModal(){
        	document.getElementById("priceChangeModal").style.display = "none";
        }
        
        function toggleSeat(id) {
        	const ghengoiid="ghengoi_" + id
            const seatElement = document.getElementById(ghengoiid);
            const seatIndex = ghengoidachon.findIndex(ghengoiid => ghengoiid === id);
            if (seatIndex === -1) {
            	ghengoidachon.push(id);
                seatElement.style.backgroundColor = "#99FFCC";
            } else {
            	ghengoidachon.splice(seatIndex, 1);
                seatElement.style.backgroundColor = "";
            }
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
