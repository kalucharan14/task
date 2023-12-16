package com.customer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.customer.dto.OrderRequest;
import com.customer.entity.Customer;
import com.customer.entity.OrderProducts;
import com.customer.entity.Orders;
import com.customer.repository.OrderProductRepository;
import com.customer.repository.OrderRepository;
import com.customer.serviceImp.IOrders;

@Service
public class OrderService  implements IOrders{
	@Autowired
	OrderRepository orderRepository;
	
	@Autowired
    OrderProductRepository orderProductRepository;
	
	@Autowired
	CustomerService customerService;
	
	public String placeOrder(Customer customer,List<OrderProducts> list) {
		Orders order=new Orders();
		order.setCustomer(customer);
		
		order=orderRepository.save(order);
		
		final Orders finalOrder = order;
		
		list.forEach(o->o.setOrders(finalOrder));
		
		orderProductRepository.saveAll(list);
		
		return "sucess";
	}

	public Customer getIdByEmail(String email) {
		List<Customer> ls=customerService.getAllCustomer();
		for(Customer customer:ls) {
			if(customer.getEmail().equals(email)) {
				return customer;
			}
		}
		return null;
	}

	

	@Override
	public List<Orders> findByCustomerCustomerId(Long customerId) {
		
		return orderRepository.findByCustomerCustomerId(customerId);
	}
	
	
}
