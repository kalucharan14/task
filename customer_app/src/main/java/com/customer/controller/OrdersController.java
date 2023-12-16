package com.customer.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.customer.dto.OrderRequest;
import com.customer.entity.Customer;
import com.customer.entity.OrderProducts;
import com.customer.entity.Orders;
import com.customer.service.OrderService;
import com.customer.serviceImp.IOrders;

@Controller
@RequestMapping("/api/orders")
public class OrdersController  {
    @Autowired
	OrderService orderService;
	
	@PostMapping("/placeOrder")
	public String placeOrders(@RequestBody OrderRequest orderRequest) {
		Customer customer = orderService.getIdByEmail(orderRequest.getEmail());
		List<OrderProducts> ls=orderRequest.getList();
		orderService.placeOrder(customer, ls);
		return "done";
	}
   @GetMapping("/{id}")
   @ResponseBody
	public List<Orders> findByCustomerCustomerId(@PathVariable(name = "id") Long customerId) {
		// TODO Auto-generated method stub
		return orderService.findByCustomerCustomerId(customerId);
	}
	
	
	
	
	
	
}
