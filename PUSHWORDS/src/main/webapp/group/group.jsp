<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Site de Mémorisation de Mots</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Other dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/index.css">
    <script nomodule src="https://cdn.jsdelivr.net/npm/@ionic/core/dist/ionic/ionic.js"></script>
    <script type="module" src="https://cdn.jsdelivr.net/npm/@ionic/core/dist/ionic/ionic.esm.js"></script>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            font-family: Arial, sans-serif;
        }

        body {
            background: radial-gradient(ellipse at bottom, #1b2735 0%, #090a0f 100%);
            height: 100vh;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .icons-container {
            display: flex;
            justify-content: space-between; /* Center icons horizontally */
            align-items: center; /* Center icons vertically */
            background-color: rgba(0,0,0,0);
            color: #fff;
            padding: 10px;
            width: 100%; /* Full width */
            position: fixed;
            top: 0;
            z-index: 1; /* Update to ensure it doesn't cover the modal */
        }

        .custom-icon {
            font-size: 40px; /* Increase icon size */
            color: white; /* Icon color */
        }

        .icon-wrapper{
            margin: 0 150px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px; /* Space between links */
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 18px; /* Increase font size for better visibility */
            padding: 10px 15px;
        }

        .nav-links a:hover {
            background-color: #555;
        }

        .nav-links .current {
            background-color: green;
        }

        .main-content {
            margin-top: 60px;
            width: 100vh;
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: rgba(232, 232, 232, 0); /* 背景颜色设置为略微透明 */
            box-sizing: border-box;
            min-height: calc(100vh - 200px); /* Adjusted for new margin top */
            overflow-y: auto;
            z-index: 1055;
            position: relative;
            border-radius: 10px; /* 可选，增加圆角 */
        }

        .form-group {
            margin-bottom: 20px; /* Adjust form field spacing */
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-size: 16px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #0056b3;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
            font-size: 14px;
        }

        input[type="submit"]:hover {
            background-color: #003875;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: rgba(0,0,0,0);
        }
        .table th, .table td {
            border: 1px solid #ddd;
            padding: 8px 16px;
            text-align: left;
        }
        .table th {
            background-color: #4CAF50;
            color: white;
        }
        .table tr:nth-child(even) {
            background-color: rgba(0,0,0,0);
        }

        .table-striped tr:nth-child(odd) {
            background-color: rgba(0,0,0,0);
        }

        .button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #45a049;
        }

        .button.delete {
            background-color: #f44336;
        }

        .button.delete:hover {
            background-color: #c33c24;
        }

        #loading {
            background-color: #fff; /* 背景颜色 */
            position: fixed; /* 固定位置覆盖整个页面 */
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 9999; /* 确保加载动画显示在最顶层 */
            display: flex;
            justify-content: center; /* 水平居中 */
            align-items: center; /* 垂直居中 */
        }

        .night {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            -webkit-transform: rotateZ(45deg);
            transform: rotateZ(45deg);
            -webkit-animation: sky 200000ms linear infinite;
            animation: sky 200000ms linear infinite;
            z-index: 0; /* Set z-index to be the lowest */
        }

        .shooting_star {
            position: absolute;
            left: 50%;
            top: 50%;
            height: 2px;
            background: linear-gradient(-45deg, #5f91ff, rgba(0, 0, 255, 0));
            border-radius: 999px;
            -webkit-filter: drop-shadow(0 0 6px #699bff);
            filter: drop-shadow(0 0 6px #699bff);
            -webkit-animation: tail 3000ms ease-in-out infinite, shooting 3000ms ease-in-out infinite;
            animation: tail 3000ms ease-in-out infinite, shooting 3000ms ease-in-out infinite;
        }

        .shooting_star::before,
        .shooting_star::after {
            content: '';
            position: absolute;
            top: calc(50% - 1px);
            right: 0;
            height: 2px;
            background: linear-gradient(-45deg, rgba(0, 0, 255, 0), #5f91ff, rgba(0, 0, 255, 0));
            -webkit-transform: translateX(50%) rotateZ(45deg);
            transform: translateX(50%) rotateZ(45deg);
            border-radius: 100%;
            -webkit-animation: shining 3000ms ease-in-out infinite;
            animation: shining 3000ms ease-in-out infinite;
        }

        .shooting_star::after {
            -webkit-transform: translateX(50%) rotateZ(-45deg);
            transform: translateX(50%) rotateZ(-45deg);
        }

        .shooting_star:nth-child(1) {
            top: calc(50% - 185px);
            left: calc(50% - 150px);
            -webkit-animation-delay: 8971ms;
            animation-delay: 8971ms;
        }

        .shooting_star:nth-child(1)::before,
        .shooting_star:nth-child(1)::after,
        .shooting_star:nth-child(1)::after {
            -webkit-animation-delay: 8971ms;
            animation-delay: 8971ms;
        }

        .shooting_star:nth-child(2) {
            top: calc(50% - 50px);
            left: calc(50% - 179px);
            -webkit-animation-delay: 9256ms;
            animation-delay: 9256ms;
        }

        .shooting_star:nth-child(2)::before,
        .shooting_star:nth-child(2)::after,
        .shooting_star:nth-child(2)::after {
            -webkit-animation-delay: 9256ms;
            animation-delay: 9256ms;
        }

        .shooting_star:nth-child(3) {
            top: calc(50% - -146px);
            left: calc(50% - 135px);
            -webkit-animation-delay: 8700ms;
            animation-delay: 8700ms;
        }

        .shooting_star:nth-child(3)::before,
        .shooting_star:nth-child(3)::after,
        .shooting_star:nth-child(3)::after {
            -webkit-animation-delay: 8700ms;
            animation-delay: 8700ms;
        }

        .shooting_star:nth-child(4) {
            top: calc(50% - -77px);
            left: calc(50% - 157px);
            -webkit-animation-delay: 3147ms;
            animation-delay: 3147ms;
        }

        .shooting_star:nth-child(4)::before,
        .shooting_star:nth-child(4)::after,
        .shooting_star:nth-child(4)::after {
            -webkit-animation-delay: 3147ms;
            animation-delay: 3147ms;
        }

        .shooting_star:nth-child(5) {
            top: calc(50% - -183px);
            left: calc(50% - 8px);
            -webkit-animation-delay: 6588ms;
            animation-delay: 6588ms;
        }

        .shooting_star:nth-child(5)::before,
        .shooting_star:nth-child(5)::after,
        .shooting_star:nth-child(5)::after {
            -webkit-animation-delay: 6588ms;
            animation-delay: 6588ms;
        }

        .shooting_star:nth-child(6) {
            top: calc(50% - -29px);
            left: calc(50% - 195px);
            -webkit-animation-delay: 8009ms;
            animation-delay: 8009ms;
        }

        .shooting_star:nth-child(6)::before,
        .shooting_star:nth-child(6)::after,
        .shooting_star:nth-child(6)::after {
            -webkit-animation-delay: 8009ms;
            animation-delay: 8009ms;
        }

        .shooting_star:nth-child(7) {
            top: calc(50% - 95px);
            left: calc(50% - 69px);
            -webkit-animation-delay: 5420ms;
            animation-delay: 5420ms;
        }

        .shooting_star:nth-child(7)::before,
        .shooting_star:nth-child(7)::after,
        .shooting_star:nth-child(7)::after {
            -webkit-animation-delay: 5420ms;
            animation-delay: 5420ms;
        }

        .shooting_star:nth-child(8) {
            top: calc(50% - -59px);
            left: calc(50% - 70px);
            -webkit-animation-delay: 9378ms;
            animation-delay: 9378ms;
        }

        .shooting_star:nth-child(8)::before,
        .shooting_star:nth-child(8)::after,
        .shooting_star:nth-child(8)::after {
            -webkit-animation-delay: 9378ms;
            animation-delay: 9378ms;
        }

        .shooting_star:nth-child(9) {
            top: calc(50% - 76px);
            left: calc(50% - 238px);
            -webkit-animation-delay: 2845ms;
            animation-delay: 2845ms;
        }

        .shooting_star:nth-child(9)::before,
        .shooting_star:nth-child(9)::after,
        .shooting_star:nth-child(9)::after {
            -webkit-animation-delay: 2845ms;
            animation-delay: 2845ms;
        }

        .shooting_star:nth-child(10) {
            top: calc(50% - 83px);
            left: calc(50% - 6px);
            -webkit-animation-delay: 5205ms;
            animation-delay: 5205ms;
        }

        .shooting_star:nth-child(10)::before,
        .shooting_star:nth-child(10)::after,
        .shooting_star:nth-child(10)::after {
            -webkit-animation-delay: 5205ms;
            animation-delay: 5205ms;
        }

        .shooting_star:nth-child(11) {
            top: calc(50% - -137px);
            left: calc(50% - 267px);
            -webkit-animation-delay: 808ms;
            animation-delay: 808ms;
        }

        .shooting_star:nth-child(11)::before,
        .shooting_star:nth-child(11)::after,
        .shooting_star:nth-child(11)::after {
            -webkit-animation-delay: 808ms;
            animation-delay: 808ms;
        }

        .shooting_star:nth-child(12) {
            top: calc(50% - 12px);
            left: calc(50% - 8px);
            -webkit-animation-delay: 2406ms;
            animation-delay: 2406ms;
        }

        .shooting_star:nth-child(12)::before,
        .shooting_star:nth-child(12)::after,
        .shooting_star:nth-child(12)::after {
            -webkit-animation-delay: 2406ms;
            animation-delay: 2406ms;
        }

        .shooting_star:nth-child(13) {
            top: calc(50% - 148px);
            left: calc(50% - 47px);
            -webkit-animation-delay: 7566ms;
            animation-delay: 7566ms;
        }

        .shooting_star:nth-child(13)::before,
        .shooting_star:nth-child(13)::after,
        .shooting_star:nth-child(13)::after {
            -webkit-animation-delay: 7566ms;
            animation-delay: 7566ms;
        }

        .shooting_star:nth-child(14) {
            top: calc(50% - -28px);
            left: calc(50% - 75px);
            -webkit-animation-delay: 7634ms;
            animation-delay: 7634ms;
        }

        .shooting_star:nth-child(14)::before,
        .shooting_star:nth-child(14)::after,
        .shooting_star:nth-child(14)::after {
            -webkit-animation-delay: 7634ms;
            animation-delay: 7634ms;
        }

        .shooting_star:nth-child(15) {
            top: calc(50% - -37px);
            left: calc(50% - 203px);
            -webkit-animation-delay: 7743ms;
            animation-delay: 7743ms;
        }

        .shooting_star:nth-child(15)::before,
        .shooting_star:nth-child(15)::after,
        .shooting_star:nth-child(15)::after {
            -webkit-animation-delay: 7743ms;
            animation-delay: 7743ms;
        }

        .shooting_star:nth-child(16) {
            top: calc(50% - 41px);
            left: calc(50% - 256px);
            -webkit-animation-delay: 2888ms;
            animation-delay: 2888ms;
        }

        .shooting_star:nth-child(16)::before,
        .shooting_star:nth-child(16)::after,
        .shooting_star:nth-child(16)::after {
            -webkit-animation-delay: 2888ms;
            animation-delay: 2888ms;
        }

        .shooting_star:nth-child(17) {
            top: calc(50% - -35px);
            left: calc(50% - 121px);
            -webkit-animation-delay: 5864ms;
            animation-delay: 5864ms;
        }

        .shooting_star:nth-child(17)::before,
        .shooting_star:nth-child(17)::after,
        .shooting_star:nth-child(17)::after {
            -webkit-animation-delay: 5864ms;
            animation-delay: 5864ms;
        }

        .shooting_star:nth-child(18) {
            top: calc(50% - 73px);
            left: calc(50% - 225px);
            -webkit-animation-delay: 7883ms;
            animation-delay: 7883ms;
        }

        .shooting_star:nth-child(18)::before,
        .shooting_star:nth-child(18)::after,
        .shooting_star:nth-child(18)::after {
            -webkit-animation-delay: 7883ms;
            animation-delay: 7883ms;
        }

        .shooting_star:nth-child(19) {
            top: calc(50% - -69px);
            left: calc(50% - 47px);
            -webkit-animation-delay: 3339ms;
            animation-delay: 3339ms;
        }

        .shooting_star:nth-child(19)::before,
        .shooting_star:nth-child(19)::after,
        .shooting_star:nth-child(19)::after {
            -webkit-animation-delay: 3339ms;
            animation-delay: 3339ms;
        }

        .shooting_star:nth-child(20) {
            top: calc(50% - 162px);
            left: calc(50% - 129px);
            -webkit-animation-delay: 7963ms;
            animation-delay: 7963ms;
        }

        .shooting_star:nth-child(20)::before,
        .shooting_star:nth-child(20)::after,
        .shooting_star:nth-child(20)::after {
            -webkit-animation-delay: 7963ms;
            animation-delay: 7963ms;
        }

        @-webkit-keyframes tail {
            0% {
                width: 0;
            }

            30% {
                width: 100px;
            }

            100% {
                width: 0;
            }
        }

        @keyframes tail {
            0% {
                width: 0;
            }

            30% {
                width: 100px;
            }

            100% {
                width: 0;
            }
        }

        @-webkit-keyframes shining {
            0% {
                width: 0;
            }

            50% {
                width: 30px;
            }

            100% {
                width: 0;
            }
        }

        @keyframes shining {
            0% {
                width: 0;
            }

            50% {
                width: 30px;
            }

            100% {
                width: 0;
            }
        }

        @-webkit-keyframes shooting {
            0% {
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }

            100% {
                -webkit-transform: translateX(300px);
                transform: translateX(300px);
            }
        }

        @keyframes shooting {
            0% {
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }

            100% {
                -webkit-transform: translateX(300px);
                transform: translateX(300px);
            }
        }

        @-webkit-keyframes sky {
            0% {
                -webkit-transform: rotate(45deg);
                transform: rotate(45deg);
            }

            100% {
                -webkit-transform: rotate(405deg);
                transform: rotate(405deg);
            }
        }

        @keyframes sky {
            0% {
                -webkit-transform: rotate(45deg);
                transform: rotate(45deg);
            }

            100% {
                -webkit-transform: rotate(405deg);
                transform: rotate(405deg);
            }
        }
    </style>
</head>
<body>

<div id="loading">
    <div class="loader"><div class="loader"><img src="${pageContext.request.contextPath}/statics/images/load.png" width="296" height="140"></div> </div> <!-- 你可以替换为自己的加载动画 -->
</div>

<div class="icons-container">
    <div class="icon-wrapper">
        <a href="user/profile.jsp"><ion-icon class="custom-icon" name="person-circle-outline"></ion-icon></a>
    </div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/index.jsp">Accueil</a>
        <a href="${pageContext.request.contextPath}/word?actionName=view">Publier</a>
        <a class="current" href="${pageContext.request.contextPath}/group?actionName=list">Gestion des Catégories</a>
        <a href="${pageContext.request.contextPath}/mem?actionName=list">Memoriser</a>
        <a href="${pageContext.request.contextPath}/report?actionName=showReports">Rapports de Données</a>
    </div>

    <div class="icon-wrapper">
        <a href="${pageContext.request.contextPath}/user?actionName=logout"><ion-icon class="custom-icon" name="exit-outline"></ion-icon></a>
    </div>
</div>

<!-- Shooting stars background -->
<div class="night">
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
    <div class="shooting_star"></div>
</div>

<main class="main-content" id="page-content">

    <div id="myDiv">
        <c:if test="${empty groupList}">
            <h2 style="color: rgb(248,246,231)"> No data Found! </h2>

        </c:if>
        <c:if test="${!empty groupList}">
            <table id="myTable" class="table table-hover table-striped">
                <tbody>
                <tr>
                    <th style="color: rgb(248,246,231)">Group Name</th>
                    <th style="color: rgb(248,246,231)">Group Description</th>
                    <th style="color: rgb(248,246,231)">Options</th>

                </tr>
                <c:forEach items="${groupList}" var="item">
                    <tr style="color: rgb(248,246,231)" id="tr_${item.groupId}">
                        <td style="color: rgb(248,246,231)">${item.groupName}</td>
                        <td style="color: rgb(248,246,231)">${item.groupDescription}</td>
                        <td>
                            <button type="button" class="button" data-bs-toggle="modal" data-bs-target="#myModal"
                                    data-modal-title="Modify Group"
                                    data-group-id="${item.groupId}"
                                    data-group-name="${item.groupName}"
                                    data-group-description="${item.groupDescription}">
                                Modify
                            </button>
                            <button class="button delete" onclick="deleteGroup(${item.groupId})">delete</button>
                        </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>

    <div style="display: flex; justify-content: center; align-items: center">
        <button type="button" class="button" data-bs-toggle="modal" data-bs-target="#myModal" data-modal-title="Add Group">Add a group</button>
    </div>

    <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">ADD GROUP</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label for="groupname">Group Name</label>
                        <input type="hidden" id="groupId" name="groupId">
                        <input type="text" name="groupname" class="form-control" id="groupname" placeholder="Group Name">

                        <label for="groupdescription">Group Description</label>
                        <input type="text" name="groupdescription" class="form-control" id="groupdescription" placeholder="Group Description">

                    </div>
                </div>

                <div class="modal-footer">
                    <span id="msg" style="font-size: 12px;color: red"></span>
                    <button id="btn_submit" type="button" class="button" >save</button>
                    <button type="button" class="button delete" data-bs-dismiss="modal">close</button>
                </div>

            </div>
        </div>
    </div>

</main>


<script>
    window.onload = function() {
        var loadingAnimation = document.getElementById('loading');
        loadingAnimation.style.display = 'none';
        var pageContent = document.getElementById('page-content');
        pageContent.style.display = 'block';
    };
</script>

<script src="${pageContext.request.contextPath}/statics/js/group.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
