package com.customer.entity;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
@Entity
public class OrderProducts {
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
	private Long orderProductId;
	private Long productId;
	private String productName;
	private int quantity;
	private double mrp ;
	private double price;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name = "orders_id")
	private Orders orders;

	public OrderProducts() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Long getOrderProductId() {
		return orderProductId;
	}

	public void setOrderProductId(Long orderProductId) {
		this.orderProductId = orderProductId;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getMrp() {
		return mrp;
	}

	public void setMrp(double mrp) {
		this.mrp = mrp;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Orders getOrders() {
		return orders;
	}

	public void setOrders(Orders orders) {
		this.orders = orders;
	}

	@Override
	public String toString() {
		return "OrderProducts [orderProductId=" + orderProductId + ", productId=" + productId + ", productName="
				+ productName + ", quantity=" + quantity + ", mrp=" + mrp + ", price=" + price + ", orders=" + orders
				+ "]";
	}
	
	
	
	
	
}
