package config;

import java.sql.Connection;
import java.sql.DriverManager;


public class ConnectDB{
	public static Connection con;
	public static Connection getConnection() {
	    if (con == null) {
	        String dbUrl = "jdbc:mysql://localhost:3306/pttkht_movie?autoReconnect=true&useSSL=false";
	        String dbClass = "com.mysql.cj.jdbc.Driver";

	        try {
	            Class.forName(dbClass);
	            con = DriverManager.getConnection(dbUrl, "root", "quancntt2003");
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return con;
	}

    
}
