<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-16
  Time: 오후 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="\resources\js\jquery.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>




    <title>Title</title>
    <script>
        function enter() {
            if (window.event.keyCode == 13) {
                document.getElementById("modalbtn").click();
            }
        }
        function pfr(){
            let yid=document.getElementById("search").value;
            let pid='${sessionScope.logmem.mid}';
            let zone=document.getElementById("resultzone")
            $.ajax({
                url:"/pfr/save",
                type:"get",
                data:{"pid":pid,"yid":yid},
                dataType: "text",
                success:function (e){
                    console.log("pfr success")
                    zone.innerHTML="친구 신청이 완료 되었습니다."


                },
                error:function (e){
                    console.log("pfr error")
                }
            })
        }
        function search(){
            let mid=document.getElementById("search").value;
            let result=document.getElementById("result")
            let zone=document.getElementById("resultzone")
            zone.innerHTML=" "

            $.ajax({
                url:"/member/search",
                type:"get",
                data:{"mid":mid},
                dataType:"json",
                success:function (e){
                    console.log("search success")
                    console.log(e)
                    let bf=e.mfname;

                    console.log("bf: "+bf)
                    let html='<table class="container" style="margin-left: 10px"><tr><td><img src="/upload/'+bf+'" width="100px" height="100px" style="border-radius: 30%" class=""></td>';
                    html+="<th style='text-align: center'><h1 class='mt-5'>"+e.mid
                    html+="</h1></th><td><button id='pbtn' class='mt-5 btn btn-secondary' onclick='reset(),pfr()'>친구신청</button></td></tr></table>"
                    result.innerHTML=html;


                },
                error:function (e){
                    console.log("search error");
                    result.innerHTML="<br>친구 아이디를 확인해주세요.<br><br>";

                }
            })
        }
        function logout(){
            location.href="/member/logout";
        }


        function reset(){
            let pbtn=document.getElementById("pbtn")
            pbtn.setAttribute("disabled","disabled");

        }
        function pfrc(){
            let mid=document.getElementById("search").value;
            let pid='${sessionScope.logmem.mid}'
            let pbtn=document.getElementById("pbtn")
            let zone=document.getElementById("resultzone")
            zone.innerHTML=" "

            $.ajax({
                url:"/pfr/pfrc",
                type:"get",
                data:{"yid":mid,"pid":pid},
                dataType:"json",
                success:function (e){
                    console.log("pfrc success : "+e);

                    if(e.fbool==1){
                        document.getElementById("result").innerHTML="<br>"+mid+"님과 이미 친구사이 입니다."+"<br><br>"
                        // alert("이미 친구사이 입니다.");
                    }else if(e.fbool==0){
                        // alert("이미 친구 신청을 하였습니다.");
                        document.getElementById("result").innerHTML="<br>"+mid+" 님과의 친구 신청이 존재합니다."+"<br><br>"
                    }
                },
                error:function (e){
                    console.log("pfrc error : ")
                    if(pid!=mid){
                        search();}else {
                        document.getElementById("result").innerHTML="<br>"+"친구의 아이디를 입력하세요."+"<br><br>"

                    }
                }
            })
        }

        function icon(type){

            let men=document.getElementById("men")
            let chat=document.getElementById("chat")
            let url=window.location.pathname

            if (type=="men"){
                location.href="/member/main"
                 console.log(url)
                chat.className="bi bi-chat"
                men.className="bi bi-person-fill"
            }else if(type=="chat"){
                location.href="/msg/chat?mget=${sessionScope.logmem.mid}"
                men.className="bi bi-person"
                chat.className="bi bi-chat-fill"
            }
        }





    </script>






</head>
<body onload="">
<div class="form-control container" style="background-color: #C8EEF3;padding: 20px 25px 0 25px;width: 400px;margin-top:20px;border-bottom-right-radius: 0;border-bottom-left-radius: 0 " >
    <div class="row justify-content-between">
        <div class="col-4 ">
            <div class="input-group">
                <h1 style="margin-top:5px"><i id="men" class="bi bi-person" onclick="icon('men')"></i></h1>
                <h2 style="margin-left:15px; margin-top:5px"><i id="chat" class="bi bi-chat" onclick="icon('chat')"></i></h2>
            </div>
            <%--            <p style="text-align: center;"  id="countzone1">--%>
            <%--            </p>--%>
        </div>

        <div class="col-6 " style="margin-bottom: 20px">
            <div class="input-group" >
                <input  id="search" class="form-control"
                        placeholder="Find ID" onkeyup="enter()">
                <button class="input-group-text btn btn-secondary" id="modalbtn" onclick="pfrc()" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="bi bi-search"></i></button>
            </div>
        </div>
    </div>
</div>



</body>
</html>
