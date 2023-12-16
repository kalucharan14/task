package com.customer.dto;

import java.util.List;

import com.customer.entity.OrderProducts;

public class OrderRequest {
	private String email;
	private List<OrderProducts> list;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public List<OrderProducts> getList() {
		return list;
	}
	public void setList(List<OrderProducts> list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "OrderRequest [email=" + email + ", list=" + list + "]";
	}

	
}
