package member;

public class memberBean {
	private int no;
	private String id;
	private String pw;
	private String name;
	private String b_date;
	private String gender;
	private String email;
	private String phone;

	public memberBean(int no,String id, String pw, String name, String b_date, String gender, String email, String phone) {
		super();
		this.no = no;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.b_date = b_date;
		this.gender = gender;
		this.email = email;
		this.phone = phone;
	}

	
	public memberBean() {
		super();
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getB_date() {
		return b_date;
	}

	public void setB_date(String b_date) {
		this.b_date = b_date;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
}
