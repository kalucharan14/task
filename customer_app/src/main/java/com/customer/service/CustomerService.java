package com.customer.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.customer.entity.Customer;
import com.customer.repository.CustomerRepository;
import com.customer.serviceImp.ICustomer;
@Service
public class CustomerService implements ICustomer {
	
	@Autowired
	CustomerRepository customerRepository;

	@Override
	public Customer add(Customer customer) {
		return customerRepository.save(customer);
	}

	@Override
	public Customer update(Customer customer) {
		
		return customerRepository.save(customer);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		customerRepository.deleteById(id);
	}

	@Override
	public Customer getCustomerById(Long id) {
		// TODO Auto-generated method stub
		return customerRepository.findById(id).get();
	}

	@Override
	public List<Customer> getAllCustomer() {
		// TODO Auto-generated method stub
		return customerRepository.findAll();
	}

	@Override
	public List<String> findEmailsByPartialEmail(String contactInfo) {
		// TODO Auto-generated method stub
		return customerRepository.findEmailsByPartialEmail(contactInfo);
	}

}
