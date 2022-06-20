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




        .form-control:focus {
            border-color: #8c8f91;
            box-shadow: 0 0 0 0.2rem rgba(74, 74, 75, 0.25);
        }



    </style>
    <script>

        let msgdb;
        let frdb;
        let pfrdb;
        function searchDB(){
            $.ajax({
                url:"/member/searchDB"
            })

        }

        function pfr(){
            let yid=document.getElementById("search").value;
            let pid='${sessionScope.logmem.mid}';
            let zone=document.getElementById("result")
            $.ajax({
                url:"/pfr/save",
                type:"get",
                data:{"pid":pid,"yid":yid},
                dataType: "text",
                success:function (e){
                    zone.innerHTML="<br>친구 신청이 완료 되었습니다.<br><br>"


                },
                error:function (e){
                }
            })
        }
        function search(){
            let mid=document.getElementById("search").value;
            let result=document.getElementById("result")
            result.innerHTML=" "

            $.ajax({
                url:"/member/search",
                type:"get",
                data:{"mid":mid},
                dataType:"json",
                success:function (e){
                    let bf=e.mfname;

                    let html='<table class="container" style="margin-left: 10px"><tr><td><img src="/upload/'+bf+'" width="100px" height="100px" style="border-radius: 30%" class=""></td>';
                    html+="<th style='text-align: center'><h1 class='mt-5'>"+e.mid
                    html+="</h1></th><td><button id='pbtn' class='mt-5 btn btn-secondary' onclick='reset(),pfr()'>친구신청</button></td></tr></table>"
                    result.innerHTML=html;


                },
                error:function (e){
                    result.innerHTML="<br>친구 아이디를 확인해주세요.<br><br>";

                }
            })
        }
        function logout(){
            location.href="/member/logout?mid=${sessionScope.logmem.mid}";
        }


        function reset(){
           let pbtn=document.getElementById("pbtn")
           pbtn.setAttribute("disabled","disabled");

        }
        function pfrc(){
            let mid=document.getElementById("search").value;
            let pid='${sessionScope.logmem.mid}'


            $.ajax({
                url:"/pfr/pfrc",
                type:"get",
                data:{"yid":mid,"pid":pid},
                dataType:"json",
                success:function (e){
                        if(e.fbool==1){
                        document.getElementById("result").innerHTML="<br>"+mid+"님과 이미 친구사이 입니다."+"<br><br>"
                    }else if(e.fbool==0){
                        document.getElementById("result").innerHTML="<br>"+mid+" 님과의 친구 신청이 존재합니다."+"<br><br>"
                    }
                },
                error:function (e){
                    if(pid!=mid){
                    search();}else {
                        document.getElementById("result").innerHTML="<br>"+"친구의 아이디를 입력하세요."+"<br><br>"

                    }
                }
            })
        }

        let pcountresult;
        function pcount(){
            let czone=document.getElementById("countzone")
            $.ajax({
                url:"/pfr/pcount",
                type:"get",
                data:{"yid":'${sessionScope.logmem.mid}'},
                dataType:"json",
                success:function (e){

                    if (e>pcountresult && pcountresult!=0 || pcountresult==0 && e==1){
                        $("#nfrbtn").click()
                        document.getElementById("mzone1").innerHTML='<p style="font-size: 15px;margin-top: 16px;text-align: center;color:#343a40">새로운 친구신청이 도착했습니다!!</p>'
                    }

                    if(e!=0){
                    czone.innerHTML='<div id="men" class="bi bi-person-plus-fill" style="font-size: 40px;"></div>'+'<div style="font-size: 25px">'+e+'</div>'
                        if(e!=pcountresult){
                            flist()
                        }
                        pcountresult=e;
                    }

                        else{
                       czone.innerHTML='<div id="men" class="bi bi-person" style="font-size: 40px"></div>'+'<div style="font-size: 25px; color: rgba(0,0,0,0)">'+e+'</div>'
                    pcountresult=e;
                    }





                },
                error:function (e){

                }
            })


        }

        let ycountresult=0;
        function ycount(){
            $.ajax({
                url:"/pfr/ycount",
                type:"get",
                data:{"yid":'${sessionScope.logmem.mid}'},
                dataType:"json",
                success:function (e){
                    if(e!=ycountresult){
                        flist()
                    }
                    ycountresult=e;

                },
                error:function (e){



                }
            })


        }

        let logint=0
        function logcount(){
            let zone=document.getElementById("logzone")
            $.ajax({
                url:"/fr/logc",
                type:"get",
                data:{"mid":'${sessionScope.logmem.mid}'},
                dataType:"text",
                success:function (e){

                    if(logint!=e){
                         flist()
                    }

                    logint=e

                },
                error:function (){

                }
            })

        }

            function mbtn(fid,ffname){
                document.getElementById("mbtn11").click()
                findmsg(fid)
                 mcount("msglist",fid)
                let zone=document.getElementById("exampleModalLabel")
                let footer=document.getElementById("footer")
                let html='<table><tr><td>'
                html+='<img src="/upload/'+ffname+'" height="70px" width="70px" style="border-radius: 30%;border: gray 2px solid"></td><td>'
                html+='<h3 class="mt-4" style="margin-left: 30px">'+fid+'</h3></td></tr></table>'

                zone.innerHTML=html;
                let html2='<textarea style="" class="form-control mb-2" id="msg" cols="20" wrap="physical"></textarea>'
                html2+='<button type="button" style="border: gray 1px solid;color: #5c636a" class="btn btn-outline-light" data-bs-dismiss="modal" id="closemodal" onclick="flist()" >Close</button>'
                html2+='<button type="button" class="btn btn-secondary " id="sendbtn" onclick="savemsg('+"'"+fid+"'"+",'"+ffname+"'"+')">Send</button>'
                footer.innerHTML=html2;



            }

        function delfr(fid){
            let czone=document.getElementById("cancelzone")
                let mid='${sessionScope.logmem.mid}'
                $.ajax({
                    url:"/fr/delfr",
                    type:"get",
                    data:{"fid":fid,"mid":mid},
                    dataType:"text",
                    success:function (e){
                        if (e>0){

                            czone.innerHTML="<br><div><div style='text-align: center;color: #51585e'>친구끊기가 완료 되었습니다.</div></div><br>"


                        }
                    },
                    error:function (){

                    }
                })
        }


            function cancelfr(fid,ffname){
                let czone=document.getElementById("cancelzone")
                czone.innerHTML="test"
                let html='<table ><tr ><td>'
                html+='<img src="/upload/'+ffname+'" height="70px" width="70px" style="margin-left:5px;border-radius: 30%;border: gray 2px solid"></td><td>'
                html+='<p style="text-align:center;margin-left: 20px; color: #5c636a">정말 취소 하시겠습니까?</p><h3 class="mt-4" style="margin-left: 30px">'+fid+'</h3></td>'
                html+='<td ><button id="canclebtn" style="margin-left: 25px" class="btn btn-secondary" onclick="delfr('+"'"+fid+"'"+')">친구끊기</button></td></tr></table>'
                czone.innerHTML=html;




            }



        function flist(){
            let flistz=document.getElementById("table");



            $.ajax({
                url:"/fr/findall",
                type:"get",
                data:{"mid":'${sessionScope.logmem.mid}'},
                dataType:'json',
                success:function (e){

                    let html='<table class="table table-hover table-borderless" style="background-color: rgba(253,253,253,0.5);">'
                    if(e.length!=0){

                    for(let i in e){

                             let count = msgcount('${sessionScope.logmem.mid}',e[i].fid);
                               let last= findclist('${sessionScope.logmem.mid}',e[i].fid);





                              if(count>0){
                                  if(e[i].logc==1){
                                  html+='<tr id="btndb1" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "data-bs-toggle="collapse" href="#collapseExample'+i+'" role="button" aria-expanded="false" aria-controls="collapseExample"><td id=logzone>'+'<i class="bi bi-check-circle-fill"></i>'+'</td><td style="text-align: center;"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;border: #BCBCBD 2px solid" class="mt-2 " ></td><td style="overflow: hidden;max-width: 200px;"><h4 style="color: #5c636a;padding: 0;margin:10px 0 5px 0 ">'+e[i].fid+'</h4><span style="height:10px;overflow: hidden;color: gray;font-size: 13px" id="last">'+last.msg+'</span></td><td class="col-3" style="padding-bottom: 0"><p id="msgcount11" style="text-align: center;margin-bottom: 10px"><span class="badge bg-secondary">'+count+'</span></p><sapn style="text-align: right;color:gray;font-size: 12px">'+last.mtime+'</span></td>';
                                      html+='</tr><tr style="border-bottom: #E4E5E8 1px solid"><td colspan="4" ><div class="collapse" id="collapseExample'+i+'" style="text-align: center;">'
                                      html+='<button class="btn  btn-outline-secondary" id="chatbtn" onclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') ">Go to Chat</button>'
                                      html+='<button style="margin-left: 25px" class="btn  btn-secondary" onclick="cancelfr('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+')" data-bs-toggle="modal" data-bs-target="#cancelmodal" id="cbt">친구 취소</button></div></td></tr>'
                                  }else if(e[i].logc==0){
                                      html+='<tr id="btndb1" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "data-bs-toggle="collapse" href="#collapseExample'+i+'" role="button" aria-expanded="false" aria-controls="collapseExample"><td id=logzone>'+'<i style="color:#d6d6d6" class="bi bi-check-circle-fill"></i>'+'</td><td style="text-align: center;"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;border: #BCBCBD 2px solid" class="mt-2 " ></td><td style="overflow: hidden;max-width: 200px;"><h4 style="color: #5c636a;padding: 0;margin:10px 0 5px 0 ">'+e[i].fid+'</h4><span style="height:10px;overflow: hidden;color: gray;font-size: 13px" id="last">'+last.msg+'</span></td><td class="col-3" style="padding-bottom: 0"><p id="msgcount11" style="text-align: center;margin-bottom: 10px"><span class="badge bg-secondary">'+count+'</span></p><sapn style="text-align: right;color:gray;font-size: 12px">'+last.mtime+'</span></td>';
                                      html+='</tr><tr style="border-bottom: #E4E5E8 1px solid"><td colspan="4" ><div class="collapse" id="collapseExample'+i+'" style="text-align: center;">'
                                      html+='<button class="btn  btn-outline-secondary" id="chatbtn" onclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') ">Go to Chat</button>'
                                      html+='<button style="margin-left: 25px" class="btn  btn-secondary"  onclick="cancelfr('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+')" data-bs-toggle="modal" data-bs-target="#cancelmodal" id="cbt">친구 취소</button></div></td></tr>'

                                  }

                              }
                              else{
                                  if(e[i].logc==1){
                                  html+='<tr id="btndb2" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "data-bs-toggle="collapse" href="#collapseExample'+i+'" role="button" aria-expanded="false" aria-controls="collapseExample"><td id="logzone1">'+'<i class="bi bi-check-circle-fill"></i>'+'</td><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;border: #BCBCBD 2px solid" class="mt-2 " ></td><td style="overflow: hidden;max-width: 200px;"><h4 style="color: #5c636a;padding: 0;margin:10px 0 5px 0 ">'+e[i].fid+'</h4><span style="height:10px;overflow: hidden;color: gray;font-size: 13px" id="last">'+last.msg+'</span></td><td class="col-3" style="padding-bottom: 0"><p id="msgcount11" style="text-align: center;margin-bottom: 10px" ><span class="badge " style="color:rgba(0,0,0,0);">'+count+'</span></p><sapn style="text-align: right;color:gray;font-size: 12px" >'+last.mtime+'</span></td>';
                                      html+='</tr><tr style="border-bottom: #E4E5E8 1px solid"><td colspan="4" ><div class="collapse" id="collapseExample'+i+'" style="text-align: center;">'
                                      html+='<button id="chatbtn" class="btn  btn-outline-secondary" onclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') ">Go to Chat</button>'
                                      html+='<button style="margin-left: 25px" class="btn  btn-secondary" onclick="cancelfr('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+')" data-bs-toggle="modal" data-bs-target="#cancelmodal" id="cbt">친구 취소</button></div></td></tr>'
                                  }else  {
                                      html+='<tr id="btndb2" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "data-bs-toggle="collapse" href="#collapseExample'+i+'" role="button" aria-expanded="false" aria-controls="collapseExample"><td id="logzone1">'+'<i style="color: #d6d6d6" class="bi bi-check-circle-fill"></i>'+'</td><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="50px" height="50px" style="border-radius: 30%;border: #BCBCBD 2px solid" class="mt-2 " ></td><td style="overflow: hidden;max-width: 200px;"><h4 style="color: #5c636a;padding: 0;margin:10px 0 5px 0 ">'+e[i].fid+'</h4><span style="height:10px;overflow: hidden;color: gray;font-size: 13px" id="last">'+last.msg+'</span></td><td class="col-3" style="padding-bottom: 0"><p id="msgcount11" style="text-align: center;margin-bottom: 10px" ><span class="badge " style="color:rgba(0,0,0,0);">'+count+'</span></p><sapn style="text-align: right;color:gray;font-size: 12px" >'+last.mtime+'</span></td>';
                                      html+='</tr><tr style="border-bottom: #E4E5E8 1px solid"><td colspan="4"><div class="collapse" id="collapseExample'+i+'" style="text-align: center;">'
                                      html+='<button id="chatbtn" class="btn  btn-outline-secondary" onclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') ">Go to Chat</button>'
                                      html+='<button style="margin-left: 25px" class="btn  btn-secondary" onclick="cancelfr('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+')" data-bs-toggle="modal" data-bs-target="#cancelmodal" id="cbt">친구 취소</button></div></td></tr>'

                                  }


                              }



                    }
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
                                result=e;

                            },
                            error:function (e){

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


                }
            });

             mcount("flist")

        }




            let mint=0
            let fint=0
        function mcount(type,fid){
            let timerVar1;
            let timerVar;
            let mid='${sessionScope.logmem.mid}'
            function timer(){
                mcount(type,fid)
            }

            $.ajax({
                url:"/msg/mcount",
                type:"get",
                data:{"mget":mid,"type":type},
                dataType:"text",
                success:function (e){



                    if(type=="flist"){

                        if(e!=fint){
                            flist()
                        }
                        pcount(),ycount(),logcount()


                        timerVar =setTimeout( timer, 2000,"flist")
                        fint=e;

                    }else if(type=="msglist"){

                        clearTimeout(timerVar);


                        timerVar1 =setTimeout( timer, 1000,"msglist",fid)
                        if(mint!=e){
                            findmsg(fid)

                       }
                        mint=e;
                    }


                    $("#closemodal,#xbtn").click(function (){
                        clearTimeout(timerVar1);
                    })



                    $("#btndb1,#btndb2").dblclick(function (){
                       clearTimeout(timerVar);

                    })
                    $("#chatbtn,#cbt,#modalbtn,#countzone,#nfrbtn").click(function (){
                        clearTimeout(timerVar);

                    })


                },
                error:function (e){



            }})}



            function test() {
            document.getElementById("msgbody").scrollTop = document.getElementById("msgbody").scrollHeight;
                    }

        function findmsg(fid){

            let body=document.getElementById("msgbody")
            let html='<div>'
            $.ajax({
                url:"/msg/findmsg",
                type:"get",
                data:{"mset":'${sessionScope.logmem.mid}',"mget":fid},
                dataType:"json",
                success:function (e){
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

                            html+='<div class="">'+e[i].msg+'</div></div>'


                        }
                        else{

                            html+='<div style="overflow: hidden;word-break:break-all;text-align: left; margin-top: 30px">'+e[i].mtime+'</div>'
                            html+='<div style="text-align:left; color: #5c636a; padding:10px;border: #C4C4C5 1px solid; background-color:#EEEEEF; border-radius: 5px">'
                            html+='<div class="">'+e[i].msg+'</div></div>'
                        }
                    }
                    body.innerHTML=html;
                    setTimeout(test,150)






                },
                error:function (e){

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

                    findmsg(fid)
                    msg.value=null
                    msg.focus()
                    setTimeout(findmsg,700,fid);

                },
                error:function (e){

                }


            })


        }


    </script>
