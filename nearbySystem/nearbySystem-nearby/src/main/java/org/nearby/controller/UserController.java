package org.nearby.controller;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.nearby.dao.UserDao;
import org.nearby.dto.Registration;
import org.nearby.dto.ResponseClass;
import org.nearby.dto.ServiceProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class UserController {

	@Autowired
	private UserDao userDao;

	@RequestMapping(value = "/registerUser", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ResponseClass> registerUser(@RequestBody Registration userRegistration) {

		try {
			userDao.storeSp(userRegistration);

			ResponseClass response = new ResponseClass();
			response.setCode(200);
			response.setError(false);
			response.setMessage("User registered successfully");

			return new ResponseEntity<ResponseClass>(response, HttpStatus.OK);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			ResponseClass response = new ResponseClass();
			response.setCode(401);
			response.setError(true);
			response.setMessage("Invalid request");

			return new ResponseEntity<ResponseClass>(response, HttpStatus.BAD_REQUEST);

		}

	}
	
	@RequestMapping(value = "/fetchEmail")
	public ResponseEntity<List<String>> fetchEmail() {

		List<String> mail = userDao.fetchAllEmail();
		return new ResponseEntity<List<String>>(mail,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/fetchMobile")
	public ResponseEntity<List<String>> fetchMobile() {

		List<String> mobile = userDao.fetchAllMobile();
		return new ResponseEntity<List<String>>(mobile,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/fetchServices", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<String>> fetchServices(HttpServletRequest request) {

		String cid = request.getParameter("cid");

		List<String> allService = userDao.fetchAllServices(Integer.parseInt(cid));

		System.out.println("CONTROLLER CALL  " + allService);

		return new ResponseEntity<List<String>>(allService, HttpStatus.OK);

	}

	@RequestMapping(value = "/fetchServicesForUser", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<String>> fetchServicesForUser(HttpServletRequest request) {

		String cid = request.getParameter("cid");

		List<String> allService = userDao.fetchAllServicesForUser(Integer.parseInt(cid));

		return new ResponseEntity<List<String>>(allService, HttpStatus.OK);

	}

	
	
	
	@RequestMapping(value = "/fetchLocationOfsp", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ServiceProvider>> fetchLocationOfsp(HttpServletRequest request) throws SQLException{

		String service = request.getParameter("service");
		String latitude = request.getParameter("latitude");
		String longitude = request.getParameter("longitude");
		System.out.println(service+" "+latitude+" "+longitude);
		List<ServiceProvider> allServices = userDao.fetchSPLocation(service, latitude, longitude);

		for(ServiceProvider s:allServices){
			Blob blob = s.getProfile();
			int blobLength = (int) blob.length();  
			byte[] blobAsBytes = blob.getBytes(1, blobLength);
			s.setImg(blobAsBytes);
			s.setProfile(null);
		}
		return new ResponseEntity<List<ServiceProvider>>(allServices,HttpStatus.OK);

	}
	
}
