package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import config.ConnectDB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import model.Theloai;

@WebServlet("/quanly/theloai")
public class TheloaiDAO extends HttpServlet{
	private static final long serialVersionUID = 1L;
	public TheloaiDAO() {
		super();
	}
	
	public List<Theloai> getDanhsachtheloai(){
		List<Theloai> DSTheloai = new ArrayList<Theloai>();
		Connection con = ConnectDB.getConnection();
		
		PreparedStatement ps = null;
	    ResultSet rs = null;

        try {

            String sql = "SELECT * from tbl_theloai;";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Theloai theloai=new Theloai();
                theloai.setId(rs.getInt("id"));
                theloai.setTentheloai(rs.getString("tentheloai"));
                theloai.setMota(rs.getString("mota"));
                DSTheloai.add(theloai);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return DSTheloai;
	}
	
}
