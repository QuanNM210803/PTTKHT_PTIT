package model;

import java.time.LocalDate;
import java.util.Date;


public class Thanhvien {
	private int id;
	private String username;
	private String password;
	private String hoten;
	private LocalDate ngaysinh;
	private String email;
	private String sdt;
	private String vaitro;
	
	public Thanhvien() {
		
	}
	
	public Thanhvien(int id, String username, String password, String hoten, LocalDate ngaysinh,
			String email, String sdt, String vaitro) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.hoten = hoten;
		this.ngaysinh = ngaysinh;
		this.email = email;
		this.sdt = sdt;
		this.vaitro = vaitro;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getHoten() {
		return hoten;
	}
	public void setHoten(String hoten) {
		this.hoten = hoten;
	}
	public LocalDate getNgaysinh() {
		return ngaysinh;
	}
	public void setNgaysinh(LocalDate ngaysinh) {
		this.ngaysinh = ngaysinh;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getStd() {
		return sdt;
	}
	public void setStd(String std) {
		this.sdt = std;
	}
	public String getVaitro() {
		return vaitro;
	}
	public void setVaitro(String vaitro) {
		this.vaitro = vaitro;
	}
	
	
}
