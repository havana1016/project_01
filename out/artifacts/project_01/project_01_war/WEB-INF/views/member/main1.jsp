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
                document.getElementById("mbtn11").click()
                // mcount("msglist",fid)
                let zone=document.getElementById("exampleModalLabel")
                let footer=document.getElementById("footer")
                let html='<table><tr><td>'
                html+='<img src="/upload/'+ffname+'" height="70px" width="70px"></td><td>'
                html+='<h3 class="mt-4" style="margin-left: 30px">'+fid+'</h3></td></tr></table>'

                zone.innerHTML=html;
                let html2='<textarea class="form-control mb-2" id="msg" cols="20" wrap="hard"></textarea>'
                html2+='<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="closemodal" >Close</button>'
                // html2+='<button type="button" class="btn btn-primary" id="sendbtn" onclick="savemsg('+"'"+fid+"'"+')">Send</button>'
                html2+='<button type="button" class="btn btn-primary" id="sendbtn" onclick="savemsg('+"'"+fid+"'"+",'"+ffname+"'"+')">Send</button>'
                // html2+='<button type="button" class="btn btn-primary" id="sendbtn" onclick="savemsg('+"'"+fid+"','"+msg+"'"+')">Send</button>'
                footer.innerHTML=html2;


                findmsg(fid)


            }
        function flist(){

            let flistz=document.getElementById("table");
            $.ajax({
                url:"/fr/findall",
                type:"get",
                data:{"mid":'${sessionScope.logmem.mid}'},
                dataType:'json',
                success:function (e){
                    console.log("flist suc")
                    console.log(e.length)
                    if(e.length!=0){
                    let html='<table class="table table-hover table-bordered">'
                    for(let i in e){
                             let count = msgcount('${sessionScope.logmem.mid}',e[i].fid);

                              if(count>0){
                        html+='<tr id="btndb1" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;" class="mt-1" ></td><td><h4 id="msgcount11" style="margin: 0"><span class="badge bg-secondary">New '+count+'</span></h4><h4 style="padding: 0;margin: 0">'+e[i].fid+'</h4></td>';}
                              else{
                                  html+='<tr id="btndb" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;" class="mt-1" ></td><td><h4 style="margin-top: 15px;color: gray;padding: 0">'+e[i].fid+'</h4></td>';}

                        html+='</tr>'
                    }


                    html+='</table>'
                    flistz.innerHTML=html;



                }else{
                        flistz.innerHTML='<h1>아직친구가 없어요.</h1>'
                    }

                    function msgcount(mset,mget){
                        let result=""
                        $.ajax({
                            url:"/msg/count",
                            type:"get",
                            data:{"mset":mset,"mget":mget},
                            dataType:"text",
                            async: false,
                            success:function (e){
                                console.log("msgcount suc : "+e)
                                result=e;

                            },
                            error:function (e){
                                console.log("msgcount err")
                            }
                        });

                        return result;

                    }




                        },
                error:function (e){
                    console.log("flist err")

                }
            });
            mcount("flist")

        }

            let count=0
        function mcount(type,fid){
            let mid='${sessionScope.logmem.mid}'
            $.ajax({
                url:"/msg/mcount",
                type:"get",
                data:{"mget":mid,"type":type},
                dataType:"text",
                success:function (e){
                    console.log("mcount suc e: "+e)
                    console.log("mcount suc count: "+count)
                    console.log("mcount suc type: "+type)

                    if(e!=count){
                        if(type=="flist"){
                            pcount()
                        flist()
                        }
                        else if(type=="msglist"){
                            findmsg(fid)
                        }
                        count=e;

                    }else {
                        if(type=="flist"){
                            pcount()
                        }
                    }
                },
                error:function (){
                    console.log("mcount err")
                    pcount()
                }
            })

            function timer(){
                mcount(type,fid)
            }

            // let timerVar1 =setTimeout( timer, 1000);
            let timerVar1;
            if (type=="flist"){
                console.log("set:2000")
                timerVar1 =setTimeout( timer, 2000)
            }else if(type=="msglist"){
                console.log("set:1000")
                timerVar1 =setTimeout( timer, 1000)
            }

            $("#btndb,#btndb1").dblclick(function (){
                clearTimeout(timerVar1);
            })
            $("#closemodal,#xbtn,#sendbtn").click(function (){
                clearTimeout(timerVar1);

            })
        }



            function test() {
            document.getElementById("msgbody").scrollTop = document.getElementById("msgbody").scrollHeight;
                    }

        function findmsg(fid){

            let body=document.getElementById("msgbody")
            let zone=document.getElementById("exampleModalLabel")
            let html='<div>'
            $.ajax({
                url:"/msg/findmsg",
                type:"get",
                data:{"mset":'${sessionScope.logmem.mid}',"mget":fid},
                dataType:"json",
                success:function (e){
                    console.log("findmsg suc")
                    for(let i in e){


                        if(e[i].mset=='${sessionScope.logmem.mid}'){
                            if(e[i].seeint!=0){
                            html+='<div class="row justify-content-between" style="padding-right: 0;margin-top: 30px">'
                                html+='<div class="col-1">'
                                    html+=e[i].seeint
                                html+='</div>'
                            html+='<div class="col-6" style="text-align: right">'
                                html+=e[i].mtime
                                html+='</div></div>';
                           }
                            else {
                                html += '<div style="text-align: right;margin-top: 30px">' + e[i].mtime + '</div>'


                            }
                                html += '<div style="text-align:right;  padding:10px; background-color:#C8EEF3; border-radius: 5px">'
                            html+=e[i].msg+'</div>'

                        }
                        else{

                            html+='<div style="text-align: left; margin-top: 30px">'+e[i].mtime+'</div>'
                            html+='<div style="text-align:left;  padding:10px; background-color:#E7E8EB; border-radius: 5px">'
                            html+=e[i].msg+'</div>'
                        }


                    }


                    body.innerHTML=html;
                    setTimeout(test,150)


                    $("#closemodal,#xbtn").click(function (){
                        location.href="/member/main"
                    })



                },
                error:function (e){
                    console.log("findmsg err")

                }

            });
        }





        function savemsg(fid,ffname){
            let msg=document.getElementById("msg");

            $.ajax({
                url:"/msg/save",
                data:{"mset":'${sessionScope.logmem.mid}',"mget":fid,"msg":msg.value,
                   "sfname":'${sessionScope.logmem.mfname}',"gfname":ffname },
                type:"get",
                dataType:"text",
                success:function (e){
                    console.log("savemsg suc")
                    mcount("msglist",fid)
                    msg.value=null
                    msg.focus()

                },
                error:function (e){
                    console.log("savemsg err")

                }


            })
        }


    </script>
