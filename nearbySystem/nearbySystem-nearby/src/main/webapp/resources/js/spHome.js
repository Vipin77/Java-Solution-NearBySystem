function fetchspfun(){
	var spId = document.getElementById("spDtoId").value;
	$.ajax({
		url : "fetchsp?spId=" +spId ,
		async : false,
		type : "POST",
		dataType : "json",
		success : function(data) {
			document.getElementById("spDtoName").innerHTML = data.firstName; 
			document.getElementById("spDtoEmail").innerHTML = "Email : "+data.email; 
			document.getElementById("spDtoimg").innerHTML = "<img height='60' width='60' src='data:image/jpg;base64,"+data.img+"'/>"; 
		} 
	});
	
}