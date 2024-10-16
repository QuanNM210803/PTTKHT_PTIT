package model;

import java.time.LocalDate;
import java.util.List;

public class Lichchieuphim {
    private int id;
    private LocalDate ngaychieu;
    private Phim phim; 
    private Phongchieu phongchieu;
    private Giochieu giochieu;
    private List<Ve> ve;
	public Lichchieuphim(int id, LocalDate ngaychieu, Phim phim, Phongchieu phongchieu, Giochieu giochieu, List<Ve> ve) {
		super();
		this.id = id;
		this.ngaychieu = ngaychieu;
		this.phim = phim;
		this.phongchieu = phongchieu;
		this.giochieu = giochieu;
		this.ve=ve;
	}
	public Lichchieuphim(int id, LocalDate ngaychieu, Phongchieu phongchieu, Giochieu giochieu, Phim phim) {
		super();
		this.id = id;
		this.ngaychieu = ngaychieu;
		this.phongchieu = phongchieu;
		this.giochieu = giochieu;
		this.phim = phim;
	}
	public Lichchieuphim() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public LocalDate getNgaychieu() {
		return ngaychieu;
	}
	public void setNgaychieu(LocalDate ngaychieu) {
		this.ngaychieu = ngaychieu;
	}
	public Phim getPhim() {
		return phim;
	}
	public void setPhim(Phim phim) {
		this.phim = phim;
	}
	public Phongchieu getPhongchieu() {
		return phongchieu;
	}
	public void setPhongchieu(Phongchieu phongchieu) {
		this.phongchieu = phongchieu;
	}
	public Giochieu getGiochieu() {
		return giochieu;
	}
	public void setGiochieu(Giochieu giochieu) {
		this.giochieu = giochieu;
	}
	public List<Ve> getVe() {
		return ve;
	}
	public void setVe(List<Ve> ve) {
		this.ve = ve;
	}
    
    
    
}
