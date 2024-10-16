package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import config.ConnectDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Giochieu;
import model.Lichchieuphim;
import model.Phim;
import model.Phongchieu;
import model.Ve;

@WebServlet("/lenlichchieuphim")
public class LichchieuphimDAO extends HttpServlet{

	private static final long serialVersionUID = 1L;
	public LichchieuphimDAO() {
		super();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		
		String vesJson = request.getParameter("vesJson");
	    int phimid = Integer.parseInt(request.getParameter("phimid"));
	    int phongchieuid = Integer.parseInt(request.getParameter("phongchieuid"));
	    LocalDate ngaychieu = LocalDate.parse(request.getParameter("ngaychieu"));
	    int giochieuid = Integer.parseInt(request.getParameter("giochieuid"));
	    	
	    ObjectMapper objectMapper = new ObjectMapper();
	    List<Ve> danhSachVe = new ArrayList<Ve>();
        
	    try {
	        danhSachVe = objectMapper.readValue(vesJson, new TypeReference<List<Ve>>() {});
	        boolean isSuccess=luuLichchieuphim(phimid, phongchieuid, giochieuid, ngaychieu, danhSachVe);
	        if(isSuccess) {
	        	 response.setStatus(HttpServletResponse.SC_OK);
	        }else {
	        	response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý yêu cầu: " + e.getMessage());
	    }
     
    }
	
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        int phimid = Integer.parseInt(request.getParameter("phimid"));
	        int phongchieuid = Integer.parseInt(request.getParameter("phongchieuid"));
	        LocalDate ngaychieu = LocalDate.parse(request.getParameter("ngaychieu"));
	        LocalTime thoigianchieu = LocalTime.parse(request.getParameter("thoigianchieu"));

	        boolean isTrunglichchieu = this.checkTrunglichchieu(phimid, phongchieuid, ngaychieu, thoigianchieu);
	        
	        
	        Map<String, Object> result = new HashMap<>();
	        result.put("isTrunglichchieu", isTrunglichchieu);

	        ObjectMapper objectMapper = new ObjectMapper();
	        String jsonResponse = objectMapper.writeValueAsString(result);

	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.setStatus(HttpServletResponse.SC_OK);
	        response.getWriter().write(jsonResponse);

	    }
	
