package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import config.ConnectDB;
import jakarta.servlet.http.HttpServlet;
import model.Phongchieu;

public class PhongchieuDAO extends HttpServlet{
	private static final long serialVersionUID = 1L;
	public PhongchieuDAO() {
		super();
	}
	
	public List<Phongchieu> getDSPhongchieu(){
		List<Phongchieu> phongchieus=new ArrayList<Phongchieu>();
		
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			String sql="SELECT * FROM tbl_phongchieu;";
			ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
			
            while(rs.next()) {
            	Phongchieu phongchieu=new Phongchieu();
            	phongchieu.setId(rs.getInt("id"));
            	phongchieu.setTenphongchieu(rs.getString("tenphongchieu"));
            	phongchieu.setDacdiem(rs.getString("dacdiem"));
            	phongchieus.add(phongchieu);
            }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return phongchieus;
	}
}
