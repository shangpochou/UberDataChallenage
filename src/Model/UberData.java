package Model;

import org.joda.time.DateTime;

public class UberData {

	private String city;
	private Integer trips_in_first_30_days;
	private DateTime signup_date;
	private Double avg_rating_of_driver;
	private Double avg_surge;
	private DateTime last_trip_date;
	private String phone;
	private Double surge_pct;
	private Boolean uber_black_user;
	private Double weekday_pct;
	private Double avg_dist;
	private Double avg_rating_by_driver;
	
	private Integer customerLifeTime;
	/*
	 * If trip_in_first_30days > 0
	 * */
	private Boolean Retention;
	
	private Boolean isActive;
	public Boolean getIsActive() {
		return isActive;
	}
	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	public Integer getCustomerLifeTime() {
		return customerLifeTime;
	}
	public void setCustomerLifeTime(Integer customerLifeTime) {
		this.customerLifeTime = customerLifeTime;
	}
	public Boolean getRetention() {
		return Retention;
	}
	public void setRetention(Boolean retention) {
		Retention = retention;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public Integer getTrips_in_first_30_days() {
		return trips_in_first_30_days;
	}
	public void setTrips_in_first_30_days(Integer trips_in_first_30_days) {
		this.trips_in_first_30_days = trips_in_first_30_days;
	}
	public DateTime getSignup_date() {
		return signup_date;
	}
	public void setSignup_date(DateTime signup_date) {
		this.signup_date = signup_date;
	}
	public Double getAvg_rating_of_driver() {
		return avg_rating_of_driver;
	}
	public void setAvg_rating_of_driver(Double avg_rating_of_driver) {
		this.avg_rating_of_driver = avg_rating_of_driver;
	}
	public Double getAvg_surge() {
		return avg_surge;
	}
	public void setAvg_surge(Double avg_surge) {
		this.avg_surge = avg_surge;
	}
	public DateTime getLast_trip_date() {
		return last_trip_date;
	}
	public void setLast_trip_date(DateTime last_trip_date) {
		this.last_trip_date = last_trip_date;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Double getSurge_pct() {
		return surge_pct;
	}
	public void setSurge_pct(Double surge_pct) {
		this.surge_pct = surge_pct;
	}
	public Boolean getUber_black_user() {
		return uber_black_user;
	}
	public void setUber_black_user(Boolean uber_black_user) {
		this.uber_black_user = uber_black_user;
	}
	public Double getWeekday_pct() {
		return weekday_pct;
	}
	public void setWeekday_pct(Double weekday_pct) {
		this.weekday_pct = weekday_pct;
	}
	public Double getAvg_dist() {
		return avg_dist;
	}
	public void setAvg_dist(Double avg_dist) {
		this.avg_dist = avg_dist;
	}
	public Double getAvg_rating_by_driver() {
		return avg_rating_by_driver;
	}
	public void setAvg_rating_by_driver(Double avg_rating_by_driver) {
		this.avg_rating_by_driver = avg_rating_by_driver;
	}
}
