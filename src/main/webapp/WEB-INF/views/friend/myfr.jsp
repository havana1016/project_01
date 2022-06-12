<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-09
  Time: 오전 11:41
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

        function plz(){
            let yes=document.getElementById("yes");
            let plz=document.getElementById("plz");
            let zone=document.getElementById("zone");
            let plzb=document.getElementById("plzb");
            let yesb=document.getElementById("yesb")
            yes.className="nav-link";
            plz.className="nav-link active";
            plzb.style.color="black";
            yesb.style.color="gray";


            let pid='${sessionScope.logmem.mid}'
            $.ajax({
                url:"/pfr/plz",
                type:"get",
                data:{"pid":pid},
                dataType:"json",
                success:function (e){

                    console.log("plz success : "+e)
                    let html='<table class="table container" style="margin-left: 10px ">'

                    for(let i in e){

                        html+='<tr><td style="text-align: center"><img src="/upload/'+e[i].yfname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h2 class="mt-4">'+e[i].yid+'</h2></td>';
                    html+='<td style="text-align: center"><button class="btn btn-outline-secondary mt-4" >신청취소</button></td></tr>'}
                    zone.innerHTML=html;
                    html+='</table>';
                },
                error:function (e){
                    console.log("plz error : ")
                }

            })


        }

        function yes(){
            // let yes=document.getElementById("yes");
            // let plz=document.getElementById("plz")
            // plz.className="nav-link";
            // yes.className="nav-link active";

            let yes=document.getElementById("yes");
            let plz=document.getElementById("plz");
            let zone=document.getElementById("zone");
            let plzb=document.getElementById("plzb");
            let yesb=document.getElementById("yesb")
            plz.className="nav-link";
            yes.className="nav-link active";
            yesb.style.color="black";
            plzb.style.color="gray";


            let yid='${sessionScope.logmem.mid}'
            $.ajax({
                url:"/pfr/yes",
                type:"get",
                data:{"yid":yid},
                dataType:"json",
                success:function (e){

                    console.log("yes success : "+e)
                    let html='<table class="table container" style="margin-left: 10px ">'
                    // $('#test').click(function (){
                    //     alert("내부함수 호출")
                    // })
                    for(let i in e){
                        html+='<tr><td style="text-align: center"><img src="/upload/'+e[i].pfname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h2 class="mt-4">'+e[i].pid+'</h2></td>';
                    html+='<td style="text-align: center"><button id="test" class="test btn btn-outline-secondary mt-4" onclick="'+"yesf('"+e[i].pid+"','"+e[i].pfname+"','"+e[i].yfname+"')"+'" >수락</button>&nbsp<button class="btn btn-outline-secondary mt-4" >거절</button></td></tr>'}

                    html+='</table>'
                    zone.innerHTML=html;
                },
                error:function (e){
                    console.log("yes error : ")
                }

            })



        }
        function yesf(pid,pfname,yfname){
            let yid='${sessionScope.logmem.mid}';
            $.ajax({
                url:"/pfr/yesf",
                type:"get",
                data:{"pid":pid,"yid":yid,"pfname":pfname,"yfname":yfname},
                dataType:"text",
                success:function (e){
                    console.log("yesf success")
                    yes();
                    alert(pid+" 님의 친구신청을 수락하셨습니다.")
                },
                error:function (e){
                    console.log("yesf error")

                }

            })

        }

    </script>


</head>

<body onload="yes()">
<div style="width: 600px;height: 1500px;padding: 30px;" >
    <div class="row justify-content-between">
        <div class="">
<ul class="nav nav-tabs">
    <li class="nav-item">
        <a class="nav-link" id="yes">
            <div style="color:gray" id="yesb" onclick="yes()">내가 받은 친구신청</div></a>
    </li>
    <li class="nav-item">
        <a class="nav-link active" id="plz">
            <div style="color:black" id="plzb" onclick="plz()">내가 한 친구신청</div></a>
    </li>
    <li class="nav-item " style="width: 200px">
        <h2 style=" margin-top:5px;text-align: right" onclick="location.href='/member/main'"><i class="bi bi-house-fill"></i></h2>
    </li>
<%--    <li class="nav-item">--%>
<%--        <a class="nav-link disabled">Disabled</a>--%>
<%--    </li>--%>
</ul>
        </div>
<%--    <div class="col-2">--%>
<%--        <button class="btn btn-secondary">fkdjhs</button></div>--%>
<%--    </div>--%>
    <div id="zone">

    </div>
    </div>
</div>
</body>
</html>