	public boolean checkTrunglichchieu(int phimid, int phongchieuid, LocalDate ngaychieu, LocalTime thoigianchieu) {
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			String sqlPhim= "SELECT * FROM tbl_phim WHERE tbl_phim.id= ?";
			ps=con.prepareStatement(sqlPhim);
			ps.setInt(1, phimid);
			rs=ps.executeQuery();
			
			int thoiluong=0;
			while(rs.next()) {
				thoiluong=rs.getInt("thoiluong");
			}
			LocalTime startTime_lichchieumoi=thoigianchieu;
			LocalTime endTime_lichchieumoi=thoigianchieu.plusMinutes(thoiluong);
			
			
			String sqlLichchieuphim= "SELECT lc.*, gc.*, p.* FROM tbl_lichchieuphim lc JOIN tbl_giochieu gc JOIN tbl_phim p ON lc.giochieuid = gc.id AND lc.phimid=p.id\r\n"
									+ "WHERE lc.phongchieuid = ? AND lc.ngaychieu = ?";
			ps=con.prepareStatement(sqlLichchieuphim);
			ps.setInt(1, phongchieuid);
			ps.setDate(2, Date.valueOf(ngaychieu));
			rs=ps.executeQuery();
			
			while(rs.next()) {
				LocalTime startTime=rs.getTime("thoigianchieu").toLocalTime();
				LocalTime endTime=startTime.plusMinutes(rs.getInt("thoiluong"));
				
				if ((startTime_lichchieumoi.isBefore(endTime) && endTime_lichchieumoi.isAfter(endTime)) || 
						(startTime_lichchieumoi.isBefore(startTime) && endTime_lichchieumoi.isAfter(startTime))) {
				    return true;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	public boolean luuLichchieuphim(int phimid, int phongchieuid, int giochieuid, LocalDate ngaychieu, List<Ve> ves) {
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps=null;
		//ResultSet rs=null;
		
		try {
			String sqlLichchieuphim = "INSERT INTO tbl_lichchieuphim (phimid, phongchieuid, giochieuid, ngaychieu) VALUES (?, ?, ?, ?)";
			ps = con.prepareStatement(sqlLichchieuphim, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, phimid);
			ps.setInt(2, phongchieuid);
			ps.setInt(3, giochieuid);
			ps.setDate(4, Date.valueOf(ngaychieu));

			ps.executeUpdate();

			ResultSet generatedKeys = ps.getGeneratedKeys();
			if (generatedKeys.next()) {
			    int lichchieuphimid = generatedKeys.getInt(1);
			    
			    String sqlInsertVe = "INSERT INTO tbl_ve (trangthai, giave, ghengoiid, lichchieuphimid, hoadonid) VALUES (?,?,?,?,?)";
			    ps = con.prepareStatement(sqlInsertVe);
			    
			    for(Ve ve:ves) {
			    	ps.setBoolean(1, true);
					ps.setInt(2, ve.getGiave());
					ps.setInt(3, ve.getGhengoi().getId());
					ps.setInt(4, lichchieuphimid);
					ps.setNull(5, java.sql.Types.INTEGER);
					
					ps.executeUpdate();
			    }
			}
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public List<Lichchieuphim> getDSLichchieuphim(int phimid){
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			List<Lichchieuphim> lichchieuphims=new ArrayList<Lichchieuphim>();
			String sql="SELECT p.id AS p_id, lcp.id AS lcp_id, gc.id AS gc_id, pc.id AS pc_id, lcp.*, gc.*, pc.*, p.* "
			        + "FROM tbl_lichchieuphim lcp "
			        + "JOIN tbl_phim p ON p.id=lcp.phimid "
			        + "JOIN tbl_giochieu gc ON lcp.giochieuid=gc.id "
			        + "JOIN tbl_phongchieu pc ON pc.id=lcp.phongchieuid "
			        + "WHERE lcp.phimid= ? AND ((lcp.ngaychieu > ?) OR (lcp.ngaychieu=? AND gc.thoigianchieu > ?))";
			ps = con.prepareStatement(sql);
			ps.setInt(1, phimid);
            ps.setDate(2, Date.valueOf(LocalDate.now()));
            ps.setDate(3, Date.valueOf(LocalDate.now()));
            ps.setTime(4, Time.valueOf(LocalTime.now()));
            rs = ps.executeQuery();
            
            while(rs.next()) {
            	int pid=rs.getInt("p_id");
            	String tenphim= rs.getString("tenphim");
            	String daodien=rs.getString("daodien");
            	String dienvienchinh=rs.getString("dienvienchinh");
            	int thoiluong=rs.getInt("thoiluong");
            	Phim phim=new Phim(pid, tenphim, daodien, dienvienchinh, thoiluong);
            	
            	int gcid=rs.getInt("gc_id");
            	LocalTime thoigianchieu=rs.getTime("thoigianchieu").toLocalTime();
            	Giochieu giochieu=new Giochieu(gcid, thoigianchieu);
            	
            	int pcid=rs.getInt("pc_id");
            	String tenphongchieu=rs.getString("tenphongchieu");
            	String dacdiem=rs.getString("dacdiem");
            	Phongchieu phongchieu=new Phongchieu(pcid, tenphongchieu, dacdiem);
            	
            	int lcpid=rs.getInt("lcp_id");
            	LocalDate ngaychieu=rs.getDate("ngaychieu").toLocalDate();
            	
            	lichchieuphims.add(new Lichchieuphim(lcpid, ngaychieu, phongchieu, giochieu, phim));
            }
			return lichchieuphims;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
