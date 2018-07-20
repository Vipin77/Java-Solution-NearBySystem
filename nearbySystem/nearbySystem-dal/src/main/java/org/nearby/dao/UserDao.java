package org.nearby.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.nearby.dto.CategoryType;
import org.nearby.dto.EmployeeRegistration;
import org.nearby.dto.EmployerRegistration;
import org.nearby.dto.JobCategory;
import org.nearby.dto.JobMaster;
import org.nearby.dto.Registration;
import org.nearby.dto.ReviewDto;
import org.nearby.dto.ServiceDto;
import org.nearby.dto.ServiceProvider;
import org.nearby.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.jdbc.Blob;

@Repository
public class UserDao {

	private static final UserDto UserDto = null;
	@Autowired
	JdbcTemplate template;

	public void storeSp(Registration userRegistration) throws IOException, SerialException, SQLException {
		// TODO Auto-generated method stub
       	final Integer subCategoryId = template
				.queryForObject("select subcategoryId from service_category where service='"
						+ userRegistration.getSubCategory() + "'and categoryId=" + userRegistration.getCategory()
						+ " and type= '" + userRegistration.getType() + "'", Integer.class);

		final String query = "insert into registration_master(firstName,lastName,mobileNumber,email,address,state,city,isdeleted,isactive,createdDate,updatedDate,subcategoryId,profile,avgrating,homeService,businessName,password) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		final Timestamp timestamp = new Timestamp(System.currentTimeMillis());

		final String firstName = userRegistration.getFirstName();
		final String lastName = userRegistration.getLastName();
		final String mobileNumber = userRegistration.getMobileNumber();
		final String password = userRegistration.getPassword();
		final String email = userRegistration.getEmail();
		final String address = userRegistration.getAddress();
		final String businessName = userRegistration.getBusinessName();
		final String homeSevice = userRegistration.getHomeService();
		final String city = userRegistration.getCity();
		final String state = userRegistration.getState();
		String country = "India";

		final List<String> latOrLong = AddressConverter
				.getLatorLong(address + "," + city + "," + state + "," + country);

		final SerialBlob blob = new javax.sql.rowset.serial.SerialBlob(userRegistration.getProfile());
		int status = template.update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

				PreparedStatement ps = connection.prepareStatement(query);
				ps.setString(1, firstName);
				ps.setString(2, lastName);
				ps.setString(3, mobileNumber);
				ps.setString(4, email);
				ps.setString(5, address);
				ps.setString(6, state);
				ps.setString(7, city);
				ps.setInt(8, 0);
				ps.setInt(9, 0);
				ps.setTimestamp(10, timestamp);
				ps.setTimestamp(11, timestamp);
				ps.setInt(12, subCategoryId);
				ps.setBlob(13, blob);
				ps.setDouble(14, 0);
				ps.setString(15, homeSevice);
				ps.setString(16, businessName);
				ps.setString(17, password);
				return ps;
			}
		});

		final Integer spId = template.queryForObject(
				"select spId from registration_master where mobileNumber= '" + userRegistration.getMobileNumber() + "'",
				Integer.class);

		final String query2 = "insert into sp_master(spId,latitude,longitude) values(?,?,?)";

		int status2 = template.update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

				PreparedStatement ps = connection.prepareStatement(query2);
				ps.setInt(1, spId);
				ps.setDouble(2, Double.parseDouble(latOrLong.get(0)));
				ps.setDouble(3, Double.parseDouble(latOrLong.get(1)));

				return ps;
			}
		});

	}
	
	public int storeUser(UserDto uDto) throws IOException, SerialException, SQLException {
		// TODO Auto-generated method stub

		final String query = "insert into user_master(firstName,lastName,mobile,password,emailId,address,city,state,country,profile,latitude,longitude,isdeleted,isactive,createdDate,updatedDate) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		final Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		final String firstName = uDto.getFirstName();
		final String lastName = uDto.getLastName();
		final String mobileNumber = uDto.getMobile();
		final String password = uDto.getPassword();
		final String email = uDto.getEmailId();
		final String address = uDto.getAddress();
		final String city = uDto.getCity();
		final String state = uDto.getState();
		final String country = "India";

		final List<String> latOrLong = AddressConverter
				.getLatorLong(address + "," + city + "," + state + "," + country);

		final SerialBlob blob = new javax.sql.rowset.serial.SerialBlob(uDto.getProfile());
		int status = template.update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

				PreparedStatement ps = connection.prepareStatement(query);
				ps.setString(1, firstName);
				ps.setString(2, lastName);
				ps.setString(3, mobileNumber);
				ps.setString(4, password);
				ps.setString(5, email);
				ps.setString(6, address);
				ps.setString(7, city);
				ps.setString(8, state);
				ps.setString(9, country);
				ps.setBlob(10, blob);
				ps.setDouble(11, Double.parseDouble(latOrLong.get(0)));
				ps.setDouble(12, Double.parseDouble(latOrLong.get(1)));
				ps.setInt(13, 0);
				ps.setInt(14, 0);
				ps.setTimestamp(15, timestamp);
				ps.setTimestamp(16, timestamp);
				return ps;
			}
		});
		return status;
	}

	public void storeCategoryType(final String categoryType) {
		// TODO Auto-generated method stub

		final String query = "insert into category_master(categoryType)values(?)";

		template.update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

				PreparedStatement ps = connection.prepareStatement(query);
				ps.setString(1, categoryType);

				return ps;
			}
		});

	}

	public void storeSubCategoryType(final String categoryType, final String subCategoryType, final String type) {
		// TODO Auto-generated method stub

		final String query = "insert into service_category(categoryId,service,type)values(?,?,?)";

		template.update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

				PreparedStatement ps = connection.prepareStatement(query);
				ps.setInt(1, Integer.parseInt(categoryType));
				ps.setString(2, subCategoryType);
				ps.setString(3, type);

				return ps;
			}
		});

	}

	public List<CategoryType> fetchType() {
		// TODO Auto-generated method stub
		List<CategoryType> dto = template.query("select * from category_master ",
				new BeanPropertyRowMapper<CategoryType>(CategoryType.class));

		return dto;
	}

	public List<String> fetchAllServices(int cid) {
		// TODO Auto-generated method stub

		List<ServiceDto> dto = template.query("select * from service_category where categoryId=" + cid + " ",
				new BeanPropertyRowMapper<ServiceDto>(ServiceDto.class));
		List<String> list = new ArrayList<String>();

		for (ServiceDto local : dto) {

			list.add(local.getService() + " - " + local.getType());

		}
		return list;
	}

	public List<String> fetchAllEmail() {
		// TODO Auto-generated method stub
		List<Registration> dto = template.query("select email from registration_master",
				new BeanPropertyRowMapper<Registration>(Registration.class));
		List<String> list = new ArrayList<String>();

		for (Registration local : dto) {
			list.add(local.getEmail());
		}
		return list;
	}

	public List<String> fetchAllMobile() {
		// TODO Auto-generated method stub
		List<Registration> dto = template.query("select mobileNumber from registration_master",
				new BeanPropertyRowMapper<Registration>(Registration.class));
		List<String> list = new ArrayList<String>();

		for (Registration local : dto) {
			list.add(local.getMobileNumber());
		}
		return list;
	}
	
	public List<String> fetchAllUserMobile() {
		// TODO Auto-generated method stub
		List<UserDto> dto = template.query("select mobile from user_master",
				new BeanPropertyRowMapper<UserDto>(UserDto.class));
		List<String> list = new ArrayList<String>();

		for (UserDto local : dto) {
			list.add(local.getMobile());
		}
		return list;
	}
	
	public List<String> fetchAllUserEmail() {
		// TODO Auto-generated method stub
		List<UserDto> dto = template.query("select emailId from user_master",
				new BeanPropertyRowMapper<UserDto>(UserDto.class));
		List<String> list = new ArrayList<String>();

		for (UserDto local : dto) {
			list.add(local.getEmailId());
		}
		return list;
	}

	public List<String> fetchAllServicesForUser(int cid) {
		// TODO Auto-generated method stub

		List<ServiceDto> dto = template.query(
				"select distinct service from service_category where categoryId=" + cid + " ",
				new BeanPropertyRowMapper<ServiceDto>(ServiceDto.class));
		List<String> list = new ArrayList<String>();

		for (ServiceDto local : dto) {

			list.add(local.getService());

		}

		return list;
	}

	public List<ServiceProvider> fetchSPLocation(String service, String latitude, String longitude) {

		List<Integer> subCategoryIdList = template.queryForList(
				"select subcategoryId from service_category where service='" + service + "'", Integer.class);

		List<ServiceProvider> providers = new ArrayList<ServiceProvider>();
		for (Integer subCategoryId : subCategoryIdList) {

			List<ServiceProvider> list = template.query(
					"SELECT s.firstName,s.mobileNumber,s.email,s.address,s.spId,s.profile,s.avgrating,s.lastname,s.businessName,p.latitude,p.longitude,( 6371 * ACOS( COS( RADIANS("
							+ latitude + "  ) ) * COS( RADIANS( p.latitude ) ) * COS( RADIANS( p.longitude )- RADIANS("
							+ longitude + " ) ) + SIN( RADIANS( " + latitude
							+ ") ) * SIN( RADIANS( p.latitude ) ) ) ) AS distance FROM registration_master s ,sp_master p , service_category sc WHERE  sc.subcategoryId="
							+ subCategoryId
							+ " AND sc.subcategoryId=s.subcategoryId AND s.spId=p.spId HAVING distance <5",
					new BeanPropertyRowMapper<ServiceProvider>(ServiceProvider.class));
			providers.addAll(list);
		}
		// TODO Auto-generated method stub
		return providers;
	}

	public void storeEmployer(EmployerRegistration dto) {
		// TODO Auto-generated method stub

		final String query = "insert into employer_registration_master(name,mobileNumber,email,address,state,city,type,dob,createdDate,isactive,isdeleted,updatedDate,password) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";

		final String name = dto.getName();
		final String mobileNo = dto.getMobileNumber();
		final String address = dto.getAddress();
		final String state = dto.getState();
		final String city = dto.getCity();
		final String email = dto.getEmail();
		final String password = dto.getPassword();
		final String type = dto.getType();
		final Date dob = dto.getDob();
		final Timestamp timeStamp = new Timestamp(System.currentTimeMillis());

		int status = template.update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

				PreparedStatement ps = connection.prepareStatement(query);

				ps.setString(1, name);
				ps.setString(2, mobileNo);
				ps.setString(3, email);
				ps.setString(4, address);
				ps.setString(5, state);
				ps.setString(6, city);
				ps.setString(7, type);
				ps.setDate(8, dob);
				ps.setTimestamp(9, timeStamp);
				ps.setInt(10, 0);
				ps.setInt(11, 0);
				ps.setTimestamp(12, timeStamp);
				ps.setString(13, password);

				return ps;
			}
		});

	}

	public Integer fetchUserInfo(String userId, String pass) {
		// TODO Auto-generated method stub
		try {
			Integer user = template
					.queryForObject("select employeeId from employee_registration_master where mobileNumber= '" + userId
							+ "' and password= '" + pass + "'", Integer.class);

			if (user != null) {
				return user;
			}

		} catch (Exception e) {

			return 0;

		}

		return 0;

	}

	public Integer fetchEmployerInfo(String userId, String pass) {
		// TODO Auto-generated method stub
		try {
			Integer user = template
					.queryForObject("select employerId from employer_registration_master where mobileNumber= '" + userId
							+ "' and password= '" + pass + "'", Integer.class);

			if (user != null) {
				return user;
			}

		} catch (Exception e) {

			return 0;

		}

		return 0;

	}

	public void storeJobPostDao(JobMaster dto) {
		// TODO Auto-generated method stub

		final String query = "insert into job_master(employerId,job_title,age,gender,salary,address,type,created_date,updated_date,created_by,isdeleted,isActive,jobDescription,jobCategoryId,jobSubCategory) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		final Timestamp time = new Timestamp(System.currentTimeMillis());
		final Integer userId = dto.getUserId();
		final String job_title = dto.getJob_title();
		final String address = dto.getAddress();
		final String age = dto.getAge();
		final String gender = dto.getGender();
		final Double salary = dto.getSalary();
		final String type = dto.getType();
		final String jd = dto.getJobDescription();
		final Integer jobCategory = Integer.parseInt(dto.getJobCategory());
		final String jobSubCategory = dto.getJobSubCategory();

		int status = template.update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

				PreparedStatement ps = connection.prepareStatement(query);

				ps.setInt(1, userId);
				ps.setString(2, job_title);
				ps.setString(3, age);
				ps.setString(4, gender);
				ps.setDouble(5, salary);
				ps.setString(6, address);
				ps.setString(7, type);
				ps.setTimestamp(8, time);
				ps.setTimestamp(9, time);
				ps.setInt(10, userId);
				ps.setInt(11, 0);
				ps.setInt(12, 0);
				ps.setString(13, jd);
				ps.setInt(14, jobCategory);
				ps.setString(15, jobSubCategory);
				return ps;
			}
		});

	}

	public List<JobMaster> fetchAllJobs() {
		// TODO Auto-generated method stub

		List<JobMaster> list = template.query("select * from job_master",
				new BeanPropertyRowMapper<JobMaster>(JobMaster.class));

		return list;
	}

	public JobMaster fetchJob(Integer jobId) {
		// TODO Auto-generated method stub
		JobMaster dto = template.queryForObject("select * from job_master where jobId=" + jobId,
				new BeanPropertyRowMapper<JobMaster>(JobMaster.class));
		return dto;
	}

	public void updatePostedJob(JobMaster dto) {
		// TODO Auto-generated method stub
		template.update("update job_master set job_title = '" + dto.getJob_title() + "', age='" + dto.getAge()
				+ "', address='" + dto.getAddress() + "',salary=" + dto.getSalary() + ",jobDescription='"
				+ dto.getJobDescription() + "', updated_date='" + new Timestamp(System.currentTimeMillis())
				+ "' where jobId =" + dto.getJobId());
	}

	public void deletPostedJob(String jobId) {
		// TODO Auto-generated method stub
		template.update("delete from job_master where jobId=" + Integer.parseInt(jobId));
	}

	public void storeEmployee(EmployeeRegistration dto) {
		// TODO Auto-generated method stub

		final String query = "insert into employee_registration_master(firstName,lastName,fatherName,gender,mobileNumber,email,"
				+ "contactAddress,permanentAddress,dob,maritalStatus,numberOfChild,age,"
				+ "salaryExpectation,jobNeeded,educationDetails,identityProof,created_date,updated_date,isDeleted,isActive,password) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		final String fname = dto.getFirstName();
		final String lName = dto.getLastName();
		final String fatherName = dto.getFatherName();
		final String gender = dto.getGender();
		final String mobNo = dto.getMobileNumber();
		final String password = dto.getPassword();
		final String email = dto.getEmail();
		final String conAddress = dto.getContactAddress();
		final String perAddres = dto.getPermanentAddress();
		final Date dob = dto.getDob();
		final String marital = dto.getMaritalStatus();
		final Integer noOfChild = dto.getNoOfChild();
		final Integer age = dto.getAge();
		final Double salary = dto.getSalaryExpectation();
		final String job = dto.getJobNeeded();
		final String education = dto.getEducationDetails();
		final String identity = dto.getIdentity();
		final Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
		template.update(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

				PreparedStatement ps = connection.prepareStatement(query);
				ps.setString(1, fname);
				ps.setString(2, lName);
				ps.setString(3, fatherName);
				ps.setString(4, gender);
				ps.setString(5, mobNo);
				ps.setString(6, email);
				ps.setString(7, conAddress);
				ps.setString(8, perAddres);
				ps.setDate(9, dob);
				ps.setString(10, marital);
				ps.setInt(11, noOfChild);
				ps.setInt(12, 0);
				ps.setDouble(13, salary);
				ps.setString(14, job);
				ps.setString(15, education);
				ps.setString(16, identity);
				ps.setTimestamp(17, timeStamp);
				ps.setTimestamp(18, timeStamp);
				ps.setInt(19, 0);
				ps.setInt(20, 0);
				ps.setString(21, password);
				return ps;
			}
		});

	}

	public List<JobCategory> fetchAllJobCategory() {
		// TODO Auto-generated method stub

		List<JobCategory> list = template.query("select * from job_category",
				new BeanPropertyRowMapper<JobCategory>(JobCategory.class));
		return list;
	}

	public List<String> fetchAllSubCategory(int cid) {
		// TODO Auto-generated method stub

		List<JobCategory> list2 = template.query("select * from job_subcategory where jobCategoryId=" + cid + " ",
				new BeanPropertyRowMapper<JobCategory>(JobCategory.class));

		List<String> list = new ArrayList<String>();

		for (JobCategory local : list2) {

			list.add(local.getSubCategory());

		}

		return list;
	}

	public List<JobMaster> fetchAvailableJobs(String userId) {
		// TODO Auto-generated method stub
		try {
			String jobNeeded = template.queryForObject(
					"select jobNeeded from employee_registration_master where employeeId='" + userId + "'",
					String.class);
			if (jobNeeded != null) {
				List<JobMaster> list = template.query(
						"select * from job_master where jobSubCategory='" + jobNeeded + "'",
						new BeanPropertyRowMapper<JobMaster>(JobMaster.class));
				return list;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}

	public List<EmployeeRegistration> fetchAvailableEmployee(String subCatValue) {
		// TODO Auto-generated method stub

		List<EmployeeRegistration> list = template.query(
				"select * from employee_registration_master where jobNeeded='" + subCatValue + "'",
				new BeanPropertyRowMapper<EmployeeRegistration>(EmployeeRegistration.class));
		return list;
	}

	public List<ServiceProvider> fetchSearchProvider(String city, String area, String subCategory) {

		List<Integer> subCategoryIdList = template.queryForList(
				"select subcategoryId from service_category where service='" + subCategory + "'", Integer.class);

		List<ServiceProvider> providers = new ArrayList<ServiceProvider>();

		for (Integer subCategoryId : subCategoryIdList) {

			List<ServiceProvider> list = template
					.query("SELECT s.spId,s.businessName,s.firstName,s.mobileNumber,s.lastname,s.address,s.email,s.profile,s.avgrating,p.latitude,p.longitude FROM registration_master s ,sp_master p WHERE city LIKE '%"
							+ city + "%' AND address LIKE '%" + area + "%' AND subcategoryId=" + subCategoryId
							+ " AND s.spId=p.spId", new BeanPropertyRowMapper<ServiceProvider>(ServiceProvider.class));
			providers.addAll(list);
		}
		return providers;
	}

	public List<ReviewDto> fetchReview(String spId) {

		List<ReviewDto> providers = new ArrayList<ReviewDto>();

		List<ReviewDto> list = template.query("SELECT review,rating,userId FROM sp_review WHERE spId=" + spId + "",
				new BeanPropertyRowMapper<ReviewDto>(ReviewDto.class));
		
		providers.addAll(list);
		return providers;
	}
	
	public int addReview(final int spId,final String review,final int userId,final double rating) {

		final String query2 = "insert into sp_review(spId,userId,review,rating) values(?,?,?,?)";

		int status = template.update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {

				PreparedStatement ps = connection.prepareStatement(query2);
				ps.setInt(1, spId);
				ps.setInt(2, userId);
				ps.setString(3,review);
				ps.setDouble(4,rating);

				return ps;
			}
		});
		List<ReviewDto> providers = new ArrayList<ReviewDto>();
		List<ReviewDto> list = template.query("SELECT rating FROM sp_review WHERE spId=" + spId + "",
				new BeanPropertyRowMapper<ReviewDto>(ReviewDto.class));
		providers.addAll(list);
		
		double rat=0;
		for(ReviewDto rDto:providers){
			rat=rat+Double.parseDouble(rDto.getRating());
		}
		double noofrating=list.size();
	    double avgrating=rat/noofrating;
	    DecimalFormat df = new DecimalFormat(".#");
	    avgrating= Double.parseDouble(df.format(avgrating));
	    template.update("UPDATE registration_master SET avgrating='"+avgrating+"' WHERE spId='"+spId+"'");
        return status;
	}
	
	public UserDto fetchUser(String mobile, String password) {
		try {
			UserDto user = template
					.queryForObject("select * from user_master where mobile= '" + mobile
							+ "' and password= '" +password+ "'",new BeanPropertyRowMapper<UserDto>(UserDto.class));
			if (user != null) {
				System.out.println("Login user "+user.getFirstName());
				return user;
			}
		} catch (Exception e) {
			return null;
		}
		return null;
	}
	
	public int verifySp(String mobile, String password) {
		try {
			Integer user = template
					.queryForObject("select spId from registration_master where mobileNumber= '" + mobile
							+ "' and password= '" + password + "'", Integer.class);
			if (user != null) {
				return user;
			}
		} catch (Exception e) {
			return 0;
		}
		return 0;
	}
	
	public ServiceProvider fetchSp(String spId) {
		try {
			ServiceProvider user = template
					.queryForObject("select * from registration_master where spId= '" +spId+"'",new BeanPropertyRowMapper<ServiceProvider>(ServiceProvider.class));
			if (user != null) {
				System.out.println("Login user "+user.getFirstName());
				return user;
			}
		   }catch (EmptyResultDataAccessException e) {
			return null;
		} 
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}
	
	public UserDto fetchUser(String userId) {
				UserDto user=  template.queryForObject("SELECT * FROM user_master WHERE userId=" + userId + "",
				new BeanPropertyRowMapper<UserDto>(UserDto.class));
		return user;
	}

}
