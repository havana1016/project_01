<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-07
  Time: 오전 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="\resources\js\jquery.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
    <title>Title</title>


    <script>
        function login(){
            let mid=document.getElementById("mid").value;
            let mpw=document.getElementById("mpw").value;
            let uplogin=document.getElementById("uplogin")
            $.ajax({
                url:"/member/login",
                type:"post",
                data:{"mid":mid,"mpw":mpw},
                dataType:"json",
                success:function (e){
                    console.log("ajax success")
                    location.href="/member/main"
                },
                error(e){
                    console.log("ajax error")
                    uplogin.innerHTML="아이디 또는 비밀번호를 확인해주세요."
                    uplogin.style.color="red"
                    uplogin.style.fontSize="15px"

                }
            })
        }
    </script>


</head>
<body>
<div class="container" style="background-color:rgb(224,224,224);width:400px; height: 250px; padding: 30px; text-align: center; margin-top: 200px">
    <form>

        <div class="input-group container mt-3">
        <i class="bi bi-person-fill input-group-text" ></i>
        <input type="text" class="form-control input-group" id="mid" name="mid" placeholder="ID"><br>
        </div>
        <div class="input-group  container mt-3">
        <i class="bi bi-key input-group-text"></i>
        <input class="form-control input-group" type="text" id="mpw" name="mpw" placeholder="Password"><br>
        </div>
        <div id="uplogin" style="margin-bottom: 0">&nbsp;</div>
    </form>
    <div style="margin: 0">
    <button class="btn btn-secondary" onclick="login()">LOG_IN</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-secondary" onclick="location.href='/member/save'">JOIN_US</button>
    </div>
</div>
</body>
</html>
