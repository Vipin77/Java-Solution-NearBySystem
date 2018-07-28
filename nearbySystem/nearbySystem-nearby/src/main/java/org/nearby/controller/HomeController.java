package org.nearby.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialException;
import org.nearby.dao.UserDao;
import org.nearby.dto.CategoryType;
import org.nearby.dto.Registration;
import org.nearby.dto.ReviewDto;
import org.nearby.dto.ServiceProvider;
import org.nearby.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
@MultipartConfig
@Controller
public class HomeController {

	@Autowired
	UserDao userDao;

	@RequestMapping(value = "/adminHome")
	public String adminHome() {
		return "loginPage";
	}
	
	@RequestMapping(value = "/spLoginPage")
	public String spLoginPage() {
		return "spLoginPage";
	}
	
	@RequestMapping(value = "/sploginVerify", method = RequestMethod.POST)
	public ModelAndView sploginVerify(HttpServletRequest servletRequest) throws SQLException {

		String mobile = servletRequest.getParameter("userName");
		String pass = servletRequest.getParameter("password");
        
		int spId=userDao.verifySp(mobile, pass);
		if(spId!=0){
			HttpSession session = servletRequest.getSession(true);
			session.setAttribute("spId",spId);
			ModelAndView map = new ModelAndView("spHome");
			return map;
		}
		ModelAndView map = new ModelAndView("spLoginPage");
		map.addObject("message", "Invalid username and password");
		return map;
	}
	
