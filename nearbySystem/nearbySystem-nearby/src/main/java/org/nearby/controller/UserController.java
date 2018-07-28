package org.nearby.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nearby.dao.AddressConverter;
import org.nearby.dao.UserDao;
import org.nearby.dto.CategoryType;
import org.nearby.dto.Registration;
import org.nearby.dto.ResponseClass;
import org.nearby.dto.ReviewDto;
import org.nearby.dto.ServiceProvider;
import org.nearby.dto.UserDto;
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
		return new ResponseEntity<List<String>>(mail, HttpStatus.OK);
	}

	@RequestMapping(value = "/fetchMobile")
	public ResponseEntity<List<String>> fetchMobile() {

		List<String> mobile = userDao.fetchAllMobile();
		return new ResponseEntity<List<String>>(mobile, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/fetchUserMobile")
	public ResponseEntity<List<String>> fetchUserMobile() {

		List<String> mobile = userDao.fetchAllUserMobile();
		return new ResponseEntity<List<String>>(mobile, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/fetchUserEmail")
	public ResponseEntity<List<String>> fetchUserEmail() {

		List<String> mail = userDao.fetchAllUserEmail();
		return new ResponseEntity<List<String>>(mail, HttpStatus.OK);
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

	@RequestMapping(value = "/fetchServiceName", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<String>> fetchServiceName(HttpServletRequest request) {

		String cid = request.getParameter("cid");

		List<String> allService = userDao.fetchServiceName(Integer.parseInt(cid));

		return new ResponseEntity<List<String>>(allService, HttpStatus.OK);

	}
	
	@RequestMapping(value = "/fetchCategoryName", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<String>> fetchCategoryName(HttpServletRequest request) {
		String cid = request.getParameter("cid");
		List<String> allService = userDao.fetchCategoryName(Integer.parseInt(cid));
		return new ResponseEntity<List<String>>(allService, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/fetchLocationOfsp", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ServiceProvider>> fetchLocationOfsp(HttpServletRequest request)
			throws SQLException, IOException {

		String serviceid = request.getParameter("service");
		String latitude = request.getParameter("latitude");
		String longitude = request.getParameter("longitude");
		/*String area = request.getParameter("area");
		String city = request.getParameter("city");
		String state = request.getParameter("state");*/

		System.out.println(serviceid + " " + latitude + " " + longitude);

		/*if (area != null) {
			System.out.println(area + " " + city + " " + state + " India");
			final List<String> latOrLong = AddressConverter.getLatorLong(area + "," + city + "," + state + ",India");
			latitude = latOrLong.get(0);
			longitude = latOrLong.get(1);
		}*/

		List<ServiceProvider> allServices = userDao.fetchSPLocation(serviceid, latitude, longitude);

		for (ServiceProvider s : allServices) {
			Blob blob = s.getProfile();
			int blobLength = (int) blob.length();
			byte[] blobAsBytes = blob.getBytes(1, blobLength);
			s.setImg(blobAsBytes);
			s.setProfile(null);
		}
		return new ResponseEntity<List<ServiceProvider>>(allServices, HttpStatus.OK);
	}

	
	@RequestMapping(value = "/userloginVerify", method = RequestMethod.POST)
	public ResponseEntity<List<String>> userloginVerify(HttpServletRequest servletRequest) {

		String mobile = servletRequest.getParameter("userName");

		String pass = servletRequest.getParameter("password");

		UserDto uDto=userDao.fetchUser(mobile, pass);
		List<String> s=new ArrayList<String>();
		if(uDto!=null){
			HttpSession session = servletRequest.getSession(true);
			session.setAttribute("userId",uDto.getUserId());
			session.setAttribute("userfName",uDto.getFirstName());
			s.add(String.valueOf(uDto.getUserId()));
			s.add(uDto.getFirstName());
			return new ResponseEntity<List<String>>(s,HttpStatus.OK);
		}
		s.add("0");
		return new ResponseEntity<List<String>>(s,HttpStatus.OK);
	}
	
	@RequestMapping(value="/addReview",method=RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<String>> addReview(HttpServletRequest request){
		
		String review=request.getParameter("review");
		int userId=Integer.parseInt(request.getParameter("userId"));
		int spId=Integer.parseInt(request.getParameter("spId"));
		double rating=Double.parseDouble(request.getParameter("rating"));
		
		int result=userDao.addReview(spId, review,userId,rating);
		String message="";
		if(result==1){
			message="Review Succesfully Added";
		}else{
			message="Adding Review is Failed";
		}
		List<String> s=new ArrayList<String>();
		s.add(message);
		
		return new ResponseEntity<List<String>>(s,HttpStatus.OK);
	}
	
	@RequestMapping(value="/checkUserLogin",method=RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Integer>> checkUserLogin(HttpServletRequest request){
		
		Object value= request.getSession().getAttribute("userId");
		int message=0;
		System.out.println("Available sessionid "+value);
		List<Integer> s=new ArrayList<Integer>();
		if(value==null){
	    message=0;
		s.add(message);
		return new ResponseEntity<List<Integer>>(s,HttpStatus.OK);
		}
		message=(Integer) value;
		s.add(message);
		return new ResponseEntity<List<Integer>>(s,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/spContactDetailInsert", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Integer>> spContactDetailInsert(HttpServletRequest request) {
		String spId = request.getParameter("spId");
		String latitude = request.getParameter("latitude");
		String longitude = request.getParameter("longitude");
		if(latitude==null){
			latitude ="";
			longitude="";
		}
		HttpSession session = request.getSession(false);
		System.out.println("User id =  "+session.getAttribute("userId"));
		Object s1=session.getAttribute("userId");
		
		System.out.println(latitude+" "+longitude);
		int result= userDao.insertContactDetail(Integer.parseInt(spId),latitude,longitude,String.valueOf(s1));
		List<Integer> s=new ArrayList<Integer>();
		s.add(result);
		return new ResponseEntity<List<Integer>>(s, HttpStatus.OK);
	}
	
	
	@RequestMapping(value = "/fetchNoOfReview", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Integer>> fetchNoOfReview(HttpServletRequest request) {
		String spId = request.getParameter("spId");
		int result =userDao.fetchNoOfReview(Integer.parseInt(spId));
		List<Integer> s=new ArrayList<Integer>();
		s.add(result);
		return new ResponseEntity<List<Integer>>(s, HttpStatus.OK);

	}
	
	
	@RequestMapping(value = "/fetchUserReview",method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReviewDto> fetchUserReviewDetails(HttpServletRequest request) {
		String spId = request.getParameter("spId");
		String userId = request.getParameter("userId");
		ReviewDto dto = userDao.fetchUserReviewDetails(Integer.parseInt(spId),Integer.parseInt(userId));
		if(dto==null){
			dto=null;
		}
		return new ResponseEntity<ReviewDto>( dto,HttpStatus.OK);
	}
}
