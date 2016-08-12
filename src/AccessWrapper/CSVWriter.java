package AccessWrapper;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import Constant.Delimiter;
import Constant.Path;
import Constant.UberDataItems;
import Model.LoginCounts;
import Model.UberData;

public class CSVWriter {
	
	public void LoginDataCountWriter(List<LoginCounts> loginCountsList, String fileName) throws IOException{
		
		BufferedWriter bw = null;
		try {
			bw = new BufferedWriter(new FileWriter(fileName));
		
			String title = "Time,Counts";
			bw.write(title);
			bw.newLine();
		
			for(int i = 0; i < loginCountsList.size(); i++){
				StringBuilder curLine = new StringBuilder();
				curLine.append(loginCountsList.get(i).getTime()).append(Delimiter.COMMA).append(String.valueOf(loginCountsList.get(i).getCounts()));
				//curLine.append(String.valueOf(i)).append(",").append(String.valueOf(loginCountsList.get(i).getCounts()));
				bw.write(curLine.toString());
				bw.newLine();
			}
			
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			bw.close();
		}		
	}

	public void UberDataWriter(List<UberData> uberDataList, String inputPath) throws IOException{
		
		BufferedWriter bw = null;
		try {
			bw = new BufferedWriter(new FileWriter(inputPath));
		
			StringBuilder title = new StringBuilder();
			title.append(UberDataItems.CITY).append(Delimiter.COMMA);
			title.append(UberDataItems.TRIP_IN_FIRST_30_DAYS).append(Delimiter.COMMA);
			title.append(UberDataItems.SIGNUP_DATES).append(Delimiter.COMMA);
			title.append(UberDataItems.AVG_RATING_OF_DRIVER).append(Delimiter.COMMA);
			title.append(UberDataItems.AVG_SURGE).append(Delimiter.COMMA);
			title.append(UberDataItems.LAST_TRIP_DATE).append(Delimiter.COMMA);
			title.append(UberDataItems.PHONE).append(Delimiter.COMMA);
			title.append(UberDataItems.SURGE_PCT).append(Delimiter.COMMA);
			title.append(UberDataItems.UBER_BLACK_USER).append(Delimiter.COMMA);
			title.append(UberDataItems.WEEKDAY_PCT).append(Delimiter.COMMA);
			title.append(UberDataItems.AVG_DIST).append(Delimiter.COMMA);
			title.append(UberDataItems.AVG_RATING_BY_DRIVER).append(Delimiter.COMMA);
			title.append(UberDataItems.CUSTOMERLIFETIME).append(Delimiter.COMMA);
			title.append(UberDataItems.RETENTION).append(Delimiter.COMMA);
			title.append(UberDataItems.ACTIVE);	
			
			bw.write(title.toString());
			bw.newLine();
		
			DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyyMMdd");
			
			for(int i = 0; i < uberDataList.size(); i++){
				StringBuilder curLine = new StringBuilder();
				
				Integer cityNumber = getCityNumber(uberDataList.get(i).getCity());
				curLine.append(cityNumber.toString()).append(Delimiter.COMMA);
				
				curLine.append(uberDataList.get(i).getTrips_in_first_30_days().toString()).append(Delimiter.COMMA);
				curLine.append(formatter.print(uberDataList.get(i).getSignup_date())).append(Delimiter.COMMA);
				curLine.append(uberDataList.get(i).getAvg_rating_of_driver().toString()).append(Delimiter.COMMA);
				curLine.append(uberDataList.get(i).getAvg_surge().toString()).append(Delimiter.COMMA);
				curLine.append(formatter.print(uberDataList.get(i).getLast_trip_date())).append(Delimiter.COMMA);
				
				Integer phoneCode = getPhoneCode(uberDataList.get(i).getPhone());
				curLine.append(phoneCode.toString()).append(Delimiter.COMMA);
				
				curLine.append(uberDataList.get(i).getSurge_pct().toString()).append(Delimiter.COMMA);
				
				Integer isUberBlackUser = uberDataList.get(i).getUber_black_user() ? 1 : 0;
				curLine.append(isUberBlackUser.toString()).append(Delimiter.COMMA);
				
				curLine.append(uberDataList.get(i).getWeekday_pct().toString()).append(Delimiter.COMMA);
				curLine.append(uberDataList.get(i).getAvg_dist().toString()).append(Delimiter.COMMA);
				curLine.append(uberDataList.get(i).getAvg_rating_by_driver().toString()).append(Delimiter.COMMA);
				curLine.append(uberDataList.get(i).getCustomerLifeTime().toString()).append(Delimiter.COMMA);
				
				Integer retention = uberDataList.get(i).getRetention() ? 1 : 0;			
				curLine.append(retention.toString()).append(Delimiter.COMMA);
				
				Integer isActive = uberDataList.get(i).getIsActive() ? 1 : 0;			
				curLine.append(isActive.toString());
				
				bw.write(curLine.toString());
				bw.newLine();
			}
			
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			bw.close();
		}		
	}
	private Integer getCityNumber(String city){
		Integer cityNumber = null;
		
		if(city.equals(UberDataItems.ASTAPOR)){
			cityNumber = -1;
		}else if(city.equals(UberDataItems.WINTERFELL)){
			cityNumber = 0;
		}else if(city.equals(UberDataItems.KINGSLANDING)){
			cityNumber = 1;
		}
		return cityNumber;
	}
	
	private Integer getPhoneCode(String phone){
		Integer phoneCode = null;
		
		if(phone.equals(UberDataItems.IPHONE)){
			phoneCode = -1;
		}else if(phone.equals(UberDataItems.ANDROID)){
			phoneCode = 0;
		}else {
			/*
			 * phone = null
			 * */
			phoneCode = 1;
		}
		return phoneCode;
	}
}
