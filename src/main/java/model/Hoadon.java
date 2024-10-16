package model;

import java.time.LocalDateTime;
import java.util.List;

public class Hoadon {
    private int id;
    private LocalDateTime thoigiantao;
    private int tongtien;
    private Nhanvienbanve nhanvienbanve;
    private List<Ve> ve;
	public Hoadon(int id, LocalDateTime thoigiantao, int tongtien, Nhanvienbanve nhanvienbanve, List<Ve> ve) {
		super();
		this.id = id;
		this.thoigiantao = thoigiantao;
		this.tongtien = tongtien;
		this.nhanvienbanve = nhanvienbanve;
		this.ve = ve;
	}
	public Hoadon() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public LocalDateTime getThoigiantao() {
		return thoigiantao;
	}
	public void setThoigiantao(LocalDateTime thoigiantao) {
		this.thoigiantao = thoigiantao;
	}
	public int getTongtien() {
		return tongtien;
	}
	public void setTongtien(int tongtien) {
		this.tongtien = tongtien;
	}
	public Nhanvienbanve getNhanvienbanve() {
		return nhanvienbanve;
	}
	public void setNhanvienbanve(Nhanvienbanve nhanvienbanve) {
		this.nhanvienbanve = nhanvienbanve;
	}
	public List<Ve> getVe() {
		return ve;
	}
	public void setVe(List<Ve> ve) {
		this.ve = ve;
	}
    
    
}
