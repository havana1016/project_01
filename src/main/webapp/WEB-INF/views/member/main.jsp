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
        .arrow_box {
            position: relative;
            background: #88b7d5;
            border: 4px solid #c2e1f5;
        }
        .arrow_box:after, .arrow_box:before {
            bottom: 100%;
            left: 50%;
            border: solid transparent;
            content: "";
            height: 0;
            width: 0;
            position: absolute;
            pointer-events: none;
        }

        .arrow_box:after {
            border-color: rgba(136, 183, 213, 0);
            border-bottom-color: #88b7d5;
            border-width: 30px;
            margin-left: -30px;
        }
        .arrow_box:before {
            border-color: rgba(194, 225, 245, 0);
            border-bottom-color: #c2e1f5;
            border-width: 36px;
            margin-left: -36px;
        }



    </style>
    <script>

        // <!-- 채팅 스크롤 하단으로 보내기 -->
        // $('#msgbody').scrollTop($('#msgbody')[0].scrollHeight);



        출처: https://mjmjmj98.tistory.com/40 [Live passionate😎:티스토리]


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
                document.getElementById("mbtn11").click()
                let zone=document.getElementById("exampleModalLabel")
                let footer=document.getElementById("footer")
                let html='<table><tr><td>'
                html+='<img src="/upload/'+ffname+'" height="70px" width="70px"></td><td>'
                html+='<h3 class="mt-4" style="margin-left: 30px">'+fid+'</h3></td></tr></table>'

                zone.innerHTML=html;
                let html2='<textarea class="form-control mb-2" id="msg" cols="20" wrap="hard"></textarea>'
                html2+='<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="closemodal" >Close</button>'
                html2+='<button type="button" class="btn btn-primary" id="sendbtn" onclick="savemsg('+"'"+fid+"'"+')">Send</button>'
                // html2+='<button type="button" class="btn btn-primary" id="sendbtn" onclick="savemsg('+"'"+fid+"','"+msg+"'"+')">Send</button>'
                footer.innerHTML=html2;


                findmsg(fid)


                // document.getElementById("mbtn11").click()






            }
        function flist(){
            pcount()
            let flistz=document.getElementById("table");
            $.ajax({
                url:"/fr/findall",
                type:"get",
                data:{"mid":'${sessionScope.logmem.mid}'},
                dataType:'json',
                success:function (e){
                    console.log("flist suc")
                    let html='<table class="table table-hover">'
                    for(let i in e){
                             let count = msgcount('${sessionScope.logmem.mid}',e[i].fid);

                              if(count>0){
                        html+='<tr id="btndb1" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h4 id="msgcount11"><span class="badge bg-secondary mt-2">New '+count+'</span></h4><h2 class="">'+e[i].fid+'</h2></td>';}
                              else{
                                  html+='<tr id="btndb" ondblclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h2 style="margin-top: 30px">'+e[i].fid+'</h2></td>';}
                        //
                        html+='<td style="text-align: center"><button id="btbt" class="btn btn-outline-secondary mt-4" >버튼버튼</button></td><td><td></tr>'
                    }
                        // html+='<tr onclick="mbtn('+"'"+e[i].fid+"'"+",'"+e[i].ffname+"'"+') "data-bs-toggle="modal" data-bs-target="#hssModal"><td style="text-align: center"><img src="/upload/'+e[i].ffname+'" width="70px" height="70px" style="border-radius: 30%;" class="mt-1" ></td><td><h2 class="mt-4">'+e[i].fid+'</h2></td>';


                    html+='</table>'
                    flistz.innerHTML=html;

                    function timer(){
                        flist()
                    }

                    let timerVar1 =setTimeout( timer, 2000);
                    // clearTimeout(timerVar1);
                    $("#btndb,#btndb1").dblclick(function (){

                        clearTimeout(timerVar1);
                    })


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


        }



            function test() {
            document.getElementById("msgbody").scrollTop = document.getElementById("msgbody").scrollHeight;
            //     let myDiv = document.getElementById("msgbody");
            //     myDiv.scrollTop = myDiv.scrollHeight;

        }
        // function msgcount(mset,mget){
        //     let zone=document.getElementById("countzone")
        //     $.ajax({
        //         url:"/msg/count",
        //         type:"get",
        //         data:{"mset":mset,"mget":mget},
        //         dataType:"text",
        //         success:function (e){
        //             console.log("msgcount suc : "+e)
        //             if(e>0){
        //                 zone.innerHTML='<span class="badge bg-secondary mt-2 ">New</span> &nbsp'+e;
        //             }
        //
        //         },
        //         error:function (e){
        //             console.log("msgcount err")
        //
        //         }
        //     })
        // }



        <%--function findmsg3(fid){--%>

        <%--    let body=document.getElementById("msgbody")--%>
        <%--    let zone=document.getElementById("exampleModalLabel")--%>

        <%--    $.ajax({--%>
        <%--        url:"/msg/findmsg",--%>
        <%--        type:"get",--%>
        <%--        data:{"mset":'${sessionScope.logmem.mid}',"mget":fid},--%>
        <%--        dataType:"json",--%>
        <%--        success:function (e){--%>
        <%--            console.log("findmsg suc")--%>
        <%--            let html='<table class="table">'--%>
        <%--            for(let i in e){--%>
        <%--                html+='<tr><td>'--%>
        <%--                html+="'"+e[i].mset+"'"--%>
        <%--                html+='</td><td>'--%>
        <%--                html+="'"+e[i].mtime+"'"--%>
        <%--                if(e[i].mset=='${sessionScope.logmem.mid}'){--%>
        <%--                html+='</td></tr><tr style="text-align: right;">'--%>
        <%--                    html+='<td ><div style="padding:10px; background-color:#77FF0F; border-radius: 5px">'--%>
        <%--                    html+=e[i].msg+'</div></td></tr>'--%>

        <%--                }--%>
        <%--                else{--%>
        <%--                    html+='</td></tr><tr style="text-align: left">'--%>
        <%--                    html+='<td ><div id="text" style="padding:10px; background-color:#E7E8EB; border-radius: 5px">'--%>
        <%--                    html+=e[i].msg+'</div></td></tr>'--%>
        <%--                    // html+=e[i].msg+e[i].setint--%>
        <%--                    // html+='</div></td></tr>'--%>
        <%--                }--%>

        <%--                // html+="'"+e[i].msg+"'"--%>
        <%--                // html+='</div></td></tr>'--%>
        <%--            }--%>

        <%--            html+='</table>'--%>
        <%--            body.innerHTML=html;--%>

        <%--            setTimeout(function() {--%>
        <%--                test();--%>
        <%--            }, 150);--%>
        <%--            function timer(){--%>
        <%--                findmsg(fid)--%>
        <%--            }--%>

        <%--            let timerVar = setTimeout( timer, 1000);--%>
        <%--            // setTimeout(function (){--%>
        <%--            // findmsg(fid)},1000--%>
        <%--            //--%>
        <%--            // )--%>
        <%--            $("#closemodal,#xbtn").click(function (){--%>
        <%--                clearTimeout(timerVar);--%>
        <%--            })--%>



        <%--        },--%>
        <%--        error:function (e){--%>
        <%--            console.log("findmsg err")--%>

        <%--        }--%>


        <%--    })}--%>

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
                            html+='<div class="col-5" style="text-align: right">'
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

                        // html+="'"+e[i].msg+"'"
                        // html+='</div></td></tr>'
                    }


                    body.innerHTML=html;

                    setTimeout(function() {
                        test();
                    }, 150);
                    function timer(){
                        findmsg(fid)
                    }

                    let timerVar = setTimeout( timer, 1000);
                    // setTimeout(function (){
                    // findmsg(fid)},1000
                    //
                    // )
                    $("#closemodal,#xbtn").click(function (){
                        clearTimeout(timerVar);
                        location.href="/member/main"
                    })



                },
                error:function (e){
                    console.log("findmsg err")

                }


            })}



        function savemsg(fid){
            let msg=document.getElementById("msg");

            $.ajax({
                url:"/msg/save",
                data:{"mset":'${sessionScope.logmem.mid}',"mget":fid,"msg":msg.value},
                type:"get",
                dataType:"text",
                success:function (e){
                    console.log("savemsg suc")
                    findmsg(fid)
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
<div style="width: 550px;padding: 30px" >
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
    <div class="mt-2">
        <div id="table" class="htable" style="height: 600px; overflow: auto">


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
<div style="width: 550px" class="modal fade hss" id="hssModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<%--    <div class="modal-dialog hss modal-dialog-scrollable" id="abc">--%>
    <div class="modal-dialog hss " id="abc">
        <div class="modal-content hss">
            <div class="modal-header hss">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
<%--                Modal title--%>
                <button type="button" id="xbtn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body hss" id="msgbody" style="overflow: auto;height: 500px; ">
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
