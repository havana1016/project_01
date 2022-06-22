<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-07
  Time: 오후 7:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="\resources\js\jquery.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
</head>
<body>
<div class="mt-5 container" style="padding: 30px;width: 350px; text-align: center;background-color:rgb(224,224,224) " >
    <h2>회원가입</h2>
    <form action="/member/save" method="post">
        <input type="text" class="form-control mt-3" name="mid" id="mid" placeholder="Id" minlength="4" maxlength="20"><br>
        <p id="upid"></p>
        <input type="text" class="form-control" name="mpw" id="mpw" placeholder="Password"><br>
        <p id="uppw"></p>
        <input type="text" class="form-control"  placeholder="Password 확인"><br>
        <p id="uprepw"></p>
        <input type="submit" class="mt-1 btn btn-dark" value="가입">
    </form>

</div>


</body>
</html>
