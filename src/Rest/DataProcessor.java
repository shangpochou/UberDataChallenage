package Rest;


import java.io.IOException;

import org.json.JSONException;

import Controller.LoginDataExplore;
import Controller.PredictiveModelingDataExplore;

/**
 * @author ShangpoChou
 * Entry point of data processor
 */
public class DataProcessor {

	public static void main(String[] args) throws JSONException, IOException {
		
		LoginDataExplore loginDataExplore = new LoginDataExplore();
		
		loginDataExplore.Explore();
		
		PredictiveModelingDataExplore pmDataExplore = new PredictiveModelingDataExplore();
		pmDataExplore.Explore();
	}

}
