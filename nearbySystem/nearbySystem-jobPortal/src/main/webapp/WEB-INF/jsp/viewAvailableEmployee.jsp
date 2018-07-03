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
<script>
function fetchSubCategory(catId){
	

$('#jobSubCat').find("option").remove();
$.ajax({
	url : "fetchJobCategory?cid=" + catId,
	async : false,

	type : "GET",
	dataType : "json",
	success : function(data) {
		
		document.getElementById("jobSubCat").innerHTML = "<option value=''>Select</option>";
		$.each(data, function(key, value) {
			$('#jobSubCat').append(
					$(      
							"<option value='"+value+"'></option>").attr('value',
							value).text(value));
		});

	}
});

}
function fetchEmployee(subCatValue){

	$.ajax({
		url : "fetchAvailableEmployee?subCatValue=" + subCatValue,
		async : false,

		type : "GET",
		dataType : "json",
		success : function(data) {
			
			if(data.length>0){
			var empprint="<div class='row mt'><div class='col-md-12'><div class='content-panel'>"+
	    	"<table class='table table-striped table-advance table-hover'><thead><tr><th>EmployeeId</th>  <th>Name</th>  <th> JOb Needed</th>  </tr></thead>";
		 
			$.each(data, function(key, value) {
		   empprint=empprint+"<tr><td>"+value.employeeId+"</td><td>"+value.firstName+"</td><td>"+value.jobNeeded+"</td></tr>";
			});
			empprint=empprint+"</table> </div> </div> </div>";
			document.getElementById("tableofemp").innerHTML = empprint;  
		  
		}
			if(data.length==0){
				document.getElementById("tableofemp").innerHTML = "<br><h2 align='center'>Employee Not Available</h2>"; 
			}
		}
	});

	}
</script>

<body>
<section id="main-content">
	 <section class="wrapper">
	  <div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
	  View Available Employee
	  
	  <form:form id="myPlanForm" class="form-horizontal style-form"
						action="storeJobPost" method="post" cammandName="JobMaster">



<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Job Category</label>
							<div class="col-sm-10">
								<select class="form-control" name="jobCategory"  onclick="fetchSubCategory(this.value)">
									<option value="">Select</option>
									 <c:forEach var="jobObj" items="${listOfJobsCategory}" >
									 <option value="${jobObj.getJobCategoryId()}">${jobObj.getJob()}</option>
                             </c:forEach>
								</select>
							</div>
						</div>
<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Job Sub Category</label>
							<div class="col-sm-10">
								<select class="form-control" name="jobSubCategory" id="jobSubCat" onchange="fetchEmployee(this.value)">
								<option></option>
									
								</select>
							</div>
						</div>
						</form:form>
						</div><!-- /content-panel -->
                  </div><!-- /col-md-12 -->
              </div><!-- /row -->
               
          <div id="tableofemp"></div>
	</section>
</section>
<!--main content end-->
</body>
</html>