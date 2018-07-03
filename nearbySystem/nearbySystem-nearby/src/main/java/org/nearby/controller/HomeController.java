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
import javax.validation.Valid;

import org.nearby.dao.UserDao;
import org.nearby.dto.CategoryType;
import org.nearby.dto.Registration;
import org.nearby.dto.ServiceProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
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

	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {

		HttpSession session = request.getSession(false);
		session.invalidate();
		redirectAttributes.addFlashAttribute("message", "Logout successfully");
		return "redirect:/adminHome";
	}

	@RequestMapping(value = "/addSp")
	public ModelAndView addUser(Model model) {
		model.addAttribute("registration", new Registration());

		List<CategoryType> listOfCategory = userDao.fetchType();
		ModelAndView map = new ModelAndView("addSp");
		map.addObject("listOfType", listOfCategory);
		return map;
	}

	@RequestMapping(value = "/storeSp", method = RequestMethod.POST )
	public String storeSp(RedirectAttributes redirectAttributes,HttpServletRequest request)
			throws IOException, ServletException, SerialException, SQLException {
		
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multiRequest.getFile("profile");
		byte []b=file.getBytes();
		 
		 String firstName=request.getParameter("firstName");
		 String lastName=request.getParameter("lastName");
		 String mobileNumber=request.getParameter("mobileNumber");
		 String email=request.getParameter("email");
		 String address=request.getParameter("address");
		 Integer categoryId=Integer.parseInt(request.getParameter("categoryId"));
		 String subCategory=request.getParameter("subCategory");
		 String state=request.getParameter("state").trim();
		 String city=request.getParameter("city").trim();
		
		Registration user=new Registration();
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setMobileNumber(mobileNumber);
		user.setEmail(email);
		user.setAddress(address);
		user.setCategoryId(categoryId);
		user.setSubCategory(subCategory);
		user.setState(state);
		user.setCity(city);
		user.setProfile(b);
		
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
	public ModelAndView addCategory() {

		List<CategoryType> listOfCategory = userDao.fetchType();
		ModelAndView map = new ModelAndView("addCategory");
		map.addObject("listOfType", listOfCategory);

		return map;
	}

	@RequestMapping(value = "/storeCategory")
	public String storeCategory(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		String categoryType = request.getParameter("type");

		userDao.storeCategoryType(categoryType);

		redirectAttributes.addFlashAttribute("message", "Type Added successfully");

		return "redirect:/addCategory";
	}

	@RequestMapping(value = "/addSubCategory")
	public ModelAndView addSubCategory() {

		List<CategoryType> listOfCategory = userDao.fetchType();
		ModelAndView map = new ModelAndView("addSubCategory");
		map.addObject("listOfType", listOfCategory);
		return map;
	}

	
	@RequestMapping(value = "/storeSubCategory")
	public String storeSubCategory(HttpServletRequest request, RedirectAttributes redirectAttributes) {
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
	public ResponseEntity<List<ServiceProvider>> fetchReview(HttpServletRequest request){
		String spId = request.getParameter("id");
		List<ServiceProvider> reviews=userDao.fetchReview(spId);
        return new ResponseEntity<List<ServiceProvider>>(reviews,HttpStatus.OK);
	}
}
