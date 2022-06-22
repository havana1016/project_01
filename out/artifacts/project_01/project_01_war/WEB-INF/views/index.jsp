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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

    <title>Title</title>


    <script>
        function login(){
            let mid=document.getElementById("mmid").value;
            let mpw=document.getElementById("mmpw").value;
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
                    uplogin.style.color="gray"
                    uplogin.style.fontSize="11px"

                }
            })
        }
        function resetupid(){
            document.getElementById("uplogin").innerHTML=" ";
        }

        function login1(){
            $("#mbtn").click()
        }
        function ff(){
            location.href="/";
        }
    </script>
<style>
    .fbox{
        /*border:darkgray solid 1px;*/
        /*background-color:#C8EEF3;*/
        border-radius: 0;
        border-top: 0;
        border-bottom: 0;
        /*width:400px;*/
        height: 230px;
        padding:20px 30px 0px 30px ;
        text-align: center;"
    }
    .nor{
        border-radius:0;
    }

    .form-control:focus {
        border-color: #8c8f91;
        box-shadow: 0 0 0 0.2rem rgba(74, 74, 75, 0.25);
    }
    /*input:-webkit-autofill {*/
    /*    -webkit-box-shadow: 0 0 0 1000px white inset;*/
    /*    box-shadow: 0 0 0 1000px white inset;*/
    /*    -webkit-text-fill-color:#5c636a;*/
    /*}*/
    input:-webkit-autofill { -webkit-box-shadow: 0 0 0 30px #fff inset ; -webkit-text-fill-color: #5c636a; }
    input:-webkit-autofill, input:-webkit-autofill:hover, input:-webkit-autofill:focus, input:-webkit-autofill:active { transition: background-color 5000s ease-in-out 0s; }

</style>

</head>
<body>
<div style="width: 400px" class="container">
<div class="container form-control" style="background-color:#E4E5E8;color:gray ;border-bottom-left-radius: 0;border-bottom-right-radius: 0; height: 62px; text-align: center; margin-top: 200px">
<%--    <div class="" style="color: gray;margin-bottom: 30px">--%>
        <span style="font-size: 30px">Havana</span> <span style="">&nbsp;ver1.0</span>
<%--    </div>--%>
</div>
    <div class="container fbox form-control" style="background-color:#FBFBFB;height: 200px" >

    <form style="margin: 0">
        <div class="input-group input-group-lg container mt-3">
        <sapn class=" input-group-text"><i class="bi bi-person-fill" ></i></sapn>
        <input type="text" class="form-control " style="color: #5c636a;background-color: white" id="mmid" name="mid" placeholder="ID" autofocus>
        </div>
        <div class="input-group input-group-lg container " style="margin-top: 35px">
        <i class="bi bi-key input-group-text "></i>
        <input class="form-control " style="color: #5c636a" type="text" id="mmpw" name="mpw" placeholder="Password" >
        </div>
        <div id="uplogin" style="margin-top: 5px">&nbsp;</div>
    </form>

    </div>
        <div class="container form-control" style="background-color:#E4E5E8; border-top-left-radius: 0;border-top-right-radius: 0; height: 80px; text-align: center;">
<div class="mt-3" >
        <button class="btn btn-secondary" style="margin-right: 10px;border-color:#d7dbdb ;" onclick="modal()"  data-bs-toggle="modal" data-bs-target="#staticBackdrop">JoinUs</button>
    <button class="btn btn-secondary" style="margin-left:10px; border-color:#d7dbdb ;" onclick="login()" onblur="resetupid()">Login</button>
    </div></div>
</div>

<script>
function modal(){
    $(".modal-body").load("/member/joinModal");}
</script>

<!-- Button trigger modal -->
<button id="mbtn" type="button" class="btn btn-primary" onclick="modal()"  data-bs-toggle="modal" data-bs-target="#staticBackdrop" hidden>
    Launch static backdrop modal
</button>

<!-- Modal -->
<div class="modal fade" style="margin-top: 50px" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 400px;">
        <div class="modal-content" style="background-color:#E4E5E8" >
            <div class="modal-header" >
                <h5 class="modal-title" id="staticBackdropLabel">Join MEMBERS</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="ff()"></button>
            </div>
            <div class="modal-body" style="background-color: rgba(253,253,253,0.8)" >
                ...
<%--            </div>--%>
<%--            <div class="modal-footer">--%>
<%--                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="ff()">Close</button>--%>
<%--                <button type="button" class="btn btn-primary" onclick="msave()">Understood</button>--%>
<%--            </div>--%>
        </div>
    </div>
</div>



</div>
</body>
</html>
