<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer List</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
 <script>
 $(document).ready(function () {
    $('#customerTable').DataTable({
        ajax: {
            url: 'http://localhost:8081/api/customer',
            dataSrc: ''
        },
        columns: [
        { data: 'customerId', searchable: true },
            { data: 'cname', searchable: true },
            { data: 'phoneNo', searchable: true },
            {data:'email',searchable: true},
            {data:'address',searchable:true}
            // Add more columns as needed
        ]
    });
});
    </script>
</head>
<body>
<div>
<form >
    <label>Customer Name:</label>
    <input type="text" id="cname" name="cname" required value="">
    
    <label>Phone:</label>
    <input type="tel" id="phone" name="phone" required minlength="10" maxlength="10">
    
    <label >Email:</label>
    <input type="email" id="email" name="email" required value="">
    
    <label>Address:</label>
    <input type="text" id="address" name="address" required value="">

    <button type="button"  onclick="validateAndAddCustomer()">Add Customer</button>
</form>
</div>
<div id="orderDetails">
    <div id="leftSide">
        <div id="orderId"></div>
        <div id="orderDate"></div>
    </div>
    <div id="center">
        <ul id="orderProductsList"></ul>
    </div>
</div>

<div id="message"></div>
<div id="customerContainer">
    <table id="customerTable">
        <thead>
            <tr>
                <th>Customer ID</th>
                <th>Customer Name</th>
                <th>Customer Phone</th>
                <th>Email</th>
                <th>Address</th>
                <th>Actions</th>
            </tr>
        </thead>
<tbody id="customerList"></tbody>
</table>
</div>
<script>

function validateAndAddCustomer() {
    // Get form elements
    var cname = document.getElementById('cname');
    var phone = document.getElementById('phone');
    var email = document.getElementById('email');
    var address = document.getElementById('address');
    // Check if all fields are filled
    if (cname.value.trim() === '' || phone.value.trim() === '' || email.value.trim() === '' || address.value.trim() === '') {
        alert('Please fill in all fields');
        return;
    }
    else{
    // Perform the actual form submission or other actions
    addCustomer();
    }
    
    
}






//to get list of customers
function getAllCustomers(url) {
    return JSON.parse($.ajax({
        type: 'GET',
        url: url,
        dataType: 'json',
        global: false,
        async: false,
        success: function (data) {
            return data;
        }
    }).responseText);
}

var customerList = getAllCustomers('http://localhost:8081/api/customer');


$(document).ready(function () {
    loadCustomerList();
});

// Function to load product list
function loadCustomerList() {
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8081/api/customer',
        success: function (customers) {
            updateCustomerList(customers);
            customerList=customers;
        }
    });
}
function addCustomer() {
	
	 //const selectedProduct = products.find(product => product.id === productId);
	
	
	var customerName = $('#cname').val();
    var phone=$('#phone').val();
    var email = $('#email').val();
    var address=$('#address').val();
    const validEmail=customerList.find(customer=>customer.email===email);
    const validPhone=customerList.find(customer=>customer.phoneNo==phone);
     console.log(validPhone);
    if(validEmail){
    	Swal.fire({
    		  title: 'Error!',
    		  text: email+' already registered try another',
    		  icon: 'error',
    		  confirmButtonText: 'Ok'
    		})
    }
    else if(validPhone){
    	Swal.fire({
  		  title: 'Error!',
  		  text: phone+' already registered try another',
  		  icon: 'error',
  		  confirmButtonText: 'Ok'
  		})
    }
    else{
    var data = {
        "cname": customerName,
        "phoneNo": phone,
        "email":email,
        "address":address
    };
    $.ajax({
        type: 'POST',
        url: "http://localhost:8081/api/customer/add",
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (customers) {
            //$('#message').text('Customer added successfully!');
            Swal.fire({
               position:"top-end",
                icon: "success",
                title: "Your Customer has been added",
                showConfirmButton: false,
                 timer: 1500
                  });
            // Reload the product list with updated data
            loadCustomerList();
        },
        error: function (error) {
            $('#message').text('Error adding customer. Please try again.');
        }
    });
    document.getElementById('cname').value = '';
    document.getElementById('phone').value = '';
    document.getElementById('email').value = '';
    document.getElementById('address').value = '';
    }
    

}

// Function to update the product list
function updateCustomerList(customers) {
    var customerLists = $('#customerList');
    customerLists.empty();
    $.each(customers, function (index, customer) {
        // Append each product to the list
        customerLists.append('<tr>' +
            '<td>' + customer.customerId +'</td>'+
            '<td>' + customer.cname +'</td>'+
            '<td>'+ customer.phoneNo+'</td>'+
            '<td>'+customer.email+ '</td>'+
            '<td>'+customer.address+ '</td>'+
            '<td><button  onclick="viewOrders(' +customer.customerId+ ')">View Orders</button></td>'+
            '<td><button  onclick="confirmation(' +customer.customerId+ ')">Delete</button></td>'+
              '</tr>');
    });
}
function confirmation(customerId){
	Swal.fire({
		  title: "Are you sure?",
		  text: "You won't be able to revert this!",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "Yes, delete it!"
		}).then((result) => {
		  if (result.isConfirmed) {
			  deleteCustomer(customerId);
		    Swal.fire({
		      title: "Deleted!",
		      text: "Your file has been deleted",
		      icon: "success",
		    });
		  }
		});
}

function deleteCustomer(customerId){
	$.ajax({
		type:'GET',
		url:"http://localhost:8081/api/customer/"+customerId,
		 success: function () {
	            // Reload the product list with updated data
	            loadCustomerList();
	        },
	        error: function (error) {
	            $('#message').text('Error delete customer. Please try again.');
	        }
		
	});
}

function viewOrders(customerId){
    $.ajax({
        type: "GET",
        url: "http://localhost:8081/api/orders/" + customerId, // Adjust the URL based on your API endpoint
        dataType: "json",
        success: function (data) {
            // Clear existing content
            $("#leftSide").empty();
            $("#center").empty();

            $.each(data, function (index, order) {
                var orderContainer = $("<div>").addClass("order-container");

                var orderDetailsTable = $("<table>").addClass("order-details-table");
                orderDetailsTable.append("<thead><tr><th>Order ID</th><th>Order Date</th></tr></thead>");
                var orderDetailsBody = $("<tbody>");
                var row = $("<tr>").append("<td>" + order.oId + "</td><td>" + order.date + "</td>");
                orderDetailsBody.append(row);
                orderDetailsTable.append(orderDetailsBody);

                
                var orderProductsTable = $("<table>").addClass("order-products-table");
                orderProductsTable.append("<thead><tr><th>Product Name</th><th>Mrp</th><th>Price</th><th>Quantity</th></tr></thead>");
                var orderProductsBody = $("<tbody>");

                var totalPrice = 0;

                $.each(order.orderProducts, function (index, orderProduct) {
                    var productRow = $("<tr>").append("<td>" + orderProduct.productName + "</td>"+"<td>" + orderProduct.mrp + "</td>"+"<td>" + orderProduct.price + "</td><td>" + orderProduct.quantity + "</td>")
                    orderProductsBody.append(productRow);

                    totalPrice += orderProduct.price * orderProduct.quantity;
                });

                orderProductsTable.append(orderProductsBody);

                orderContainer.append(orderDetailsTable, orderProductsTable);

                orderContainer.append("<div>Total Price: " + totalPrice.toFixed(2) + "</div>");

                $("#leftSide").append(orderContainer);
            });
        },
        error: function (error) {
            console.error("Error fetching order details: ", error);
        }
    });
}

</script>

</body>
</html>