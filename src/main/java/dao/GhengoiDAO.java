package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import config.ConnectDB;
import jakarta.servlet.http.HttpServlet;
import model.Ghengoi;

public class GhengoiDAO extends HttpServlet{
	private static final long serialVersionUID = 1L;
	public GhengoiDAO() {
		super();
	}

	public List<Ghengoi> getDSGhengoi(int phongchieuid){
		
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<Ghengoi> ghengois=new ArrayList<Ghengoi>();
		
		try {
			String sql= "SELECT * FROM tbl_ghengoi WHERE tbl_ghengoi.phongchieuid= ? ORDER BY tbl_ghengoi.soghe ASC";
			ps=con.prepareStatement(sql);
			ps.setInt(1, phongchieuid);
			rs=ps.executeQuery();
			while(rs.next()) {
				Ghengoi ghengoi=new Ghengoi();
				ghengoi.setId(rs.getInt("id"));
				ghengoi.setSoghe(rs.getString("soghe"));
				ghengois.add(ghengoi);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return ghengois;
	}
}
