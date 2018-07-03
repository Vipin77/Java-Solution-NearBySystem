
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<script src="./resources/js/bootstrap.min.js"></script>
 <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    

<script type="text/javascript">
function fetchServices(cid)
{
	


	$('#existingServices').find("option").remove();
	$.ajax({
		url : "fetchServices?cid=" + cid,
		async : false,
		data : {
			cid : cid
		},
		type : "GET",
		dataType : "json",
		success : function(data) {
			$.each(data, function(key, value) {
				
				$('#existingServices').append($("<option></option>").attr('value', value).text(value));
			});

		}
	});
	
	
	
	}
</script>


<!--**********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->


<section id="main-content">

	<section class="wrapper">
		<h4>
			<i class="fa fa-angle-right"></i> Add SubCategory
		</h4>
		<strong><h2>${message}</h2></strong>
		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">

					<form:form id="myPlanForm" class="form-horizontal style-form"
						action="storeSubCategory" method="post" cammandName="plan">


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">CategoryType</label>
							<div class="col-sm-10">
								<select class="form-control" onChange="fetchServices(this.value)" name="categorytype"
									required="required">
									<option></option>
									<c:forEach var="type" items="${listOfType}">
										<option value="${type.getCategoryId()}">${type.getCategoryType()}</option>

									</c:forEach>

								</select>
							</div>
						</div>

				<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Existing Services</label>
							<div class="col-sm-10">
								<select class="form-control" id="existingServices">
									<option></option>
								</select>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">New Service </label>
							<div class="col-sm-10">
								<input type="text" name="subType" class="form-control"
									required="required">
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Type</label>
							<div class="col-sm-10">
								<select class="form-control" name="type" required="required">
									<option value="mobile">Mobile</option>
									<option value="static">Static</option>


								</select>
							</div>
						</div>



						<div class="form-group">
							<div class="col-sm-10">
								<center>
									<input type="submit" class="form-submit" value="Add"
										onclick="return confirm('Are you sure you want to add category');">
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
