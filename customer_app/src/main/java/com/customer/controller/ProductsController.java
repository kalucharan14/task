package com.customer.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.customer.entity.Products;
import com.customer.service.ProductService;


@Controller
@RequestMapping("api/products")
public class ProductsController {

@Autowired
ProductService productService;
@PostMapping("/add")
@ResponseBody
public List<Products> add(@RequestBody Products products) {
	productService.add(products);
	return productService.getAll();
	}
@GetMapping("/all")
@ResponseBody
public List<Products> getAll() {
	return productService.getAll();
}

@GetMapping("/searchProduct")
@ResponseBody
public List<Products> searchProduct(@RequestParam String name) {
    String lowerCaseName = name.toLowerCase();
    return productService.getAll().stream()
            .filter(product -> product.getProductName().toLowerCase().contains(lowerCaseName))
            .collect(Collectors.toList());
    
}
	
	
	
}
