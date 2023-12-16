<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script
	src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<style type="text/css">

nav {
    background-color: #333;
    overflow: hidden;
}

ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
}

li {
    float: right;
}

a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

a:hover {
    background-color: #ddd;
    color: black;
}

</style>
</head>
<body>
<nav>
    <ul>
        <li><a href="/views/index.jsp">Home</a></li>
        <li><a href="#" onclick="loadContent('products')">Products</a></li>
        <li><a href="#" onclick="loadContent('customerList')">Customer List</a></li>
    </ul>
</nav>
<div id="content"></div>

<script>
    function loadContent(page) {
        $.ajax({
            type: 'GET',
            url: '/views/'+page +'.jsp', 
            success: function (data) {
                $('#content').html(data);
            }
        });
    }

    // default load
    $(document).ready(function () {
        loadContent('home');
   });
</script>
</body>
</html>