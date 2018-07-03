   <%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
        <%@ page session="false" %>
              
              
              <script src="./resources/js/jquery-1.11.0.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>



<script>


var countList = '<%=request.getAttribute("countList")%>';



$(document)
.ready(
		function() {
			jQuery.support.cors = true;
			
					$.ajax({
						type : "GET",
						url : './getCounts',
						contentType : "application/json",
						
						success:function(data){
							document.getElementById("enquiryCount").innerHTML=data[0];
							document.getElementById("planCount").innerHTML=data[1];
							document.getElementById("memberCount").innerHTML=data[2];
						}
						})
		})

</script>
     
      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
     <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
<h4>
					<i class="fa fa-angle-right"></i> Dashboard
				</h4>

              <div class="row">
                  <div class="col-lg-9 main-chart">
                  
              
                  	
                  	
                  	
                  
                      
                   </div>  </div>
                    				
				
    
                      
                      
           
          </section>
      </section>

      <!--main content end-->
      
