 <%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>Home Page</title>

    <!-- Bootstrap core CSS -->
    <link href="./resources/static/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="./resources/static/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="./resources/static/css/zabuto_calendar.css">
    <link rel="stylesheet" type="text/css" href="./resources/static/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="./resources/static/lineicons/style.css">    
    
    <!-- Custom styles for this template -->
    <link href="./resources/static/css/style.css" rel="stylesheet">
    <link href="./resources/static/css/style-responsive.css" rel="stylesheet">

    <script src="./resources/static/js/chart-master/Chart.js"></script>
    <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<script src="./resources/js/jquery-1.11.0.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/jsfunction.js"></script>
 <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
  <script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEZu0QdROlLayd9EcOb7ydUmTT24yQSWA">
    </script>
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  
    
  </head>
    
    <style>
.error {
	color: #ff0000;
	font-style: italic;
	font-weight: bold;
}
a{
}
mob{
}
.navbar1 {
  overflow: hidden;
  background-color: #33ECFF;
  top: 0;
  width: 100%;
}
.navbar1 a {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 22px;
  text-decoration: none;
  font-size: 17px;
}
.navbar1 a:hover {
  background: #ddd;
  color: black;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
    $("mob").focusout(function(){
    	 var mobileNumber=document.myForm.mobile.value; 
    	 if(mobileNumber.length==0){
     		document.getElementById("usermobilecheck").innerHTML="";
     	}
    	 else if(mobileNumber.length!=10){
    		document.getElementById("usermobilecheck").innerHTML="mobile number length must be 10";
    	}
    	else if(mobileNumber.length==10){
        	 $.ajax({
        			url : "fetchUserMobile",
        			type : "GET",
        			dataType : "json",
        			success : function(data) {
        				var status;
        				var i=0;
        	             $.each(data, function(key, value) {
        	            	 if(value==mobileNumber){
        	            		 status="Mobile Number is already Registered";
        	            		i=1;
        	            	 }
        	            	 if(value!=mobileNumber && i==0){
        	            		 status="";
        	            	 }
        				});
        	             document.getElementById("usermobilecheck").innerHTML =status;
        			}
        		}); 
    	}
    });
});
    
$(document).ready(function(){
    $("a").focusout(function(){
    var email=document.myForm.emailId.value;  
    var status;
     $.ajax({
		url : "fetchUserEmail",
		type : "GET",
		dataType : "json",
		success : function(data) { 
			var i=0;
             $.each(data, function(key, value) {
            	 if(value==email){
            		 status="Email is already Registered";
            		i=1;
            	 }
            	 if(value!=email && i==0){
            		 status="";
            	 }
			});
             document.getElementById("useremailcheck").innerHTML =status;
		}
	}); 
    });
});
function fetchlocat(){
		var locat = document.getElementById("locat").value;
		if(locat=="yes"){
			getAddress();
		}
		if(locat=="no"){
			document.getElementById("ad").innerHTML = "<input type='text' name='address' id='address' class='form-control' required='required'><div style='margin-left: 18%; color: red' class='col-sm-10' id='addresscheck'></div>";
			document.getElementById("showcity").innerHTML =" <div class='form-group'>"
			+"<label class='col-sm-2 col-sm-2 control-label'>Country</label>"+
			"<div class='col-sm-10'>"
			 +"<select id='country' name='country' class='form-control' required='required'>"+
               "<option value='' selected='selected'></option>"+
              "</select></div><div style='margin-left: 18%; color: red' class='col-sm-10' id='countrycheck'></div></div>"+
              "<div class='form-group'>"
			+"<label class='col-sm-2 col-sm-2 control-label'>State</label>"+
			"<div class='col-sm-10'>"
			 +"<select id='state' name='state' class='form-control' required='required'>"+
               "<option value='' selected='selected'></option>"+
              "</select></div><div style='margin-left: 18%; color: red' class='col-sm-10' id='statecheck'></div></div>"+
              "<div class='form-group'>"
			+"<label class='col-sm-2 col-sm-2 control-label'>City</label>"+
			"<div class='col-sm-10'>"
			 +"<select id='city' name='city' class='form-control' required='required'>"+
               "<option value='' selected='selected'></option>"+
              "</select></div><div style='margin-left: 18%; color: red' class='col-sm-10' id='citycheck'></div></div>"+
              "<div class='form-group'>"+
							"<label class='col-sm-2 col-sm-2 control-label'>PinCode</label>"+
							"<div class='col-sm-10'>"+
								"<input type='text' name='pincode' id='pincode' class='form-control' required='required'>"+
							"</div><div style='margin-left: 18%; color: red' class='col-sm-10' id='pincodecheck'></div>"+
						"</div>";
              fun();
		}
	}
	
