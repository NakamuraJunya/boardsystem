<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>掲示板画面</title>
</head>
<body>
<script>

function check(){
	if(window.confirm('選択した内容を削除してもよろしいですか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false; // 送信を中止
	}
}

</script>

	<div class="header">
	<c:if test="${loginUser.positionId==1}">
		<a href="usermanagement">ユーザー管理</a>
	</c:if>
		<a href="newmessage">新規投稿</a>
		<a href="logout">ログアウト</a>
	</div>
	<p><p/>
	<div class="profile">
		現在、<span class="name"><c:out value="${loginUser.name}" />でログイン中です</span>
	</div>
	<p><font size="5">商売繁盛掲示板</font></p>
	<p><p/>
	<div>
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
	</div>

	<form action = "./" method = "get"><font size="4">絞込み検索</font>
	<p><p/>
【カテゴリー検索】:
<select name = "category" size="1">
	<option value="">カテゴリーを選択してください</option>
    	<c:forEach items="${categoryList}" var="category">
    		<c:if test="${ makeMessage.category == category.category }">
				<option value="${category.category}" selected>${category.category}</option>
			</c:if>
			<c:if test="${ makeMessage.category != category.category }">
				<option value="${category.category}">${category.category}</option>
			</c:if>
		</c:forEach>
	</select>

【日付検索】:
		<label for="startDate"></label>
		<input type="date" name="startDate" value="${startDate}" />～

		<label for="endDate"></label>
		<input type="date" name="endDate" value="${endDate}" /><br />

		<p><p/>

		<button type="submit" >検索</button>
		<p><p/>
	</form>
	<br/>

	<div class="messages">

		<c:forEach items = "${messages}" var = "message"><br/>

		【件名】：<span class="title"><c:out value="${message.title}" /></span><br/><p><p/>

		【カテゴリー】：<span class="category"><c:out value="${message.category}" /></span><br/><p><p/>

		【本文】<c:forEach var="text" items="${fn:split(message.text, '
		')}">
   					<div><c:out value="${text}"/></div>
				</c:forEach><br/><p><p/>

		【投稿者】:<span class="name"><c:out value="${message.name}" /></span><br/><p><p/>

		【投稿日時】：<span class="createdAt"><fmt:formatDate value="${message.createdAt}" pattern="yyyy/MM/dd HH:mm:ss" /></span><br/><p><p/>

			<form action = "messagedelete" method = "post" onSubmit="return check()" >

				<c:choose>
					<c:when test="${loginUser.id == message.userId}">
						 <button type="submit" name="id" value="${message.id}">削除</button><p><p/>
					</c:when>

					<c:when test="${loginUser.positionId == 2}">
 						<button type="submit" name="id" value="${message.id}">削除</button><p><p/>
					</c:when>

					<c:when test="${loginUser.branchId == message.branchId && loginUser.positionId == 3}">
						<button type="submit" name="id" value="${message.id}">削除</button><p><p/>
					</c:when>

				</c:choose>

		 	</form>
		 	<p><p/>

			<br/>
			<c:forEach items="${comments}" var="comment">
				<c:if test="${message.id == comment.messageId}">
				【コメント】
					<c:forEach var="text" items="${fn:split(comment.text, '
								')}">
   						<div><c:out value="${text}"/></div>
					</c:forEach><br/><p><p/>
					【投稿者】:<span class="name"><c:out value="${comment.name}" /></span><br/><p><p/>
					【投稿日時】：<span class="createdAt"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy/MM/dd HH:mm:ss" /></span><br/><p><p/>

					<form action = "commentdelete" method = "post" onSubmit="return check()" >

						<c:choose>
							<c:when test="${loginUser.id == comment.userId}">
							 <button type="submit" name="id" value="${comment.id}">削除</button><p><p/>
							</c:when>

							<c:when test="${loginUser.positionId == 2}">
 								<button type="submit" name="id" value="${comment.id}">削除</button><p><p/>
							 </c:when>

							<c:when test="${loginUser.branchId == comment.branchId && loginUser.positionId == 3}">
								<button type="submit" name="id" value="${comment.id}">削除</button><p><p/>
								<input type = hidden name="id" value="${user.id}">
							</c:when>

						</c:choose>

		 			</form>
				</c:if>
			</c:forEach>
			<form action="newcomment" method="post">
				【コメント入力スペース】
         		<input type = hidden name="messageId" value="${message.id}" >
         		<textarea name="text" cols="100" rows="5" class="tweet-box">${makeComment.text}</textarea>
        		<p></p>
        	 	<button name="userId" value="${loginUser.id}">コメント</button>
       		 </form>
       		 <p></p>
   		</c:forEach>
	</div>

<div class="copyright">Copyright(c)Junya Nakamura</div>

</body>
</html>
