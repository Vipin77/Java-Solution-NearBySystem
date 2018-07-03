<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<section id="main-content">
	<section class="wrapper">

		<h4>
			<i class="fa fa-angle-right"></i>EDIT POSTED JOB

		</h4>
		<strong><h2>${message}</h2></strong>
		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">

					<form:form id="myPlanForm" class="form-horizontal style-form"
						action="updatePostedJob" method="post" cammandName="JobMaster">


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Job Title</label>
							<div class="col-sm-10">
								<input type="text" name="jobTitle"
									value="${jobObject.getJobTitle()}" class="form-control">
								<input type="hidden" name="jobId"
									value="${jobObject.getJobId()}">
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Age Limit</label>
							<div class="col-sm-10">
								<select class="form-control" name="age" required="required">
									<option value="${jobObject.getAge()}">${jobObject.getAge()}</option>
									<option value="20-25">20 - 25</option>
									<option value="25-30">25 - 30</option>
									<option value="30-40">30 - 40</option>
									<option value="40-60">40 - 60</option>
								</select>
							</div>
						</div>

						<!-- <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<input type="radio" name="gender" value="male"
									required="required"> Male &nbsp&nbsp&nbsp&nbsp&nbsp
										<input type="radio" name="gender" value="female" 
									>Female
							</div>
						</div> -->

						<input type="hidden" name="gender"
							value="${jobObject.getGender()}">


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Salary</label>
							<div class="col-sm-10">
								<input type="number" name="salary" class="form-control"
									value="${jobObject.getSalary()}">
							</div>
						</div>

						<!-- <div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Type</label>
							<div class="col-sm-10">
								<input type="radio" name="type" value="daily"
									required="required"> Daily &nbsp&nbsp&nbsp&nbsp&nbsp
										<input type="radio" name="type" value="monthly" 
									>Monthly
							</div>
						</div> -->
						<input type="hidden" name="type" value="${jobObject.getType()}">


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Address</label>
							<div class="col-sm-10">
								<input type="text" name="address"
									value="${jobObject.getAddress()}" class="form-control"
									required="required">
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Job
								Description</label>
							<div class="col-sm-10">

								<input type="text" name="jobDescription"
									value="${jobObject.getJobDescription()}" class="form-control"
									required="required">


							</div>
						</div>




						<div class="form-group">
							<div class="col-sm-10">
								<center>
									<input type="submit" class="form-submit" value="UPDATE"
										onclick="return confirm('Are you sure you want to Update');">
									&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <a href="postJob"
										onclick="return confirm('Are you sure you want to cancel');">Cancel</a>
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



