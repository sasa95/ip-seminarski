package rs;

public class Admin_sajta {
	private int adminID;
	private String username,password;
	public Admin_sajta(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}
	public Admin_sajta() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getAdminID() {
		return adminID;
	}
	public void setAdminID(int adminID) {
		this.adminID = adminID;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
