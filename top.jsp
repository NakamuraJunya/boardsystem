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
		<link href="./css/top.css" rel="stylesheet" type="text/css">
	<title>掲示板画面</title>
	<style type="text/css">
		body {
  			  background: -webkit-linear-gradient(-45deg,  rgba(61,104,153,1) 0%,rgba(32,124,202,1) 2%,rgba(32,124,202,1)
  			   13%,rgba(32,124,202,1) 34%,rgba(96,161,214,1) 53%,rgba(32,124,202,1)
  			   77%,rgba(41,137,216,1) 93%,rgba(125,185,232,1) 100%);
	}
			  }
	</style>
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
<script type="text/javascript">
function CountDownLength( idn, str, mnum ) {
   document.getElementById(idn).innerHTML = "あと" + (mnum - str.length) + "文字";
}
</script>

	<h3><font size="8">商売繁盛掲示板</font></h3>
<div id="menu_box">
 <c:if test="${loginUser.positionId==1}">
  <ul class="menu">
   <li class="drop_3row"><a href="#">メニュー</a>
      <ul>
        <li><a href="usermanagement">ユーザー管理</a></li>
        <li><a href="newmessage">新規投稿</a></li>
        <li><a href="logout">ログアウト</a></li>

      </ul>
   </li>
   </ul>
   </c:if>
  </div>
 <div id="menu_box">
 <c:if test="${loginUser.positionId!=1}">
  <ul class="menu">
   <li class="drop_2row"><a href="#">メニュー</a>
      <ul>
        <li><a href="newmessage">新規投稿</a></li>
        <li><a href="logout">ログアウト</a></li>
          </ul>
   </li>
   </ul>
   </c:if>
  </div>

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
<div class="box14">
	<form action = "./" method = "get"><div class="center"><font size="8" >絞込み検索</font></div><br/>
	<p></p>
【カテゴリー検索】:
<select name = "category" size="1">
	<option value="">カテゴリーを選択してください</option>
    	<c:forEach items="${categoryList}" var="category">
    		<c:if test="${ category.category == selectCatogory}">
				<option value="${category.category}" selected>${category.category}</option>
			</c:if>
			<c:if test="${ category.category != selectCatogory }">
				<option value="${category.category}">${category.category}</option>
			</c:if>
		</c:forEach>
	</select><br/><br/><br/>

【日付検索】:
		<label for="startDate"></label>
		<input type="date" name="startDate" value="${startDate}" />～

		<label for="endDate"></label>
		<input type="date" name="endDate" value="${endDate}" />
<p></p>
		<button type="submit" >検索</button><br/>
<p></p>

	</form>
	<form action = "./" method = "get"><font size="4"></font>
		<button type="submit" >全件表示</button>
	</form>
	<br/>
</div>
<p></p>
<div class="profile">
	<font size="4">	現在、<span class="name"><c:out value="${loginUser.name}" />でログイン中です</span></font>
</div>
<div class="box29">
   <div class="box-title">投稿一覧</div>
   <div class="messages">
</div>
	<c:forEach items = "${messages}" var = "message"><br/>
	<div class="box26">
		<span class="box-title">【件名】</span>
	 	<span class="title"><c:out value="${message.title}" /></span><br/>
	</div>
		<div class="box26">
			<span class="box-title">【カテゴリー】</span>
			<span class="category"><c:out value="${message.category}" /></span><br/>
		</div>
			<div class="box27">
				<span class="box-title">【本文】</span>
				<c:forEach var="text" items="${fn:split(message.text, '
				')}">
   					<div><c:out value="${text}"/></div>
				</c:forEach><br/>
			</div>
			<div class="left">
		【投稿者】:<span class="name"><c:out value="${message.name}" /></span><br/>
		【投稿日時】：<span class="createdAt"><fmt:formatDate value="${message.createdAt}" pattern="yyyy/MM/dd HH:mm:ss" /></span><br/>

				<form action = "messagedelete" method = "post" onSubmit="return check()" >

				<c:choose>
					<c:when test="${loginUser.id == message.userId}">
						 <button type="submit" name="id" value="${message.id}">投稿削除</button><p><p/>
					</c:when>

					<c:when test="${loginUser.positionId == 2}">
 						<button type="submit" name="id" value="${message.id}">投稿削除</button><p><p/>
					</c:when>

					<c:when test="${loginUser.branchId == message.branchId && loginUser.positionId == 3}">
						<button type="submit" name="id" value="${message.id}">投稿削除</button><p><p/>
					</c:when>

				</c:choose>

		 		</form>
		 	</div>
					<c:forEach items="${comments}" var="comment">
						<c:if test="${message.id == comment.messageId}">
							<div class="box28">
								<span class="box-title">【コメント】</span>
						<c:forEach var="text" items="${fn:split(comment.text, '
								')}">
   							<div><c:out value="${text}"/></div>
						</c:forEach><br/>
							</div>
							<div class="left">
								【投稿者】:<span class="name"><c:out value="${comment.name}" /></span><br/>
								【投稿日時】：<span class="createdAt"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy/MM/dd HH:mm:ss" /></span><br/>
							</div>
							<form action = "commentdelete" method = "post" onSubmit="return check()" >

								<c:choose>
									<c:when test="${loginUser.id == comment.userId}">
									 <button type="submit" name="id" value="${comment.id}">コメント削除</button><p><p/>
									</c:when>

									<c:when test="${loginUser.positionId == 2}">
		 								<button type="submit" name="id" value="${comment.id}">コメント削除</button><p><p/>
									 </c:when>

									<c:when test="${loginUser.branchId == comment.branchId && loginUser.positionId == 3}">
										<button type="submit" name="id" value="${comment.id}">コメント削除</button><p><p/>
										<input type = hidden name="id" value="${user.id}">
									</c:when>

								</c:choose>
		 					</form>
						</c:if>
					</c:forEach>
			 <form action="newcomment" method="post">
				【コメント入力スペース】<p></p>
         		<input type = hidden name="messageId" value="${message.id}" >
         		<textarea name="text" maxlength='500' cols="100" rows="5" class="tweet-box" onkeyup="CountDownLength( '${message.id}' , value , 500 );">${makeComment.text}</textarea>
        		<p id = ${message.id}>残り500文字</p>
        	 	<button name="userId" value="${loginUser.id}">コメント</button>
       		 </form>
       		 <p></p>
   		</c:forEach>
	</div>

<div class="copyright">Copyright(c)Junya Nakamura</div>

</body>
</html>