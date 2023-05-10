package com.multi.dorae.help;

public class HelpCategoryVO {
	
	private String helpCategory_id;
	private String name;
	private int depth;
	private String parentCategory_id;
	
	public String getHelpCategory_id() {
		return helpCategory_id;
	}
	public void setHelpCategory_id(String helpCategory_id) {
		this.helpCategory_id = helpCategory_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getParentCategory_id() {
		return parentCategory_id;
	}
	public void setParentCategory_id(String parentCategory_id) {
		this.parentCategory_id = parentCategory_id;
	}
	
	@Override
	public String toString() {
		return "HelpCategoryVO [helpCategory_id=" + helpCategory_id + ", name=" + name + ", depth=" + depth
				+ ", parentCategory_id=" + parentCategory_id + "]";
	}
	
}
