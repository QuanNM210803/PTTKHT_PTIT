package model;

public class Ghengoi {
    private int id;
    private String soghe;
	public Ghengoi(int id, String soghe) {
		super();
		this.id = id;
		this.soghe = soghe;
	}
	public Ghengoi() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSoghe() {
		return soghe;
	}
	public void setSoghe(String soghe) {
		this.soghe = soghe;
	}
    
}

