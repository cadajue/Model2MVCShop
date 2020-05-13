package com.model2.mvc.common;


public class Search {
	
	///Field
	private int curruntPage;
	private String searchCondition;
	private String searchKeyword;
	private String searchKeywordOptional;
	private String searchOrder;
	private int pageSize;
	
	private int endRowNum;
	private int startRowNum;

	///Constructor
	public Search() {
	}
	
	///Method
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int paseSize) {
		this.pageSize = paseSize;
	}
	
	public int getCurrentPage() {
		return curruntPage;
	}
	public void setCurrentPage(int curruntPage) {
		this.curruntPage = curruntPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	public String getSearchOrder() {
		return searchOrder;
	}

	public void setSearchOrder(String searchOrder) {
		this.searchOrder = searchOrder;
	}

	public String getSearchKeywordOptional() {
		return searchKeywordOptional;
	}

	public void setSearchKeywordOptional(String searchKeywordOptional) {
		this.searchKeywordOptional = searchKeywordOptional;
	}

	public int getCurruntPage() {
		return curruntPage;
	}

	public void setCurruntPage(int curruntPage) {
		this.curruntPage = curruntPage;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	@Override
	public String toString() {
		return "Search [curruntPage=" + curruntPage + ", searchCondition=" + searchCondition + ", searchKeyword="
				+ searchKeyword + ", searchKeywordOptional=" + searchKeywordOptional + ", searchOrder=" + searchOrder
				+ ", pageSize=" + pageSize + ", endRowNum=" + endRowNum + ", startRowNum=" + startRowNum + "]";
	}

}