</head>
<body onload="flist()">

<div class="form-control container" style="background-color:#E4E5E8;padding: 10px 20px 0 25px;width: 400px;margin-top:20px;border-bottom-right-radius: 0;border-bottom-left-radius: 0 " >



    <div class="" style=";margin-top:10px;margin-bottom: 20px">
        <div class="" style="">
        <div class="input-group " style="margin-left: 160px;width:200px;" >
            <input style="border: 2px gray solid" id="search" class="form-control"
                    placeholder="Find ID" >
            <button class="input-group-text btn btn-secondary" id="modalbtn" onclick="pfrc()" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="bi bi-search"></i></button>
    </div>
    </div>
        </div>
</div>




<div class="form-control container" style="border-radius:0;width: 400px;height: 100px;border-top: 0;border-bottom: 0;background-color:#F6F6F7;" >

    <table class="table table-borderless" style=";">
        <tr data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
            <th style="font-size: 30px"><p class="mt-3" style="color: #5c636a;margin-bottom: 0;text-align: right">${sessionScope.logmem.mid}</p></th>
            <td style="width:100px; height:100px"><img src="${pageContext.request.contextPath}/upload/${sessionScope.logmem.mfname}"
                                                            alt="" width="70px" height="70px" class="dot" style="border-radius: 30%;border:2px solid gray"></td>
        </tr>
    </table></div>


