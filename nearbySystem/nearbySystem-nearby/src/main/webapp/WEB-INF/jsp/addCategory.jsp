   <%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

              
              <script src="./resources/js/jquery-1.11.0.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>


      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
   

		<section id="main-content">
	
			<section class="wrapper">
				<h4>
					<i class="fa fa-angle-right"></i> Add Category
				</h4>
        		<strong><h2>${message}</h2></strong>
				<!-- BASIC FORM ELELEMNTS -->
				<div class="row mt">
					<div class="col-lg-12">
						<div class="form-panel">
			
							<form:form  id="myPlanForm" class="form-horizontal style-form" action="storeCategory" method="post" cammandName="plan">
								
								
								
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Existing CategoryType</label>
							<div class="col-sm-10">
								<select class="form-control" name="categoryId"
									>
									<option></option>
									<c:forEach var="type" items="${listOfType}">
										<option value="${type.getCategoryId()}">${type.getCategoryType()}</option>

									</c:forEach>

								</select>
							</div>
						</div>
								
								
								
								<div class="form-group">
									<label class="col-sm-2 col-sm-2 control-label">Add New Category</label>
									<div class="col-sm-10">
										<input type="text" name="type" class="form-control" required="required">				</div>
								</div>

								

								<div class="form-group">
									<div class="col-sm-10">
									<center><input type="submit" class="form-submit" value="Add" onclick="return confirm('Are you sure you want to add category');">
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
      
