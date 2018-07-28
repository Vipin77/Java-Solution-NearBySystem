package org.nearby.dto;

import java.util.List;

public class CategoryType {

	
	
	private Integer categoryId;
	private String categoryType;
    private List<SubCategoryType> subCategoryType;
	
	public String getCategoryType() {
		return categoryType;
	}

	public void setCategoryType(String categoryType) {
		this.categoryType = categoryType;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public List<SubCategoryType> getSubCategoryType() {
		return subCategoryType;
	}

	public void setSubCategoryType(List<SubCategoryType> subCategoryType) {
		this.subCategoryType = subCategoryType;
	}

	
	
}
