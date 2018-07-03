<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<script>
function fetchSubCategory(catId){
	

$('#jobSubCat').find("option").remove();
$.ajax({
	url : "fetchJobCategory?cid=" + catId,
	async : false,

	type : "GET",
	dataType : "json",
	success : function(data) {
		$.each(data, function(key, value) {

			$('#jobSubCat').append(
					$(
							"<option ></option>").attr('value',
							value).text(value));
		});

	}
});

}

</script>

<section id="main-content">
	<section class="wrapper">

		<h4>
			<i class="fa fa-angle-right"></i>JOB POST
			
		</h4>
		<strong><h2>${message}</h2></strong>
		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">

					<form:form id="myPlanForm" class="form-horizontal style-form"
						action="storeJobPost" method="post" cammandName="JobMaster">



<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Job Category</label>
							<div class="col-sm-10">
								<select class="form-control" name="jobCategory"  onchange="fetchSubCategory(this.value)">
									
									 <c:forEach var="jobObj" items="${listOfJobsCategory}" >
									 <option value="${jobObj.getJobCategoryId()}">${jobObj.getJob()}</option>
                             </c:forEach>
								</select>
							</div>
						</div>
<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Job Sub Category</label>
							<div class="col-sm-10">
								<select class="form-control" name="jobSubCategory" id="jobSubCat">
								<option></option>
									
								</select>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Job Title</label>
							<div class="col-sm-10">
								<input type="text" name="jobTitle" class="form-control"
									required="required">
							</div>
						</div>
					
<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Age Limit</label>
							<div class="col-sm-10">
								<select class="form-control" name="age" required="required">
								<option >Select</option>
									<option value="20-25">20 - 25</option>
									<option value="25-30">25 - 30</option>
									<option value="30-40">30 - 40</option>
									<option value="40-60">40 - 60</option>
								</select>
							</div>
						</div>




	<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<input type="radio" name="gender" value="male"
									required="required"> Male &nbsp&nbsp&nbsp&nbsp&nbsp
										<input type="radio" name="gender" value="female" 
									>Female
							</div>
						</div>


	<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Salary</label>
							<div class="col-sm-10">
								<input type="number" name="salary" class="form-control"
									required="required">
							</div>
						</div>

<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Type</label>
							<div class="col-sm-10">
								<input type="radio" name="type" value="daily"
									required="required"> Daily &nbsp&nbsp&nbsp&nbsp&nbsp
										<input type="radio" name="type" value="monthly" 
									>Monthly
							</div>
						</div>

					

	<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Address</label>
							<div class="col-sm-10">
								<input type="text" name="address" class="form-control"
									required="required">
							</div>
						</div>


	<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Job Description</label>
							<div class="col-sm-10">
								
									<textarea rows="5" cols="35" name="jobDescription" class="form-control"></textarea>
							</div>
						</div>

						
				

						<div class="form-group">
							<div class="col-sm-10">
								<center>
									<input type="submit" class="form-submit" value="SUBMIT"
										onclick="return confirm('Are you sure you want to submit');">
										&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
										<a href="postJob" onclick="return confirm('Are you sure you want to reset');">Reset</a>
								</center>
							</div>
						</div>



					</form:form>
				</div>
			</div>
			<!-- col-lg-12-->
		</div>
		<!-- /row -->


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
                                  <td>
                                    	<a href="editPostedJob?jobId=${jobObj.getJobId()}" class="btn btn-primary btn-xs" >Edit</a> 
                                     <a href="deletePostedJob?jobId=${jobObj.getJobId()}" class="btn btn-danger btn-xs" onclick="return confirm('Are you sure you want to delete job');">Delete</a>
                                  </td>
                              </tr>
                       		</c:forEach>
                              </tbody>
                          </table>
                      </div><!-- /content-panel -->
                  </div><!-- /col-md-12 -->
              </div><!-- /row -->


	</section>
</section>

<!--main content end-->



