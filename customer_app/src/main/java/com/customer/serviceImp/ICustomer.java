package com.customer.serviceImp;

import java.util.List;

import com.customer.entity.Customer;

public interface ICustomer {
	Customer add(Customer customer);
	Customer update(Customer customer);
	void delete(Long id);
	Customer getCustomerById(Long id);
	List<Customer> getAllCustomer();
	List<String> findEmailsByPartialEmail(String email);
	
	

}