var lati;
var longi;
	function getlatlong(){
		
		var firstName=document.myForm.firstName.value; 
		var lastName=document.myForm.lastName.value; 
		var mobile=document.myForm.mobile.value; 
		var password=document.myForm.password.value; 
		var emailId=document.myForm.emailId.value; 
		
		 var country;
	     var state;
	     var city;
		var d = document.getElementById("locat");
	       var locat = d.options[d.selectedIndex].text;
	       if(locat=="No"){
	    	   var a = document.getElementById("country");
		        country = a.options[a.selectedIndex].text;
		       var b = document.getElementById("state");
		        state = b.options[b.selectedIndex].text;
		       var c = document.getElementById("city");
		        city = c.options[c.selectedIndex].text;
	    	   pincode=document.myForm.pincode.value; 
	       }
	       
		var address=document.myForm.address.value; 
		var profile=document.myForm.profile.value; 
	       
		if(firstName.length==0){
    		document.getElementById("firstNamecheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(firstName.length!=0){
		document.getElementById("firstNamecheck").innerHTML="";
	   }
     	if(lastName.length==0){
    		document.getElementById("lastNamecheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(lastName.length!=0){
		document.getElementById("lastNamecheck").innerHTML="";
	   }
     	if(mobile.length!=0){
		document.getElementById("usermobilecheck").innerHTML="";
	   }
     	if(mobile.length==0){
    		document.getElementById("usermobilecheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(password.length==0){
    		document.getElementById("passwordcheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(password.length!=0){
		document.getElementById("passwordcheck").innerHTML="";
	   }
    	if(emailId.length==0){
    		document.getElementById("useremailcheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(emailId.length!=0){
		document.getElementById("useremailcheck").innerHTML="";
	   }
     	if(locat==""){
     		document.getElementById("locatcheck").innerHTML="Field is Required..";return 0;
   	      }
   	      if(locat!=""){
   	    	document.getElementById("locatcheck").innerHTML="";
   		   }
     	if(locat=="No"){
         	if(country==""){
         		document.getElementById("countrycheck").innerHTML="Field is Required..";return 0;
       	      }
       	      if(country!=""){
       	    	document.getElementById("countrycheck").innerHTML="";
       		   }
       	   if(state==""){
        		document.getElementById("statecheck").innerHTML="Field is Required..";return 0;
      	      }
      	      if(state!=""){
      	    	document.getElementById("statecheck").innerHTML="";
      		   }
      	    if(city==""){
        		document.getElementById("citycheck").innerHTML="Field is Required..";return 0;
      	      }
      	      if(city!=""){
      	    	document.getElementById("citycheck").innerHTML="";
      		   }
      	    if(pincode.length==0){
        		document.getElementById("pincodecheck").innerHTML="Field is Required..";
        		return 0;
        	}
         	if(pincode.length!=0){
    		document.getElementById("pincodecheck").innerHTML="";
    	   }
         	}
     	if(address.length==0){
    		document.getElementById("addresscheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(address.length!=0){
		document.getElementById("addresscheck").innerHTML="";
	   }
     	if(profile.length==0){
    		document.getElementById("profilecheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(profile.length!=0){
		document.getElementById("profilecheck").innerHTML="";
	   }
	    locat = document.getElementById("locat").value;
		if(locat=="yes"){
			document.getElementById("latlong").innerHTML ="<input type='hidden' name='latitude' value='"+lati+"'><input type='hidden' name='longitude' value='"+longi+"'>";
			document.getElementById("myPlanForm").submit();
		}
        if(locat=="no"){
        	var add=document.getElementById("address").value;
        	 var a = document.getElementById("state");
		       var state = a.options[a.selectedIndex].text;
		       var b = document.getElementById("city");
		       var city = b.options[b.selectedIndex].text;
        	
		       var pin=document.getElementById("pincode").value;
		       var v=state+" "+pin;
		       document.getElementById("forstate").innerHTML ="<input type='hidden' name='state1' value='"+v+"'>";
        	var address=add+","+city+","+state+" "+pin+",India";
        	
        	alert(address);
	        	
        	var geocoder = new google.maps.Geocoder();
  		  geocoder.geocode( { 'address': address}, function(results, status) {
  		  if (status == google.maps.GeocoderStatus.OK) {
  		      var lati = results[0].geometry.location.lat();
  		      var longi = results[0].geometry.location.lng();
  		    document.getElementById("latlong").innerHTML ="<input type='hidden' name='latitude' value='"+lati+"'><input type='hidden' name='longitude' value='"+longi+"'>";
  		    document.getElementById("myPlanForm").submit();
  		      } 
  		  }); 
        } 
	}
function getAddress() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showPosition);
	} else {
		
	}
}

function showPosition(position) {
 	lati = position.coords.latitude;
	longi = position.coords.longitude;
	var latlng = new google.maps.LatLng(lati, longi);
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'latLng': latlng }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            if (results[0]) {
            	var add= results[0].formatted_address ;
                var  value=add.split(",");

                count=value.length;
                country=value[count-1];
                state=value[count-2];
                city=value[count-3];
                document.getElementById("showcity").innerHTML="";
               
                document.getElementById("ad").innerHTML = "<input type='text' name='address' id='address' class='form-control' required='required' value='"+results[0].formatted_address+"'>"
                +"<input type='hidden' id='country' name='country' value='"+country+"'>"+
                "<input type='hidden' id='state' name='state1' value='"+state+"'>"+
                "<input type='hidden' id='city' name='city' value='"+city+"'>";
            }
        }
    });
}
</script>
<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->

