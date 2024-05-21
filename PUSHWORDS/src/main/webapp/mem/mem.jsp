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
            background: #f4f4f4;
            display: flex;
            flex-direction: column;
        }

        .icons-container {
            display: flex;
            justify-content: space-around; /* Center icons horizontally */
            align-items: center; /* Center icons vertically */
            background-color: #333;
            color: #fff;
            padding: 10px;
            width: 100%; /* Full width */
            position: fixed;
            top: 0;
            z-index: 1000;
        }

        .custom-icon {
            font-size: 60px; /* Increase icon size */
            color: white; /* Icon color */
        }

        .sidebar {
            background-color: #333;
            color: #fff;
            padding: 60px 20px; /* Add padding around sidebar links */
            width: 200px; /* Adjust sidebar width */
            height: calc(100vh - 60px); /* Adjust height excluding icon container */
            position: fixed;
            top: 60px; /* Match the height of icons container */
            left: 0;
            box-sizing: border-box;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
            font-size: 18px; /* Increase font size for better visibility */
        }

        .sidebar li {
            margin-bottom: 15px; /* Add margin between each link */
        }

        .sidebar li a {
            color: white;
            text-decoration: none;
        }

        .sidebar li a:hover {
            background-color: #555;
        }

        .main-content {
            margin-left: 210px; /* Leave space for sidebar */
            width: calc(100% - 220px); /* Adjusted for new sidebar width */
            margin-top: 80px;

            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #e8e8e8;
            box-sizing: border-box;
            min-height: 100vh;
            overflow-y: auto;
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

        .cards-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            width: 300px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            cursor: pointer; /* Add pointer cursor to indicate clickability */
            transition: box-shadow 0.3s;
        }

        .card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .card h3 {
            margin-top: 0;
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
    <div class="icon-wrapper">
        <a href="${pageContext.request.contextPath}/user?actionName=logout"><ion-icon class="custom-icon" name="exit-outline"></ion-icon></a>
    </div>
</div>

<div class="sidebar">
    <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
        <li><a href="${pageContext.request.contextPath}/word?actionName=view">Publier</a></li>
        <li><a href="${pageContext.request.contextPath}/group?actionName=list">Gestion des Catégories</a></li>
        <li class="current"><a href="${pageContext.request.contextPath}/mem?actionName=list">Memoriser</a></li>
        <li><a href="${pageContext.request.contextPath}/reports.jsp">Rapports de Données</a></li>
    </ul>
</div>

<main class="main-content" id="page-content">

    <div id="myDiv">
        <c:if test="${empty groupList}">
            <h2> No data Found! </h2>
        </c:if>
        <c:if test="${!empty groupList}">
            <div class="cards-container">
                <c:forEach items="${groupList}" var="item">
                    <div class="card" onclick="handleCardClick(${item.groupId})">
                        <h3>${item.groupName}</h3>
                        <p>${item.groupDescription}</p>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>

</main>

<script>
    $(window).on('load', function() {
        $("#loading").fadeOut("slow");
    });

    function handleCardClick(groupId) {
        // Your custom JS code for handling the card click event
        alert(1);
        console.log("Card clicked, groupId:", groupId);
    }
</script>

</body>
</html>