<div class="form-control container" style="border-radius:0;background-color:#E4E5E8;width: 400px;padding: 15px 10px 15px 10px" >

        <div id="table" class="" style="border-radius: 0%;height: 500px;overflow:auto;">


        </div>
        <!-- Button trigger modal -->
        <button type="button" id="mbtn11" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#hssModal" hidden></button>
                    <div id="nfrbtn"  style=";display:none;margin:0;padding: 0"  data-bs-toggle="modal" href="#exampleModalToggle2" role="button">22222</div>

    </div>
<div class="form-control container" style="color: #5c636a;border-top:0;border-top-right-radius: 0;border-top-left-radius: 0;text-align:right;background-color:#E4E5E8;width: 400px;" >
    <div class="row justify-content-between">
        <div class="col-4 " style="margin-left: 10px">
            <div class="input-group" onclick="yes()" id="countzone" style="margin-top:8px;margin-bottom: 9px;color: #5c636a"  data-bs-toggle="modal" href="#exampleModalToggle" role="button">
            </div>

        </div>

            <div class="col-4 mt-2">
                <i style="font-size: 40px;margin: 20px 0px 10px 0" class="bi bi-box-arrow-right" onclick="logout()"></i>
            </div>
        </div>
</div>




<!-- 새로운 친구신청 Modal -->
<div class="modal fade " id="nfr" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 450px;background-color: #E4E5E8">
            <div class="modal-header">
                <br></div>
            <div class="modal-body container" id="nfrzone" style="font-size: 15px;background-color: rgba(253,253,253,0.5);color: #5c636a;text-align: center">

            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</div>







