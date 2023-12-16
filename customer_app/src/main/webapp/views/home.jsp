<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>


<style type="text/css">
/* General styling */
body {
    font-family: Arial, sans-serif;
    margin: 20px;
}

/* Search input */
#searchInput {
    padding: 5px;
    width: 200px;
}

/* Product list */
#productList {
    list-style: none;
    padding: 0;
}

#cartTable {
    border-collapse: collapse;
    width: 100%;
    margin-top: 20px;
}

#cartTable th, #cartTable td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

#cartTable th {
    background-color: #f2f2f2;
}

/* Total price display */
#totalPrice {
    font-weight: bold;
}

/* Contact info input */
#contactInfo {
    padding: 5px;
    width: 300px;
}

/* Place order button */
button {
    background-color: #4caf50;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background-color: #45a049;
}

</style>
    
</head>
<body>
<div>
        <input type="text" id="searchInput" placeholder="Search Product">
   </div>
       <div>
        <ul id="productList"></ul>
    </div>
   <div>
   <table id="cartTable">
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Mrp</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Action</th>
            </tr>
        </thead>
<tbody id="cartList"></tbody>
</table>

        <p>Total Price: Rs<span id="totalPrice">0.00</span></p>
    </div>
    <div>
			<label >Mobile or Email:</label> <input type="email"
				id="contactInfo" placeholder="Enter mobile or email"
				required="required">
		</div>
		<div id="searchResults"></div>
		<button onclick="placeOrder()">Place Order</button>
    
    <script>
    function getAllProducts(url) {
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

    var productList = getAllProducts('http://localhost:8081/api/products/all');

    
    
    $(document).ready(function () {
        // Attach input event to search as the user types
        $('#searchInput').on('input', function () {
            searchProduct($(this).val());
        });
    });
    
    function searchProduct(searchTerm) {
        // Make an AJAX request to your server to get product details
        if (searchTerm && searchTerm.trim() !== '') {
        $.ajax({
            url: 'http://localhost:8081/api/products/searchProduct', 
            type: 'GET',
            data: { name: searchTerm },
            success: function (data) {
                displayProductResults(data);
            },
            error: function (error) {
                console.error('Error searching product:', error);
            }
        });
    }
        else{
        	$('#productList').empty();
        }
        
    }
    
    
    function displayProductResults(products){
    	$('#productList').empty();
    	const tableBody = document.getElementById('productList');
        products.forEach(product => {
        const row = createProductRow(product);
        tableBody.appendChild(row);
        });
    }
    
    
    function createProductRow(product) {
        const row = document.createElement('tr');
        row.innerHTML =
        '<td>' + product.productId + '</td>' +
        '<td>' + product.productName + '</td>' +
        '<td>' + product.mrp + '</td>' +
        '<td>' + product.price + '</td>' +
        '<td><input type="number" value="1" id="quantity' + product.productId + '" min="1" onchange="updateTotal(' + product.productId + ')"></td>' +
        '<td id="totalPrice' + product.productId + '">' + product.price.toFixed(2) + '</td>' +
        '<td><button  onclick="addToCart(' +product.productId+ ')">Add to Cart</button></td>';
        return row;
      }
    
    let cart=[];
    
    // Function to add a product to the cart
    function addToCart(productId) {
  	 if(!cart.some((s)=>s.id===productId)){
      const selectedProduct = productList.find(product => product.productId === productId);
      if(selectedProduct) {
        const quantity = parseInt(document.getElementById("quantity"+productId).value, 10);
        const productInCart = { ...selectedProduct, quantity };
        cart.push(productInCart);
        updateCartList();
        updateTotalPrice();
      }
  	  }
  	  else{
  		  
  	  }
    }

    // Function to update the cart list on the page
  function updateCartList() {
    const cartList = document.getElementById('cartList');
    cartList.innerHTML = '';
    cart.forEach(product => {
      const row = document.createElement('tr');
      row.innerHTML = 
    	'<td>' + product.productId + '</td>' +
    	'<td>' + product.productName + '</td>' +
    	'<td>' + product.mrp + '</td>' +
    	'<td>' + product.price + '</td>' +
    	'<td>' + product.quantity + '</td>' +
        '<td>'+(product.price * product.quantity)+'</td>'+
        '<td><button onclick="removeFromCart('+product.productId+')">Remove</button></td>'
      ;
      cartList.appendChild(row);
    });
  }

    
    function updateTotal(productId) {
        const quantity = parseInt(document.getElementById("quantity"+productId).value, 10);
        const product = productList.find(p => p.productId === productId);
        if (product) {
          const total = product.price * quantity;
          document.getElementById("totalPrice"+productId).textContent = total.toFixed(2);
          updateTotalPrice();
        }
      }
    
    function updateTotalPrice() {
        const totalPriceElement = document.getElementById('totalPrice');
        const totalPrice = cart.reduce((sum, product) => sum + product.price * product.quantity, 0);
        totalPriceElement.textContent = totalPrice.toFixed(2);
      }

    function removeFromCart(productId) {
        cart = cart.filter(product => product.productId !== productId);
        updateCartList();
        updateTotalPrice();
      }
    
    function placeOrder(){
    	const contactInfo = document.getElementById('contactInfo').value;
                const data = {
                    email: contactInfo,
                    list: cart
                };
                fetch("http://localhost:8081/api/orders/placeOrder", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                   body: JSON.stringify(data)
                })
                .then(responseData => {
                	Swal.fire({
                        position:"top-end",
                         icon: "success",
                         title: "Your Ordes Sucessfully",
                         showConfirmButton: false,
                          timer: 1500
                           });
                })
                .catch(error => {
                    console.error("Error sending data:", error);
                    alert("Error placing order");
                });   
                }
      
    
    $(document).ready(function () {
        $("#contactInfo").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: "http://localhost:8081/api/customer/search",
                    dataType: "json",
                    data: {
                        term: request.term
                    },
                    success: function (data) {
                        response(data);
                    }
                });
            },
            minLength: 2, 
            select: function (event, ui) {
                console.log("Selected: " + ui.item.value);
            }
        });
    });    </script>
    
</body>
</html>