<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="<c:url value="/css/main.css" />" />

<title>Product</title>
<script type="text/javascript" src="<c:url value="/js/jquery-1.9.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/json2.js" />"></script>
<script type="text/javascript">
function clearForm() {
	jQuery("#idResult").text("");
	
	var inputs = document.getElementsByTagName("input");
	for(var i=0; i<inputs.length; i++) {
		if(inputs[i].type=="text") {
			inputs[i].value="";
		}
	}
}
var contextPath = "${pageContext.request.contextPath}";
function doBlur() {
 	var idValue = jQuery("input[name=id]").val();
	var options = new Object();
	options.url=contextPath+"/pages/product.view";
	options.type="POST";
	options.data="id="+encodeURI(idValue);
	options.async=true;
	options.dataType="json";
	options.cache=false;
	options.success=processJSON;
	jQuery.ajax(options);
}
function processJSON(text) {
	var jsonResult = eval(text);
	jQuery("#idResult").text(jsonResult[0].text);
	if(jsonResult[0].hasMoreData) {
		jQuery("input[name=id]").val(jsonResult[1].id);
		jQuery("input[name=name]").val(jsonResult[1].name);
		jQuery("input[name=price]").val(jsonResult[1].price);
		jQuery("input[name=make]").val(jsonResult[1].make);
		jQuery("input[name=expire]").val(jsonResult[1].expire);
	}
}
</script>
</head>
<body>

<h3>Welcome ${user.custid}</h3>

<h3>Product Table</h3>

<form action="<c:url value="/pages/product.controller" />" method="post">
<table>
	<tr>
		<td>ID : </td>
		<td><input type="text" name="id" value="${param.id}" onblur="doBlur()" onfocus="clearForm()" ></td>
		<td><span id="idResult" class="error">${errors.id}</span></td>
	</tr>
	<tr>
		<td>Name : </td>
		<td><input type="text" name="name" value="${param.name}"></td>
		<td></td>
	</tr>

	<tr>
		<td>Price : </td>
		<td><input type="text" name="price" value="${param.price}"></td>
		<td><span class="error">${errors.price}</span></td>
	</tr>
	<tr>
		<td>Make : </td>
		<td><input type="text" name="make" value="${param.make}"></td>
		<td><span class="error">${errors.make}</span></td>
	</tr>
	<tr>
		<td>Expire : </td>
		<td><input type="text" name="expire" value="${param.expire}"></td>
		<td><span class="error">${errors.expire}</span></td>
	</tr>
	<tr>
		<td>
			<input type="submit" name="prodaction" value="Insert">
			<input type="submit" name="prodaction" value="Update">
		</td>
		<td>
			<input type="submit" name="prodaction" value="Delete">
			<input type="submit" name="prodaction" value="Select">
			<input type="button" value="Clear" onclick="clearForm()">
		</td>
	</tr>
</table>

</form>

<h3><span class="error">${errors.action}</span></h3>
<c:if test="${not empty insert}">
	<h3>Insert Product Table Success</h3>
	<table border="1">
		<tr><td>Id:</td><td>${insert.id}</td></tr>
		<tr><td>Name:</td><td>${insert.name}</td></tr>
		<tr><td>Price:</td><td>${insert.price}</td></tr>
		<tr><td>Make:</td><td>${insert.make}</td></tr>
		<tr><td>Expire:</td><td>${insert.expire}</td></tr>
	</table>
	<script type="text/javascript">clearForm();</script>	
</c:if>

<c:if test="${not empty update}">
	<h3>Update Product Table Success</h3>
	<table border="1">
		<tr><td>Id:</td><td>${update.id}</td></tr>
		<tr><td>Name:</td><td>${update.name}</td></tr>
		<tr><td>Price:</td><td>${update.price}</td></tr>
		<tr><td>Make:</td><td>${update.make}</td></tr>
		<tr><td>Expire:</td><td>${update.expire}</td></tr>
	</table>
	<script type="text/javascript">clearForm();</script>
</c:if>

<c:if test="${not empty delete and delete}">
	<h3>Delete Product Table Success</h3>
	<script type="text/javascript">clearForm();</script>
</c:if>

</body>
</html>