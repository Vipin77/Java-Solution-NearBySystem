package org.nearby.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.nearby.dao.UserDao;
import org.nearby.dto.EmployeeRegistration;
import org.nearby.dto.JobMaster;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PortalRestController {

	@Autowired
	private UserDao userDao;
	
	@RequestMapping(value = "/fetchJobCategory", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<String>> fetchServicesForUser(HttpServletRequest request) {

		String cid = request.getParameter("cid");

		List<String> allJobs = userDao.fetchAllSubCategory(Integer.parseInt(cid));

		return new ResponseEntity<List<String>>(allJobs, HttpStatus.OK);

	}
	
	@RequestMapping(value = "/fetchAvailableEmployee", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<EmployeeRegistration>> fetchAvailableEmployee(HttpServletRequest request) {

		String subCatValue = request.getParameter("subCatValue");
		
		List<EmployeeRegistration> availableEmp = userDao.fetchAvailableEmployee(subCatValue);
		return new ResponseEntity<List<EmployeeRegistration>>(availableEmp, HttpStatus.OK);

	}

	
	
	
	
	
}
