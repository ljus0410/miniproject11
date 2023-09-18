package com.model2.mvc.service.domain;

public class Basket {
	
	private User preUser;
	private Product preProduct;
	private int basketNo;
	
	public User getPreUser() {
		return preUser;
	}
	public Product getPreProduct() {
		return preProduct;
	}
	public int getBasketNo() {
		return basketNo;
	}
	public void setPreUser(User preUser) {
		this.preUser = preUser;
	}
	public void setPreProduct(Product preProduct) {
		this.preProduct = preProduct;
	}
	public void setBasketNo(int basketNo) {
		this.basketNo = basketNo;
	}
	
	public String toString() {
		return "BasketVO :: user = "+ preUser +", product = "+preProduct+
				", basketNo = "+basketNo;
	}

}
