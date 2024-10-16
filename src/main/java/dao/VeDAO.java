package dao;

import java.io.IOException;
import java.security.Timestamp;
import java.sql.Array;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
import jakarta.servlet.http.HttpSession;
import model.Ghengoi;
import model.Giochieu;
import model.Lichchieuphim;
import model.Phim;
import model.Phongchieu;
import model.Thanhvien;
import model.Ve;

@WebServlet("/ve")
public class VeDAO extends HttpServlet{

	private static final long serialVersionUID = 1L;
	public VeDAO() {
		super();
	}
	
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] dsveid = request.getParameter("dsveid").split(",");
        List<Integer> ds_veid=new ArrayList<Integer>();
        for(String veid:dsveid) {
        	ds_veid.add(Integer.parseInt(veid));
        }
        boolean isTrangthaive = checkTrangthaive(ds_veid);
        
        
        Map<String, Object> result = new HashMap<>();
        result.put("isTrangthaive", isTrangthaive);

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonResponse = objectMapper.writeValueAsString(result);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(jsonResponse);

    }
	 
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		 HttpSession isession = request.getSession(false);
         Integer thanhvienid = (isession != null && isession.getAttribute("user") != null) 
                           ? ((Thanhvien) isession.getAttribute("user")).getId() 
                           : null;
		 
		String[] dsveid = request.getParameter("dsveid").split(",");
        List<Integer> ds_veid=new ArrayList<Integer>();
        for(String veid:dsveid) {
        	ds_veid.add(Integer.parseInt(veid));
        }
        boolean isLuudatve = luuDatve(ds_veid, thanhvienid);
        
        
        Map<String, Object> result = new HashMap<>();
        result.put("isLuudatve", isLuudatve);

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonResponse = objectMapper.writeValueAsString(result);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(jsonResponse);
     
    }
	 
	private boolean checkTrangthaive(List<Integer> ds_veid) {
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			StringBuilder placeholders = new StringBuilder();
			for (int i = 0; i < ds_veid.size(); i++) {
			    placeholders.append("?");
			    if (i < ds_veid.size() - 1) {
			        placeholders.append(", ");
			    }
			}
			String sql="SELECT * FROM tbl_ve WHERE tbl_ve.id IN (" + placeholders.toString() + ")";
			ps=con.prepareStatement(sql);

			for(int i=0;i<ds_veid.size(); i++) {
			    ps.setInt(i+1, ds_veid.get(i));
			}
			rs = ps.executeQuery();
			
			while(rs.next()) {
				boolean trangthai=rs.getBoolean("trangthai");
				if(trangthai==false) {
					return false;
				}
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	private boolean luuDatve(List<Integer> ds_veid, Integer thanhvienid) {
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps=null;
		//ResultSet rs=null;
		
		try {
			String sql="INSERT INTO tbl_hoadon (thoigiantao, nhanvienbanveid) "
					+ "VALUES (?,?)";
			ps=con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setTimestamp(1, java.sql.Timestamp.valueOf(LocalDateTime.now()));
			ps.setInt(2, thanhvienid);
			ps.executeUpdate();
			ResultSet generatedKeys = ps.getGeneratedKeys();
			if (generatedKeys.next()) {
			    int hoadonid = generatedKeys.getInt(1);
			    
			    StringBuilder placeholders = new StringBuilder();
				for (int i = 0; i < ds_veid.size(); i++) {
				    placeholders.append("?");
				    if (i < ds_veid.size() - 1) {
				        placeholders.append(", ");
				    }
				}
				String sqlUpdateVe="UPDATE tbl_ve SET tbl_ve.trangthai=false, tbl_ve.hoadonid= ? "
						+ "WHERE tbl_ve.id IN (" + placeholders.toString() + ")";
				ps=con.prepareStatement(sqlUpdateVe);
				ps.setInt(1, hoadonid);
				for(int i=0;i<ds_veid.size(); i++) {
				    ps.setInt(i+2, ds_veid.get(i));
				}
				ps.executeUpdate();
				return true;
			}
			return false;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public List<Ve> getDSVe(Lichchieuphim lichchieuphim){
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			List<Ve> ves=new ArrayList<Ve>();
			String sql="SELECT v.id AS v_id, ng.id AS ng_id, v.*, ng.* FROM tbl_ve v "
					+ "JOIN tbl_ghengoi ng ON ng.id=v.ghengoiid "
					+ "WHERE v.lichchieuphimid=? AND ng.phongchieuid=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, lichchieuphim.getId());
            ps.setInt(2, lichchieuphim.getPhongchieu().getId());
            rs = ps.executeQuery();
            
            while(rs.next()) {
            	int ngid=rs.getInt("ng_id");
            	String soghe=rs.getString("soghe");
            	Ghengoi ghengoi=new Ghengoi(ngid, soghe);
            	
            	int vid=rs.getInt("v_id");
            	Boolean trangthai=rs.getBoolean("trangthai");
            	int giave=rs.getInt("giave");
            	ves.add(new Ve(vid, trangthai, giave, ghengoi));
            }
			return ves;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}