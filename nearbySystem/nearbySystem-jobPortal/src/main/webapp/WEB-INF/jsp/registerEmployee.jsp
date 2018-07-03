    <!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>SignUp Page</title>

    <!-- Bootstrap core CSS -->
    <link href="./resources/static/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="./resources/static/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="./resources/static/css/style.css" rel="stylesheet">
    <link href="./resources/static/css/style-responsive.css" rel="stylesheet">



<script src="./resources/js/jquery-1.11.0.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>

 <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
<script type="text/javascript">

function copyAddress()
{

	var address= document.getElementById("address").value;
	document.getElementById("address2").value =address;
	 
	}

</script>


  </head>

  <body>




<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->


<section id="main-content">

							

	<section class="wrapper">

		<h4>
			<i class="fa fa-angle-right"></i>Employee Registration
			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<a href="portalLoginPage" >Login</a>
		</h4>
		<strong><h2>${message}</h2></strong>
		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">

					<form:form id="myPlanForm" class="form-horizontal style-form"
						action="storeEmployee" method="post" cammandName="employeeDto">

<h4>
			<i class="fa fa-angle-right"></i>Personal Details
		
		</h4>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">First Name</label>
							<div class="col-sm-10">
								<input type="text" name="firstName" class="form-control"
									required="required">
							</div>
						</div>

		<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Last Name</label>
							<div class="col-sm-10">
								<input type="text" name="lastName" class="form-control"
									required="required">
							</div>
						</div>

<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Father Name</label>
							<div class="col-sm-10">
								<input type="text" name="fatherName" class="form-control"
									required="required">
							</div>
						</div>

<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<input type="radio" name="gender"  value="male" 
									required="required"> Male &nbsp&nbsp&nbsp <input type="radio" name="gender" value="female" 
									>Female &nbsp&nbsp&nbsp <input type="radio" name="gender"  value="other"
									>Other
							</div>
						</div>




						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Mobile No</label>
							<div class="col-sm-10">
								<input type="text" name="mobileNumber" class="form-control"
									required="required">
							</div>
						</div>



	<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">DOB</label>
							<div class="col-sm-10">
								<input type="date" name="dob" class="form-control"
									required="required">
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									required="required">
							</div>
						</div>



						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Contact Address</label>
							<div class="col-sm-10">
								<input type="text" name="ContactAddress" id="address" class="form-control"
									required="required">
							</div>
						</div>

						<div class="form-group">
						<input type="checkbox" onclick="copyAddress()" >Same as contact address
							<label class="col-sm-2 col-sm-2 control-label">Permanent Address</label>
							<div class="col-sm-10">
								<input type="text" name="permanentAddress" id="address2" class="form-control"
									>
							</div>
						</div>

	<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Password</label>
							<div class="col-sm-10">
								<input type="password" name="password"  class="form-control"
									required="required">
							</div>
						</div>


<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Marital Status </label>
							<div class="col-sm-10">
								<input type="radio" name="maritalStatus"  value="Married" 
									required="required"> Married &nbsp&nbsp&nbsp <input type="radio" name="maritalStatus" value="UnMarried" 
									>UnMarried &nbsp&nbsp&nbsp <input type="radio" name="maritalStatus"  value="Widow" 
									>Widow
							</div>
						</div>

	<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Number Of Children</label>
							<div class="col-sm-10">
								<input type="number" name="noOfChild" class="form-control"
									>
							</div>
						</div>


		<h4>
			<i class="fa fa-angle-right"></i>Education Details
		
		</h4>	
					
					<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Qualification</label>
							<div class="col-sm-10">
								
									<select class="form-control" name="educationDetails">
									
									<option value="10th">10th</option>
									<option value="12th">12th</option>
									<option value="Graduation">Graduation</option>
									<option value="Post Graduation">Post Graduation</option>
									
																		
																		
									</select>
							</div>
						</div>
					
					<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Passing Year</label>
							<div class="col-sm-10">
								<input type="text" name="year" class="form-control"
									>
							</div>
						</div>
					
					
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Job Needed</label>
							<div class="col-sm-10">
								<input type="text" name="jobNeeded" class="form-control"
									>
							</div>
						</div>
						
							<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label"> Salary Expectation </label>
							<div class="col-sm-10">
								<input type="text" name="salaryExpectation" class="form-control"
									>
							</div>
						</div>
				
		<h4>
			<i class="fa fa-angle-right"></i>KYC Details
		
		</h4>	
					
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label"> Aadhar No/Voter Id/PAN No </label>
							<div class="col-sm-10">
								<input type="text" name="identityProof" class="form-control"
									>
							</div>
						</div>
				
					
						

		

						
				

						<div class="form-group">
							<div class="col-sm-10">
								<center>
									<input type="submit" class="form-submit" value="SUBMIT"
										onclick="return confirm('Are you sure you want to submit');">
										&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
										<a href="portalLoginPage" onclick="return confirm('Are you sure you want to cancel');">Cancel</a>
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

<!--main content end-->











    <!-- js placed at the end of the document so the pages load faster -->
    <script src="./resources/static/js/jquery.js"></script>
    <script src="./resources/static/js/bootstrap.min.js"></script>

    <!--BACKSTRETCH-->
    <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
    <script type="text/javascript" src="./resources/static/js/jquery.backstretch.min.js"></script>
    <script>
        $.backstretch("./resources/static/img/", {speed: 500});
    </script>


  </body>
</html>
    