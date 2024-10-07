package model;

import java.time.LocalDate;

public class Nhanvienbanve extends Thanhvien{
	
	private String calamviec;
	
	public Nhanvienbanve() {
		
	}

	public Nhanvienbanve( String calamviec, int id, String username, String password, String hoten, LocalDate ngaysinh,
			String email, String std, String vaitro) {
		super(id, username, password, hoten, ngaysinh, email, std, vaitro);
		this.calamviec=calamviec;
	}

	public String getCalamviec() {
		return calamviec;
	}

	public void setCalamviec(String calamviec) {
		this.calamviec = calamviec;
	}
	
	

}
