package Model;

public class LoginCounts {

	private String time;
	private int counts;

	public LoginCounts(String time, int counts){
		this.time = time;
		this.counts = counts;
	}

	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getCounts() {
		return counts;
	}
	public void setCounts(int counts) {
		this.counts = counts;
	}
	
}
