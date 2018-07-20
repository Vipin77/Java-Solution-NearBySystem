<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="./resources/js/jquery-1.11.0.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/jsfunction.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEZu0QdROlLayd9EcOb7ydUmTT24yQSWA">
    </script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 <link rel="stylesheet" href="./resources/css/modal.css">
 <style>
.avatar {
    vertical-align: middle;
    width: 100px;
    height: 100px;
    border-radius: 50%;
}
table {
margin-left:5%;
background-color:white;
border: 1px solid #ddd;
    border-collapse: collapse;
    width: 70%;
    
}

th, td {
    padding: 8px;
    text-align: left;
    
}
tr{
border: 1px solid #ddd;
}
.close1 {
    color: black;
    float: right;
    font-size: 28px;
    font-weight: bold;
}close1:hover,
.close1:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}
</style>
</head>
<script type="text/javascript">


var countryStateInfo = {
		"Madhya Pradesh": {
			"Indore": {
				"Aanand bazar": [],
				"Anoop Nagar": [],
				"Bangali": [],
				"Palasiya": [],
				"Regal": [],
				"Rajwada": [],
				"vijay nagar": []
			 },
			"Dewas": {
				"rto" : []
			},
			"Ujjain": {
				"Ujjain":[]
			}
		}
	}

var countr = document.getElementById("country");
	function fun() {
		//Get html elements
		var stateSel = document.getElementById("state");
		var citySel = document.getElementById("city");	
		//Load state
		for (var country in countryStateInfo) {
			stateSel.options[stateSel.options.length] = new Option(country, country);
		}
		//state Changed
		stateSel.onchange = function () {
			 citySel.length = 1; // remove all options bar first
			 if (this.selectedIndex < 1)
				 return; // done
			 for (var city in countryStateInfo[this.value]) {
				 citySel.options[citySel.options.length] = new Option(city, city);
			 }
		}
	}
	var spId=[];
	var spfname=[];
	var splname=[];
	var spemail=[];
	var spmobile=[];
	var spaddress=[];
	var spservice=[];
	var spimg=[];
	var spbusinessName=[];
	var spavgrating=[];
	var spstatus=-1;
	
	function searchProvider(){
		var area=document.search.area.value; 
		var city=document.search.city.value; 
		var subCategory=document.search.subCategory.value; 
		$.ajax({
			url : "searchProvider?area=" + area + "&subCategory="
					+ subCategory+"&city="+city,
			async : false,
			type : "POST",
			dataType : "json",
			success : function(data) {
				alert("Success");
				 var sp="<h3>&ensp;&ensp;&ensp;&ensp;Service Providers For "+subCategory+"</h3><table><thead><tr></tr></thead>";
				 $.each(data, function(key, value) {
					 spstatus=spstatus+1;
					 spId.push(value.spId);
					 spfname.push(value.firstName); 
					 splname.push(value.lastName); 
					 spemail.push(value.email);
					 spmobile.push(value.mobileNumber);
					 spaddress.push(value.address);
					 spservice.push(value.service);
					 spbusinessName.push(value.businessName);
					 spavgrating.push(value.avgrating);
					 spimg.push(value.img);
					 sp=sp+"<tr id='myProfileBtn' onclick=onrowclick("+spstatus+")><td><img class='avatar' height='100' width='100' src='data:image/jpg;base64,"+value.img+"'/></td><td><h3 style='color: blue'>"+value.businessName+"</h3>";
					 var s=0;
					
					for(var r=1;r<=5;r++){
                       if(r<=value.avgrating){
                    	   sp=sp+"<span class='fa fa-star checked' style='font-size:20px;color:orange'></span>";
                       }else{
                    	   if((r-1)==value.avgrating){
                    		   s=1;
                    	   }
                    	   if(s==1){
                    		   sp=sp+"<span class='fa fa-star' style='font-size:20px;color:Gainsboro'></span>";
                    	   }
                    	   if(s==0){
                    		   if((value.avgrating>=((r-1)+.3))&&(value.avgrating<=((r-1)+.8))){
                    			sp=sp+"<i class='fa fa-star-half-full' style='font-size:20px;color:orange'></i>";
                    		   }if(value.avgrating<((r-1)+.3)){
                    			  sp=sp+"<span class='fa fa-star' style='font-size:20px;color:Gainsboro'></span>";
                    		   }if(value.avgrating>((r-1)+.8)){
                    			   sp=sp+"<span class='fa fa-star checked' style='font-size:20px;color:orange'></span>";
                    		   }
                    		   s=1;
                    	   }
                       }
					}
					
		            sp=sp+"&emsp; Average Rating: "+value.avgrating+", &ensp;&ensp;<button id='myReviewBtn' onclick=onReview("+value.spId+","+spstatus+")>Reviews</button><br>"+
		            value.firstName+" "+value.lastName+" <br> Email Id : "+value.email+"<br>"+value.address+" - "+value.mobileNumber+"<br>Open time 10Am and Closed time 8Pm </td><td><br><br><button id='myBtn' onclick=onbtn("+value.latitude+","+value.longitude+",'"+String(value.firstName)+"','"+String(value.mobileNumber)+"',"+spstatus+")>Show on Map</button></td</tr>";
				}); 
				sp=sp+"</table>";
				document.getElementById("spdetails").innerHTML = sp; 
				 document.getElementById("spcontent").click();
				if(data==""){
					document.getElementById("spdetails").innerHTML = "<h2 style='margin-left: 6%;'>Service Prvoiders Are Not Available</h2>";
				  }
			  }
		});
	}
	var ignoreparent=0;
	function onrowclick(status){
		if(ignoreparent==1){
			ignoreparent=0;
			return 0;
			}
		var e = document.getElementById("cid");
	       var Category = e.options[e.selectedIndex].text;
		pmodal.style.display = "block";
		
		var content="<h3 style='color: blue;margin-left:36px;'>Category >> "+Category+" >> "+spservice[status]+"</h3>"+
		"<hr><h3 style='margin-left:36px;'>"+spbusinessName[status]+"</h3>";
		content=content+"&emsp;&emsp;&emsp;";
		 var s=0;
		for(var r=1;r<=5;r++){
            if(r<=spavgrating[status]){
            	content=content+"<span class='fa fa-star checked' style='font-size:20px;color:orange'></span>";
            }else{
         	   if((r-1)==spavgrating[status]){
         		   s=1;
         	   }
         	   if(s==1){
         		  content=content+"<span class='fa fa-star' style='font-size:20px;color:Gainsboro'></span>";
         	   }
         	   if(s==0){
         		   if((spavgrating[status]>=((r-1)+.3))&&(spavgrating[status]<=((r-1)+.8))){
         			  content=content+"<i class='fa fa-star-half-full' style='font-size:20px;color:orange'></i>";
         		   }if(spavgrating[status]<((r-1)+.3)){
         			  content=content+"<span class='fa fa-star' style='font-size:20px;color:Gainsboro'></span>";
         		   }if(spavgrating[status]>((r-1)+.8)){
         			  content=content+"<span class='fa fa-star checked' style='font-size:20px;color:orange'></span>";
         		   }
         		  s=1;
         	   }
            }
			}
		content=content+"<h4 style='margin-left:36px;'>Address "+spaddress[status]+"</h4>"+
		"<h4 style='margin-left:36px;'>Phone: "+spmobile[status]+"</h4>"+
		"<hr><img height='230' width='230' src='data:image/jpg;base64,"+spimg[status]+"'/>";
		document.getElementById("modal-body3").innerHTML =content;
	}
	
	function onbtn(lati,longi,fname,m,status){
		ignoreparent=1;
		modal.style.display = "block";
		document.getElementById("busnameandaddress").innerHTML=spbusinessName[status]+", Address : "+spaddress[status];
		var map = new google.maps.Map(document.getElementById('map'), {
	          zoom: 10,
	          center: {lat: lati, lng: longi}
	        }); 
		 var geocoder = new google.maps.Geocoder;
		 var infowindow = new google.maps.InfoWindow;
		geocodeLatLng(geocoder, map, infowindow,lati,longi);
		myMap(lati,longi,fname,m);
		
	}
	
	function onReview(id,status){
		ignoreparent=1;
		//alert(spfname[status]+" "+spemail[status]+" "+splname[status]+" "+spmobile[status]+" "+spaddress[status]+" "+spservice[status]+" "+spimg[status]);
		var e = document.getElementById("cid");
       var Category = e.options[e.selectedIndex].text;

       rmodal.style.display = "block";
	$.ajax({
		url : "fetchReview?id=" + id,
		async : false,
		type : "POST",
		dataType : "json",
		success : function(data) {
			
			var i=0;
			var content="<h3 style='color: blue;margin-left:36px;'>Category >> "+Category+" >> "+spservice[status]+"</h3>"+
			"<table style=' width: 50%;border: 1px solid black;'><thead><tr></tr></thead><tr><td><img height='110' width='110' src='data:image/jpg;base64,"+spimg[status]+"'/></td><td>Category is : "+spservice[status]+"<br>"+
			"Service Provider is : "+spfname[status]+" "+splname[status]+"<br>"+
			"Contact Number : "+spmobile[status]+"<br>"+
			"Email Address : "+spemail[status]+"<br>"+
			"Address : "+spaddress[status]+"</td></tr></table>";
			
			 var maincontent=content;
			content=content+"<table style=' width: 60%;border: 1px solid black;'><tr><th style='border: 1px solid black;'>Comment No.</th><th style='border: 1px solid black;'>Comment</th><th style='border: 1px solid black;'>Rating</th></tr>";
			$.each(data, function(key, value) {
				 i++;
				content=content+"<tr><h4><td style='border: 1px solid black;'> "+i+". </td><td style='border: 1px solid black;'>"+value.review+" </td><td style='border: 1px solid black;'>";
				 var s=0;
				 for(var r=1;r<=5;r++){
                    if(r<=value.rating){
                    	content=content+"<span class='fa fa-star checked' style='font-size:20px;color:orange'></span>";
                    }else{
                 	   if((r-1)==value.rating){
                 		   s=1;
                 	   }
                 	   if(s==1){
                 		  content=content+"<span class='fa fa-star' style='font-size:20px;color:Gainsboro'></span>";
                 	   }
                 	   if(s==0){
                 		   if((value.rating>=((r-1)+.3))&&(value.rating<=((r-1)+.8))){
                 			  content=content+"<i class='fa fa-star-half-full' style='font-size:20px;color:orange'></i>";
                 		   }if(value.rating<((r-1)+.3)){
                 			  content=content+"<span class='fa fa-star' style='font-size:20px;color:Gainsboro'></span>";
                 		   }if(value.rating>((r-1)+.8)){
                 			  content=content+"<span class='fa fa-star checked' style='font-size:20px;color:orange'></span>";
                 		   }
                 		   s=1;
                 	   }
                    }
					} 
				content=content+"&ensp;&ensp; "+value.rating+"</td></h4></tr><br>";
			}); 
			 document.getElementById("modal-body2").innerHTML =""+content+"</table><br><br><br><br><br><br><br><br><br><br><br><br><br><br>";
		     if(data.length==0){
		    	 document.getElementById("modal-body2").innerHTML =maincontent+"<h3><br>No Review</h3><br><br><br><br><br><br><br><br><br><br><br><br>";
		     }
		}
	});
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
              //infowindow.setContent(results[0].formatted_address);
              infowindow.open(map, marker);
            } else {
              window.alert('No results found');
            }
          } else {
            window.alert('Geocoder failed due to: ' + status);
          }
        });
      }
	function myMap(lat, longi,fname,mobile) {

		var myCenter = new google.maps.LatLng(lat, longi);
		var mapCanvas = document.getElementById("map");
		var mapOptions = {
			center : myCenter,
			zoom : 18
		};
		var map = new google.maps.Map(mapCanvas, mapOptions);
		var marker = new google.maps.Marker({
			position : myCenter
		});
		marker.setMap(map);
		google.maps.event.addListener(marker,'click',function() {
		    var infowindow = new google.maps.InfoWindow({
		      content:"<h3>Name : "+fname+", Mobile : "+mobile+"</h3>"
		    });
		  infowindow.open(map,marker);
		  });
	}
