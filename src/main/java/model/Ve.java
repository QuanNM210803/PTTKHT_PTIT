package model;

public class Ve {
    private int id;
    private boolean trangthai;
    private int giave; 
    private Ghengoi ghengoi;
	public Ve(int id, boolean trangthai, int giave, Ghengoi ghengoi) {
		this.id = id;
		this.trangthai = trangthai;
		this.giave = giave;
		this.ghengoi = ghengoi;
	}
	public Ve(boolean trangthai, int giave, Ghengoi ghengoi) {
		this.trangthai = trangthai;
		this.giave = giave;
		this.ghengoi = ghengoi;
	}
	public Ve() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public boolean isTrangthai() {
		return trangthai;
	}
	public void setTrangthai(boolean trangthai) {
		this.trangthai = trangthai;
	}
	public int getGiave() {
		return giave;
	}
	public void setGiave(int giave) {
		this.giave = giave;
	}
	public Ghengoi getGhengoi() {
		return ghengoi;
	}
	public void setGhengoi(Ghengoi ghengoi) {
		this.ghengoi = ghengoi;
	}

    
}

