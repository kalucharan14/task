package com.customer.controller;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.customer.entity.Customer;
import com.customer.service.CustomerService;
@Controller
@RequestMapping("/api/customer")
public class CustomerController {
@Autowired
CustomerService customerService;	
@GetMapping("/home")
public String home() {
	return "index";
}
	
@PostMapping("/add")
@ResponseBody
public List<Customer> add(@RequestBody Customer customer) {
	 customerService.add(customer);
	 return customerService.getAllCustomer();
}
@GetMapping("/{id}")
@ResponseBody
public 	String delete( @PathVariable Long id) {
	customerService.delete(id);
	System.out.println("customer deleted");
	return "moye moye";
}
@GetMapping
@ResponseBody
public List<Customer> getAll(){
return	customerService.getAllCustomer();
}

@GetMapping("/search")
@ResponseBody
public List<String> searchCustomers(@RequestParam(name = "term") String email) {
    List<String> customers = customerService.findEmailsByPartialEmail("%" + email + "%");
    return customers;
    }


}
