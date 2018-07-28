<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEZu0QdROlLayd9EcOb7ydUmTT24yQSWA">
</script>
<script src="./resources/js/jsfunction.js"></script>
<script src="./resources/js/userhome.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./resources/css/userhome.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>user</title>
<style>
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 50px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
.modal-content {
	position: relative;
	background-color: #fefefe;
	margin: auto;
	padding: 0;
	border: 1px solid #888;
	width: 65%;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
	-webkit-animation-name: animatetop;
	-webkit-animation-duration: 0.4s;
	animation-name: animatetop;
	animation-duration: 0.4s
}
/* The Close Button */
.close {
	color: white;
	float: right;
	font-size: 28px;
	font-weight: bold;
}
.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
.close1 {
	color: white;
	float: right;
	font-size: 28px;
	font-weight: bold;
}
.close1:hover, .close1:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
.close2 {
	color: white;
	float: right;
	font-size: 28px;
	font-weight: bold;
}
.close2:hover, .close2:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
.close4 {
	color: white;
	float: right;
	font-size: 28px;
	font-weight: bold;
}
.close4:hover, .close4:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
.modal-header {
	padding: 2px 16px;
	background-color: DarkSlateBlue;
	color: white;
}
.modal-body {
	padding: 2px 16px;
}
.modal-footer {
	padding: 2px 10px;
	color: white;
}
.split {
    height: 497px;
    width: 39%;
    position: fixed;
    top: 23%;
    overflow-x: hidden;
    padding-top: 20px;
}
.left {
    left: 0;
}
.fa {
    font-size: 25px;
}

.checked {
    color: orange;
}
body {margin:0;}
.navbar1 {
  overflow: hidden;
  background-color: #333;
  position: fixed;
  top: 0;
  width: 100%;
}
.navbar1 a {
  float: right;
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
.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
  margin: auto;
  text-align: center;
  font-family: arial;
}

.title {
  color: grey;
  font-size: 18px;
}
a {
  text-decoration: none;
  font-size: 22px;
  color: black;
}
c{
}
</style>
</head>
<body onload="getLocation()" style="background-color: #FAFAFA;">
      <strong id="forservice"></strong>
      <strong id="forcategory"> &ensp;</strong>
       <strong id="forservicename"></strong>
        <strong id="forcategoryname"> &ensp;</strong>
      <div class="navbar1">
      <% Object s= session.getAttribute("userId");
         if(s!=null){%>
        	  <a href="userlogout" id="logouts">Logout</a>
         <% }
      %>
       <span  id="Loginlink">
      <% Object s2= session.getAttribute("userId");
         if(s2==null){%>
        	  <a  onclick="loginModal(this.id)" id="logins">Login</a>
         <% }
      %></span>
           <a href="user">Home</a>
           <span  id="Registrationlink">
       <% Object s4= session.getAttribute("userId");
         if(s4==null){%>
        <a href="userRegistration">Registration</a>
         <% }
      %></span>
             <span  id="splogin">
            <% Object s3= session.getAttribute("userId");
             if(s3==null){%>
        	 <a href="spLoginPage" id="splogin">SP Login</a>
         <% }
          %></span>
      </div>
	<div style="height: 80px; background-color: #333;">
		<br>
		<br><br>
		<span style="color: white;font-size: 22px;text-align: center;margin-left: 38%;">Java Solution Near By System</span>
		<span style="float: right;margin-right: 2%;color: white;" id="loginname">
		<% Object s5= session.getAttribute("userfName");
             if(s5!=null){%>
        	 <strong>Welcome ${userfName}</strong>
         <% }
          %>
		</span>
	</div>

 <table style="color:white;background-color:black;text-align: left;">
  <tr>
    <td style="padding:4px;" onmousemove="viewcategory()">CategoryType<select></select></td>
			<td style="padding:4px;"><span id='svalue'></span></td>
		<td style="padding:4px;">Search By</td>
      <td style="padding:4px;"><select id="locat" name="locat" class="form-control"
				onchange="fetchlocat()">
				
				<option value="no" selected="selected"/>Specific Area
				<option value="yes" selected="selected"/>Your Location
			</select></td>	
			<td style="padding:4px;" id="fsearch"><input type="button" class="form-submit" value="Search"
					onclick="fetchPoint()"></td>
	        <td id="t1" style="padding:4px;"></td>
	        <td id="t2" style="padding:4px;"></td>
	        <td id="t3" style="padding:4px;"></td>
	        <td id="t4" style="padding:4px;"></td>
	        <td id="t5" style="padding:4px;"></td>
	        <td id="t6" style="padding:4px;"></td>
	        <td id="t7" style="padding:4px;"></td>
	</tr>
	</table>
	</div><br><br>
	<!--   <input type="button" id="routebtn" value="route"> -->
	<br><div class="split left">
	<div id="spdetails">
	
	<div class="card" style="margin-left:18%; height:100%; width:80%;"><br><br>
  <img src="./resources/static/img/jsnearlogo.png" alt="John" height="74%;" width="70%;">
 <br><br><br>
  <h3 style="font-style: italic;">Search Whatever You Want</h3>
    <br><br><br>
  
 <p><button
 style=" border: none;
  outline: 0;
  display: inline-block;
  padding: 8px;
  color: white;
  background-color: #000;
  text-align: center;
  cursor: pointer;
  width: 100%;
  font-size: 18px;"
 >Java Solutions</button></p>
