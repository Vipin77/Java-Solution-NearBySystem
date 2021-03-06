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

public class AddressConverter {

	private static final String URL = "http://maps.googleapis.com/maps/api/geocode/json";

	public GoogleResponse convertToLatLong(String fullAddress) throws IOException {

		URL url = new URL(URL + "?address=" + URLEncoder.encode(fullAddress, "UTF-8") + "&sensor=false");
		// Open the Connection
		URLConnection conn = url.openConnection();

		InputStream in = conn.getInputStream();
		System.out.println(in.available());
/*		byte[] b=new byte[in.available()];
		in.read(b);
		String s=new String(b);
		System.out.println(s);
*/		
		ObjectMapper mapper = new ObjectMapper();
		 GoogleResponse response = mapper.readValue(in, GoogleResponse.class);
		 int count=0;
		 while(!response.getStatus().equals("OK")){
			 count++;
			 System.out.println("count = "+count);
			  conn = url.openConnection();
			 in = conn.getInputStream();
			 mapper = new ObjectMapper();
				 response=null;
				 response = (GoogleResponse) mapper.readValue(in, GoogleResponse.class);
			
		 }
		
		in.close();
		return response;

	}


	
	
	
	public static List<String> getLatorLong(String address) throws IOException
	{
		
		List<String> list= new ArrayList<String>();
		
		GoogleResponse res = new AddressConverter().convertToLatLong(address);
		if (res.getStatus().equals("OK")) {
			for (Result result : res.getResults()) {
				System.out.println("Lattitude of address is :" + result.getGeometry().getLocation().getLat());
				System.out.println("Longitude of address is :" + result.getGeometry().getLocation().getLng());
				System.out.println("Location is " + result.getGeometry().getLocation_type());
			
				list.add(result.getGeometry().getLocation().getLat());
				list.add(result.getGeometry().getLocation().getLng());
				
				return list;
			
			}
		} else {
			list=getLatorLong(address);
			
		}
		
		
		return list;
	}

}