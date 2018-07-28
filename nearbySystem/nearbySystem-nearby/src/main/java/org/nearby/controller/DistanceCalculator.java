package org.nearby.controller;

public class DistanceCalculator {

	
	public static void main (String[] args) throws java.lang.Exception
	{
		System.out.println(distance(32.9697, -96.80322, 29.46786, -98.53506) + " Miles\n");
		//first is vijay nagar
		System.out.println(distance(22.66215, 75.9035,22.731457, 75.914391) + " Kilometers\n");
		System.out.println(distance(32.9697, -96.80322, 29.46786, -98.53506) + " Nautical Miles\n");
		System.out.println(" Your Result >>> "+DistanceCalculator.bearing(22.731457, 75.914391,22.66215, 75.9035));
	}
	private static double distance(double lat1, double lon1, double lat2, double lon2) {
		String unit="k";
		double theta = lon1 - lon2;
		double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;
		if (unit == "K") {
			dist = dist * 1.609344;
		} else if (unit == "N") {
			dist = dist * 0.8684;
		}
		return (dist);
	}

	private static double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}
	private static double rad2deg(double rad) {
		return (rad * 180 / Math.PI);
	}
	 protected static String bearing(double lat1, double lon1, double lat2, double lon2){
         double longitude1 = lon1;
         double longitude2 = lon2;
         double latitude1 = Math.toRadians(lat1);
         double latitude2 = Math.toRadians(lat2);
         double longDiff= Math.toRadians(longitude2-longitude1);
         double y= Math.sin(longDiff)*Math.cos(latitude2);
         double x=Math.cos(latitude1)*Math.sin(latitude2)-Math.sin(latitude1)*Math.cos(latitude2)*Math.cos(longDiff);
         double resultDegree= (Math.toDegrees(Math.atan2(y, x))+360)%360;
         String coordNames[] = {"N","NNE", "NE","ENE","E", "ESE","SE","SSE", "S","SSW", "SW","WSW", "W","WNW", "NW","NNW", "N"};
         double directionid = Math.round(resultDegree / 22.5); 
         if (directionid < 0) {
             directionid = directionid + 16;
              //no. of contains in array
         }
         String compasLoc=coordNames[(int) directionid];
         return compasLoc;
       }

}
