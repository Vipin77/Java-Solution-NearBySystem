<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEZu0QdROlLayd9EcOb7ydUmTT24yQSWA&callback=getLocation">
    </script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>user</title>
<style>
.avatar {
    vertical-align: middle;
    width: 100px;
    height: 100px;
    border-radius: 50%;
}
table {
    margin-left:10%;
    margin-right:40%;
    border-collapse: collapse;
    width: 50%;
}

th, td {
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {background-color: #f2f2f2;}
</style>
</head>
<body onload="getLocation()">
	<div style="height:100px; background-color: #848484;">
<br>
<h2 align="center">Java Solution Near By System</h2>
</div>

           <div id="mainfirst">
        <div class="form-group">
		<label class="col-sm-2 col-sm-2 control-label"></label>
		<div class="col-sm-10"  style="font-size: 160%;float:left">
			CategoryType <select  style="font-size: 60%;width:30%; height: 22px;" class="form-control" onChange="fetchServices(this.value)" name="categoryId">
				<option></option>
				<c:forEach var="type" items="${listOfType}">
					<option value="${type.getCategoryId()}"
						>${type.getCategoryType()}</option>
</c:forEach>
			</select>
		</div>
	</div>
	<div class="form-group">
		<div style="font-size: 160%;float:left">
      Select Service <select class="form-control" style="font-size: 60%;width:10%; height: 22px;" onChange="fetchPoint(this.value)" id="existingServices" name="subCategory">
				<option></option>
			</select>
		</div>
	</div>
        </div>
         <div class="form-group"><label class="col-sm-2 col-sm-2 control-label"></label>
			<div class="col-sm-30" style="font-size: 160%;">
			<input type="button" class="form-submit" value="Search" onclick="#">
		</div>
		</div> 
        
      <!--   <input type="button" id="routebtn" value="route" /> -->
      <br>
		<div id="map" style="width:84%; height: 450px;"></div>
		
<p id="demo" style="margin-left: 18%;"></p>
	<script>
		var lati;
		var longi;

		var x = document.getElementById("demo");

		function getLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(showPosition);
			} else {
				x.innerHTML = "Geolocation is not supported by this browser.";
			}
		}

		function showPosition(position) {
			
		 	lati = position.coords.latitude;
			longi = position.coords.longitude;
			var map = new google.maps.Map(document.getElementById('map'), {
		          zoom: 8,
		          center: {lat: lati, lng: longi}
		        }); 
			 var geocoder = new google.maps.Geocoder;
			 var infowindow = new google.maps.InfoWindow;
			geocodeLatLng(geocoder, map, infowindow,lati,longi);
			// alert(x+"  "+y);
			myMap(position.coords.latitude, position.coords.longitude);
		}

		
		function geocodeLatLng(geocoder, map, infowindow,lat,longi) {
	        var latlng = {lat: parseFloat(lat), lng: parseFloat(longi)};
	        geocoder.geocode({'location': latlng}, function(results, status) {
	          if (status === 'OK') {
	            if (results[0]) {
	              map.setZoom(11);
	              var marker = new google.maps.Marker({
	                position: latlng,
	                map: map
	              });
	              x.innerHTML = "Your Location is : " + results[0].formatted_address;
	              infowindow.setContent(results[0].formatted_address);
	              infowindow.open(map, marker);
	            } else {
	              window.alert('No results found');
	            }
	          } else {
	            window.alert('Geocoder failed due to: ' + status);
	          }
	        });
	      }
		
		
		function myMap(lat, longi) {

			var myCenter = new google.maps.LatLng(lat, longi);
			var mapCanvas = document.getElementById("map");
			var mapOptions = {
				center : myCenter,
				zoom : 20
			};
			var map = new google.maps.Map(mapCanvas, mapOptions);
			var marker = new google.maps.Marker({
				position : myCenter
			});
			marker.setMap(map);
		}
		function fetchServices(cid) {

			$('#existingServices').find("option").remove();
			$.ajax({
				url : "fetchServicesForUser?cid=" + cid,
				async : false,

				type : "GET",
				dataType : "json",
				success : function(data) {
					document.getElementById("existingServices").innerHTML = "<option value=''>Select</option>";
					$.each(data, function(key, value) {

						$('#existingServices').append(
								$(
										"<option ></option>").attr('value',
										value).text(value));
					});

				}
			});

		}

		
		var locationsPointSpName = [];
		var locationsPointLati = [];
		var locationsPointLongi = [];
		var locationsPointSpMobile = [];
		
		
		function fetchPoint(service) {
			locationsPointSpName = [];
			locationsPointLati = [];
			locationsPointLongi = [];
			locationsPointSpMobile = [];
alert("fetch Start");
			$.ajax({
				url : "fetchLocationOfsp?service=" + service + "&latitude="
						+ lati + "&longitude=" + longi,
				async : false,
				type : "GET",
				dataType : "json",
				success : function(data) {
					
					 var sp="<h2>&emsp;&emsp;&emsp;&emsp;Available Providers</h2><table class='table table-striped table-advance table-hover'><thead><tr><th>Profile</th><th>Name</th><th>Mobile Number</th></tr></thead>";
					 $.each(data, function(key, value) {
						// myMap(value.latitude, value.longitude);
						locationsPointSpName.push(value.firstName);
						locationsPointLati.push(value.latitude);
						locationsPointLongi.push(value.longitude);
						locationsPointSpMobile.push(value.mobileNumber);
						showPoint(service);
			            sp=sp+"<tr><td><img class='avatar' height='100' width='100' src='data:image/jpg;base64,"+value.img+"'/></td><td>"+value.firstName+" "+value.lastName+"</td><td>"+value.mobileNumber+"</td></tr>";
					}); 
					sp=sp+"</table>";
					document.getElementById("spdetails").innerHTML = sp; 
					if(data==""){
						document.getElementById("spdetails").innerHTML = "<h2 style='margin-left: 16%;'>Prvoiders Are Not Available</h2>";
						showPoint(service);
					}
				}
			});
		}
		
		function showPoint(service)
		{   
			 var map = new google.maps.Map(document.getElementById('map'), {
			      zoom: 12,
			      center: new google.maps.LatLng(lati, longi),
			      mapTypeId: google.maps.MapTypeId.ROADMAP,
			    });

			    var infowindow = new google.maps.InfoWindow();

			    var marker, i;
               var icon1;
			    for (i = -1; i < locationsPointLati.length; i++) { 
			    	if(service=="Mobile Phones"){
				    	  icon1 = {url: "resources/images/locationlogo/mobilelogo.png",
				    			  scaledSize: new google.maps.Size(40, 40)
								}; 
				         }
				    if(service=="Bata"){
				    	  icon1 = {url: "resources/images/locationlogo/batalogo.jpg",
								    scaledSize: new google.maps.Size(40, 40)
								}; 
				    }
				    if(service=="vegetable"){
				    	  icon1 = {url: "resources/images/locationlogo/vegetable.jpg",
								    scaledSize: new google.maps.Size(40, 40)
								}; 
				    }
				    if(service=="Dentist"){
				    	  icon1 = {url: "resources/images/locationlogo/Dentist.png",
								    scaledSize: new google.maps.Size(40, 40)
								}; 
				    }
			    	if(i==-1){
			    		locationsPointLati[i]=lati;
			    		locationsPointLongi[i]=longi;
			    		icon1=null;
			    	}
			    	marker = new google.maps.Marker({
			        position: new google.maps.LatLng(locationsPointLati[i], locationsPointLongi[i]),
			         map: map,
			         icon:icon1
			    	});
			      google.maps.event.addListener(marker, 'click', (function(marker, i) {
			    	  return function() {
			             if(i==-1){
			            	 infowindow.setContent("<b>You</b>");
			             }else{
			    		  infowindow.setContent("Name: <b>"+locationsPointSpName[i]+"</b> \n Mob No: <b>"+locationsPointSpMobile[i]+"</b><input type='hidden' id='a"+i+"' name='b"+i+"' value='"+locationsPointLati[i]+"'><input type='hidden' id='c"+i+"' name='d"+i+"' value='"+locationsPointLongi[i]+"'>");
			             }infowindow.open(map, marker);
			    	  }
			      })(marker, i));
			     //google.maps.event.addDomListener(document.getElementById('routebtn'), 'click', calcRoute(locationsPointLati[i],locationsPointLongi[i]));
			    }
			    function calcRoute(lat,longg) {
					 var directionsDisplay;
					  var directionsService = new google.maps.DirectionsService();
					  directionsDisplay = new google.maps.DirectionsRenderer();
					    var start = new google.maps.LatLng(lati, longi);
					    var end = new google.maps.LatLng(lat, longg);
					    var request = {
					      origin: start,
					      destination: end,
					      travelMode: google.maps.TravelMode.DRIVING
					    };
					    directionsService.route(request, function(response, status) {
					      if (status == google.maps.DirectionsStatus.OK) {
					        directionsDisplay.setDirections(response);
					        directionsDisplay.setMap(map);
					      } else {
					        alert("Directions Request from " + start.toUrlValue(6) + " to " + end.toUrlValue(6) + " failed: " + status);
					      }
					    });
					  }
		}
		
		
	</script>
<div id="spdetails"></div>
</body>
</html>