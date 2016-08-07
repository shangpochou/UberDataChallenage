package AccessWrapper;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import Model.LoginCounts;

public class CSVWriter {

	private String logincountsFilename = "D:\\My_Documents\\Java\\UberDataChallenge\\resource\\logincounts2.csv";
	
	public void LoginDataCountWriter(List<LoginCounts> loginCountsList) throws IOException{
		
		BufferedWriter bw = null;
		try {
			bw = new BufferedWriter(new FileWriter(logincountsFilename));
		
			String title = "Time,Counts";
			bw.write(title);
			bw.newLine();
		
			for(int i = 0; i < loginCountsList.size(); i++){
				StringBuilder curLine = new StringBuilder();
				curLine.append(loginCountsList.get(i).getTime()).append(",").append(String.valueOf(loginCountsList.get(i).getCounts()));
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
}