<body onload="fun()">
 <div class="navbar1" style=" background-color: #333;">
       <a style="float: right;" href="user">Home</a>
      </div>
<div class="navbar1">
       <h3>&emsp;Near By Application</h3>
      </div>
      <strong><h2>${message}</h2></strong>
<section id="main-content" style="margin-right: 30%;">
	<section class="wrapper" style="margin-top: 0%;">
		<h2 style="margin-left: 15%;">User Registration Form</h2>
		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<form:form id="myPlanForm" name="myForm" class="form-horizontal style-form"
		action="storeUser" method="post" modelAttribute="userDto" enctype="multipart/form-data" >
                  <div id="latlong"></div>
                  <div id="forstate"></div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">First Name</label>
							<div class="col-sm-10">
								<input type="text" name="firstName" id="firstName" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="firstNamecheck"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Last Name</label>
							<div class="col-sm-10">
								<input type="text" name="lastName" id="lastName" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="lastNamecheck"></div>
						</div>
                        <mob>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Mobile No</label>
							<div class="col-sm-10">
								<input type="text" name="mobile" id="mobile" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="usermobilecheck"></div>
						</div>
						</mob>

                        <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Password</label>
							<div class="col-sm-10">
								<input type="password" name="password" id="password" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="passwordcheck"></div>
						</div>
						
						<a><div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" name="emailId" id="emailId" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="useremailcheck"></div>
						</div></a>
						
						
						 <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Get Location from Device</label>
							<div class="col-sm-10">
								 <select id="locat" name="locat" class="form-control" onchange="fetchlocat()">
                                <option value="yes" selected="selected">Yes</option>
                                 <option value="no" selected="selected">No</option>
                                  <option value="" selected=""></option>
                              </select>
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="locatcheck"></div>
						</div>
						
                       <div id="showcity">
                       <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Country</label>
							<div class="col-sm-10">
							 <select id="country" name="country" class="form-control" required="required">
                               <option value="" selected="selected"></option>
                              </select>
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="countrycheck"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">State</label>
							<div class="col-sm-10">
								 <select id="state" name="state" class="form-control"  required="required">
                               <option value="" selected="selected"></option>
                              </select>
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="statecheck"></div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">City</label>
							<div class="col-sm-10">
								 <select id="city" name="city" class="form-control" required="required">
                               <option value="" selected="selected"></option>
                              </select>
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="citycheck"></div>
						</div>
                        <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">PinCode</label>
							<div class="col-sm-10" id="ad">
								<input type="text" name="pincode" id="pincode" class="form-control"
									 required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="pincodecheck"></div>
						</div>
                         </div>
                         <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Address</label>
							<div class="col-sm-10" id="ad">
								<input type="text" name="address" id="address" class="form-control"
									 required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="addresscheck"></div>
						</div>
						              <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Profile Picture</label>
							<div class="col-sm-10">
									<input type="file" name="profile" class="form-control" id="profile"
									 required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="profilecheck"></div>
						</div>
						<div class="form-group">
							<div class="col-sm-10">
								<center>
									<input type="button" class="form-submit" value="Add"
										onclick="getlatlong()"/>
								</center>
							</div>
						</div>
					</form:form>
				</div>
			</div>
			<!-- col-lg-12-->
		</div>
		<!-- /row -->
	</section>
</section>
</body>
<!--main content end-->

 