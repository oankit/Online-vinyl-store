<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Date" %>

<html>
<head>
<title>Gramophone Records</title>
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
  <p style="font-size:20px; font-family : 'Brush Script MT', cursive"> Gramophone Records</p>
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



<%
// Get product name to search for
// TODO: Retrieve and display info for the product


String pId = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
out.print("<h2>"+name+"</h2>");
out.print("<table><tr><th>Id</th><td>"+pId+"</td></tr><tr><th>Price</th><td> $"+price+"</td></tr>");

String sql = "SELECT productId, productName, productPrice FROM product";
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String ps = "YourStrong@Passw0rd";

int reviewRating= request.getParameter("reviewRating");
String custId = request.getParameter("customerId");
String reviewComment = request.getParameter("reviewComment");

// Save order information to database
try(Connection con = DriverManager.getConnection(url,uid,ps);){


// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping

PreparedStatement pstmt= con.prepareStatement("SELECT productId, productName, productPrice, productImageURL, productDesc  FROM product WHERE productId= ?");
pstmt.setString(1, pId);
ResultSet rst = pstmt.executeQuery();
// TODO: If there is a productImageURL, display using IMG tag
 

while (rst.next()) { 
        out.println("<img src=" + rst.getString(4) + ">");
String link = "\"addcart.jsp?id=" + rst.getString(1) + "&name=" + rst.getString(2) + "&price=" + rst.getString(3) + "\"";
out.println("<p>Product Description: "+ rst.getString(5) + " </p>");
out.println("<h2><a href = "+link+"\">Add to Cart</a></h2>");
out.println("<h2><a href = listprod.jsp>Return to shopping</a></h2>");
}
Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
  NumberFormat currFormat = NumberFormat.getCurrencyInstance();
 
  while (iterator.hasNext())
  { 
Map.Entry<String, ArrayList<Object>> entry = iterator.next();
sql2 = "INSERT INTO review ( reviewRating,reviewDate, customerId, productId, reviewComment) VALUES(?, ?, ?, ?)";
pstmt = con.prepareStatement(sql);
pstmt.setInt(1, reviewRating);
pstmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
pstmt.setInt(3, customerId);
pstmt.setString(4, pId);
pstmt.setString(5, reviewComment);
pstmt.executeUpdate();	

}
catch (SQLException ex) 
{ 	out.println(ex); 
}


			
  }
  <br>

  <div style="margin:0 auto;text-align:center;display:inline;">

<h2 align="leave">Leave a review</h2>

<form name="Form2" method=post action="addReview.jsp">
<table style="display:inline">
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Comment:</font></div></td>
        <td><input type="text" name="reviewComment"  size=30 maxlength="1000"></td>
    </tr>
    <tr>
      <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Rating:</font></div></td>
        <td><input type="number" name="reviewRating"  size=30 maxlength="100"></td>
      </tr>
      </table>
      <br/>
      <input class="submit" type="submit" name="Submit2" value="Add review">
      </form>
      <br>

       
      
%>

</body>
</html>