<!--  cancel Modal -->
<div class="modal fade  container"  data-bs-backdrop="static" id="cancelmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 430px">
            <div class="modal-header ">
                <button type="button" onclick="flist()" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body " id="cancelzone" >
                ...
            </div>
            <div class="modal-footer ">
                <button type="button" onclick="flist()" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>







    <!-- 친구 찾기 Modal -->
    <div class="modal fade " id="exampleModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 450px;background-color: #E4E5E8">
                <div class="modal-header">
                <br></div>
               <div class="modal-body container" id="result" style="margin: 0;font-size: 15px;background-color: rgba(253,253,253,0.5);color: #5c636a;text-align: center">

                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="flist()">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>



<!--  메시지 Modal -->
<div  style="" class="modal fade" id="hssModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog  " style="width: 400px" >
        <div class="modal-content" style="background-color: #E4E5E8" >
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
                <button type="button" id="xbtn" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="flist()" ></button>
            </div>
            <div class="modal-body" id="msgbody" style="overflow: auto;height: 420px; background-color:rgba(253,253,253,0.9)">
                ...
            </div>
            <div class="modal-footer" id="footer">
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
                let type="cancel"
                let html;
                if(e.length==0){
                    html='<table class="table table-borderless" style="">'
                    html+='<tr><td style="text-align: center"><div style="color:#5c636a;margin-top:20px;">내가 한 친구 신청이 없습니다.</div></td></tr>'
                }else{
                    html='<table class="table " style="">'}
                for(let i in e){
                    html+='<tr><td style="text-align: center"><img src="/upload/'+e[i].yfname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h2 style="margin-top: 30px;color: #5c636a">'+e[i].yid+'</h2></td>';
                    html+='<td style="text-align: center"><button class="btn btn-outline-secondary mt-4" onclick="'+"nof('"+e[i].yid+"','"+e[i].pfname+"','"+e[i].yfname+"','"+type+"'"+')"'+'">신청취소</button></td></tr>'}
                html+='</table>';
                zone.innerHTML=html;
            },
            error:function (e){

            }

        })


    }

    function yes(){
        let zone=document.getElementById("mzone");
        let type="nof"
        let yid='${sessionScope.logmem.mid}'
        $.ajax({
            url:"/pfr/yes",
            type:"get",
            data:{"yid":yid},
            dataType:"json",
            success:function (e){


                let html;
                if(e.length==0){
                    html='<table class="table table-borderless" style="">'
                    html+='<tr><td style="text-align: center"><div style="color:#5c636a;margin-top:20px;">새로운 친구 신청이 없습니다.</div></td></tr>'
                }else{
                html='<table class="table " style="">'}
                for(let i in e){
                    html+='<tr><td style="text-align: center"><img src="/upload/'+e[i].pfname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h3 class="mt-4" style="color: #5c636a">'+e[i].pid+'</h3></td>';
                    html+='<td style="text-align: center"><button id="test" class="test btn btn-outline-secondary mt-4" onclick="'+"yesf('"+e[i].pid+"','"+e[i].pfname+"','"+e[i].yfname+"')"+'">수락</button>&nbsp<button class="btn btn-outline-secondary mt-4" onclick="'+"nof('"+e[i].pid+"','"+e[i].pfname+"','"+e[i].yfname+"','"+type+"'"+')"'+'">거절</button></td></tr>'}

                html+='</table>'
                zone.innerHTML=html;
            },
            error:function (e){

            }

        })



    }
    function yesf(pid,pfname,yfname){
        let yid='${sessionScope.logmem.mid}';
        let zone=document.getElementById("mzone")
        $.ajax({
            url:"/pfr/yesf",
            type:"get",
            data:{"pid":pid,"yid":yid,"pfname":pfname,"yfname":yfname},
            dataType:"text",
            success:function (e){

                zone.innerHTML='<div style="text-align: center;margin-top: 30px;margin-bottom: 30px;color: #51585e"><h3 style="text-align:center;color: #343a40"><b>'+pid+'</b></h3>님의 친구신청을 수락 하였습니다.</div>'
                flist()
            },
            error:function (e){


            }

        })

    }

    function nof(pid,pfname,yfname,type){
        let yid='${sessionScope.logmem.mid}';
        let zone=document.getElementById("mzone")
        let zone1=document.getElementById("mzone1")
        if(type=="nof"){
        $.ajax({
            url:"/pfr/nof",
            type:"get",
            data:{"pid":pid,"yid":yid,"pfname":pfname,"yfname":yfname},
            dataType:"text",
            success:function (e){

                zone.innerHTML='<div style="text-align: center;margin-top: 30px;margin-bottom: 30px;color: #51585e"><h3 style="text-align:center;color: #343a40"><b>'+pid+'</b></h3>님의 친구신청을 거절 하였습니다.</div>'

            },
            error:function (e){


            }

        })}else if(type=="cancel"){
            $.ajax({
                url:"/pfr/nof",
                type:"get",
                data:{"pid":yid,"yid":pid,"pfname":yfname,"yfname":pfname},
                dataType:"text",
                success:function (e){

                    zone1.innerHTML='<div style="text-align: center;margin-top: 30px;margin-bottom: 30px;color: #51585e"><h3 style="text-align:center;color: #343a40"><b>'+pid+'</b></h3>님에게 한 친구신청을 취소 하였습니다.</div>'

                },
                error:function (e){


                }

            })

        }
    }

</script>





<div class="modal fade" id="exampleModalToggle" data-bs-backdrop="static" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="width:450px ;background-color: #E4E5E8">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel">내가 받은 친구 신청</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="flist()"></button>
            </div>
            <div class="modal-body" style="background-color: rgba(253,253,253,0.5)" id="mzone">

            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal" onclick="plz()">내가 한 친구신청 보기</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="exampleModalToggle2" data-bs-backdrop="static" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
    <div class="modal-dialog ">
        <div class="modal-content" style="width: 450px;background-color: #E4E5E8">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel2">내가 한 친구신청</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="flist()"></button>
            </div>
            <div class="modal-body" style="background-color: rgba(253,253,253,0.5)" id="mzone1">

            </div>
            <div class="modal-footer">
                <button  class="btn btn-secondary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal" onclick="yes()">내가 받은 친구신청 보기</button>
            </div>
        </div>
    </div>
</div>


<script>

</script>




</body>
</html>
