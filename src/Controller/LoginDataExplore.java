package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import AccessWrapper.CSVWriter;
import AccessWrapper.InputWrapper;
import Model.LoginCounts;
import Model.TimeInterval;

public class LoginDataExplore {

	ArrayList<DateTime> loginData;
	
	Map<Integer, Integer> counts;
	
	public void Explore() throws JSONException, IOException{
		InputWrapper wrapper = new InputWrapper();
		String input = wrapper.getString();
		
		JSONObject jsonObject = new JSONObject(input);
		JSONArray jsonArray = (JSONArray)jsonObject.get("login_time");
			
		DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
		
		this.loginData = new ArrayList<DateTime>();
		
		for(int i = 0; i < jsonArray.length(); i++){
			DateTime curDateTime = formatter.parseDateTime((String) jsonArray.get(i));
			this.loginData.add(curDateTime);
//			System.out.println(jsonArray.get(i));
		}
	
		this.counts = initCounts();

		for(int i = 0; i < this.loginData.size(); i++){
			int min = this.loginData.get(i).getMinuteOfDay();
			
			int minIndex = min/15;
			
			if(this.counts.containsKey(minIndex)){
				this.counts.put(minIndex, this.counts.get(minIndex)+1);
			}
		}
		
		List<LoginCounts> loginCountsList = new ArrayList<LoginCounts>();
		
		DateTime timeCounter = new DateTime(2016, 8, 1, 0, 0);
		
		for (Map.Entry<Integer, Integer> entry : counts.entrySet()) {
		    Integer value = entry.getValue();
		    
		    int StartHour = timeCounter.getHourOfDay();
		    int StartMin = timeCounter.getMinuteOfHour();
		    
		    timeCounter = timeCounter.plusMinutes(15);
		    
		    int EndHour = timeCounter.getHourOfDay();
		    int EndMin = timeCounter.getMinuteOfHour();
		    
		    StringBuilder sb = new StringBuilder();
		    //sb.append(StartHour).append(":").append(StartMin).append("-").append(EndHour).append(":").append(EndMin);
		    sb.append(String.format("%02d", StartHour)).append(String.format("%02d", StartMin));
		    loginCountsList.add(new LoginCounts(sb.toString(), value));
		   
//		    System.out.println(key + " " + value);
//		    System.out.println(sb.toString() + " " + value);
		}
		
		CSVWriter csvWriter = new CSVWriter();
		csvWriter.LoginDataCountWriter(loginCountsList);
	}
	
	public Map<Integer, Integer>initCounts(){
		Map<Integer, Integer> counts = new TreeMap<Integer, Integer>();
		
		for(int i = 0; i < 96; i++){
			counts.put(i, 0);
		}
		return counts;
	}
	
	
	public ArrayList<TimeInterval> getTimeIntervalList(){
		
		ArrayList<TimeInterval> timeInterval = new ArrayList<TimeInterval>();
		
		for(int i = 0; i < 96; i++){
			System.out.println(i*15 + " " + ((i+1)*15));
		}
		return timeInterval;
	}
}
