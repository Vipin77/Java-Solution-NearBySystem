
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
			document.getElementById("ad").innerHTML = "<input type='text' name='address' id='address' class='form-control' required='required'>";
			document.getElementById("showcity").innerHTML =" <div class='form-group'>"
			+"<label class='col-sm-2 col-sm-2 control-label'>Country</label>"+
			"<div class='col-sm-10'>"
			 +"<select id='country' name='country' class='form-control' required='required'>"+
               "<option value='' selected='selected'>-- Select Country --</option>"+
              "</select></div></div>"+
              "<div class='form-group'>"
			+"<label class='col-sm-2 col-sm-2 control-label'>State</label>"+
			"<div class='col-sm-10'>"
			 +"<select id='state' name='state' class='form-control' required='required'>"+
               "<option value='' selected='selected'>-- Select State --</option>"+
              "</select></div></div>"+
              "<div class='form-group'>"
			+"<label class='col-sm-2 col-sm-2 control-label'>City</label>"+
			"<div class='col-sm-10'>"
			 +"<select id='city' name='city' class='form-control' required='required'>"+
               "<option value='' selected='selected'>-- Select City --</option>"+
              "</select></div></div>";
              fun();
		}
	}
	
function getAddress() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showPosition);
	} else {
		
	}
}
function showPosition(position) {
 	var lati = position.coords.latitude;
	var longi = position.coords.longitude;
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
                "<input type='hidden' id='state' name='state' value='"+state+"'>"+
                "<input type='hidden' id='city' name='city' value='"+city+"'>";
            }
        }
    });
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

					<form:form id="myPlanForm" name="myForm" class="form-horizontal style-form"
						action="storeSp" method="post" cammandName="registration" enctype="multipart/form-data" >


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">First Name</label>
							<div class="col-sm-10">
								<input type="text" name="firstName" class="form-control" required="required">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Last Name</label>
							<div class="col-sm-10">
								<input type="text" name="lastName" class="form-control" required="required">
							</div>
						</div>
                        <mob>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Mobile No</label>
							<div class="col-sm-10">
								<input type="text" name="mobileNumber" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="mobilecheck"></div>
						</div></mob>


						<a><div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control" required="required">
							</div><div style="margin-left: 18%; color: red" class="col-sm-10" id="emailcheck"></div>
						</div></a>

                        <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Get Location from Device</label>
							<div class="col-sm-10">
								 <select id="locat" name="locat" class="form-control" onchange="fetchlocat()">
                                <option value="yes" selected="selected">Yes
                                 <option value="no" selected="selected">No
                                  <option value="" selected="">-- Select choice --</option>
                              </select>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Address</label>
							<div class="col-sm-10" id="ad">
								<input type="text" name="address" id="address" class="form-control"
									 required="required">
							</div>
						</div>

                       <div id="showcity">
                       <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Country</label>
							<div class="col-sm-10">
							 <select id="country" name="country" class="form-control" required="required">
                               <option value="" selected="selected">-- Select Country --</option>
                              </select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">State</label>
							<div class="col-sm-10">
								 <select id="state" name="state" class="form-control"  required="required">
                               <option value="" selected="selected">-- Select State --</option>
                              </select>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">City</label>
							<div class="col-sm-10">
								 <select id="city" name="city" class="form-control" required="required">
                               <option value="" selected="selected">-- Select City --</option>
                              </select>
							</div>
						</div>

                         </div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">CategoryType</label>
							<div class="col-sm-10">
								<select class="form-control" onChange="fetchServices(this.value)" name="categoryId"
									 required="required">
									<option></option>
									<c:forEach var="type" items="${listOfType}">
										<option value="${type.getCategoryId()}" >${type.getCategoryType()}</option>

									</c:forEach>

								</select>
							</div>
						</div>

				<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Service</label>
							<div class="col-sm-10">
								<select class="form-control" id="existingServices"  name="subCategory" required="required">
									<option></option>
								</select>
							</div>
						</div>

              <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Profile Picture</label>
							<div class="col-sm-10">
									<input type="file" name="profile" class="form-control"
									 required="required">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-10">
								<center>
									<input type="submit" class="form-submit" value="Add"
										onclick="return confirm('Are you sure you want to add Service Provider');">
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

