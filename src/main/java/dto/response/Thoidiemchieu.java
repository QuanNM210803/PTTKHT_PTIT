package dto.response;

import java.time.LocalDate;

import model.Giochieu;

public class Thoidiemchieu {
	private Giochieu giochieu;
	private LocalDate ngaychieu;
	public Thoidiemchieu(Giochieu giochieu, LocalDate ngaychieu) {
		super();
		this.giochieu = giochieu;
		this.ngaychieu = ngaychieu;
	}
	public Thoidiemchieu() {
		super();
	}
	public Giochieu getGiochieu() {
		return giochieu;
	}
	public void setGiochieu(Giochieu giochieu) {
		this.giochieu = giochieu;
	}
	public LocalDate getNgaychieu() {
		return ngaychieu;
	}
	public void setNgaychieu(LocalDate ngaychieu) {
		this.ngaychieu = ngaychieu;
	}
	
	
}
