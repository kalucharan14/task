<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
    $(document)
    .ready(function () {
      $('#cartTable')
        .DataTable();
    });
 
    </script>
</head>
<body>
<div>
<form id="addProductForm">
    <label for="productName">Product Name:</label>
    <input type="text" id="productName" name="productName" required="required">
    
    <label for="mrp">MRP:</label>
    <input type="number" id="mrp" name="mrp" required="required">
    
    <label for="productPrice">Product Price:</label>
    <input type="number" id="productPrice" name="productPrice" required="required">

    <button type="button" onclick="addProduct()">Add Product</button>
</form>
</div>
<div id="message"></div>
<div id="cartContainer">
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
<tbody id="productList"></tbody>
</table>
</div>
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
        loadProductList();
    });

   
    function loadProductList() {
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8081/api/products/all',
            success: function (products) {
            	console.log(products)
            	displayProducts(products);
            }
        });
    }

    
    console.log(productList);
    console.log("hello");
    console.log(productList);
    function addProduct() {
    	var productName = $('#productName').val();
        var mrp=$('#mrp').val();
        var productPrice = $('#productPrice').val();
        var data = {
            "productName": productName,
            "price": productPrice,
            "mrp":mrp
        };
        
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8081/api/products/add',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (updatedProductList) {
                //$('#message').text('Product added successfully!');
                
                Swal.fire({
               position: "top-end",
                icon: "success",
                title: "Your Product has been added",
                showConfirmButton: false,
                 timer: 1500
                  });
                // Reload the product list with updated data
                //updateProductList(updatedProductList);
                loadProductList();
            },
            error: function (error) {
                $('#message').text('Error adding product. Please try again.');
            }
        });
    }

    function displayProducts(products) {
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
     function updateTotal(productId) {
    	    const quantity = parseInt(document.getElementById("quantity"+productId).value, 10);
    	    const product = productList.find(p => p.productId === productId);
    	    if (product) {
    	      const total = product.price * quantity;
    	      document.getElementById("totalPrice"+productId).textContent = total.toFixed(2);
    	    }
    	  }
    
     function showCart() {
         const cartContainer = document.getElementById('cartContainer');
         cartContainer.style.display = 'block';
       }
</script>

</body>
</html>