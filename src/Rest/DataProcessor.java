package Rest;


import java.io.IOException;

import org.json.JSONException;

import Controller.PredictiveModelingDataExplore;

public class DataProcessor {

	public static void main(String[] args) throws JSONException, IOException {
		
		//LoginDataExplore loginDataExplore = new LoginDataExplore();
		
		//loginDataExplore.Explore();
		
		PredictiveModelingDataExplore pmDataExplore = new PredictiveModelingDataExplore();
		pmDataExplore.Explore();
	}

}
