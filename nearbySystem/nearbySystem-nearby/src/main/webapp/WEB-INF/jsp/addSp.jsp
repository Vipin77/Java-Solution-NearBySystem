<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<script src="./resources/js/jquery-1.11.0.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/jsfunction.js"></script>
 <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
  <script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEZu0QdROlLayd9EcOb7ydUmTT24yQSWA">
    </script>
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
</style>
<script type="text/javascript">
$(document).ready(function(){
    $("mob").focusout(function(){
    	 var mobileNumber=document.myForm.mobileNumber.value; 
    	 if(mobileNumber.length==0){
     		document.getElementById("mobilecheck").innerHTML="";
     	}
    	 else if(mobileNumber.length!=10){
    		document.getElementById("mobilecheck").innerHTML="mobile number length must be 10";
    	}
    	else if(mobileNumber.length==10){
        	 $.ajax({
        			url : "fetchMobile",
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
        	             document.getElementById("mobilecheck").innerHTML =status;
        			}
        		}); 
    	}
    });
});
    
$(document).ready(function(){
    $("a").focusout(function(){
    var email=document.myForm.email.value;  
    var status;
     $.ajax({
		url : "fetchEmail",
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
             document.getElementById("emailcheck").innerHTML =status;
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
			document.getElementById("showcity").innerHTML ="<div class='form-group'>"+
			"<label class='col-sm-2 col-sm-2 control-label'>PinCode</label>"+
			"<div class='col-sm-10'>"+
		    "<input type='text' name='pincode' id='pincode' class='form-control' required='required'>"+
			"</div><div style='margin-left: 18%; color: red' class='col-sm-10' id='pincodecheck'></div>"+
		    "</div>"+
			"<div class='form-group'>"
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
              "</select></div><div style='margin-left: 18%; color: red' class='col-sm-10' id='citycheck'></div></div>";
              fun();
		}
	}

function getAddress() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showPosition);
	} else {
		
	}
}

var lati;
var longi;
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
                "<input type='hidden' id='state1' name='state1' value='"+state+"'>"+
                "<input type='hidden' id='city' name='city' value='"+city+"'>"+
                "";
            }
        }
    });
}

	function getlatlong(){
		
		var businessName=document.myForm.businessName.value; 
		var firstName=document.myForm.firstName.value; 
		var mobileNumber=document.myForm.mobileNumber.value; 
		var password=document.myForm.password.value; 
		var email=document.myForm.email.value; 
		var address=document.myForm.address.value; 
		var pincode;
		var profile=document.myForm.profile.value; 
		
	       var d = document.getElementById("locat");
	       var locat = d.options[d.selectedIndex].text;
	       
	       
	       var e = document.getElementById("categoryId");
	       var categoryId = e.options[e.selectedIndex].text;
	       var f = document.getElementById("existingServices");
	       var existingServices = f.options[f.selectedIndex].text;
	       var g = document.getElementById("homeService");
	       var homeService = g.options[g.selectedIndex].text;
	       var country;
	       var state;
	       var city;
	       if(locat=="No"){
	    	   var a = document.getElementById("country");
		        country = a.options[a.selectedIndex].text;
		       var b = document.getElementById("state");
		        state = b.options[b.selectedIndex].text;
		       var c = document.getElementById("city");
		        city = c.options[c.selectedIndex].text;
	    	   pincode=document.myForm.pincode.value; 
	       }
	       
   	    if(businessName.length==0){
    		document.getElementById("businessNamecheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(businessName.length!=0){
		document.getElementById("businessNamecheck").innerHTML="";
	   }
     	if(firstName.length==0){
    		document.getElementById("firstNamecheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(firstName.length!=0){
		document.getElementById("firstNamecheck").innerHTML="";
	   }
     	if(mobileNumber.length!=0){
		document.getElementById("mobilecheck").innerHTML="";
	   }
     	if(mobileNumber.length==0){
    		document.getElementById("mobilecheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(password.length==0){
    		document.getElementById("passwordcheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(password.length!=0){
		document.getElementById("passwordcheck").innerHTML="";
	   }
    	if(email.length==0){
    		document.getElementById("emailcheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(email.length!=0){
		document.getElementById("emailcheck").innerHTML="";
	   }
     	 if(locat==""){
     		document.getElementById("locatcheck").innerHTML="Field is Required..";return 0;
   	      }
   	      if(locat!=""){
   	    	document.getElementById("locatcheck").innerHTML="";
   		   }
     	if(address.length==0){
    		document.getElementById("addresscheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(address.length!=0){
		document.getElementById("addresscheck").innerHTML="";
	   }
     	if(locat=="No"){
     	if(pincode.length==0){
    		document.getElementById("pincodecheck").innerHTML="Field is Required..";
    		return 0;
    	}
     	if(pincode.length!=0){
		document.getElementById("pincodecheck").innerHTML="";
	   }
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
     	}
  	    if(categoryId==""){
    		document.getElementById("categoryIdcheck").innerHTML="Field is Required..";return 0;
  	      }
  	      if(categoryId!=""){
  	    	document.getElementById("categoryIdcheck").innerHTML="";
  		   }
  	    if(existingServices==""){
    		document.getElementById("existingServicescheck").innerHTML="Field is Required..";return 0;
  	      }
  	      if(existingServices!=""){
  	    	document.getElementById("existingServicescheck").innerHTML="";
  		   }
  	    if(homeService==""){
    		document.getElementById("homeServicecheck").innerHTML="Field is Required..";return 0;
  	      }
  	      if(homeService!=""){
  	    	document.getElementById("homeServicecheck").innerHTML="";
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
        	  a = document.getElementById("state");
		        state = a.options[a.selectedIndex].text;
		        b = document.getElementById("city");
		        city = b.options[b.selectedIndex].text;
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
  		      console.log(lati, longi);
  		    document.getElementById("latlong").innerHTML ="<input type='hidden' name='latitude' value='"+lati+"'><input type='hidden' name='longitude' value='"+longi+"'>";
  		     document.getElementById("myPlanForm").submit(); 
  		      } 
  		  }); 
        } 
        alert("");
	}
	
function getlatlongcheck(){
		
		var locat = document.getElementById("locat").value;
		if(locat=="yes"){
			alert("in yes "+lati+" "+longi);
			document.getElementById("latlong").innerHTML ="<input type='hidden' name='latitude' value='"+lati+"'><input type='hidden' name='longitude' value='"+longi+"'>";
			 alert("now Submit"); 
		}
        if(locat=="no"){
        	var add=document.getElementById("address").value;
        	 var a = document.getElementById("state");
		       var state = a.options[a.selectedIndex].text;
		       var b = document.getElementById("city");
		       var city = b.options[b.selectedIndex].text;
        	
		       var pin=document.getElementById("pincode").value;
	        	var address=add+","+city+","+state+" "+pin+",India";
	        	document.getElementById("forstate").innerHTML ="<input type='hidden' name='state1' value="+state+">";
	        	alert(address);
	        	
	        	
        	var geocoder = new google.maps.Geocoder();
  		  geocoder.geocode( { 'address': address}, function(results, status) {
  		  if (status == google.maps.GeocoderStatus.OK) {
  		      var lati = results[0].geometry.location.lat();
  		      var longi = results[0].geometry.location.lng();
  		      console.log(lati, longi);
  		    alert("in no "+lati+" "+longi);
  		    document.getElementById("latlong").innerHTML ="<input type='hidden' name='latitude' value='"+lati+"'><input type='hidden' name='longitude' value='"+longi+"'>";
  		  alert("now Submit");    
  		  } 
  		  }); 
        }
	}
function fetchServices(cid)
{
	$('#existingServices').find("option").remove();
	$.ajax({
		url : "fetchServices?cid=" + cid,         
		async : false,
		data : { 
			cid : cid
		},
		type : "GET",
		dataType : "json",
		success : function(data) {
			
			$('#existingServices').append("<option></option>");
			$.each(data, function(key, value) {
				
				$('#existingServices').append($("<option></option>").attr('value', value).text(value));
			});
		}
	});
	}
</script>
<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->

<body onload="fun()">
<section id="main-content">
	<section class="wrapper">
		<h4>
			<i class="fa fa-angle-right"></i> Add New SP
		</h4>
		<strong><h2>${message}</h2></strong>
		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
<!-- <button onclick="getlatlongcheck()"></button> -->
					<form:form id="myPlanForm" name="myForm" class="form-horizontal style-form"
						action="storeSp" method="post" cammandName="registration" enctype="multipart/form-data" >
                       <div id="latlong"></div>
                       <div id="forstate"></div>
                       <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Business Name</label>
							<div class="col-sm-10">
								<input type="text" name="businessName" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="businessNamecheck"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">First Name</label>
							<div class="col-sm-10">
								<input type="text" name="firstName" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="firstNamecheck"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Last Name</label>
							<div class="col-sm-10">
								<input type="text" name="lastName" class="form-control">
							</div>
						</div>
                        <mob>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Mobile No</label>
							<div class="col-sm-10">
								<input type="text" name="mobileNumber" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="mobilecheck"></div>
						</div></mob>

                        <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Password</label>
							<div class="col-sm-10">
								<input type="password" name="password" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="passwordcheck"></div>
						</div>
                        
						<a><div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="emailcheck"></div>
						</div></a>

                        <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Get Location from Device</label>
							<div class="col-sm-10">
								 <select id="locat" name="locat" class="form-control" onchange="fetchlocat()">
                                <option value="yes" selected="selected">Yes</option>
                                 <option value="no" selected="selected">No</option>
                                 <option value=""selected="selected"></option>
                              </select>
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="locatcheck"></div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Address</label>
							<div class="col-sm-10" id="ad">
								<input type="text" name="address" id="address" class="form-control"
									 required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="addresscheck"></div>
						</div>
						
                       <div id="showcity">
                       
                       <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">PinCode</label>
							<div class="col-sm-10">
								<input type="text" name="pincode" id="pincode" class="form-control"
									 required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="pincodecheck"></div>
						</div>
						
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

                         </div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">CategoryType</label>
							<div class="col-sm-10">
								<select class="form-control" onChange="fetchServices(this.value)" name="categoryId" id="categoryId"
									 required="required">
									<option></option>
									<c:forEach var="type" items="${listOfType}">
										<option value="${type.getCategoryId()}" >${type.getCategoryType()}</option>

									</c:forEach>

								</select>
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="categoryIdcheck"></div>
						</div>

				<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Service</label>
							<div class="col-sm-10">
								<select class="form-control" id="existingServices"  name="subCategory" required="required">
									<option></option>
								</select>
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="existingServicescheck"></div>
						</div>
              
              <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Home Service</label>
							<div class="col-sm-10">
								 <select id="homeService" name="homeService" class="form-control">
                                <option value="yes" selected="selected">Yes</option>
                                 <option value="no" selected="selected">No</option>
                                  <option value="" selected=""></option>
                              </select>
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="homeServicecheck"></div>
						</div>
              
              <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Profile Picture</label>
							<div class="col-sm-10">
									<input type="file" name="profile" class="form-control"
									 required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="profilecheck"></div>
						</div>
						<div class="form-group">
							<div class="col-sm-10">
								<center>
									<input type="button" class="form-submit" value="Add"
										onclick="getlatlong()">
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

