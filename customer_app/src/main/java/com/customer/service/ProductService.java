package com.customer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.customer.entity.Products;
import com.customer.repository.ProductRepository;
import com.customer.serviceImp.IProducts;
@Service
public class ProductService  implements IProducts{
    @Autowired
	ProductRepository productRepository;
	@Override
	public Products add(Products products) {
	return	productRepository.save(products);
	}
 
	@Override
	public List<Products> getAll() {
		// TODO Auto-generated method stub
		return productRepository.findAll();
	}

}
