<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>Portal Page</title>
    
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
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
  </head>

  <body>
  
  <section id="container" >
      <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      <header class="header black-bg">
              <div class="sidebar-toggle-box">
                  <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
              </div>
            <!--logo start-->
            <a href="#" class="logo"><b>Job Portal</b></a>
            <!--logo end-->
            <div class="nav notify-row" id="top_menu">
            </div>
          
           <div class="top-menu">
            	<ul class="nav pull-right top-menu">
                    <li><a class="logout" href="logoutPortal" onclick="return confirm('Are you sure you want to logout');">Logout</a></li>
            	</ul>
            </div>
        </header>
      <!--header end-->
      
       
      <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <ul class="sidebar-menu" id="nav-accordion">
              
              	  <p class="centered"><img src="./resources/static/img/nearby.png" class="img-circle" width="100"></p>
              	
              	  	
                  <li class="mt">
                      <a class="active" href="portalHomeEmployee">
                          <i class="fa fa-dashboard"></i>
                          <span>Dashboard</span>
                        
                      </a>
                  </li>

                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-desktop"></i>
                          <span>Job Master</span>
                      </a>
                      <ul class="sub">
                      
                          <li>
                           <form name="submitForm" method="POST" action="availableJob">
    <input type="hidden" name="userId" value="<%=session.getAttribute("userId")%>">
    <A HREF="javascript:document.submitForm.submit()">Available Job</A>
      </form>
                          </li>
                           
                          <li><a  href="#">Search Job</a></li>
                      </ul>
                  </li>
              </ul>
          </div>
      </aside>
      