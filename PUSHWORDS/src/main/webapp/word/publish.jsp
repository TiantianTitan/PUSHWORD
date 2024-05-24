<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Site de Mémorisation de Mots</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/index.css">
    <script nomodule src="https://cdn.jsdelivr.net/npm/@ionic/core/dist/ionic/ionic.js"></script>
    <script type="module" src="https://cdn.jsdelivr.net/npm/@ionic/core/dist/ionic/ionic.esm.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
            justify-content: space-between;
            align-items: center;
            background-color: rgba(0,0,0,0);
            color: #fff;
            padding: 10px;
            width: 100%;
            position: fixed;
            top: 0;
            z-index: 1000;
        }

        .custom-icon {
            font-size: 40px;
            color: white;
        }

        .icon-wrapper {
            margin: 0 150px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 18px;
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
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: rgba(0,0,0,0);
            box-sizing: border-box;
            min-height: calc(100vh - 60px);
            overflow-y: auto;
            z-index: 10;
            position: relative;
        }

        .container {
            background: rgba(255,255,255,0);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0);
            padding: 20px 40px;
            width: 100%;
            max-width: 400px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .container:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #333;
            font-size: 16px;
            font-weight: bold;
        }

        select, input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
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
            z-index: 1;
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
<div class="icons-container">
    <div class="icon-wrapper">
        <a href="${pageContext.request.contextPath}/user/profile.jsp"><ion-icon class="custom-icon" name="person-circle-outline"></ion-icon></a>
    </div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/index.jsp">Accueil</a>
        <a class="current" href="${pageContext.request.contextPath}/word?actionName=view">Publier</a>
        <a href="${pageContext.request.contextPath}/group?actionName=list">Gestion des Catégories</a>
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

<main class="main-content">
    <!-- La zone de contenu principal -->
    <div class="container">
        <c:if test="${empty groupList}">
            <h2>No Group exists!</h2>
            <h4><a href="group?actionName=list">Add Group</a></h4>
        </c:if>

        <c:if test="${not empty groupList}">
            <form class="form-group" method="post" action="${pageContext.request.contextPath}/word" accept-charset="UTF-8">
                <input type="hidden" name="actionName" value="addOrUpdate">
                <div class="form-group">
                    <h2 style="color: white">Save your word</h2>
                    <label for="category" style="color:rgb(248,246,231);">Group:</label>
                    <select id="category" name="groupId">
                        <c:forEach var="item" items="${groupList}">
                            <option value="${item.groupId}">${item.groupName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="title" style="color: rgb(248,246,231)">Title:</label>
                    <input type="text" id="title" name="title" placeholder="Enter the word" value="${resultInfo.result.title}">
                    <div style="margin-top: 20px;">
                        <button type="button" onclick="translateWord()">Translate</button>
                    </div>
                    <br>
                    <br>
                    <label for="definition" style="color: rgb(248,246,231)">Select a Definition:</label>
                    <select id="definition" name="definition" onchange="copyToDescription()">
                        <option>Select a definition</option>
                    </select>
                    <br><br>
                    <label style="color: rgb(248,246,231)">Explication:</label>
                    <input type="text" id="explication" name="content" placeholder="Enter the description" value="${resultInfo.result.content}">
                    <div style="margin-top: 20px;">
                        <button type="submit" onclick="return checkForm()">Save</button>
                        &nbsp;<span id="msg" style="font-size: 12px; color:red"></span>
                    </div>
                </div>
            </form>
        </c:if>
    </div>

    <script type="text/javascript">
        function checkForm() {
            var title = $("#title").val();
            var explication = $("#explication").val();

            if (title.trim() === "") {
                $("#msg").html("<br>Enter the word!");
                return false;
            }

            if (explication.trim() === "") {
                $("#msg").html("Give the explication!");
                return false;
            }
        }

        function translateWord() {
            var title = $("#title").val().trim();
            if (title === "") {
                $("#msg").html("<br>Enter the word to translate!");
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/word',
                type: 'GET',
                data: {
                    actionName: 'translate',
                    word: title
                },
                success: function (data) {
                    console.log("Translation result: " + data);
                    $("#definition").empty();
                    data.forEach(function (item) {
                        $("#definition").append(new Option(item.definition, item.definition));
                    });
                    $("#definition").prop("selectedIndex", 1); // Select the first definition
                    $("#msg").html("Translation successful.").css("color", "green");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error("Translation error: " + textStatus + " - " + errorThrown);
                    $("#msg").html("<br>Translation failed. Please try again.").css("color", "red");
                }
            });
        }

        function copyToDescription() {
            var selectedDefinition = $("#definition").val();
            $("#explication").val(selectedDefinition);
        }

        $("#title").on("input", function () {
            $("#msg").html("");
        });
    </script>
</main>

</body>
</html>
