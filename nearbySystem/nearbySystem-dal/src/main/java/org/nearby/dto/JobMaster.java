package org.nearby.dto;

import java.sql.Timestamp;

public class JobMaster {

	private Integer jobId;
	private Integer userId;
	private String jobTitle;
	private String jobDescription;
	private String type;
	private String address;
	private Double salary;
	private String age;
	private String gender;
	private String jobCategory;
	private String jobSubCategory;
	private Integer isActive;
	private Integer isDeleted;
	private Timestamp createdDate;
	private Timestamp updatedDate;

	
	public Timestamp getUpsdatedDate() {
		return updatedDate;
	}

	public void setUpsdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}

	public Integer getJobId() {
		return jobId;
	}

	public void setJobId(Integer jobId) {
		this.jobId = jobId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getJob_title() {
		return jobTitle;
	}

	public void setJob_title(String job_title) {
		this.jobTitle = job_title;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Integer getIsActive() {
		return isActive;
	}

	public void setIsActive(Integer isActive) {
		this.isActive = isActive;
	}

	public Integer getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(Integer isDeleted) {
		this.isDeleted = isDeleted;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getJobDescription() {
		return jobDescription;
	}

	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Timestamp getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getJobCategory() {
		return jobCategory;
	}

	public void setJobCategory(String jobCategory) {
		this.jobCategory = jobCategory;
	}

	public String getJobSubCategory() {
		return jobSubCategory;
	}

	public void setJobSubCategory(String jobSubCategory) {
		this.jobSubCategory = jobSubCategory;
	}


}
