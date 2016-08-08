package AccessWrapper;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;


public class InputWrapper {

//	public String path = "D:\\My_Documents\\Java\\UberDataChallenge\\resource\\logins.json";
	
	public String getString(String path){
		BufferedReader br;
	
		StringBuilder sb = new StringBuilder();
		
		try {
			br = new BufferedReader(new FileReader(path));

		    String line = br.readLine();
		    //System.out.println(line);
		    while (line != null) {
		        sb.append(line);
		        line = br.readLine();
		    }
			
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			
		}
				
		return sb.toString();
	}
}
