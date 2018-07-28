
var countryStateInfo = {
		"India": {
			"Assam": {
				"Dispur": [],
				"Guwahati" : []
			},
			"Gujarat": {
				"Vadodara" : [],
				"Surat" : []
			},
			"Madhya Pradesh": {
				"Indore" : [],
				"Dewas" : [],
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
var countr = document.getElementById("country");
	function fun() {
		//Get html elements
		var countySel = document.getElementById("country");
		var stateSel = document.getElementById("state");	
		var citySel = document.getElementById("city");
		//Load countries  
		for (var country in countryStateInfo) {
			countySel.options[countySel.options.length] = new Option(country, country);
		}
		//County Changed
		countySel.onchange = function () {
			 stateSel.length = 1; // remove all options bar first
			 citySel.length = 1; // remove all options bar first
			 if (this.selectedIndex < 1)
				 return; // done
			 for (var state in countryStateInfo[this.value]) {
				 stateSel.options[stateSel.options.length] = new Option(state, state);
			 }
		}
		//State Changed
		stateSel.onchange = function () {		 
			 citySel.length = 1; // remove all options bar first
			 if (this.selectedIndex < 1)
				 return; // done
			 for (var city in countryStateInfo[countySel.value][this.value]) {
				 citySel.options[citySel.options.length] = new Option(city, city);
			 }
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
				$('#existingServices').append("<option></option>");
				$.each(data, function(key, value) {
					
					$('#existingServices').append(
							$(
									"<option ></option>").attr('value',
									value).text(value));
				});

			}
		});

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
	            }
	        }
	    });
	}
	function fetchPoint() {
		locationsPointSpName = [];
		locationsPointLati = [];
		locationsPointLongi = [];
		locationsPointSpMobile = [];
		
		var e = document.getElementById("existingServices");
	       var service = e.options[e.selectedIndex].text;
	      
      alert("fetch Start in js fun");
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
		            sp=sp+"Average Rating: "+value.avgrating+",<button id='myReviewBtn'>Reviews</button><br>"+
		            value.firstName+" "+value.lastName+" <br> Email Id : "+value.email+"<br>"+value.address+" - "+value.mobileNumber+"<br>Open time 10Am and Closed time 8Pm </td><td><button id='myBtn'>Show on Map</button></td</tr>";
				}); 
				sp=sp+"</table>";
				document.getElementById("spdetails").innerHTML = sp; 
				if(data==""){
					document.getElementById("spdetails").innerHTML = "<h2 style='margin-left: 6%;'>Service Prvoiders Are Not Available</h2>";
				}
			}
		});
	}
	
	function fetchPointbyarea(){
		alert("fetchPointbyarea");
		locationsPointSpName = [];
		locationsPointLati = [];
		locationsPointLongi = [];
		locationsPointSpMobile = [];
		
		var e = document.getElementById("existingServices");
	       var service = e.options[e.selectedIndex].text;
	       var a = document.getElementById("state");
	       var state = a.options[a.selectedIndex].text;
	       var b = document.getElementById("city");
	       var city = b.options[b.selectedIndex].text;
	       var area=document.getElementById("area").value;
	      
      alert("fetch Start ");
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
		            sp=sp+"Average Rating: "+value.avgrating+",<button id='myReviewBtn'>Reviews</button><br>"+
		            value.firstName+" "+value.lastName+" <br> Email Id : "+value.email+"<br>"+value.address+" - "+value.mobileNumber+"<br>Open time 10Am and Closed time 8Pm </td><td><button id='myBtn'>Show on Map</button></td</tr>";
				}); 
				sp=sp+"</table>";
				document.getElementById("spdetails").innerHTML = sp; 
				if(data==""){
					document.getElementById("spdetails").innerHTML = "<h2 style='margin-left: 6%;'>Service Prvoiders Are Not Available</h2>";
				}
			}
		});
	}
	function onReview(id,status){
		
		alert("on review invoked");
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
	
	