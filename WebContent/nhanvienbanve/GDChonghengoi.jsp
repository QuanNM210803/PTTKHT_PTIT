<%@page import="dao.VeDAO"%>
<%@page import="model.Ve"%>
<%@page import="model.Lichchieuphim"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Phim"%>
<%@page import="java.util.List"%>
<%@page import="model.Thanhvien"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime" %>
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
	
	VeDAO veDAO=new VeDAO();
	List<Ve> dsve=veDAO.getDSVe(lichchieuphim);
	
	httpSession.setAttribute("dsve", dsve);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chọn ghế ngồi</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 100px);
        }
        .form-card {
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 20px;
            padding: 10px;
            width: 600px;
            text-align: center;
            flex-direction: column;
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
		h2 {
            text-align: center;
        }
        p {
            text-align: center;
        }
        
        .p-left{
        	text-align: left;
            padding-left: 20px;
        }
        .submit-button {
            width: 100px;
            margin: 10px auto;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            border-radius: 5px;
            border: none;
        }
        
        .submit-button-disabled {
	        background-color: #ccc;
	        cursor: not-allowed;
	        width: 100px;
            margin: 10px auto;
            padding: 10px;
            color: white;
            border-radius: 5px;
            border: none;
	    }

        .unavailable {
            background-color: #ccc;
            text-align: center;
            border: 0.5px solid #999;
        }

        .pointer{
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
        <div class="form-card">
            <h2>Chọn ghế ngồi</h2>
            <p class="p-left"><strong>Phim: </strong><%= phim.getTenphim() %></p>
            <p class="p-left"><strong>Phòng chiếu: </strong><%= lichchieuphim.getPhongchieu().getTenphongchieu() %></p>
            <p class="p-left"><strong>Thời điểm chiếu: </strong><%= lichchieuphim.getNgaychieu() + " " + lichchieuphim.getGiochieu().getThoigianchieu() %></p>

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
			    
		    <button id="continue-button" onclick="handleClickButton()">Tiếp tục</button>

        </div>
    </div>
    <script>
    
        let ghengoidachon = [];
	    var ves = JSON.parse('<%= new com.fasterxml.jackson.databind.ObjectMapper().writeValueAsString(dsve) %>');
	    console.log(ves)
	    function updateButtonState() {
		    const button = document.getElementById('continue-button');
		    if (ghengoidachon.length > 0) {
		    	button.className = 'submit-button'
		        button.disabled = false;
		    } else {
		    	button.className = 'submit-button-disabled'
		        button.disabled = true;
		    }
	    }
	    updateButtonState();
	    
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
	                seatCell.id = ves[count].id;
	                seatCell.className = 'ghengoi';
	                if (ves[count].trangthai===false) {
	                    seatCell.className += ' unavailable'; 
	                    var price = document.createElement('p');
		                price.innerHTML = "X";
		                seatCell.appendChild(price);
	                } else {
	                    seatCell.setAttribute('onclick', 'toggleSeat(' + ves[count].id + ')');
	                    seatCell.className += ' pointer';
	                 	// Hiển thị giá vé
		                var price = document.createElement('p');
		                price.innerHTML = ves[count].giave;
		                seatCell.appendChild(price);
	                }
	
	                row.appendChild(seatCell);
	                count++;
	            }
	
	            tbody.appendChild(row);
	        });
	    }
	    renderSeats();
	    
	    function toggleSeat(veid) {
            const seatElement = document.getElementById(veid);
            const seatIndex = ghengoidachon.findIndex(ve_id => ve_id === veid);
            if (!ghengoidachon.includes(veid)) {
            	ghengoidachon.push(veid);
                seatElement.style.backgroundColor = "#99FFCC";
            } else {
            	ghengoidachon = ghengoidachon.filter(item => item !== veid);
                seatElement.style.backgroundColor = "";
            }
            updateButtonState();
        }
	    
	    function handleClickButton(){
	        let seats = ghengoidachon.join(',');
	        window.location.href = '/pttkht/nhanvienbanve/GDXacnhanthanhtoan.jsp?seats='+seats + '&lichchieuphimid=' + <%=lichchieuphimid%>;
	    }
    </script>
</body>
</html>
