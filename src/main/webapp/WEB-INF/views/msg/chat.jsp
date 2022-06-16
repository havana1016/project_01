<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-16
  Time: 오후 2:45
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


    </script>



</head>
<body onload="">
<jsp:include page="/resources/layout/header.jsp" ></jsp:include>
<div class="form-control container" style="border-top: 0;background-color: #C8EEF3;width: 400px;height: 710px;border-top-right-radius: 0;border-top-left-radius: 0;padding: 15px 10px 15px 10px" >
    <div style="background-color: rgba(253,253,253,0.5)">
    <table class="table table-hover table-bordered">
    <c:forEach var="result" items="${clist}">
            <script>
                function findclist(){
                    $.ajax({
                        url:"/msg/chatlist",
                        type:"get",
                        data:{"mget":'${sessionScope.logmem.mid}',"mset":${result.mset}},
                        dataType:"json",
                        success:function (e){
                            console.log("findclist suc")
                        },
                        error:function (){
                            console.log("findclist err")

                        }
                    })
                }
            </script>
        <tr style="padding-bottom: 0">
            <td class="col-1" style="text-align: center">
                <img src="/upload/${result.sfname}" width="50px" height="50px" style="border-radius: 30%;" class="mt-1" >
            </td>
            <td class="col-4"><h5 style="">${result.mset}</h5><p style="color:gray;margin-bottom: 0">${result.msg}</p></td>
            <td class="col-2"><p style="margin-bottom:10px ;font-size: 12px;color:gray;text-align: right">${result.mtime}</p><p style="text-align: center;margin: 0">51</p></td>
        </tr>

    </c:forEach>
    </table>
    </div>

</div>






</body>
</html>
