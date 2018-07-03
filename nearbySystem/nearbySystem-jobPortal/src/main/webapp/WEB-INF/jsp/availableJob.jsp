<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<section id="main-content">
	 <section class="wrapper">
	   <c:if test="${fn:length(listOfJobs) lt 1}">
   <h2><p>Currently Jobs are Not Available for You</p></h2>
</c:if>
          <c:if test="${fn:length(listOfJobs) gt 0}">
		 <div class="row mt">
                  <div class="col-md-12">
                  <div class="content-panel">
             <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> Available Jobs</h4>
	                  	  	  <hr>
                              <thead>
                              <tr>
                                  <th>JobId</th>
                                  <th class="hidden-phone">Title</th>
                                  <th> Post Date</th>
                                  <th> JOb Description</th>
                              </tr>
                              </thead>
                              <tbody>
                              <c:forEach var="jobObj" items="${listOfJobs}" >
                              <tr>
                                  <td>${jobObj.getJobId()}</td>
                                  <td >${jobObj.getJobTitle()}</td>
                                  <td>${jobObj.getCreatedDate()}</td>
                                     <td>${jobObj.getJobDescription()}</td>
                              </tr>
                       		</c:forEach>
                              </tbody>
                          </table>
                      </div><!-- /content-panel -->
                  </div><!-- /col-md-12 -->
              </div><!-- /row -->
</c:if>
	</section>
</section>
<!--main content end-->
</body>
</html>