</script>
<body onload="fun()">
<a id='spcontent' href="#C"></a>
<section id="main-content">
   <section class="wrapper">
	<h3>Search SP</h3>
	
	<br><br>
	  <form id="search" name="search" action="searchProvider" method="post">
	  <div class="form-group">
		<label class="col-sm-2 col-sm-1 control-label">State</label>
		<div class="col-sm-5">
		 <select id="state" name="state" class="form-control"  required="required">
            <option value="" selected="selected">-- Select State --</option>
         </select>
		</div>
	   </div><br><br><br>
	   <div class="form-group">
		 <label class="col-sm-2 col-sm-1 control-label">City</label>
		 <div class="col-sm-5">
			<select id="city" name="city" class="form-control" required="required">
             <option value="" selected="selected">-- Select City --</option>
            </select>
	     </div>
	   </div><br><br>
	 <div class="form-group">
         <label class="col-sm-2 col-sm-1 control-label">Area</label>
		 <div class="col-sm-5">
								<input type="text" id="area" name="area" class="form-control" required="required">
							</div>
	  </div><br><br>
	<div class="form-group">
		 <label class="col-sm-2 col-sm-1 control-label">CategoryType</label>
		 <div class="col-sm-5">
			<select class="form-control" onChange="fetchServices(this.value)" id="cid" name="categoryId" required="required">
				<option></option>
				<c:forEach var="type" items="${listOfType}">
					<option value="${type.getCategoryId()}">${type.getCategoryType()}</option>
                </c:forEach>
			</select>
	     </div>
	   </div><br><br>
		<div class="form-group">
		 <label class="col-sm-2 col-sm-1 control-label">Select Service </label>
		 <div class="col-sm-5">
			<select class="form-control" id="existingServices" name="subCategory">
				<option></option>
			</select>
	     </div>
	   </div><br><br><br>
	   <div class="form-group">
			<div class="col-sm-10" style="margin-left: 10%;">
			<input type="button" class="form-submit" value="Search" onclick="searchProvider()"></div><h2 id='C'></h2><br>
		</div>
	</form>   
	<br>
	<div id="spdetails"></div>
	<!-- Trigger/Open The Modal -->