</div>
	
	</div></div>
	<div id="map" style="width: 61%; height: 450px; margin-left: 39%;"></div>

	<p id="demo" style="margin-left: 39%;"></p>
	<!-- The Modal for Map-->
	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<div class="modal-header">
				<h2 id="addressinmap"></h2>
			</div>
			<span class="close" style="color: black;">Close</span>
			<div id="mapinmodal" style="width: 100%; height: 465px;"></div>
			<div id="modal-body" class="modal-body"></div>
			<div class="modal-footer">
				<h3></h3>
			</div>
		</div>
	</div>

	<!-- The Modal for viewReview-->
	<div id="myReviewModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<div class="modal-header">
				<h2>Java Solution Near by System</h2>
			</div>
			<div style="text-align: right;">
				<input type="button" id="btn2" value="Close" />
			</div>
			<div id="modal-body2" class="modal-body"></div>
			<div class="modal-footer">
				<h3></h3>
			</div>
		</div>
	</div>
	
	<!-- The Modal for AddReview-->
	<div id="addReviewModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<div class="modal-header">
				<h2>Java Solution Near by System</h2>
			</div>
			<div style="text-align: right;">
				<input type="button" id="btn3" value="Close" />
			</div>
			<div id="modal-body3" class="modal-body"></div>
			<div class="modal-footer">
				<h3></h3>
			</div>
		</div>
	</div>
	
	<!-- The Modal for profile-->
<div id="profileModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content" style="height:85%;width: 50%;">
    <div style="text-align: right;"><input type="button" id="btn4" value="Close"/></div>
    <div id="modal-body4" class="modal-body"></div>
      <h3></h3>
    </div>
  </div>
  
  <!-- The Modal for Login-->
<div id="LoginModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content" style="height:58%;width: 30%;">
    <div style="text-align: right;"><input type="button" id="btn5" value="Close"/></div>
    <div id="modal-body5" class="modal-body"></div>
      <h3></h3>
    </div>
  </div>
  
  <!-- The Modal for Category-->
<div id="catModal" class="modal" style="background-color: rgba(0, 0, 0, 0);">
  <!-- Modal content -->
  <div class="modal-content" style="height:0%;width: 0%;margin-left: 0.2%;margin-top:6%;background-color: #232B4E;" >
   <!--  <div style="text-align: right;"><input type="button" id="btn6" value="Close"/></div>
    --> <div id="modal-body6" class="modal-body"></div>
      <h3></h3>
    </div>
  </div>
  
  <!-- The Modal for Contact-->
