package model;

import java.time.LocalTime;

public class Giochieu {
	private int id;
	private LocalTime thoigianchieu;
	public Giochieu(int id, LocalTime thoigianchieu) {
		super();
		this.id = id;
		this.thoigianchieu = thoigianchieu;
	}
	public Giochieu() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public LocalTime getThoigianchieu() {
		return thoigianchieu;
	}
	public void setThoigianchieu(LocalTime thoigianchieu) {
		this.thoigianchieu = thoigianchieu;
	}
	
	
	
}
