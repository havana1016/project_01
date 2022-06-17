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
        .form-control:focus {
            border-color: #8c8f91;
            box-shadow: 0 0 0 0.2rem rgba(74, 74, 75, 0.25);
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
                    czone.innerHTML='<div id="men" class="bi bi-person-plus-fill" style="font-size: 40px;"></div>'+'<div style="font-size: 25px">'+e+'</div>'}
                    // czone.innerHTML='<div style="padding: 0" id="pcountbtn" onclick='+"location.href='/pfr/myfr'"+'> <h3 style="padding: 0;margin: 3px"><i class="bi bi-person-plus-fill"></i>'
                        else{
                       czone.innerHTML='<div id="men" class="bi bi-person" style="font-size: 40px"></div>'+'<div style="font-size: 25px; color: rgba(0,0,0,0)">'+e+'</div>'
                    }
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
                html+='<img src="/upload/'+ffname+'" height="70px" width="70px" style="border-radius: 30%;border: gray 2px solid"></td><td>'
                html+='<h3 class="mt-4" style="margin-left: 30px">'+fid+'</h3></td></tr></table>'

                zone.innerHTML=html;
                let html2='<textarea style="" class="form-control mb-2" id="msg" cols="20" wrap="physical"></textarea>'
                html2+='<button type="button" style="border: gray 1px solid;color: #5c636a" class="btn btn-outline-light" data-bs-dismiss="modal" id="closemodal" >Close</button>'
                // html2+='<button type="button" class="btn btn-primary" id="sendbtn" onclick="savemsg('+"'"+fid+"'"+')">Send</button>'
                html2+='<button type="button" class="btn btn-secondary " id="sendbtn" onclick="savemsg('+"'"+fid+"'"+",'"+ffname+"'"+')">Send</button>'
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
                                  let html='<table class="table table-hover " style="background-color: rgba(253,253,253,0.5);">'
                    if(e.length!=0){

                    for(let i in e){
                             let count = msgcount('${sessionScope.logmem.mid}',e[i].fid);
                               let last= findclist('${sessionScope.logmem.mid}',e[i].fid);
                                console.log(last)


                              if(count>0){
                        // html+='<tr id="btndb1" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;" class="mt-1" ></td><td><h4 id="msgcount11" style="margin: 0"><span class="badge bg-secondary">New '+count+'</span></h4><h4 id="last" style="overflow:hidden;padding: 0;margin: 0">'+e[i].fid+'</h4></td><td style="overflow: hidden" id="last">'+last+'</tdsty>';}
                        // html+='<tr id="btndb1" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;" class="mt-2" ></td><td style="overflow: hidden;max-width: 200px;"><h4 style="padding: 0;margin:0 0 5px 0 ">'+e[i].fid+'</h4><span style="height:10px;overflow: hidden;color: gray;font-size: 13px" id="last">'+last.msg+'</span></td><td class="col-2" style="padding-bottom: 0"><h5 id="msgcount11" style="text-align: center;"><span class="badge bg-secondary">New '+count+'</span></h5><sapn style="text-align: right;color:gray;font-size: 12px">'+last.mtime+'</span></td>';}
                        html+='<tr id="btndb1" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "><td style="text-align: center;"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;border: #BCBCBD 2px solid" class="mt-2 mb-1" ></td><td style="overflow: hidden;max-width: 200px;"><h4 style="color: #5c636a;padding: 0;margin:10px 0 5px 0 ">'+e[i].fid+'</h4><span style="height:10px;overflow: hidden;color: gray;font-size: 13px" id="last">'+last.msg+'</span></td><td class="col-3" style="padding-bottom: 0"><p id="msgcount11" style="text-align: center;margin-bottom: 10px"><span class="badge bg-secondary">'+count+'</span></p><sapn style="text-align: right;color:gray;font-size: 12px">'+last.mtime+'</span></td>';}
                              else{

                                  html+='<tr id="btndb1" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;border: #BCBCBD 2px solid" class="mt-2 mb-1" ></td><td style="overflow: hidden;max-width: 200px;"><h4 style="color: #5c636a;padding: 0;margin:10px 0 5px 0 ">'+e[i].fid+'</h4><span style="height:10px;overflow: hidden;color: gray;font-size: 13px" id="last">'+last.msg+'</span></td><td class="col-3" style="padding-bottom: 0"><p id="msgcount11" style="text-align: center;margin-bottom: 10px" ><span class="badge " style="color:rgba(0,0,0,0);">'+count+'</span></p><sapn style="text-align: right;color:gray;font-size: 12px" >'+last.mtime+'</span></td>';}

                        // html+='<tr id="btndb" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;" class="mt-1" ></td><td><h4 style="margin-top: 15px;color: gray;padding: 0">'+e[i].fid+'</h4></td><td id="last1">'+last+'</td>';}

                    }
                        html+='</tr>'
                    html+='</table>'


                    flistz.innerHTML=html;



                }else{
                        flistz.innerHTML='<table style="background-color: rgba(253,253,253,0.8);width: 380px;height: 500px;color: #5c636a;font-size:20px;text-align: center"><tr><td>친구신청을 먼저 해주세요.</td></tr></table>'
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
                    function findclist(mget,mset){
                        let result=""
                        $.ajax({
                            url:"/msg/chatlist",
                            type:"get",
                            data:{"mget":mget,"mset":mset},
                            dataType:"json",
                            async:false,
                            success:function (e){
                                result ={
                                    mtime: e.mtime,
                                    msg: e.msg,
                                }
                            },
                            error:function (){
                                console.log("findclist err")
                                result ={
                                    mtime:" ",
                                    msg: " ",
                                }

                            }
                        })
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
                                html += '<div class="" style="overflow: hidden;word-break:break-all;text-align:right; padding:10px; color: #5c636a;background-color:white; border:1px solid #E4E4E4;border-radius: 5px">'
                                  // html+='<div style="text-align:left;  padding:10px; color: #5c636a;background-color:white; border:1px solid #E4E4E4;border-radius: 5px">'

                            // html += '<div class="" style="overflow: hidden;word-break:break-all;text-align:right; padding:10px;border: #C4C4C5 1px solid; background-color:#E4E4E4; border-radius: 5px">'
                                // html += '<div class="" style="overflow: hidden;word-break:break-all;text-align:right;  padding:10px; background-color:#C8EEF3; border-radius: 5px">'
                            html+='<div class="">'+e[i].msg+'</div></div>'
                            // html += '<div style="text-align:right;  padding:10px; background-color:#C8EEF3; border-radius: 5px">'
                            // html+=e[i].msg+'</div>'

                        }
                        else{

                            html+='<div style="overflow: hidden;word-break:break-all;text-align: left; margin-top: 30px">'+e[i].mtime+'</div>'
                            html+='<div style="text-align:left; color: #5c636a; padding:10px;border: #C4C4C5 1px solid; background-color:#EEEEEF; border-radius: 5px">'
                            // html += '<div class="" style="overflow: hidden;word-break:break-all;text-align:right; padding:10px;border: #C4C4C5 1px solid; background-color:#E4E4E4; border-radius: 5px">'


                            // html+='<div style="text-align:left;  padding:10px; background-color:#F5F5F5; border:1px solid #E4E4E4;border-radius: 5px">'
                            html+='<div class="">'+e[i].msg+'</div></div>'
                            // html+=e[i].msg+'</div>'
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
        // function icon(type){
        //
        //     let men=document.getElementById("men")
        //     let chat=document.getElementById("chat")
        //
        //     if (type=="men"){
        //         // location.href="/member/main"
        //         chat.className="bi bi-chat"
        //         men.className="bi bi-person-fill"
        //     }else if(type=="chat"){
        //
        //         men.className="bi bi-person"
        //         chat.className="bi bi-chat-fill"
        //     }
        // }

    </script>
</head>
<body onload="flist()">
<%--<jsp:include page="/resources/layout/header.jsp" ></jsp:include>--%>

<div class="form-control container" style="background-color:#E4E5E8;padding: 10px 20px 0 25px;width: 400px;margin-top:20px;border-bottom-right-radius: 0;border-bottom-left-radius: 0 " >
    <div class="row justify-content-between">
        <div class="col-4 ">

                <div class="input-group" onclick="yes()" id="countzone" style="margin-top:8px"  data-bs-toggle="modal" href="#exampleModalToggle" role="button">

                </div>


        </div>


    <div class="col-6 " style="margin-top:10px;margin-bottom: 20px">
        <div class="input-group" >
            <input style="border: 2px gray solid" id="search" class="form-control"
                    placeholder="Find ID" onkeyup="enter()">
            <button class="input-group-text btn btn-secondary" id="modalbtn" onclick="pfrc()" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="bi bi-search"></i></button>
    </div>
    </div>
        </div>
</div>


<%--<div class="collapse" id="collapseExample" style="">--%>
<%--    <div class="form-control container" style="border-radius:0;width: 400px;border-top: 0" >--%>
<%--        &lt;%&ndash;        <div class="card card-body" >&ndash;%&gt;--%>
<%--        <div class="btn-group container" style="margin-top: 20px; margin-bottom: 20px;" >--%>
<%--            <button class="btn  btn-outline-secondary" onclick="location.href='/pfr/myfr'">친구관리</button>--%>
<%--            <button class="btn  btn-outline-secondary" onclick="logout()">로그아웃</button>--%>
<%--        </div>--%>
<%--        &lt;%&ndash;       </div>&ndash;%&gt;--%>
<%--    </div>--%>
<%--</div>--%>


<%--<div class="form-control container" style="border-radius:0;width: 400px;height: 100px;background-color:#AEAEAF;border-inline:#E4E5E8 10px solid " >--%>
<div class="form-control container" style="border-radius:0;width: 400px;height: 100px;border-top: 0;border-bottom: 0;background-color:#F6F6F7;" >

    <table class="table table-borderless" style=";">
        <tr data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
<%--            <td class="col-3"><p style="text-align: center" id="countzone" ></p></td>--%>
            <th style="font-size: 30px"><p class="mt-3" style="color: #5c636a;margin-bottom: 0;text-align: right">${sessionScope.logmem.mid}</p></th>
            <td style="width:100px; height:100px"><img src="${pageContext.request.contextPath}/upload/${sessionScope.logmem.mfname}"
                                                            alt="" width="70px" height="70px" class="dot" style="border-radius: 30%;border:2px solid gray"></td>
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
<%--<div class="form-control container" style="background-color:#E4E5E8;width: 400px;border-top-right-radius: 0;border-top-left-radius: 0;padding:0" >--%>
<div class="form-control container" style="border-radius:0;background-color:#E4E5E8;width: 400px;padding: 15px 10px 15px 10px" >

<%--    <div class="mt-2">--%>
        <div id="table" class="" style="border-radius: 0%;height: 500px;overflow:auto;">
<%--        <div id="table" class="htable" style="height:auto; overflow: auto">--%>


        </div>
        <!-- Button trigger modal -->
        <button type="button" id="mbtn11" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#hssModal" hidden></button>

    </div>
<div class="form-control container" style="border-top:0;border-top-right-radius: 0;border-top-left-radius: 0;text-align:right;background-color:#E4E5E8;width: 400px;" >
    <i style="font-size: 40px;margin: 10px 10px 10px 0" class="bi bi-box-arrow-right" onclick="logout()"></i>
</div>













    <!-- 친구 찾기 Modal -->
    <div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="background-color: #E4E5E8">
                <div class="modal-header">
<%--                    <h5 class="modal-title mt-4" id="exampleModalLabel"></h5>--%>
                <br></div>
               <div class="modal-body container" id="result" style="font-size: 15px;background-color: rgba(253,253,253,0.5);color: #5c636a;text-align: center">

                </div>
                <div class="modal-footer">
                    <span id="resultzone" style="color: #5c636a;text-align: center"></span>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>



<!--  메시지 Modal -->
<div style="" class="modal fade" id="hssModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<%--    <div class="modal-dialog hss modal-dialog-scrollable" id="abc">--%>
    <div class="modal-dialog  " style="width: 400px" >
        <div class="modal-content" style="background-color: #E4E5E8" >
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
<%--                Modal title--%>
                <button type="button" id="xbtn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="msgbody" style="overflow: auto;height: 420px; background-color:rgba(253,253,253,0.9)">
                ...
            </div>
            <div class="modal-footer" id="footer">
<%--                <textarea class="form-control mb-2" name="msg"></textarea>--%>
<%--                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>--%>
<%--                <button type="button" class="btn btn-primary" id="sendbtn">Send</button>--%>
            </div>
        </div>
    </div>
</div>



<%--친구목록 모달--%>
<script>

    function plz(){

        let zone=document.getElementById("mzone1");
        let pid='${sessionScope.logmem.mid}'
        $.ajax({
            url:"/pfr/plz",
            type:"get",
            data:{"pid":pid},
            dataType:"json",
            success:function (e){
                console.log("plz success : "+e)
                let html;
                if(e.length==0){
                    html='<table class="table table-borderless" style="">'
                    html+='<tr><td style="text-align: center"><div style="color:#5c636a;margin-top:20px;">내가 한 친구 신청이 없습니다.</div></td></tr>'
                }else{
                    html='<table class="table table-hover table-borderless" style="">'}
                for(let i in e){
                    html+='<tr><td style="text-align: center"><img src="/upload/'+e[i].yfname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h2 style="margin-top: 30px;color: #5c636a">'+e[i].yid+'</h2></td>';
                    html+='<td style="text-align: center"><button class="btn btn-outline-secondary mt-4" >신청취소</button></td></tr>'}
                html+='</table>';
                zone.innerHTML=html;
            },
            error:function (e){
                console.log("plz error : ")
            }

        })


    }

    function yes(){
        let zone=document.getElementById("mzone");

        let yid='${sessionScope.logmem.mid}'
        $.ajax({
            url:"/pfr/yes",
            type:"get",
            data:{"yid":yid},
            dataType:"json",
            success:function (e){

                console.log("yes success : "+e)
                let html;
                if(e.length==0){
                    html='<table class="table table-borderless" style="">'
                    html+='<tr><td style="text-align: center"><div style="color:#5c636a;margin-top:20px;">새로운 친구 신청이 없습니다.</div></td></tr>'
                }else{
                html='<table class="table table-hover table-borderless" style="">'}
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





<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
<%--    <div class="modal-dialog modal-dialog-centered">--%>
    <div class="modal-dialog">
        <div class="modal-content" style="background-color: #E4E5E8">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel">내가 받은 친구 신청</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" style="background-color: rgba(253,253,253,0.5)" id="mzone">

            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal" onclick="plz()">내가 한 친구신청 보기</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
<%--    <div class="modal-dialog modal-dialog-centered">--%>
    <div class="modal-dialog ">
        <div class="modal-content" style="background-color: #E4E5E8">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel2">내가 한 친구신청</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" style="background-color: rgba(253,253,253,0.5)" id="mzone1">

            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal" onclick="yes()">내가 받은 친구신청 보기</button>
            </div>
        </div>
    </div>
</div>
<%--<a class="btn btn-secondary" data-bs-toggle="modal" href="#exampleModalToggle" role="button">Open first modal</a>--%>


<script>

</script>




</body>
</html>
