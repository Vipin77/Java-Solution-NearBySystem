package org.nearby.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nearby.dao.UserDao;
import org.nearby.dto.EmployeeRegistration;
import org.nearby.dto.EmployerRegistration;
import org.nearby.dto.JobCategory;
import org.nearby.dto.JobMaster;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class PortalController {


	
	@Autowired
	private UserDao userDao;


	@RequestMapping(value = "/portalLoginPage")
	public String portalLoginPage() {

		return "portalLoginPage";
	}

	@RequestMapping(value = "/registerEmployer")
	public String registerEmployer(Model model) {

		model.addAttribute("employerDto", new EmployerRegistration());
		return "registerEmployer";
	}

	@RequestMapping(value = "/registerEmployee")
	public String registerEmployee(Model model) {

		model.addAttribute("employeeDto", new EmployerRegistration());
		return "registerEmployee";
	}

	@RequestMapping(value = "/portalHome")
	public String adminHome() {

		return "portalHome";
	}
	
	
	@RequestMapping(value = "/logoutPortal")
	public String logoutPortal(HttpServletRequest request) {


		HttpSession session= request.getSession(false);
		
		session.invalidate();
		
		return "portalLoginPage";
	}

	@RequestMapping(value = "/storeEmployer", method = RequestMethod.POST)
	public String storeUser(@ModelAttribute("employerDto") EmployerRegistration dto, RedirectAttributes redirectAttributes)
			throws IOException {

		userDao.storeEmployer(dto);

		redirectAttributes.addFlashAttribute("message", "Employer registered successfully");
		return "redirect:/portalLoginPage";
	}

	@RequestMapping(value = "/storeEmployee", method = RequestMethod.POST)
	public String storeEmployee(@ModelAttribute("employeeDto") EmployeeRegistration dto, RedirectAttributes redirectAttributes)
			throws IOException {
    	userDao.storeEmployee(dto);

		redirectAttributes.addFlashAttribute("message", "Employee registered successfully");
		return "redirect:/portalLoginPage";
	}
	
	
	@RequestMapping(value = "/employerloginVerify", method = RequestMethod.POST)
	public String loginVerify(HttpServletRequest servletRequest, RedirectAttributes redirectAttributes) {

		String userIds = servletRequest.getParameter("userName");

		String pass = servletRequest.getParameter("password");

		Integer userId= userDao.fetchEmployerInfo(userIds, pass);
		
		if (userId!=0) {
			
			HttpSession session= servletRequest.getSession(true);
			
			session.setAttribute("userId", userId);
			
			return "portalHome";

		}

		redirectAttributes.addFlashAttribute("message", "Invalid username and password");

		return "redirect:/portalLoginPage";
	}

	
	
	
	@RequestMapping(value = "/employeeloginVerify", method = RequestMethod.POST)
	public String employeeloginVerify(HttpServletRequest servletRequest, RedirectAttributes redirectAttributes) {

		String userIds = servletRequest.getParameter("userName");

		String pass = servletRequest.getParameter("password");

		Integer userId= userDao.fetchUserInfo(userIds, pass);
		
		if (userId!=0) {
			
			HttpSession session= servletRequest.getSession(true);
			session.setAttribute("userId", userId);
			
			return "portalHomeEmployee";

		}

		redirectAttributes.addFlashAttribute("message", "Invalid username and password");

		return "redirect:/portalLoginPage";
	}
	
	
	
	@RequestMapping(value = "/postJob")
	public ModelAndView postJob(Model model) {

		model.addAttribute("JobMaster", new JobMaster());
		
		ModelAndView map= new ModelAndView("postJob");
		
		List<JobMaster> listOfJobs= userDao.fetchAllJobs();
		
		List<JobCategory> listOfJobsCategory= userDao.fetchAllJobCategory();
		
		map.addObject("listOfJobs", listOfJobs);
		map.addObject("listOfJobsCategory", listOfJobsCategory);
		
		return map;
	}
	
	
	
	
	@RequestMapping(value = "/storeJobPost")
	public String storeJobPost(@ModelAttribute("JobMaster") JobMaster dto, RedirectAttributes redirectAttributes, HttpServletRequest request) {

		HttpSession session= request.getSession(false);
		
		
		Integer userId= (Integer) session.getAttribute("userId");
		dto.setUserId(userId);
	
	
		
		userDao.storeJobPostDao(dto);
		
		redirectAttributes.addFlashAttribute("message", "Job Added susccessfully");
		
		return "redirect:/postJob";
	}
	
	
	
	@RequestMapping(value = "/searchJob")
	public String searchJob(){
		return "searchJob";
	}
	
	@RequestMapping(value = "/editPostedJob")
	public ModelAndView editPostedJob(HttpServletRequest request) {

		String jobId= request.getParameter("jobId");
		
		JobMaster jobObject =userDao.fetchJob(Integer.parseInt(jobId));
		ModelAndView map= new ModelAndView("editPostedJob");
		
		map.addObject("jobObject", jobObject);
		return map;
	}
	
	
	
	
	@RequestMapping(value = "/updatePostedJob")
	public String updatePostedJob(@ModelAttribute("JobMaster") JobMaster dto, RedirectAttributes redirectAttributes, HttpServletRequest request) {

		
		userDao.updatePostedJob(dto);
		
		redirectAttributes.addFlashAttribute("message", "Job Updated successfully");
		return "redirect:/postJob";
	}
	
	
	@RequestMapping(value = "/deletePostedJob")
	public String updatePostedJob(RedirectAttributes redirectAttributes, HttpServletRequest request) {

		String jobId= request.getParameter("jobId");
		
		userDao.deletPostedJob(jobId);
		
		redirectAttributes.addFlashAttribute("message", "Job deleted successfully");
		return "redirect:/postJob";
	}
	
	@RequestMapping(value = "/portalHomeEmployee")
	public String HomeEmployee() {

		return "portalHomeEmployee";
	}

	@RequestMapping(value = "/availableJob")
	public ModelAndView availableJob(Model model,HttpServletRequest req) {
		model.addAttribute("JobMaster", new JobMaster());
		
		ModelAndView map= new ModelAndView("availableJob");
		List<JobMaster> listOfJobs= userDao.fetchAvailableJobs(req.getParameter("userId"));
		
		map.addObject("listOfJobs", listOfJobs);
		
		return map;
	}
	
	@RequestMapping(value = "/viewAvailableEmployee")
	public ModelAndView availableJob(Model model) {

		model.addAttribute("JobMaster", new JobMaster());
		
		ModelAndView map= new ModelAndView("viewAvailableEmployee");
		
		List<JobMaster> listOfJobs= userDao.fetchAllJobs();
		
		List<JobCategory> listOfJobsCategory= userDao.fetchAllJobCategory();
		
		map.addObject("listOfJobs", listOfJobs);
		map.addObject("listOfJobsCategory", listOfJobsCategory);
		
		return map;
	}
}
