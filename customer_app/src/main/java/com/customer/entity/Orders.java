package com.customer.entity;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
@Entity
public class Orders {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long oId;
	private LocalDate date;
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name = "customer_id")
	private Customer customer;
	@JsonManagedReference
	@OneToMany(mappedBy = "orders")
	private List<OrderProducts> orderProducts;
	@PrePersist
	@PreUpdate
	public void date() {
			date=LocalDate.now();
		}
	
	public Orders() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Long getoId() {
		return oId;
	}
	public void setoId(Long oId) {
		this.oId = oId;
	}
	public LocalDate getDate() {
		return date;
	}
	public void setDate(LocalDate date) {
		this.date = date;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public List<OrderProducts> getOrderProducts() {
		return orderProducts;
	}
	public void setOrderProducts(List<OrderProducts> orderProducts) {
		this.orderProducts = orderProducts;
	}
	@Override
	public String toString() {
		return "Orders [oId=" + oId + ", date=" + date + ", customer=" + customer + ", orderProducts=" + orderProducts
				+ "]";
	}
	
	
	
}
