package com.customer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.customer.entity.Products;

public interface ProductRepository extends JpaRepository<Products, Long> {

}
