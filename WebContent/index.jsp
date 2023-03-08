<!DOCTYPE html>
<html>
<head>
        <title>Gramophone Records Main Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
  font-family:Brush Script MT , Helvetica, sans-serif;
}

.topnav {
  overflow: hidden;
  background-color: #46636F;
  position: sticky;
}

.topnav #myLinks {
  display: none;
}

.topnav a {
  color: white;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  display: block;
}

.topnav a.icon {
  background: 324750;
  display: block;
  position: absolute;
  right: 0;
  top: 0;
}

.topnav a:hover {
  background-color: #ddd;
  color: black;
}

.active {
  background-color: #324750;
  color: white;
}
</style>
</head>
<body>



<div class="topnav">
  <p style=> </p>
 
  <div id="myLinks">
    <a href="index.jsp">HOME</a>
    <a  href="login.jsp">LOGIN</a>
    <a href="logout.jsp">LOG OUT</a>
	<a href="addcart.jsp">CHECKOUT</a>
  </div>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">
    <i class="fa fa-bars"></i>
  </a>
</div>


</div>

<script>
function myFunction() {
  var x = document.getElementById("myLinks");
  if (x.style.display === "block") {
    x.style.display = "none";
  } else {
    x.style.display = "block";
  }
}
</script>
</head>
<body bgcolor = "#AAC0CA">
<h1 align="center">Welcome to Gramophone Records</h1><br><br>
<p align="center">At Gramophone Records we aim to connect users with their favourite musicians from across the world </p>
<p align="center">We recognize the sudden need for the reintroduction of vinyl records thanks to the recent turn to new technology and digital music. Gramophone Records allows music lovers to have easy and fast access to a variety of vinyl records. </p>
<p align="center">We are a web based company that operates out of Kelowna, BC and ship internationally. </p>
<p align="center">We offer a curated collection of vinyl products in a variety of genres. </p>
<p align="center">Our company is one of the only in the market that offers straight to your door free delivery on all products ordered through our website.</p>
<br><br>
<p  align="center">Create an account today!</p>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<h2 align="center"><a href="ship.jsp">Shipment</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
%>
</body>
</head>


