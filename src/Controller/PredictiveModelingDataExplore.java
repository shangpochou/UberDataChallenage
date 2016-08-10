package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import AccessWrapper.CSVWriter;
import AccessWrapper.InputWrapper;
import Constant.Path;
import Constant.UberDataItems;
import Model.UberData;

public class PredictiveModelingDataExplore {
	
	public void Explore() throws JSONException, IOException{
		InputWrapper inputWrapper = new InputWrapper();
		
		String input = inputWrapper.getString(Path.task3Path);
		
		JSONArray jsonArray = new JSONArray(input);
		
		DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd");
		
		List<UberData> uberDataList = new ArrayList<UberData>();
		
		Set<String> cities = new HashSet<String>();
		
		for(int i = 0; i < jsonArray.length(); i++){
			
			UberData curDataPoint = new UberData();

			JSONObject jsonObject = (JSONObject) jsonArray.get(i);
			
			curDataPoint.setCity(jsonObject.getString(UberDataItems.CITY));
			
			
			curDataPoint.setTrips_in_first_30_days(jsonObject.getInt(UberDataItems.TRIP_IN_FIRST_30_DAYS));
			
			DateTime signupDate = formatter.parseDateTime(jsonObject.getString(UberDataItems.SIGNUP_DATES));
			curDataPoint.setSignup_date(signupDate);
		
			curDataPoint.setAvg_rating_of_driver(jsonObject.getDouble(UberDataItems.AVG_RATING_OF_DRIVER));
						
			curDataPoint.setAvg_surge(jsonObject.getDouble(UberDataItems.AVG_SURGE));
			
			
			DateTime lastTripDate = formatter.parseDateTime(jsonObject.getString(UberDataItems.LAST_TRIP_DATE));
			curDataPoint.setLast_trip_date(lastTripDate);
			
			/*
			 * phone could be null
			 * */
			curDataPoint.setPhone(jsonObject.get(UberDataItems.PHONE).toString());
			
			cities.add(curDataPoint.getPhone());
			
			curDataPoint.setSurge_pct(jsonObject.getDouble(UberDataItems.SURGE_PCT));
			curDataPoint.setUber_black_user(jsonObject.getBoolean(UberDataItems.UBER_BLACK_USER));
			curDataPoint.setWeekday_pct(jsonObject.getDouble(UberDataItems.WEEKDAY_PCT));
			curDataPoint.setAvg_dist(jsonObject.getDouble(UberDataItems.AVG_DIST));
			curDataPoint.setAvg_rating_by_driver(jsonObject.getDouble(UberDataItems.AVG_RATING_BY_DRIVER));
			
			int customerLifeTime = Days.daysBetween(signupDate.toLocalDate(), lastTripDate.toLocalDate()).getDays();
			
			curDataPoint.setCustomerLifeTime(customerLifeTime);
			/*
			 * Calculate active
			 * */
			if((curDataPoint.getLast_trip_date()).getMonthOfYear() == 6){
				curDataPoint.setIsActive(true);
			}else{
				curDataPoint.setIsActive(false);
			}
			
			
			/*
			 * Calculate retention
			 * */
			if(curDataPoint.getTrips_in_first_30_days() > 0){
				curDataPoint.setRetention(true);
			}else{
				curDataPoint.setRetention(false);
			}
					
			
			uberDataList.add(curDataPoint);
		}
		
		
		//getCohort(uberDataList);
		//System.out.println(uberDataList.size());
		CSVWriter csvWriter = new CSVWriter();
		csvWriter.UberDataWriter(uberDataList, Path.uberDataFilename);
		
		List<UberData> uberDataCohortList = new ArrayList<UberData>();
		
		for(int i = 0; i < uberDataList.size(); i++){
			if(uberDataList.get(i).getRetention() && !Double.isNaN(uberDataList.get(i).getAvg_rating_of_driver())){
				uberDataCohortList.add(uberDataList.get(i));
			}
		}
		csvWriter.UberDataWriter(uberDataCohortList, Path.uberCohortDataFilename);
	}
	
	public void getCohort(List<UberData> uberDataList){
		int inactive = 0;
		for(int i = 0; i < uberDataList.size(); i++){
			if(uberDataList.get(i).getTrips_in_first_30_days() == 0){
				inactive++;
			}
		}
		System.out.println(inactive);
	}
}
