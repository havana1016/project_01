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
        function yes(){
            let zone=document.getElementById("zone");
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
durlrkkljdfhgkjsdhg
    <div id="zone">

    </div>


</body>
</html>
