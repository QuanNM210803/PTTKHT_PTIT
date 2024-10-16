package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import config.ConnectDB;
import dto.response.Thoidiemchieu;
import jakarta.servlet.http.HttpServlet;
import model.Giochieu;

public class GiochieuDAO extends HttpServlet{
	private static final long serialVersionUID = 1L;
	public GiochieuDAO() {
		super();
	}
	
	public List<Thoidiemchieu> getDSThoidiemchieu(){
		List<Thoidiemchieu> thoidiemchieus=new ArrayList<Thoidiemchieu>();
		
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			String sql="SELECT * FROM tbl_giochieu;";
			ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
			List<Giochieu> giochieus=new ArrayList<Giochieu>();
            while(rs.next()) {
        		Giochieu giochieu=new Giochieu();
            	giochieu.setId(rs.getInt("id"));
            	giochieu.setThoigianchieu(rs.getTime("thoigianchieu").toLocalTime());
            	giochieus.add(giochieu);
            }
            
            // 2 ngày tiếp theo
            for(int i=0;i<=2;i++) {
            	for(Giochieu giochieu:giochieus) {
            		if(i==0 && LocalTime.now().isAfter(giochieu.getThoigianchieu())) {
            			continue;
            		}
            		if(giochieu.getThoigianchieu().isAfter(LocalTime.of(0, 0, 0)) && giochieu.getThoigianchieu().isBefore(LocalTime.of(6, 0, 0))) {
            			continue;
            		}
            		Thoidiemchieu thoidiemchieu=new Thoidiemchieu(giochieu, LocalDate.now().plusDays(i));
            		thoidiemchieus.add(thoidiemchieu);
            	}
            }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return thoidiemchieus;
	}
}
