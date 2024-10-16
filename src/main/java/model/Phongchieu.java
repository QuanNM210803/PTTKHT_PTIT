package model;

import java.util.List;

public class Phongchieu {
    private int id;
    private String tenphongchieu;
    private String dacdiem;
    private List<Ghengoi> ghengoi;
    
    public Phongchieu() {
    	
    }
	public Phongchieu(int id, String tenphongchieu, String dacdiem, List<Ghengoi> ghengoi) {
		super();
		this.id = id;
		this.tenphongchieu = tenphongchieu;
		this.dacdiem = dacdiem;
		this.ghengoi=ghengoi;
	}
	public Phongchieu(int id, String tenphongchieu, String dacdiem) {
		super();
		this.id = id;
		this.tenphongchieu = tenphongchieu;
		this.dacdiem = dacdiem;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTenphongchieu() {
		return tenphongchieu;
	}
	public void setTenphongchieu(String tenphongchieu) {
		this.tenphongchieu = tenphongchieu;
	}
	public String getDacdiem() {
		return dacdiem;
	}
	public void setDacdiem(String dacdiem) {
		this.dacdiem = dacdiem;
	}
	public List<Ghengoi> getGhengoi() {
		return ghengoi;
	}
	public void setGhengoi(List<Ghengoi> ghengoi) {
		this.ghengoi = ghengoi;
	}

    

}

