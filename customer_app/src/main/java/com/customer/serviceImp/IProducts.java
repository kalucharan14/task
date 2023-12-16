package com.customer.serviceImp;

import java.util.List;

import com.customer.entity.Products;


public interface IProducts {

	 Products add(Products products);
	 List<Products> getAll();
}
