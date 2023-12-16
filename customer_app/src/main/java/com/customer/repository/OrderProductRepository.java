package com.customer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.customer.entity.OrderProducts;

public interface OrderProductRepository extends JpaRepository<OrderProducts, Long> {

}
