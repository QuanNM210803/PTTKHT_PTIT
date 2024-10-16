package model;

public class Phim {
	private int id;
	private String tenphim;
	private String daodien;
	private String dienvienchinh;
	private int thoiluong;
	private Theloai theloai;
	
	public Phim() {
		
	}
	public Phim(int id, String tenphim, String daodien, String dienvienchinh, int thoiluong, Theloai theloai) {
		super();
		this.id = id;
		this.tenphim = tenphim;
		this.daodien = daodien;
		this.dienvienchinh = dienvienchinh;
		this.thoiluong = thoiluong;
		this.theloai=theloai;
	}
	public Phim(int id, String tenphim, String daodien, String dienvienchinh, int thoiluong) {
		super();
		this.id = id;
		this.tenphim = tenphim;
		this.daodien = daodien;
		this.dienvienchinh = dienvienchinh;
		this.thoiluong = thoiluong;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTenphim() {
		return tenphim;
	}
	public void setTenphim(String tenphim) {
		this.tenphim = tenphim;
	}
	public String getDaodien() {
		return daodien;
	}
	public void setDaodien(String daodien) {
		this.daodien = daodien;
	}
	public String getDienvienchinh() {
		return dienvienchinh;
	}
	public void setDienvienchinh(String dienvienchinh) {
		this.dienvienchinh = dienvienchinh;
	}
	public int getThoiluong() {
		return thoiluong;
	}
	public void setThoiluong(int thoiluong) {
		this.thoiluong = thoiluong;
	}
	public Theloai getTheloai() {
		return theloai;
	}
	public void setTheloai(Theloai theloai) {
		this.theloai = theloai;
	}
	
	
}