<div id="contactModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content" style="height:70%;width:25%;margin-top:8%;">
     <div style="text-align: right;"><input type="button" id="btn7" value="Close"/></div>
     <div id="modal-body7" class="modal-body"></div>
      <h3></h3>
    </div>
  </div>
  
	<script>
		var x = document.getElementById("demo");
		var modal = document.getElementById('myModal');
		//Get the button that opens the modal
		var btn = document.getElementById("myBtn");
		//Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];
		//When the user clicks the button, open the modal 

		//When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modal.style.display = "none";
		}
         ///////////////////////////////////////////
		var rmodal = document.getElementById('myReviewModal');
		//Get the button that opens the modal
		var rbtn = document.getElementById("myReviewBtn");
		var span2 = document.getElementsByClassName("close1")[0];
		btn2.onclick = function() {
			rmodal.style.display = "none";
		}
		
		var addrevmodal = document.getElementById('addReviewModal');
		//Get the button that opens the modal
		var addrevbtn = document.getElementById("addReviewBtn");
		//Get the <span> element that closes the modal
		var span3 = document.getElementsByClassName("close2")[0];
		btn3.onclick = function() {
			addrevmodal.style.display = "none";
		}
		
		var pmodal = document.getElementById('profileModal');
		//Get the button that opens the modal
		var profilebtn = document.getElementById("myProfileBtn");
		var span4 = document.getElementsByClassName("close4")[0];
		btn4.onclick = function() {
			pmodal.style.display = "none";
		}
		var logmodal = document.getElementById('LoginModal');
		//Get the button that opens the modal
		var profilebtn = document.getElementById("myLogBtn");
		var span5 = document.getElementsByClassName("close5")[0];
		btn5.onclick = function() {
			logmodal.style.display = "none";
		}
		var catemodal = document.getElementById('catModal');
		//Get the button that opens the modal
		var span6 = document.getElementsByClassName("close6")[0];
		/* btn6.onclick = function() {
			catemodal.style.display = "none";
		} */
		var contmodal = document.getElementById('contactModal');
		//Get the button that opens the modal
		var span7 = document.getElementsByClassName("close7")[0];
		btn7.onclick = function() {
			contactModal.style.display = "none";
		}
		//When the user clicks anywhere outside of the modal, close it
		
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
			if (event.target == rmodal) {
				rmodal.style.display = "none";
			}
			if (event.target == addrevmodal) {
				addrevmodal.style.display = "none";
			}
			 if (event.target == pmodal) {
			    	pmodal.style.display = "none";
			    }
			 if (event.target == logmodal) {
				 logmodal.style.display = "none";
			    }
			 if (event.target == catemodal) {
				 catemodal.style.display = "none";
			    }
			 if (event.target == contmodal) {
				 contmodal.style.display = "none";
			    }
		}
		var sub=[];
	
		function viewcategory(){
			
			
			catemodal.style.display = "block";
			var catcontent="<div style='float:left;' id='dtable1'><table style='border: 1px solid #ddd;text-align: left;border-collapse: collapse;'>";
			
			<c:forEach var="category" items="${listOfType}">
			catcontent=catcontent+"<tr style='border: 1px solid #ddd;background-color:white;' id='${category.categoryId}' onmousemove='subcatadd(this.id)' onmouseout='subcatremove(this.id)'><td style=' padding: 10px;'> ${category.categoryType}";

			var i='${category.categoryId}';
			var s="";
			s=s+"<table style='border: 1px solid #ddd;text-align: left;border-collapse: collapse;width:180%'>";
			<c:forEach var="subcategory" items="${category.subCategoryType}">
			s=s+"<tr style='border: 1px solid #ddd;background-color:white;' id='s${subcategory.subcategoryId}'><td style=' padding: 10px;' onclick=passservice(${subcategory.subcategoryId},${category.categoryId}) onmousemove='submove(${subcategory.subcategoryId})' onmouseout='subout(${subcategory.subcategoryId})'>${subcategory.service}_${subcategory.type}</td></tr>";
              
			</c:forEach>
              s=s+"</table>";
              sub[i]=s;
              
              catcontent=catcontent+"</td><td>&nbsp;</td></tr>";
			</c:forEach>
		   catcontent=catcontent+"</table></div><div id='subcatitem' style='height:100%;width:100%;'></div";
		   
		   document.getElementById("modal-body6").innerHTML =catcontent;
		  
		}
		
		 function subcatadd(rowid){
			 document.getElementById(rowid).style.backgroundColor="#9F81F7";
			 document.getElementById("subcatitem").innerHTML =sub[rowid];
		}
		
		 function subcatremove(rowid){
			 document.getElementById(rowid).style.backgroundColor = "white";
		}
		 function passservice(serid,categoryid){
			 document.getElementById("subcatitem").innerHTML ="";
			 document.getElementById("dtable1").innerHTML ="";
			 catemodal.style.display = "none";
			 document.getElementById("forservice").innerHTML ="<input type='hidden' id='serviceid' value="+serid+">";
			 document.getElementById("forcategory").innerHTML ="<input type='hidden' id='categoryid' value="+categoryid+">";
			var c;
			var s;
			 $.ajax({
					url : "fetchServiceName?cid="+serid,
					async : false,
					type : "GET",
					dataType : "json",
					success : function(data) {
						s=data[0];
		       document.getElementById("forservicename").innerHTML ="<input type='hidden' id='servicename' value="+data[0]+">";
					}
				});
			 $.ajax({
					url : "fetchCategoryName?cid="+categoryid,
					async : false,
					type : "GET",
					dataType : "json",
					success : function(data) {
						c=data;
		         document.getElementById("forcategoryname").innerHTML ="<input type='hidden' id='categoryname' value="+data+">";
					}
				});
			 var setcs=c+" >> "+s;
			 document.getElementById("svalue").innerHTML=setcs;
		 }
		 
		 function submove(subid){
			  var ss="s"+subid;
			 document.getElementById(ss).style.backgroundColor="#9F81F7";
		 }
		 function subout(subid){
			 var ss="s"+subid;
			 document.getElementById(ss).style.backgroundColor="white";
		 }
		 var add_id;
			var add_status;
			var add_ff;
		var clickid;
		function loginModal(clickbtn){
			clickid=clickbtn;
			logmodal.style.display = "block";
			
			var vc="<br><table style=' width: 100%;border: 0px solid black;font-size: 120%;'>"+
			"<tr style='border: 0px;'><td style='padding: 8px;'>Mobile Number</td><td style='padding: 8px;'><input type='text' class='form-control-login' name='userName' id='userName' placeholder='Mobile Number' autofocus></td></tr><tr style='border: 0px;background-color: white;'><td>&ensp;</td></tr>"+
			"<tr style='border: 0px;background-color: white;'><td style='padding: 8px;'>Password</td><td style='padding: 8px;'><input type='password' class='form-control-login'  name='password' id='password' placeholder='Password'></td></tr>"+
			"</table><br>";
			var logcontent="<div><center><div class='login-wrap' style='font-size: 100%;'>"+
           "<br> <br><h3>USER LOGIN</h3><br>"+vc+
           " <br><br><br><label class='checkbox'>"+
           " </label>"+
           " <button class='btn btn-theme btn-block' type='submit' onclick='userloginfun()'><i class='fa fa-lock'></i> SIGN IN</button>"+
           "&ensp;&ensp;&ensp;&ensp;<a href='userRegistration'>Registration</a></div></center></div>";
			
			document.getElementById("modal-body5").innerHTML =logcontent;
		}
	function userloginfun(){
		 var userName=document.getElementById("userName").value;
		 var password=document.getElementById("password").value;
		 
		 $.ajax({
				url : "userloginVerify?userName=" + userName + "&password="
						+ password,
				async : false,
				type : "POST",
				dataType : "json",
				success : function(data) {
				if(data!=0){
					alert("Login Sucessfull..");
					document.getElementById("splogin").innerHTML ="";
					document.getElementById("Registrationlink").innerHTML ="";
					document.getElementById("Loginlink").innerHTML ="<a href='userlogout'>Logout</a>";
					logmodal.style.display = "none";
					document.getElementById("loginname").innerHTML ="Welcome "+data[1];
					if(clickid=="logins"){
						
					}
                    if(clickid=="logininrev"){
                    	Review(add_id,add_status,add_ff);
					}
				}
				if(data==0){
					alert("Invalid Mobile Number or Password");
				}
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
		var spbusinessName=[];
		var spavgrating=[];
		var spnoofreview=[];
		var spstatus=-1;

		function fetchPoint() {
			locationsPointSpName = [];
			locationsPointLati = [];
			locationsPointLongi = [];
			locationsPointSpMobile = [];
			var service = document.getElementById("serviceid").value;
			var servicen;
			var catId = document.getElementById("categoryid").value;
			 $.ajax({
					url : "fetchServiceName?cid="+service,
					async : false,
					type : "GET",
					dataType : "json",
					success : function(data) {
						servicen=data[0];
					}
				});
			
			$.ajax({
				url : "fetchLocationOfsp?service=" + service + "&latitude="
						+ lati + "&longitude=" + longi,
				async : false,
				type : "GET",
				dataType : "json",
				success : function(data) {
					
					 var sp="<h2>Available Service Providers for "+servicen+"</h2><table><thead><tr></tr></thead>";
					 $.each(data, function(key, value) {
						// myMap(value.latitude, value.longitude);
						locationsPointSpName.push(value.firstName);
						locationsPointLati.push(value.latitude);
						locationsPointLongi.push(value.longitude);
						locationsPointSpMobile.push(value.mobileNumber);
						showPoint(servicen);
						spstatus=spstatus+1;
						 spId.push(value.spId);
						 spfname.push(value.firstName); 
						 splname.push(value.lastName); 
						 spemail.push(value.email);
						 spmobile.push(value.mobileNumber);
						 spaddress.push(value.address);
						 spservice.push(servicen);
						 spimg.push(value.img);
						 spbusinessName.push(value.businessName);
						 spavgrating.push(value.avgrating);
						 var rr;
						 $.ajax({
								url : "fetchNoOfReview?spId="+value.spId,
								async : false,
								type : "GET",
								dataType : "json",
								success : function(data) {
								rr=data[0];
								spnoofreview.push(rr);
								}
							});
						 
						sp=sp+"<tr id='myProfileBtn' onclick=onReview("+value.spId+","+spstatus+",'1')><td><img height='100' width='100' src='data:image/jpg;base64,"+value.img+"'/></td><td><h3 style='color: blue'>"+value.businessName+"</h3>";
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
			            sp=sp+"&ensp;"+rr+" Reviews,&ensp;Average Rating: "+value.avgrating+",<br><button onclick=contactmodal("+spstatus+")>View Contact</button>&ensp;&nbsp;&ensp;&nbsp;&ensp;&ensp;&ensp;&ensp;<button id='myReviewBtn' onclick=onReviewBtn("+value.spId+","+spstatus+",'1')>Reviews</button>&ensp;&nbsp;&nbsp;&nbsp;&ensp;&ensp;&nbsp;&nbsp;<button id='myBtn' onclick=onbtn("+value.latitude+","+value.longitude+",'"+String(value.firstName)+"','"+String(value.mobileNumber)+"',"+spstatus+")>Show on Map</button><br>"+
			            "Open time 10Am and Closed time 8Pm </td></tr>";
					}); 
					sp=sp+"</table>";
					document.getElementById("spdetails").innerHTML = sp; 
					if(data==""){
						getLocation();
						document.getElementById("spdetails").innerHTML = "<h2 style='margin-left: 6%;'>Service Prvoiders Are Not Available</h2>";
					}
				}
			});
			/* if(statusafterfetchsp==1){
				alert("statusafterfetchsp "+statusafterfetchsp);
			} */
		}

		function onrowclick(status){
			if(ignoreparent==1){
				ignoreparent=0;
				return 0;
				}
		       var Category =  document.getElementById("categoryname").value;
			pmodal.style.display = "block";
			
			var content="<h3 style='color: blue;margin-left:36px;'>Category >> "+Category+" >> "+spservice[status]+"</h3>"+
			"<hr><h3 style='margin-left:36px;'>"+spbusinessName[status]+"</h3>";
			content=content+"&emsp;&emsp;Average Rating &emsp;";
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
			content=content+"<br><br>"+
			"<hr><img height='230' width='230' src='data:image/jpg;base64,"+spimg[status]+"'/>";
			document.getElementById("modal-body4").innerHTML =content;
		}
		
		
		function fetchPointbyarea(){
			locationsPointSpName = [];
			locationsPointLati = [];
			locationsPointLongi = [];
			locationsPointSpMobile = [];
			document.getElementById("spdetails").innerHTML = ""; 
			var servicen;
			var service = document.getElementById("serviceid").value;
		       var a = document.getElementById("state");
		       var state = a.options[a.selectedIndex].text;
		       var b = document.getElementById("city");
		       var city = b.options[b.selectedIndex].text;
		       var area=document.getElementById("area").value;
		       var servicen;
			   var catId = document.getElementById("categoryid").value;

				 $.ajax({
						url : "fetchServiceName?cid="+service,
						async : false,
						type : "GET",
						dataType : "json",
						success : function(data) {
							servicen=data[0];
						}
					});
		       
				var address=area+","+city+","+state+",India";
				 var geocoder = new google.maps.Geocoder();
		  		  geocoder.geocode( { 'address': address}, function(results, status) {
		  		  if (status == google.maps.GeocoderStatus.OK) {
		  		      var lati2 = results[0].geometry.location.lat();
		  		      var longi2 = results[0].geometry.location.lng();
		  		      $.ajax({
						url : "fetchLocationOfsp?service=" + service + "&latitude="
							+ lati2 + "&longitude=" + longi2,
						async : false,
						type : "GET",
						dataType : "json",
						success : function(data) {
							 var sp="<h2>Available Service Providers for "+servicen+"</h2><table><thead><tr></tr></thead>";
							 $.each(data, function(key, value) {
								// myMap(value.latitude, value.longitude);
								locationsPointSpName.push(value.firstName);
								locationsPointLati.push(value.latitude);
								locationsPointLongi.push(value.longitude);
								locationsPointSpMobile.push(value.mobileNumber);
								showPoint(servicen);
								spstatus=spstatus+1;
								 spId.push(value.spId);
								 spfname.push(value.firstName); 
								 splname.push(value.lastName); 
								 spemail.push(value.email);
								 spmobile.push(value.mobileNumber);
								 spaddress.push(value.address);
								 spservice.push(servicen);
								 spbusinessName.push(value.businessName);
								 spavgrating.push(value.avgrating);
								 spimg.push(value.img);
								 var rr;
								 $.ajax({
										url : "fetchNoOfReview?spId="+value.spId,
										async : false,
										type : "GET",
										dataType : "json",
										success : function(data) {
										rr=data[0];
										spnoofreview.push(rr);
										}
									});
								 sp=sp+"<tr id='myProfileBtn' onclick=onReview("+value.spId+","+spstatus+",'2')><td><img height='100' width='100' src='data:image/jpg;base64,"+value.img+"'/></td><td><h3 style='color: blue'>"+value.businessName+"</h3>";
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
								 sp=sp+"&ensp;"+rr+" Reviews,&ensp;Average Rating: "+value.avgrating+",<br><button onclick=contactmodal("+spstatus+")>View Contact</button>&ensp;&nbsp;&ensp;&nbsp;&ensp;&ensp;&ensp;&ensp;<button id='myReviewBtn' onclick=onReviewBtn("+value.spId+","+spstatus+",'2')>Reviews</button>&ensp;&nbsp;&nbsp;&nbsp;&ensp;&ensp;&nbsp;&nbsp;<button id='myBtn' onclick=onbtn("+value.latitude+","+value.longitude+",'"+String(value.firstName)+"','"+String(value.mobileNumber)+"',"+spstatus+")>Show on Map</button>"
						            +"<br>Open time 10Am and Closed time 8Pm </td></tr>";
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
		  		  }); 
		}
		 spfname=[];
			var splname=[];
		function contactmodal(status){
			ignoreparent=1;
			 $.ajax({
					url : "spContactDetailInsert?spId="+spId[status]+"&latitude="
					+ lati + "&longitude=" + longi,
					async : false,
					type : "Post",
					dataType : "json",
					success : function(data) {
					}
				});
			 contmodal.style.display = "block";
			 var content="<img height='200' width='100%' src='data:image/jpg;base64,"+spimg[status]+"'/><br><br>"+
			 "<center>Person Name : "+spfname[status]+" "+splname[status]+"<br>"+
			 "Mobile Number <br>"+spmobile[status]+
			 "<br><br>Email <br>"+spemail[status]+
			 "<br><br>Address <br>"+spaddress[status]+"</center>";
			 document.getElementById("modal-body7").innerHTML =content;
			 
		}
		var ignoreparent=0;
		function onReview(id,status,ff){
			if(ignoreparent==1){
				ignoreparent=0;
				return 0;
				}
			//alert(spfname[status]+" "+spemail[status]+" "+splname[status]+" "+spmobile[status]+" "+spaddress[status]+" "+spservice[status]+" "+spimg[status]);
		    var Category =  document.getElementById("categoryname").value;

		   rmodal.style.display = "block";
		$.ajax({
			url : "fetchReview?id=" + id,
			async : false,
			type : "POST",
			dataType : "json",
			success : function(data) {
				
				var i=0;
				var content="<h3 style='color: blue;margin-left:36px;'>Category >> "+Category+" >> "+spservice[status]+"</h3>"+
				"<table style=' width: 50%;border: 1px solid black;'><thead><tr></tr></thead><tr><td><img height='110' width='110' src='data:image/jpg;base64,"+spimg[status]+"'/></td><td> <h4 style='color: blue'>"+spbusinessName[status]+"</h4>Average Rating: "+spavgrating[status]+", "+spnoofreview[status]+" Reviews<br>"+
				"Service Provider is : "+spfname[status]+" "+splname[status]+"<br>Open time 10Am and Closed time 8Pm "+
				"</td></tr></table>";
				
				
				var addreview="<div>"+
		        "<input type='button' value='Add Review' id='addReviewBtn' onclick='Review("+id+","+status+","+ff+")'>&ensp;<button onclick=contactmodal("+status+")>View Contact</button>&ensp;<span id='linkoflogger'></span>"+
		        "</div>";
				
				 var maincontent=content;
				content=content+addreview+"<br><table style=' width: 80%;border: 1px solid black;'><tr><th style='padding: 8px;'>User</th><th style='padding: 8px;'>Comment</th><th style='padding: 8px;'>Rating</th></tr>";
				$.each(data, function(key, value) {
					
					//for user Details
					$.ajax({
						url : "fetchUser?userId="+value.userId,
						async : false,
						type : "POST",
						dataType : "json",
						success : function(user){
							 content=content+"<tr><td style='padding: 8px;'>&nbsp;"+user.firstName+" "+user.lastName+"&emsp;&emsp;</td>";
					content=content+"<td style='padding: 8px;'>"+value.review+"</td><td style='padding: 8px;'>";
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
		function onReviewBtn(id,status,ff){
			ignoreparent=1;
			//alert(spfname[status]+" "+spemail[status]+" "+splname[status]+" "+spmobile[status]+" "+spaddress[status]+" "+spservice[status]+" "+spimg[status]);
		    var Category =  document.getElementById("categoryname").value;

		   rmodal.style.display = "block";
		$.ajax({
			url : "fetchReview?id=" + id,
			async : false,
			type : "POST",
			dataType : "json",
			success : function(data) {
				
				var i=0;
				var content="<h3 style='color: blue;margin-left:36px;'>Category >> "+Category+" >> "+spservice[status]+"</h3>"+
				"<table style=' width: 50%;border: 1px solid black;'><thead><tr></tr></thead><tr><td><img height='110' width='110' src='data:image/jpg;base64,"+spimg[status]+"'/></td><td> <h4 style='color: blue'>"+spbusinessName[status]+"</h4>Average Rating: "+spavgrating[status]+", "+spnoofreview[status]+" Reviews<br>"+
				"Service Provider is : "+spfname[status]+" "+splname[status]+"<br>Open time 10Am and Closed time 8Pm "+
				"</td></tr></table>";
				
				
				var addreview="<div>"+
		        "<input type='button' value='Add Review' id='addReviewBtn' onclick='Review("+id+","+status+","+ff+")'>&ensp;<button onclick=contactmodal("+status+")>View Contact</button>&ensp;<span id='linkoflogger'></span>"+
		        "</div>";
				
				 var maincontent=content;
				content=content+addreview+"<br><table style=' width: 80%;border: 1px solid black;'><tr><th style='padding: 8px;'>User</th><th style='padding: 8px;'>Comment</th><th style='padding: 8px;'>Rating</th></tr>";
				$.each(data, function(key, value) {
					
					//for user Details
					$.ajax({
						url : "fetchUser?userId="+value.userId,
						async : false,
						type : "POST",
						dataType : "json",
						success : function(user){
							 content=content+"<tr><td style='padding: 8px;'>&nbsp;"+user.firstName+" "+user.lastName+"&emsp;&emsp;</td>";
					content=content+"<td style='padding: 8px;'>"+value.review+"</td><td style='padding: 8px;'>";
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
		function Review(id,status,ff){
			add_id=id;
			add_status=status;
			add_ff=ff;
			addrevmodal.style.display = "block";
			$.ajax({
				url : "checkUserLogin",
				async : false,
				type : "POST",
				dataType : "json",
				success : function(data){
					if(data!=0){
						var existingreview;
						var existingrating;
						 $.ajax({
		        			url : "fetchUserReview?userId=" + data+"&spId="+id,
		        			async : false,
		        			type : "GET",
		        			dataType : "json",
		        			success : function(data) {
		        				existingreview=data.review;
		        				existingrating=data.rating;
		        			} 
				          });   

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
						
						var addreview="<div>&emsp;&emsp;&emsp;&emsp;<h4 style='color: blue'>"+spbusinessName[status]+"</h4>"+
						"&emsp;<p id='divforrating'></P>";
						
		                addreview=addreview+"<textarea rows='5' cols='50' name='rev' id='rev'>"+
		                "</textarea><br><br>"+ratingcontent+
		                "<br>&emsp;<input type='button' value='Add Review' onclick='addReview("+id+","+data+","+status+","+ff+")'>&emsp;&emsp;Average Rating "+spavgrating[status]+"</div>";
		                var content="";
		               
		                $.ajax({
		        			url : "fetchReview?id=" + id,
		        			async : false,
		        			type : "POST",
		        			dataType : "json",
		        			success : function(data) {
	                      content=content+"<br><table style=' width: 80%;border: 1px solid black;'><tr><th style='padding: 8px;'>User</th><th style='padding: 8px;'>Comment</th><th style='padding: 8px;'>Rating</th></tr>";
		        				$.each(data, function(key, value) {
		              //for user Details
						$.ajax({
							url : "fetchUser?userId="+value.userId,
							async : false,
							type : "POST",
							dataType : "json",
							success : function(user){
						content=content+"<tr><td style='padding: 8px;'>&nbsp;"+user.firstName+" "+user.lastName+"&emsp;&emsp;</td>";
						content=content+"<td style='padding: 8px;'>"+value.review+"</td><td style='padding: 8px;'>";
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
		        	content=content+"</table><br><br><br><br>";
		        	} 
		          });    
						
		      document.getElementById("modal-body3").innerHTML = addreview+""+content;
		      
		      if(existingreview!=undefined){
		        document.getElementById("rev").defaultValue = existingreview;
		        
		        var content="";
		        var s=0;
				 for(var r=1;r<=5;r++){
	                if(r<=existingrating){
	                	content=content+"<span class='fa fa-star checked' style='font-size:20px;color:orange'></span>";
	                }else{
	             	   if((r-1)==existingrating){
	             		   s=1;
	             	   }
	             	   if(s==1){
	             		  content=content+"<span class='fa fa-star' style='font-size:20px;color:Gainsboro'></span>";
	             	   }
	             	   if(s==0){
	             		   if((existingrating>=((r-1)+.3))&&(existingrating<=((r-1)+.8))){
	             			  content=content+"<i class='fa fa-star-half-full' style='font-size:20px;color:orange'></i>";
	             		   }if(existingrating<((r-1)+.3)){
	             			  content=content+"<span class='fa fa-star' style='font-size:20px;color:Gainsboro'></span>";
	             		   }if(existingrating>((r-1)+.8)){
	             			  content=content+"<span class='fa fa-star checked' style='font-size:20px;color:orange'></span>";
	             		   }
	             		   s=1;
	             	   }
	                }
					}
		        
		        document.getElementById("divforrating").innerHTML = "Edit Your Review and Rating ..<br>"+content;
		        }
					}
					if(data==0){
						alert("first you have to login....");
						addrevmodal.style.display = "none";
						loginModal('logininrev');
					}
				}
			});
		}
		var statusafterfetchsp=0;
		function addReview(spid,userid,status,ff){
			statusafterfetchsp=1;
			var rating=ratingcheck();
			var rev=document.getElementById("rev").value;
			$.ajax({
				url : "addReview?review="+rev+"&spId="+spid+"&userId="+userid+"&rating="+rating,
				async : false,
				type : "POST",
				dataType : "json",
				success : function(data){
					alert(data);
					addrevmodal.style.display = "none";
					 rmodal.style.display = "none";
 					 if(ff==1){
						fetchPoint();
					}if(ff==2){
						fetchPointbyarea();
					}
				}
			});
		}
		function onbtn(lati,longi,fname,m,spstatus){
			ignoreparent=1;
			modal.style.display = "block";
			document.getElementById("addressinmap").innerHTML =spbusinessName[spstatus]+", Address : "+spaddress[spstatus];
				
			var map = new google.maps.Map(document.getElementById('mapinmodal'), {
		          zoom: 10,
		          center: {lat: lati, lng: longi}
		        }); 
			 var geocoder = new google.maps.Geocoder;
			 var infowindow = new google.maps.InfoWindow;
			geocodeLatLng2(geocoder, map, infowindow,lati,longi);
			myMap2(lati,longi,fname,m);
			
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
			/* marker.setMap(map); */
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

		
	</script>
</body>
</html>