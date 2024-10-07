package model;

public class Theloai {
	private int id;
	private String tentheloai;
	private String mota;
	
	public Theloai() {
		
	}

	public Theloai(int id, String tentheloai, String mota) {
		super();
		this.id = id;
		this.tentheloai = tentheloai;
		this.mota = mota;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTentheloai() {
		return tentheloai;
	}

	public void setTentheloai(String tentheloai) {
		this.tentheloai = tentheloai;
	}

	public String getMota() {
		return mota;
	}

	public void setMota(String mota) {
		this.mota = mota;
	}
	
	
}
