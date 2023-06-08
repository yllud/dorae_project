package com.multi.dorae.help;

public class HelpCategoryVO {
	
	private String help_category_id;
	private String name;
	private String parent_category_id;
	
	public String getHelp_category_id() {
		return help_category_id;
	}
	public void setHelp_category_id(String help_category_id) {
		this.help_category_id = help_category_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getParent_category_id() {
		return parent_category_id;
	}
	public void setParent_category_id(String parent_category_id) {
		this.parent_category_id = parent_category_id;
	}
	@Override
	public String toString() {
		return "HelpCategoryVO [help_category_id=" + help_category_id + ", name=" + name + ", parent_category_id="
				+ parent_category_id + "]";
	}
	
	
	
}