</head>
<body onload="flist()">
<jsp:include page="/resources/layout/header.jsp" ></jsp:include>

<%--<div class="form-control container" style="background-color: #C8EEF3;padding: 20px 25px 0 25px;width: 400px;margin-top:20px;border-bottom-right-radius: 0;border-bottom-left-radius: 0 " >--%>
<%--    <div class="row justify-content-between">--%>
<%--        <div class="col-4 ">--%>
<%--            <div class="input-group">--%>
<%--                <h1 style="margin-top:5px"><i id="men" class="bi bi-person-fill" onclick="icon('men')"></i></h1>--%>
<%--                <h2 style="margin-left:15px; margin-top:5px"><i id="chat" class="bi bi-chat" onclick="icon('chat')"></i></h2>--%>
<%--            </div>--%>
<%--&lt;%&ndash;            <p style="text-align: center;"  id="countzone1">&ndash;%&gt;--%>
<%--&lt;%&ndash;            </p>&ndash;%&gt;--%>
<%--        </div>--%>

<%--    <div class="col-6 " style="margin-bottom: 20px">--%>
<%--        <div class="input-group" >--%>
<%--            <input  id="search" class="form-control"--%>
<%--                    placeholder="Find ID" onkeyup="enter()">--%>
<%--            <button class="input-group-text btn btn-secondary" id="modalbtn" onclick="pfrc()" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="bi bi-search"></i></button>--%>
<%--    </div>--%>
<%--    </div>--%>
<%--        </div>--%>
<%--</div>--%>

<div class="collapse" id="collapseExample" style="">
    <div class="form-control container" style="border-radius:0;width: 400px;border-top: 0" >
        <%--        <div class="card card-body" >--%>
        <div class="btn-group container" style="margin-top: 20px; margin-bottom: 20px;" >
            <button class="btn  btn-outline-secondary" onclick="location.href='/pfr/myfr'">친구관리</button>
            <button class="btn  btn-outline-secondary" onclick="logout()">로그아웃</button>
        </div>
        <%--       </div>--%>
    </div>
</div>


<div class="form-control container" style="border-radius:0;width: 400px;border-top: 0;border-bottom: 0;background-color: rgba(200, 238, 243,0.3)" >

    <table class="table table-borderless" style="margin-top:16px;">
        <tr data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
            <td class="col-3"><p style="text-align: center" id="countzone" ></p></td>
            <th style="font-size: 30px"><p class="mt-5" style="margin-bottom: 0;text-align: right">${sessionScope.logmem.mid}</p></th>
            <td style="width:100px; height:100px"><img src="${pageContext.request.contextPath}/upload/${sessionScope.logmem.mfname}"
                                                            alt="" width="100px" height="100px" class="dot" style="border-radius: 30%"></td>
        </tr>
    </table></div>

<%--    <div class="collapse" id="collapseExample" style="">--%>
<%--    <div class="form-control container" style="border-radius:0;width: 450px;border-bottom: 0" >--%>
<%--&lt;%&ndash;        <div class="card card-body" >&ndash;%&gt;--%>
<%--            <div class="btn-group container" style="margin-top: 20px; margin-bottom: 20px;" >--%>
<%--            <button class="btn  btn-outline-secondary" onclick="location.href='/pfr/myfr'">친구관리</button>--%>
<%--            <button class="btn  btn-outline-secondary" onclick="logout()">로그아웃</button>--%>
<%--        </div>--%>
<%--&lt;%&ndash;       </div>&ndash;%&gt;--%>
<%--    </div>--%>
<%--</div>--%>
<div class="form-control container" style="background-color: #C8EEF3;width: 400px;border-top-right-radius: 0;border-top-left-radius: 0;padding: 15px 10px 15px 10px" >

<%--    <div class="mt-2">--%>
        <div id="table" class="" style="border-radius: 2%;background-color: rgba(253,253,253,0.5);height: 510px;overflow:auto;">
<%--        <div id="table" class="htable" style="height:auto; overflow: auto">--%>


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
<div style="width: 400px" class="modal fade hss" id="hssModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<%--    <div class="modal-dialog hss modal-dialog-scrollable" id="abc">--%>
    <div class="modal-dialog hss " id="abc">
        <div class="modal-content hss">
            <div class="modal-header hss">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
<%--                Modal title--%>
                <button type="button" id="xbtn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body hss" id="msgbody" style="overflow: auto;height: 420px; ">
                ...
            </div>
            <div class="modal-footer hss" id="footer">
<%--                <textarea class="form-control mb-2" name="msg"></textarea>--%>
<%--                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>--%>
<%--                <button type="button" class="btn btn-primary" id="sendbtn">Send</button>--%>
            </div>
        </div>
    </div>
</div>
<script>


</script>

</body>
</html>
