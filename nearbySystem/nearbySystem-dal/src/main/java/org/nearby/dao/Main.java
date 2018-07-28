package org.nearby.dao;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.map.ObjectMapper;
import org.nearby.dto.GoogleResponse;
import org.nearby.dto.Result;

public class Main {

	
	private static final String URL = "http://maps.googleapis.com/maps/api/geocode/json";

	public GoogleResponse convertToLatLong(String fullAddress) throws IOException {

		URL url = new URL(URL + "?address=" + URLEncoder.encode(fullAddress, "UTF-8") + "&sensor=false");
		// Open the Connection
		URLConnection conn = url.openConnection();

		InputStream in = conn.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		GoogleResponse response=null;
	   try{
		 response = (GoogleResponse) mapper.readValue(in, GoogleResponse.class);
	   }catch(Exception e){
	
	   }
		in.close();
		return response;

	}

	
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub

List<String> list= new ArrayList<String>();
		String address="vijay nagar"+",Indore"+",Madhya Pradesh 452010,"+"India";
		
		
		GoogleResponse res = new AddressConverter().convertToLatLong(address);
		if (res.getStatus().equals("OK")) {
			for (Result result : res.getResults()) {
				System.out.println("Lattitude of address is :" + result.getGeometry().getLocation().getLat());
				System.out.println("Longitude of address is :" + result.getGeometry().getLocation().getLng());
				System.out.println("Location is " + result.getGeometry().getLocation_type());
			
				list.add(result.getGeometry().getLocation().getLat());
				list.add(result.getGeometry().getLocation().getLng());
				
			
			}
		} 
		System.out.println(list);
	}

}
