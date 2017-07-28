<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>簡易Twitter</title>
</head>
<body>
<div class="main-contents">

<div class="header">
	<c:if test="${ empty loginUser }">
		<a href="login">ログイン</a>
		<a href="signup">登録する</a>
    </c:if>
	<c:if test="${ not empty loginUser }">
		<a href="./">ホーム</a>
		<a href="settings">設定</a>
		<a href="logout">ログアウト</a>
	</c:if>
</div>

<div class="copyright">Copyright(c)Junya Nakamura</div>
</div>
</body>
</html>
