
var countryStateInfo = {
		"India": {
			"Assam": {
				"Dispur": [],
				"Guwahati" : []
			},
			"Gujarat": {
				"Vadodara" : [],
				"Surat" : []
			},
			"Madhya Pradesh": {
				"Indore" : [],
				"Dewas" : [],
				"Ujjain":[]
			}
		}
	}

var countr = document.getElementById("country");
	function fun() {
		//Get html elements
		var countySel = document.getElementById("country");
		var stateSel = document.getElementById("state");	
		var citySel = document.getElementById("city");
		//Load countries
		for (var country in countryStateInfo) {
			countySel.options[countySel.options.length] = new Option(country, country);
		}
		//County Changed
		countySel.onchange = function () {
			 stateSel.length = 1; // remove all options bar first
			 citySel.length = 1; // remove all options bar first
			 if (this.selectedIndex < 1)
				 return; // done
			 for (var state in countryStateInfo[this.value]) {
				 stateSel.options[stateSel.options.length] = new Option(state, state);
			 }
		}
		//State Changed
		stateSel.onchange = function () {		 
			 citySel.length = 1; // remove all options bar first
			 if (this.selectedIndex < 1)
				 return; // done
			 for (var city in countryStateInfo[countySel.value][this.value]) {
				 citySel.options[citySel.options.length] = new Option(city, city);
			 }
		}
	}

	function fetchServices(cid) {

		$('#existingServices').find("option").remove();
		$.ajax({
			url : "fetchServicesForUser?cid=" + cid,
			async : false,

			type : "GET",
			dataType : "json",
			success : function(data) {
				document.getElementById("existingServices").innerHTML = "<option value=''>Select</option>";
				$.each(data, function(key, value) {

					$('#existingServices').append(
							$(
									"<option ></option>").attr('value',
									value).text(value));
				});

			}
		});

	}
	