package Rest;


import java.io.IOException;

import org.json.JSONException;

import Controller.LoginDataExplore;

public class DataProcessor {

	public static void main(String[] args) throws JSONException, IOException {
		LoginDataExplore loginDataExplore = new LoginDataExplore();
		
		loginDataExplore.Explore();
	}

}
