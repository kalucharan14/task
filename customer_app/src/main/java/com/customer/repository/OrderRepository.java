package com.customer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.customer.entity.Orders;

public interface OrderRepository extends JpaRepository<Orders, Long> {
	
	  @Query("SELECT o FROM Orders o JOIN FETCH o.orderProducts WHERE o.customer.customerId = :customerId")
	List<Orders> findByCustomerCustomerId(Long customerId);
}
