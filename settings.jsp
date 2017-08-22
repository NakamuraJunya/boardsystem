<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="./css/style.css" rel="stylesheet" type="text/css">
	<title>ユーザー編集画面</title>

</head>
<body>
	<div class="main-contents">
<font size="5">ユーザー編集</font>

<script>
function check(){
	if(window.confirm('入力した内容で更新してもよろしいですか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false; // 送信を中止
	}
}
</script>

<c:if test="${ not empty errorMessages }">
	<div class="errorMessages">
		<ul>
			<c:forEach items="${errorMessages}" var="message">
				<li><c:out value="${message}" />
			</c:forEach>
		</ul>
	</div>
	<c:remove var="errorMessages" scope="session"/>
</c:if>

<form action = settings  method = "post" onSubmit="return check()"><br/>
	<label for="name">名前:</label>
	<input maxlength='10' name="name" value="${editUser.name}" />（10文字以内で入力してください）<br />
<p></p>
	<label for="loginId">ログインID:</label>
	<input type = hidden name="id" value="${editUser.id}">
	<input maxlength='20' name="loginId" value="${editUser.loginId}" />（半角英数字6文字以上20文字以下で入力してください）<br />
<p></p>
	<label for="password">パスワード:</label>
	<input maxlength='20' name="password" value="${password}" type="password" id="password"/>（記号を含む全ての半角文字6文字以上20文字以下で入力してください）<br />
<p></p>
	<label for="nextpassword">パスワード（再入力）:</label>
	<input maxlength='20' name="nextpassword" value="${nextpassword}" type="password" id="password"/> <br />
<p></p>

<c:if test="${users.id != editUser.id}" >
支店名:
<select name = "selectBranch">
    	<c:forEach items="${branchList}" var="branch">

				<option value="${branch.id}" <c:if test="${ branch.id == editUser.branchId }"> selected </c:if>  >${branch.name}</option>
		</c:forEach>
</select>
<p></p>
部署・役職:
<select name = "selectPosition">
    	<c:forEach items="${positionList}" var="position">
			<option value="${position.id}" <c:if test="${ position.id == editUser.positionId }"> selected </c:if> >${position.name}</option>
		</c:forEach>
</select>
</c:if>
<c:if test="${users.id == editUser.id}" >
<input type = hidden name="selectBranch" value="${1}" >
<input type = hidden name="selectPosition" value="${1}" >
</c:if>
<p></p>
	<button type="submit" name="id" value="${editUser.id}">登録</button>

</form>
<p></p>
	<a href="usermanagement">ユーザー管理に戻る</a>
<p></p>

</div>
</body>
</html>