	@RequestMapping(value = "/fetchsp",method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ServiceProvider> fetchsp(HttpServletRequest request) throws SQLException {
		String Id = request.getParameter("spId");
        ServiceProvider spDto = userDao.fetchSp(Id);
			Blob blob = spDto.getProfile();
			int blobLength = (int) blob.length();  
			byte[] blobAsBytes = blob.getBytes(1, blobLength);
			spDto.setImg(blobAsBytes);
			spDto.setProfile(null);
        return new ResponseEntity<ServiceProvider>(spDto,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/splogout")
	public String splogout(HttpServletRequest request, RedirectAttributes redirectAttributes) {

		HttpSession session = request.getSession(false);
		session.invalidate();
		redirectAttributes.addFlashAttribute("message", "Logout successfully");
		return "redirect:/spLoginPage";
	}

	@RequestMapping(value = "/userLoginPage")
	public String userLoginPage() {
		return "userLoginPage";
	}
	
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {

		HttpSession session = request.getSession(false);
		
		session.setAttribute("aId",null);
		session.invalidate();
		redirectAttributes.addFlashAttribute("message", "Logout successfully");
		return "redirect:/adminHome";
	}
	
	@RequestMapping(value = "/userlogout")
	public ModelAndView userlogout(HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		session.invalidate();
		List<CategoryType> listOfCategory = userDao.fetchType();
		ModelAndView map = new ModelAndView("userHome");
		map.addObject("listOfType", listOfCategory);
		return map;
	}
	
	@RequestMapping(value = "/userRegistration")
	public ModelAndView userRegistration(Model model) {
		model.addAttribute("userDto", new UserDto());
		
		ModelAndView map = new ModelAndView("userRegistration");
		return map;
	}
	
	@RequestMapping(value = "/storeUser", method = RequestMethod.POST )
	public String userSp(HttpServletRequest request,RedirectAttributes redirectAttributes) throws IOException, SerialException, SQLException{

		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multiRequest.getFile("profile");
		byte []b=file.getBytes();
   		String latitude=request.getParameter("latitude");
		 String longitude=request.getParameter("longitude");
		 String firstName=request.getParameter("firstName");
		 String lastName=request.getParameter("lastName");
		 String mobile=request.getParameter("mobile");
		 String password=request.getParameter("password");
		 String email=request.getParameter("emailId");
		 String address=request.getParameter("address");
		 String country=request.getParameter("country").trim();
		 String state=request.getParameter("state1").trim();
		 System.out.println("State of user = "+state);
		 String city=request.getParameter("city").trim();
		 
		 UserDto userDto=new UserDto();
		 userDto.setFirstName(firstName);
		 userDto.setLastName(lastName);
		 userDto.setMobile(mobile);
		 userDto.setPassword(password);
		 userDto.setEmailId(email);
		 userDto.setAddress(address);
		 userDto.setCity(city);
		 userDto.setState(state);
		 userDto.setCountry(country);
		 userDto.setProfile(b);
		 userDto.setLatitude(Double.parseDouble(latitude));
		 userDto.setLongitude(Double.parseDouble(longitude));
		 
		 int result=userDao.storeUser(userDto);
		 
		 if(result==1){
		   redirectAttributes.addFlashAttribute("message", "Registration successfully");
		 }else{
		 redirectAttributes.addFlashAttribute("message", "Registration Failed");
		 }
		return "redirect:/userRegistration";
	}

	@RequestMapping(value = "/addSp")
	public ModelAndView addUser(Model model,HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		System.out.println("Admin id =  "+session.getAttribute("aId"));
		Object s1=session.getAttribute("aId");
		if(s1==null){
			ModelAndView map = new ModelAndView("loginPage");
			map.addObject("message", "First You Have to Login..");
			return map;
		}
		
		model.addAttribute("registration", new Registration());

		List<CategoryType> listOfCategory = userDao.fetchType();
		ModelAndView map = new ModelAndView("addSp");
		map.addObject("listOfType", listOfCategory);
		return map;
	}

	@RequestMapping(value = "/storeSp", method = RequestMethod.POST )
	public String storeSp(RedirectAttributes redirectAttributes,HttpServletRequest request)
			throws IOException, ServletException, SerialException, SQLException {
		
		HttpSession session = request.getSession(false);
		System.out.println("Admin id =  "+session.getAttribute("aId"));
		Object s1=session.getAttribute("aId");
		if(s1==null){
			redirectAttributes.addFlashAttribute("message", "First You have to login..");
			return "redirect:/adminHome";
		}
		
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multiRequest.getFile("profile");
		byte []b=file.getBytes();
		 
		String latitude=request.getParameter("latitude");
		 String longitude=request.getParameter("longitude");
		 System.out.println(latitude+" ... "+longitude);
		 String businessName=request.getParameter("businessName");
		 String firstName=request.getParameter("firstName");
		 String lastName=request.getParameter("lastName");
		 String mobileNumber=request.getParameter("mobileNumber");
		 String password=request.getParameter("password");
		 String email=request.getParameter("email");
		 String address=request.getParameter("address");
		 Integer categoryId=Integer.parseInt(request.getParameter("categoryId"));
		 String subCategory=request.getParameter("subCategory");
		 String state=request.getParameter("state1").trim();
		 System.out.println("state = "+state);
		 String city=request.getParameter("city").trim();
		 String homeService=request.getParameter("homeService").trim();
		 
		 Registration user=new Registration();
		 
           if(lastName.equals("")){
        	   user.setLastName("Not specified");
		   }else{
			   user.setLastName(lastName);
		   }
           if(email.equals("")){
        	   user.setEmail("Not specified");
		   }else{
			   user.setEmail(email);
		   }
        user.setBusinessName(businessName);
		user.setFirstName(firstName);
		user.setMobileNumber(mobileNumber);
		user.setPassword(password);
		System.out.println(user.getPassword()+" ........");
		user.setAddress(address);
		user.setCategoryId(categoryId);
		user.setSubCategory(subCategory);
		user.setState(state);
		user.setCity(city);
		user.setProfile(b);
		user.setHomeService(homeService);
	    user.setLatitude(latitude);
	    user.setLongitude(longitude);
		String str = user.getSubCategory();
  
		String[] obj = str.split("\\-");

		user.setSubCategory(obj[0].trim());
		user.setType(obj[1].trim());
		userDao.storeSp(user); 
		
		redirectAttributes.addFlashAttribute("message", "SP added successfully");
		return "redirect:/addSp";
	}

	@RequestMapping(value = "/loginVerify", method = RequestMethod.POST)
	public String loginVerify(HttpServletRequest servletRequest, RedirectAttributes redirectAttributes) {

		String userId = servletRequest.getParameter("userName");

		String pass = servletRequest.getParameter("password");

		if (userId.equals("admin") && pass.equals("admin")) {
			HttpSession session = servletRequest.getSession(true);
			session.setAttribute("aId",userId);
			return "adminHomePage";
		}
		redirectAttributes.addFlashAttribute("message", "Invalid username and password");
		return "redirect:/adminHome";
	}

	@RequestMapping(value = "/deshboard")
	public String deshboard() {

		return "adminHomePage";
	}

	@RequestMapping(value = "/addCategory")
	public ModelAndView addCategory(HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		System.out.println("Admin id =  "+session.getAttribute("aId"));
		Object s1=session.getAttribute("aId");
		if(s1==null){
			ModelAndView map = new ModelAndView("loginPage");
			map.addObject("message", "First You Have to Login..");
			return map;
		}
		
		List<CategoryType> listOfCategory = userDao.fetchType();
		ModelAndView map = new ModelAndView("addCategory");
		map.addObject("listOfType", listOfCategory);

		return map;
	}

	@RequestMapping(value = "/storeCategory")
	public String storeCategory(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
		HttpSession session = request.getSession(false);
		System.out.println("Admin id =  "+session.getAttribute("aId"));
		Object s1=session.getAttribute("aId");
		if(s1==null){
			redirectAttributes.addFlashAttribute("message", "First You have to login..");
			return "redirect:/adminHome";
		}
		String categoryType = request.getParameter("type");

		userDao.storeCategoryType(categoryType);

		redirectAttributes.addFlashAttribute("message", "Type Added successfully");

		return "redirect:/addCategory";
	}

	@RequestMapping(value = "/addSubCategory")
	public ModelAndView addSubCategory(HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		System.out.println("Admin id =  "+session.getAttribute("aId"));
		Object s1=session.getAttribute("aId");
		if(s1==null){
			ModelAndView map = new ModelAndView("loginPage");
			map.addObject("message", "First You Have to Login..");
			return map;
		}
		
		List<CategoryType> listOfCategory = userDao.fetchType();
		ModelAndView map = new ModelAndView("addSubCategory");
		map.addObject("listOfType", listOfCategory);
		return map;
	}

	
	@RequestMapping(value = "/storeSubCategory")
	public String storeSubCategory(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		HttpSession session = request.getSession(false);
		System.out.println("Admin id =  "+session.getAttribute("aId"));
		Object s1=session.getAttribute("aId");
		if(s1==null){
			redirectAttributes.addFlashAttribute("message", "First You have to login..");
			return "redirect:/adminHome";
		}
		
		String categoryType = request.getParameter("categorytype");
		String subCategoryType = request.getParameter("subType");
		String type = request.getParameter("type");
		userDao.storeSubCategoryType(categoryType, subCategoryType, type);
		redirectAttributes.addFlashAttribute("message", "Subcategory Added successfully");

		return "redirect:/addSubCategory";
	}

	
	@RequestMapping(value = "/user")
	public ModelAndView userHome() {

		List<CategoryType> listOfCategory = userDao.fetchType();
		ModelAndView map = new ModelAndView("userHome");
		map.addObject("listOfType", listOfCategory);
		return map;
		
		
	}
	
	@RequestMapping(value = "/searchSp")
	public ModelAndView searchSp() {
		List<CategoryType> listOfCategory = userDao.fetchType();
		ModelAndView map = new ModelAndView("searchSp");
		map.addObject("listOfType", listOfCategory);
		return map;
	}
	
	@RequestMapping(value = "/searchProvider",method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ServiceProvider>> searchProvider(HttpServletRequest request) throws SQLException {
		String area = request.getParameter("area");
		String city = request.getParameter("city");
		String subCategory = request.getParameter("subCategory");
        List<ServiceProvider> Services = userDao.fetchSearchProvider(city,area, subCategory);
        for(ServiceProvider s:Services){
        	s.setService(subCategory);
			Blob blob = s.getProfile();
			int blobLength = (int) blob.length();  
			byte[] blobAsBytes = blob.getBytes(1, blobLength);
			s.setImg(blobAsBytes);
			s.setProfile(null);
		}
        return new ResponseEntity<List<ServiceProvider>>(Services,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/fetchReview",method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ReviewDto>> fetchReview(HttpServletRequest request){
		String spId = request.getParameter("id");
		List<ReviewDto> reviews=userDao.fetchReview(spId);
        return new ResponseEntity<List<ReviewDto>>(reviews,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/fetchUser",method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<UserDto> fetchUser(HttpServletRequest request){
		String userId = request.getParameter("userId");
		UserDto user=userDao.fetchUser(userId);
        return new ResponseEntity<UserDto>(user,HttpStatus.OK);
	}
}
