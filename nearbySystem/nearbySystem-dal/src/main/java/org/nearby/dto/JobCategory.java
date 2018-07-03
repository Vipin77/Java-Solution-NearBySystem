package org.nearby.dto;

public class JobCategory {

	private Integer jobCategoryId;
	private String subCategory;
	private String job;

	public Integer getJobCategoryId() {
		return jobCategoryId;
	}

	public void setJobCategoryId(Integer jobCategoryId) {
		this.jobCategoryId = jobCategoryId;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getSubCategory() {
		return subCategory;
	}

	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}

}
