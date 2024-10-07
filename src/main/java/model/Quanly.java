package model;

import java.time.LocalDate;

public class Quanly extends Thanhvien{
	private String phongban;
	
	public Quanly() {
		
	}

	public Quanly(String phongban, int id, String username, String password, String hoten, LocalDate ngaysinh,
			String email, String std, String vaitro) {
		super(id, username, password, hoten, ngaysinh, email, std, vaitro);
		this.phongban=phongban;
	}

	public String getPhongban() {
		return phongban;
	}

	public void setPhongban(String phongban) {
		this.phongban = phongban;
	}
	
	
}
