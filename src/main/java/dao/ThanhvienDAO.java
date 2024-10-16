package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import config.ConnectDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Nhanvienbanve;
import model.Quanly;
import model.Thanhvien;

@WebServlet("/dangnhap")
public class ThanhvienDAO extends HttpServlet{

	private static final long serialVersionUID = 1L;
	public ThanhvienDAO() {
		super();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Thanhvien thanhvien=this.checkLogin(username, password);
        
        if(thanhvien instanceof Quanly){
        	HttpSession session = request.getSession();
        	session.setAttribute("user", thanhvien);
        	response.sendRedirect("/pttkht/quanly/GDChinhquanly.jsp");
		}else if(thanhvien instanceof Nhanvienbanve) {
			HttpSession session = request.getSession();
        	session.setAttribute("user", thanhvien);
        	response.sendRedirect("/pttkht/nhanvienbanve/GDChinhnhanvienbanve.jsp");
		}else {
			response.sendRedirect("/pttkht/GDDangnhap.jsp?error=true");
		}
     
    }
	
	private Thanhvien checkLogin(String username, String password) {
		Connection con = ConnectDB.getConnection();
		
		PreparedStatement ps = null;
	    ResultSet rs = null;
	    Thanhvien tv = null;
	    try {

	        String query = "SELECT * FROM tbl_thanhvien WHERE username = ? AND password = ?";
	        ps = con.prepareStatement(query);
	        ps.setString(1, username);
	        ps.setString(2, password);
	        
	        rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            int id = rs.getInt("id");
	            String hoten = rs.getString("hoten");
	            LocalDate ngaysinh=rs.getDate("ngaysinh").toLocalDate();
	            String email=rs.getString("email");
	            String sdt=rs.getString("sdt");
	            String vaitro = rs.getString("vaitro");

	            if ("QL".equals(vaitro)) {
	                String queryQL = "SELECT * FROM tbl_quanly WHERE thanhvienid = ?";
	                ps=con.prepareStatement(queryQL);
	                ps.setInt(1, id);
	                rs=ps.executeQuery();
	                
	                if (rs.next()) {
	                    String phongban = rs.getString("phongban");
	                    tv = new Quanly(phongban, id, username, "", hoten, ngaysinh, email, sdt, vaitro);
	                }
	                
	            } else if ("NVBV".equals(vaitro)) {

	                String queryNVBV = "SELECT * FROM tbl_nhanvienbanve WHERE thanhvienid = ?";
	                ps=con.prepareStatement(queryNVBV);
	                ps.setInt(1, id);
	                rs=ps.executeQuery();
	                
	                if (rs.next()) {
	                    String calamviec = rs.getString("calamviec");
	                    tv=new Nhanvienbanve(calamviec, id, username, "", hoten, ngaysinh, email, sdt, vaitro);
	                }

	            }
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return tv;
	}

}
