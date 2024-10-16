package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import config.ConnectDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Phim;
import model.Theloai;

@WebServlet("/quanly/phim")
public class PhimDAO extends HttpServlet{
	private static final long serialVersionUID = 1L;
	public PhimDAO() {
		super();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String tenphim = request.getParameter("tenphim");
        String daodien = request.getParameter("daodien");
        String dienvienchinh = request.getParameter("dienvienchinh");
        int thoiluong=0;
        int theloaiId = Integer.parseInt(request.getParameter("theloaiid"));
        try {
        	thoiluong = Integer.parseInt(request.getParameter("thoiluong"));
		} catch (Exception e) {
			request.setAttribute("errorMessage", "Thời lượng nhập số.");
            response.sendRedirect("/pttkht/quanly/GDThemmoimotphim.jsp");
            return;
		}

        if (tenphim == null || daodien == null || dienvienchinh == null || thoiluong <= 0 || theloaiId <= 0) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin.");
            response.sendRedirect("/pttkht/quanly/GDThemmoimotphim.jsp");
            return;
        }

        boolean isSaved = this.luuThongtinphim(tenphim, daodien, dienvienchinh, thoiluong, theloaiId);

        if (isSaved) {
            response.sendRedirect("/pttkht/quanly/GDChinhquanly.jsp");
        } else {
            request.setAttribute("errorMessage", "Lưu phim thất bại, vui lòng thử lại.");
            response.sendRedirect("/pttkht/quanly/GDThemmoimotphim.jsp");
        }
    }
	
	public boolean luuThongtinphim(String tenphim, String daodien, String dienvienchinh, int thoiluong, int theloaiId) {
        String sql = "INSERT INTO tbl_phim (tenphim, daodien, dienvienchinh, thoiluong, theloaiid) VALUES (?, ?, ?, ?, ?)";
        Connection connection = ConnectDB.getConnection();
        PreparedStatement ps = null;
        try{
        	ps = connection.prepareStatement(sql);
            ps.setString(1, tenphim);
            ps.setString(2, daodien);
            ps.setString(3, dienvienchinh);
            ps.setInt(4, thoiluong);
            ps.setInt(5, theloaiId);

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
	
	public List<Phim> getDSPhim(){
		List<Phim> DSPhim = new ArrayList<Phim>();
		Connection con = ConnectDB.getConnection();
		
		PreparedStatement ps = null;
	    ResultSet rs = null;

        try {

            String sql = "SELECT p.*, t.*\r\n"
            		+ "FROM tbl_phim p\r\n"
            		+ "JOIN tbl_theloai t ON p.theloaiid = t.id;";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Phim phim = new Phim();
                phim.setId(rs.getInt("id"));
                phim.setTenphim(rs.getString("tenphim"));
                phim.setDaodien(rs.getString("daodien"));
                phim.setDienvienchinh(rs.getString("dienvienchinh"));
                phim.setThoiluong(rs.getInt("thoiluong"));
                phim.setTheloai(new Theloai(rs.getInt("id"), rs.getString("tentheloai"), rs.getString("mota")));
                DSPhim.add(phim);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return DSPhim;
	}
	
	public List<Phim> getDSPhimbanve(){
		List<Phim> DSPhim = new ArrayList<Phim>();
		Connection con = ConnectDB.getConnection();
		
		PreparedStatement ps = null;
	    ResultSet rs = null;

        try {

            String sql = "SELECT p.*, t.* FROM tbl_phim p\r\n"
            		+ "JOIN tbl_theloai t ON p.theloaiid = t.id\r\n"
            		+ "JOIN tbl_lichchieuphim lcp ON p.id=lcp.phimid\r\n"
            		+ "JOIN tbl_giochieu gc ON gc.id=lcp.giochieuid\r\n"
            		+ "WHERE (lcp.ngaychieu > ?) OR (lcp.ngaychieu=? AND gc.thoigianchieu > ?)";
            ps = con.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(LocalDate.now()));
            ps.setDate(2, Date.valueOf(LocalDate.now()));
            ps.setTime(3, Time.valueOf(LocalTime.now()));
            rs = ps.executeQuery();

            while (rs.next()) {
                Phim phim = new Phim();
                phim.setId(rs.getInt("id"));
                phim.setTenphim(rs.getString("tenphim"));
                phim.setDaodien(rs.getString("daodien"));
                phim.setDienvienchinh(rs.getString("dienvienchinh"));
                phim.setThoiluong(rs.getInt("thoiluong"));
                phim.setTheloai(new Theloai(rs.getInt("id"), rs.getString("tentheloai"), rs.getString("mota")));
                DSPhim.add(phim);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return DSPhim;
	}
}
