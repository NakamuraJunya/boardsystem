<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="./css/newcomment.css" rel="stylesheet" type="text/css">
	<title>新規投稿画面</title>
</head>
<body>
			<style type="text/css">
				body {
					background:#207cca
			}
		}
	}
			</style>
			
	<h3><font size="8">新規投稿</font></h3>


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
	<script>
		function check(){
			if(window.confirm('投稿してもよろしいですか？')){ // 確認ダイアログを表示
			return true; // 「OK」時は送信を実行
			}
			else{ // 「キャンセル」時の処理
			window.alert('キャンセルされました'); // 警告ダイアログを表示
			return false; // 送信を中止
		}
	}
	</script>

		<script type="text/javascript">
			function CountDownLength( idn, str, mnum ) {
  			 document.getElementById(idn).innerHTML = "あと" + (mnum - str.length) + "文字";
			}
		</script>

<form action="newmessage" method="post" onSubmit="return check()">

<p class="form-item">
<label for="title">件名:</label>
<input maxlength='30' name="title"value="${makeMessage.title}" id="title"/>（30文字以内で入力してください)<br />
<p></p>
既存カテゴリー:
	<select name = "category" size="1">
	<option value=""></option>
    	<c:forEach items="${categoryList}" var="category">
    		<c:if test="${ newMakeMessage == category.category }">
				<option value="${category.category}" selected>${category.category}</option>
			</c:if>
			<c:if test="${ newMakeMessage != category.category }">
				<option value="${category.category}">${category.category}</option>
			</c:if>
		</c:forEach>
	</select>（すでに存在するものがあれば選択してください）
<p></p>
<label for="newcategory">新規カテゴリー:</label>
<input maxlength='10' name="newCategory" value = "${makeMessage.category}"id="newCategory"/>（10文字以内で入力してください）
<p></p>
<label for="text">本文:</label>（1000文字以内で入力してください）
<br />
<textarea maxlength='1000' name="text" cols="100" rows="5" class="tweet-box" onkeyup="CountDownLength( 'cdlength1' , value , 1000 );">${makeMessage.text}</textarea>
<p id="cdlength1">残り1000文字</p><br />
<p></p>
<button type="submit" value="投稿">投稿</button>
</form>
<p></p>
	<a href="./">ホームに戻る</a>
	<p></p>
</div>
</body>
</html>