var x = document.getElementById("demo");
function getLocation() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showPosition);
	} else {
		x.innerHTML = "Geolocation is not supported by this browser.";
	}
}
var lati;
var longi;
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
	google.maps.event.addListener(marker,'click',function() {
	    var infowindow = new google.maps.InfoWindow({
	       content:"You"
	    });
	  infowindow.open(map,marker);
	  });
}

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

function func() {
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

	function fetchlocat(){
		var locat = document.getElementById("locat").value;
		if(locat=="yes"){
			document.getElementById("t1").innerHTML ="";
			document.getElementById("t2").innerHTML ="";
			document.getElementById("t3").innerHTML ="";
			document.getElementById("t4").innerHTML ="";
			document.getElementById("t5").innerHTML ="";
			document.getElementById("t6").innerHTML ="";
			document.getElementById("t7").innerHTML ="";
			document.getElementById("fsearch").innerHTML ="<td style='padding:8px;'>"+
			"<input type='button' class='form-submit' value='Search' onclick='fetchPoint()'></td>";
		}
		if(locat=="no"){
			document.getElementById("t1").innerHTML ="State";
			document.getElementById("t2").innerHTML ="<select id='state' name='state' class='form-control'  required='required'>"+
       "<option value='' selected='selected'>-- Select State --</option>"+
      "</select>";
			document.getElementById("t3").innerHTML ="City";
			document.getElementById("t4").innerHTML ="<select id='city' name='city' class='form-control' required='required'>"+
     "<option value='' selected='selected'>-- Select City --</option>"+
      " </select>";
			document.getElementById("t5").innerHTML ="Area";
			document.getElementById("t6").innerHTML ="<input type='text' id='area' name='area' class='form-control' required='required'>";
			document.getElementById("t7").innerHTML ="<input type='button' class='form-submit' value='Search' onclick='fetchPointbyarea()'>";
			func();
		document.getElementById("fsearch").innerHTML ="";
		}
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

var spId=[];
var spfname=[];
var splname=[];
var spemail=[];
var spmobile=[];
var spaddress=[];
var spservice=[];
var spimg=[];
var spstatus=-1;

function fetchPoint() {
	locationsPointSpName = [];
	locationsPointLati = [];
	locationsPointLongi = [];
	locationsPointSpMobile = [];
	
	var e = document.getElementById("existingServices");
       var service = e.options[e.selectedIndex].text;

       alert("fetch Start in home js");
	$.ajax({
		url : "fetchLocationOfsp?service=" + service + "&latitude="
				+ lati + "&longitude=" + longi,
		async : false,
		type : "GET",
		dataType : "json",
		success : function(data) {
			
			 var sp="<h2>&ensp;&ensp;&ensp;&ensp;Available Service Providers</h2><table><thead><tr></tr></thead>";
			 $.each(data, function(key, value) {
				// myMap(value.latitude, value.longitude);
				locationsPointSpName.push(value.firstName);
				locationsPointLati.push(value.latitude);
				locationsPointLongi.push(value.longitude);
				locationsPointSpMobile.push(value.mobileNumber);
				showPoint(service);
				spstatus=spstatus+1;
				 spId.push(value.spId);
				 spfname.push(value.firstName); 
				 splname.push(value.lastName); 
				 spemail.push(value.email);
				 spmobile.push(value.mobileNumber);
				 spaddress.push(value.address);
				 spservice.push(service);
				 spimg.push(value.img);
				sp=sp+"<tr id='myProfileBtn' onclick=onrowclick("+spstatus+")><td><img height='100' width='100' src='data:image/jpg;base64,"+value.img+"'/></td><td><h3 style='color: blue'>Service Provider for "+service+"</h3>";
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
	            sp=sp+"&ensp;&ensp;Average Rating: "+value.avgrating+",<br>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;<button id='myReviewBtn' onclick=onReview("+value.spId+","+spstatus+")>Reviews</button>&nbsp;&nbsp;&nbsp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&nbsp;&nbsp;<button id='myBtn' onclick=onbtn("+value.latitude+","+value.longitude+",'"+String(value.firstName)+"','"+String(value.mobileNumber)+"')>Show on Map</button><br>"+
	            value.firstName+" "+value.lastName+" <br> Email Id : "+value.email+"<br>"+value.address+" - "+value.mobileNumber+"<br>Open time 10Am and Closed time 8Pm </td></tr>";
			}); 
			sp=sp+"</table>";
			document.getElementById("spdetails").innerHTML = sp; 
			if(data==""){
				getLocation();
				document.getElementById("spdetails").innerHTML = "<h2 style='margin-left: 6%;'>Service Prvoiders Are Not Available</h2>";
			}
		}
	});
}


function fetchPointbyarea(){
	locationsPointSpName = [];
	locationsPointLati = [];
	locationsPointLongi = [];
	locationsPointSpMobile = [];
	document.getElementById("spdetails").innerHTML = ""; 
	alert("fetchPointbyarea");
	
	var e = document.getElementById("existingServices");
       var service = e.options[e.selectedIndex].text;
       var a = document.getElementById("state");
       var state = a.options[a.selectedIndex].text;
       var b = document.getElementById("city");
       var city = b.options[b.selectedIndex].text;
       var area=document.getElementById("area").value;
      
	$.ajax({
		url : "fetchLocationOfsp?service=" + service + "&state="
				+ state + "&city=" + city+"&area="+area,
		async : false,
		type : "GET",
		dataType : "json",
		success : function(data) {
			 var sp="<h2>&ensp;&ensp;&ensp;&ensp;Available Service Providers</h2><table><thead><tr></tr></thead>";
			 $.each(data, function(key, value) {
				// myMap(value.latitude, value.longitude);
				locationsPointSpName.push(value.firstName);
				locationsPointLati.push(value.latitude);
				locationsPointLongi.push(value.longitude);
				locationsPointSpMobile.push(value.mobileNumber);
				showPoint(service);
				spstatus=spstatus+1;
				 spId.push(value.spId);
				 spfname.push(value.firstName); 
				 splname.push(value.lastName); 
				 spemail.push(value.email);
				 spmobile.push(value.mobileNumber);
				 spaddress.push(value.address);
				 spservice.push(service);
				 spimg.push(value.img);
				sp=sp+"<tr><td><img height='100' width='100' src='data:image/jpg;base64,"+value.img+"'/></td><td><h3 style='color: blue'>Service Provider for "+service+"</h3>";
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
			     sp=sp+"&ensp;&ensp;Average Rating: "+value.avgrating+",<br>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;<button id='myReviewBtn' onclick=onReview("+value.spId+","+spstatus+")>Reviews</button>&nbsp;&nbsp;&nbsp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&nbsp;&nbsp;<button id='myBtn' onclick=onbtn("+value.latitude+","+value.longitude+",'"+String(value.firstName)+"','"+String(value.mobileNumber)+"')>Show on Map</button><br>"+
	            value.firstName+" "+value.lastName+" <br> Email Id : "+value.email+"<br>"+value.address+" - "+value.mobileNumber+"<br>Open time 10Am and Closed time 8Pm </td></tr>";
			}); 
			sp=sp+"</table>";
			document.getElementById("spdetails").innerHTML = sp; 
			if(data==""){
				getLocation();
				document.getElementById("spdetails").innerHTML = "<h2 style='margin-left: 6%;'>Service Prvoiders Are Not Available</h2>";
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
       var servicen = document.getElementById("servicename").value;
	    for (i = -1; i < locationsPointLati.length; i++) { 
	    	if(servicen=="Mobile Phones"){
	    		alert(match);
		    	  icon1 = {url: "resources/images/locationlogo/mobilelogo.png",
		    			  scaledSize: new google.maps.Size(40, 40)
						}; 
		         }
		    if(servicen=="Bata"){
		    	  icon1 = {url: "resources/images/locationlogo/batalogo.jpg",
						    scaledSize: new google.maps.Size(40, 40)
						}; 
		    }
		    if(servicen=="vegetable"){
		    	  icon1 = {url: "resources/images/locationlogo/vegetable.jpg",
						    scaledSize: new google.maps.Size(40, 40)
						}; 
		    }
		    if(servicen=="Dentist"){
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
}
function onReview(id,status){
	 
	//alert(spfname[status]+" "+spemail[status]+" "+splname[status]+" "+spmobile[status]+" "+spaddress[status]+" "+spservice[status]+" "+spimg[status]);
	var e = document.getElementById("categoryId");
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
		
		
		var addreview="<div>"+
        "<input type='button' value='Add Review' id='addReviewBtn' onclick='Review("+id+","+status+")'><span id='linkoflogger'></span>"+
        "</div>";
		
		 var maincontent=content;
		content=content+"<br>"+addreview+"<table style=' width: 60%;border: 1px solid black;'><tr><th>User</th><th>Comment</th><th>Rating</th></tr>";
		$.each(data, function(key, value) {
			
			//for user Details
			$.ajax({
				url : "fetchUser?userId="+value.userId,
				async : false,
				type : "POST",
				dataType : "json",
				success : function(user){
			 content=content+"<tr><td>&nbsp;"+user.firstName+" "+user.lastName+"&emsp;</td></h4><br>";
			content=content+"<h4><td>"+value.review+"</td><td>";
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
			   content=content+"</tr>";
				}
			});
		}); 
		 document.getElementById("modal-body2").innerHTML =""+content+"</table><br><br><br><br><br><br><br><br><br><br><br><br><br><br>";
	     if(data.length==0){
	    	 document.getElementById("modal-body2").innerHTML =maincontent+"<h3>"+addreview+"<br>No Review</h3><br><br><br><br><br><br><br><br><br><br><br><br>";
	     }
	}
});
}
var v1=0;var v2=0;var v3=0,v4=0,v5=0;
function ratingcheck(){
var v=v1+v2+v3+v4+v5;
return v;
}
function c1(){
if(v1==1){
v1=0;v2=0;v3=0;v4=0;v5=0;
document.getElementById("1").innerHTML="<span class='fa fa-star' onclick=c1()></span>";
document.getElementById("2").innerHTML="<span class='fa fa-star' onclick=c2()></span>";
document.getElementById("3").innerHTML="<span class='fa fa-star' onclick=c3()></span>";
document.getElementById("4").innerHTML="<span class='fa fa-star' onclick=c4()></span>";
document.getElementById("5").innerHTML="<span class='fa fa-star' onclick=c5()></span>";
}
else{
v1=1;
document.getElementById("1").innerHTML="<span class='fa fa-star checked' onclick=c1()></span>";

}
}

function c2(){
if(v2==1){
v2=0;v3=0;v4=0;v5=0;
document.getElementById("2").innerHTML="<span class='fa fa-star' onclick=c2()></span>";
document.getElementById("3").innerHTML="<span class='fa fa-star' onclick=c3()></span>";
document.getElementById("4").innerHTML="<span class='fa fa-star' onclick=c4()></span>";
document.getElementById("5").innerHTML="<span class='fa fa-star' onclick=c5()></span>";
}
else{
v1=1;v2=1;
document.getElementById("1").innerHTML="<span class='fa fa-star checked' onclick=c1()></span>";
document.getElementById("2").innerHTML="<span class='fa fa-star checked' onclick=c2()></span>";
}
}

function c3(){
if(v3==1){
v3=0;v4=0;v5=0;
document.getElementById("3").innerHTML="<span class='fa fa-star' onclick=c3()></span>";
document.getElementById("4").innerHTML="<span class='fa fa-star' onclick=c4()></span>";
document.getElementById("5").innerHTML="<span class='fa fa-star' onclick=c5()></span>";
}
else{
v3=1;v1=1;v2=1;
document.getElementById("1").innerHTML="<span class='fa fa-star checked' onclick=c1()></span>";
document.getElementById("2").innerHTML="<span class='fa fa-star checked' onclick=c2()></span>";
document.getElementById("3").innerHTML="<span class='fa fa-star checked' onclick=c3()></span>";
}
}
function c4(){
if(v4==1){
v4=0;v5=0;
document.getElementById("4").innerHTML="<span class='fa fa-star' onclick=c4()></span>";
document.getElementById("5").innerHTML="<span class='fa fa-star' onclick=c5()></span>";
}
else{
v4=1;v3=1;v1=1;v2=1;
document.getElementById("1").innerHTML="<span class='fa fa-star checked' onclick=c1()></span>";
document.getElementById("2").innerHTML="<span class='fa fa-star checked' onclick=c2()></span>";
document.getElementById("3").innerHTML="<span class='fa fa-star checked' onclick=c3()></span>";
document.getElementById("4").innerHTML="<span class='fa fa-star checked' onclick=c4()></span>";
}
}
function c5(){
if(v5==1){
v5=0;
document.getElementById("5").innerHTML="<span class='fa fa-star' onclick=c5()></span>";
}
else{
v5=1;v4=1;v3=1;v1=1;v2=1;
document.getElementById("1").innerHTML="<span class='fa fa-star checked' onclick=c1()></span>";
document.getElementById("2").innerHTML="<span class='fa fa-star checked' onclick=c2()></span>";
document.getElementById("3").innerHTML="<span class='fa fa-star checked' onclick=c3()></span>";
document.getElementById("4").innerHTML="<span class='fa fa-star checked' onclick=c4()></span>";
document.getElementById("5").innerHTML="<span class='fa fa-star checked' onclick=c5()></span>";
}
}

function Review(id,status){
	addrevmodal.style.display = "block";
	$.ajax({
		url : "checkUserLogin",
		async : false,
		type : "POST",
		dataType : "json",
		success : function(data){
			if(data!=0){
				
				var ratingcontent="<div style='margin-left:2%;'><div id='1' style='float: left;'>"+
				"<span class='fa fa-star' onclick=c1()></span></div>"+
				"<div id='2' style='float: left;'>"+
				"<span class='fa fa-star' onclick=c2()></span></div>"+
				"<div id='3' style='float: left;'>"+
				"<span class='fa fa-star' onclick=c3()></span></div>"+
				"<div id='4' style='float: left;'>"+
				"<span class='fa fa-star' onclick=c4()></span></div>"+
				"<div id='5' style='float: left;'>"+
				"<span class='fa fa-star' onclick=c5()></span></div></div><br>"+
				"<br>";
				
				var addreview="<div>&emsp;"+
                "<textarea rows='3' cols='30' name='rev' id='rev'>"+
                "</textarea><br><br>"+ratingcontent+
                "<br>&emsp;<input type='button' value='Add Review' onclick='addReview("+id+","+data+","+status+")'></div>";
				document.getElementById("modal-body3").innerHTML = addreview+"<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>";
			}
			if(data==0){
				alert("first you have to login....");
				addrevmodal.style.display = "none";
				var addreview="&emsp;For Login <a class='logout'  onclick='loginModal(this.id)' id='logininrev'>click here..</a>"+
                "&emsp;For Registration <a href='userRegistration'>click here..</a><br>";
				document.getElementById("linkoflogger").innerHTML = addreview;		
			}
		}
	});
}


function addReview(spid,userid,status,ff){
	var rating=ratingcheck();
	var rev=document.getElementById("rev").value;
	$.ajax({
		url : "addReview?review="+rev+"&spId="+spid+"&userId="+userid+"&rating="+rating,
		async : false,
		type : "POST",
		dataType : "json",
		success : function(data){
			alert(data+" with f "+ff);
			addrevmodal.style.display = "none";
			onReview(spid,status);
		}
	});
	
}

function onbtn(lati,longi,fname,m){
	modal.style.display = "block";
	
	var map = new google.maps.Map(document.getElementById('mapinmodal'), {
          zoom: 10,
          center: {lat: lati, lng: longi}
        }); 
	 var geocoder = new google.maps.Geocoder;
	 var infowindow = new google.maps.InfoWindow;
	geocodeLatLng2(geocoder, map, infowindow,lati,longi);
	myMap2(lati,longi,fname,m);
	
}
function geocodeLatLng2(geocoder, map, infowindow,lat,longi) {
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
function myMap2(lat, longii,fname,mobile) {

	var myCenter = new google.maps.LatLng(lat, longii);
	var mapCanvas = document.getElementById("mapinmodal");
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
		 var directionsDisplay;
		  var directionsService = new google.maps.DirectionsService();
		  directionsDisplay = new google.maps.DirectionsRenderer();
		    var start = new google.maps.LatLng(lati, longi);
		    var end = new google.maps.LatLng(lat, longii);
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
