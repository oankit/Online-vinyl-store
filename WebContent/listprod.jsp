
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<title>Gramophone Records List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
  font-family: Arial, Helvetica, sans-serif;
}

.topnav {
  overflow: hidden;
  background-color: #46636F;
  position: relative;
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
  <p style="font-size:20px;" align = "center"  > Gramophone Records</p>
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
<style>
	table {
	
	  font-family: arial, sans-serif;
	
	  border-collapse: collapse;
	
	  width: 100%;
	
	}
	td, th {
	
	  border: 1px solid #dddddd;
	
	  text-align: left;
	
	  padding: 8px;

	
	}
	tr:nth-child(even) {
	
	  background-color: #dddddd;
	
	}
	</style>
</head>
<body bgcolor = "#AAC0CA">


<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
	<p align="left">
		<select size="1" name="catName">
		<option  value="">All</option>
	  
		<option value="Jazz">Jazz</option>
		<option  value="Electronic">Electronic</option>
		<option  value="Funk/Soul">Funk/Soul</option>
		<option  value="Hip Hop">Hip Hop</option>
		<option  value="Rock">Rock</option>
		<option  value="Soundtrack">Soundtrack</option>   
		</select>
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
String cat =  request.getParameter("catName");


		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
Locale locale = new Locale("en", "US");
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(locale);
try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
{
	PreparedStatement all = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
		ResultSet rst = null;
		ResultSet rst2 = null;
		ResultSet rst3= null;
		boolean notEmpty = name!=null && !name.equals("");
		boolean noCat = cat != null && cat.equals("");

		if(!notEmpty && cat == null){

		all= con.prepareStatement("SELECT productId,  productName, productPrice, categoryName FROM product JOIN category ON product.categoryId = category.categoryId");
		 rst = all.executeQuery();
		 
		 out.println("<h2>All Products</h2><table><tr><th></th><th>Product Name </th><th>Category</th><th>Price </th></tr>");

			while (rst.next()) {
				String link = "\"addcart.jsp?id=" + rst.getString(1) + "&name=" + rst.getString(2) + "&price=" + rst.getString(3) + "\"";
				String link2 = "\"product.jsp?id=" + rst.getString(1) + "&name=" + rst.getString(2) + "&price=" + rst.getString(3) + "\"";

				out.println("<tr><td><a href="+link+"\">Add to cart</a></td><td>"+"<a href="+link2+"\">"+rst.getString(2)+"</a></td><td>"+rst.getString(4)+"</td><td>"+currFormat.format(rst.getBigDecimal(3))+"</td></tr>");
			}

			out.println("</table>");
		}
		else if(!notEmpty && !noCat){

			String sql = "SELECT productId, productName, productPrice, categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE categoryName LIKE ?";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setString(1,"%"+cat+"%");
			rst3 = pstmt2.executeQuery();
		
		out.print("<h2>Category containing '"+cat+"'</h2>");
		out.print("<table><tr><th></th><th>Product Name</th><th>Category</th><th>Price </th></tr>");
			while (rst3.next()) { 
				String link = "\"addcart.jsp?id=" + rst3.getString(1) + "&name=" + rst3.getString(2) + "&price=" + rst3.getString(3) +  "\"";
				String link2 = "\"product.jsp?id=" + rst3.getString(1) + "&name=" + rst3.getString(2) + "&price=" + rst3.getString(3) + "\"";
				out.println("<tr><td><a href="+link+"\">Add to cart</a></td><td>"+"<a href="+link2+"\">"+rst3.getString(2)+"</a></td><td>"+rst3.getString(4)+"</td><td>"+currFormat.format(rst3.getBigDecimal(3))+"</td></tr>");
			}
		out.print("</table>");

		}

else{
    
	String sql = "SELECT productId, productName, productPrice,categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,"%"+name+"%");
	rst2 = pstmt.executeQuery();

out.print("<h2>Products containing '"+name+"'</h2>");
out.print("<table><tr><th></th><th>Product Name</th><th>Category</th><th>Price </th></tr>");
	while (rst2.next()) { 
		String link = "\"addcart.jsp?id=" + rst2.getString(1) + "&name=" + rst2.getString(2) + "&price=" + rst2.getString(3) +  "\"";
		String link2 = "\"product.jsp?id=" + rst2.getString(1) + "&name=" + rst2.getString(2) + "&price=" + rst2.getString(3) + "\"";
		out.println("<tr><td><a href="+link+"\">Add to cart</a></td><td>"+"<a href="+link2+"\">"+rst2.getString(2)+"</a></td><td>"+rst2.getString(4)+"</td><td>"+currFormat.format(rst2.getBigDecimal(3))+"</td></tr>");
	}
out.print("</table>");
}
}
catch (SQLException ex) 
{ 	out.println(ex); 
}	

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberForm;t currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>



</body>
</html>