<!-- The Modal for Map-->
<div id="myModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <h2 id="busnameandaddress"></h2>
    </div>
     <span class="close" style="color: black;">Close</span>
    <div id="map" style="width:100%; height: 465px;"></div>
    <div id="modal-body" class="modal-body"></div>
    <div class="modal-footer">
      <h3></h3>
    </div>
  </div>
</div>

<!-- The Modal for Review-->
<div id="myReviewModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <h2>Java Solution Near by System </h2>
    </div>
    <div style="text-align: right;"><input type="button" id="btn2" value="Close"/></div>
    <div id="modal-body2" class="modal-body"></div>
    <div class="modal-footer">
      <h3></h3>
    </div>
  </div>
</div>

<!-- The Modal for profile-->
<div id="profileModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content" style="height:85%;width: 50%;">
    <div style="text-align: right;"><input type="button" id="btn3" value="Close"/></div>
    <div id="modal-body3" class="modal-body"></div>
      <h3></h3>
    </div>
  </div>
</div>
	
	</section>
</section>
<script>
var modal = document.getElementById('myModal');
// Get the button that opens the modal
var btn = document.getElementById("myBtn");
// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];
// When the user clicks the button, open the modal 
// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

var rmodal = document.getElementById('myReviewModal');
//Get the button that opens the modal
var rbtn = document.getElementById("myReviewBtn");
var span2 = document.getElementsByClassName("close1")[0];

btn2.onclick = function() {
    rmodal.style.display = "none";
}

var pmodal = document.getElementById('profileModal');
//Get the button that opens the modal
var profilebtn = document.getElementById("myProfileBtn");
var span2 = document.getElementsByClassName("close2")[0];

btn3.onclick = function() {
	pmodal.style.display = "none";
}
//When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
    if (event.target == rmodal) {
        rmodal.style.display = "none";
    }
    if (event.target == pmodal) {
    	pmodal.style.display = "none";
    }
}
</script>
</body>
</html>