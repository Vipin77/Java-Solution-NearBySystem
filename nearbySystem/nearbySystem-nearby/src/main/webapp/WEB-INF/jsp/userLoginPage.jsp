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

    <title>LoginPage</title>

    <!-- Bootstrap core CSS -->
    <link href="./resources/static/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="./resources/static/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="./resources/static/css/style.css" rel="stylesheet">
    <link href="./resources/static/css/style-responsive.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <style>
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
    
  </head>

  <body>
  
<div class="navbar1" style=" background-color: #333;">
       <a style="float: right;" href="userRegistration">Registration</a>
       <a style="float: right;" href="user">Home</a>
      </div>
      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<br><br><br><br><br><br>
	  <div id="login-page">
	  	<div class="container">
	  	
		      <form:form class="form-login" action="userloginVerify" method="post" commandName="login">
		        <h2 class="form-login-heading">User Login</h2>
		           <center> <span>${message}</span></center>
		        <div class="login-wrap">
		            <input type="text" class="form-control-login" name="userName" placeholder="Mobile Number" autofocus>
		            <br>
		            <input type="password" class="form-control-login"  name="password" placeholder="Password">
		            <label class="checkbox">
		            </label>
		            <button class="btn btn-theme btn-block" type="submit"><i class="fa fa-lock"></i> SIGN IN</button>
		        </div>
		</form:form>
	  	</div>
	  </div>

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
    