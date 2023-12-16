package com.customer.serviceImp;

import java.util.List;

import com.customer.entity.Orders;

public interface IOrders {
 List<Orders> findByCustomerCustomerId(Long customerId);
}
