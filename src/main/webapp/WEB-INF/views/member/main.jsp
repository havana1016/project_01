<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-08
  Time: 오전 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="\resources\js\jquery.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
    <title>Title</title>
    <style>
        .box{
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
        }
        .htable{
            border:gray solid 1px;
            height: 1000px;
        }
    </style>
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

        function pcount(){
            let czone=document.getElementById("countzone")
            $.ajax({
                url:"/pfr/pcount",
                type:"get",
                data:{"yid":'${sessionScope.logmem.mid}'},
                dataType:"json",
                success:function (e){
                    console.log("pcount suc : ")
                    if(e!=0){
                    czone.innerHTML='<div class="form-control" style="padding: 0" id="pcountbtn" onclick='+"location.href='/pfr/myfr'"+'> <h3 style="padding: 0;margin: 3px"><i class="bi bi-person-plus-fill"></i>'
                        +e+'</h3></div>'}
                    // document.getElementById("pcountbtn").click(function (){
                    //     $(location.href="/pfr/myfr");
                    // })

                },
                error:function (e){
                    console.log("pcount err : ")

                }
            })
        }
            function mbtn(fid,ffname){
                console.log(fid+" "+ffname)
                let zone=document.getElementById("exampleModalLabel")
                let html='<table><tr><td>'
                html+='<img src="/upload/'+ffname+'" height="70px" width="70px"></td><td>'
                html+=fid+'</td></tr></table>'
                zone.innerHTML=html;
                document.getElementById("mbtn11").click()




            }
        function flist(){
            let flist=document.getElementById("table");
            $.ajax({
                url:"/fr/findall",
                type:"get",
                data:{"mid":'${sessionScope.logmem.mid}'},
                dataType:'json',
                success:function (e){
                    console.log("flist suc")
                    let html='<table class="table table-hover">'
                    for(let i in e){
                        html+='<tr ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+')"><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h2 class="mt-4">'+e[i].fid+'</h2></td>';
                        // html+='<tr ondblclick="mbtn()"><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h2 class="mt-4">'+e[i].fid+'</h2></td>';
                        html+='<td style="text-align: center"><button class="btn btn-outline-secondary mt-4" >버튼버튼</button></td></tr>'}
                    html+='</table>'
                    flist.innerHTML=html;










                },
                error:function (e){
                    console.log("flist err")

                }
            })

        }
    </script>
</head>
<body onload="pcount(),flist()">
<div style="width: 600px;height: 1500px;padding: 30px" >
   <div class="row justify-content-between">
    <div class="mb-4 col-4">
    <button class="btn btn-secondary" onclick="location.href='/pfr/myfr'" >친구관리</button>
    </div>
    <div  class="mb-4 col-2">
        <button class="btn btn-secondary" onclick="logout()">logout</button>
    </div>
   </div>
    <div class="row justify-content-between">
        <div class="col-2">
<%--            style="background-color:white; border-radius: 3px; padding-left: 10px;padding-top: 5px">--%>
            <p style="text-align: center"  id="countzone"></p></div>
    <div class="col-4">
        <div class="input-group" >
            <input  id="search" class="form-control"
                    placeholder="Find ID" onkeyup="enter()">
            <button class="input-group-text btn btn-outline-secondary" id="modalbtn" onclick="pfrc()" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="bi bi-search"></i></button>
    </div>
    </div>
        </div>
    <table class="table ">
        <tr>
            <th style="font-size: 50px"><p class="mt-4" style="margin-bottom: 0;text-align: right">${sessionScope.logmem.mid}</p></th>
            <td style="width:100px; height:100px"><img src="${pageContext.request.contextPath}/upload/${sessionScope.logmem.mfname}"
                                                            alt="" width="100px" height="100px" class="dot" style="border-radius: 30%"></td>
        </tr>
    </table>
    <div>
        <div id="table" class="htable">


        </div>
        <!-- Button trigger modal -->
        <button type="button" id="mbtn11" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#hssModal" hidden></button>

    </div>












    <!-- 친구 찾기 Modal -->
    <div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
<%--                    <h5 class="modal-title mt-4" id="exampleModalLabel"></h5>--%>
                <br></div>
               <div class="modal-body container" id="result">

                </div>
                <div class="modal-footer">
                    <span id="resultzone"></span>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>



<!--  메시지 Modal -->
<div class="modal fade" id="hssModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
<%--                Modal title--%>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>
