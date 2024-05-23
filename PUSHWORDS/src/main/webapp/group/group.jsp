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

        .table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
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
            background-color: #f2f2f2;
        }
        .table tr:hover {
            background-color: #ddd;
        }
        .table-hover tr:hover {
            background-color: #f5f5f5;
        }
        .table-striped tr:nth-child(odd) {
            background-color: #f9f9f9;
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
                <li class="current"><a href="${pageContext.request.contextPath}/group?actionName=list">Gestion des Catégories</a></li>
                <li><a href="${pageContext.request.contextPath}/mem?actionName=list">Memoriser</a></li>
                <li><a href="${pageContext.request.contextPath}/report?actionName=showReports">Rapports de Données</a></li>
            </ul>
        </div>

    <main class="main-content" id="page-content">

        <div id="myDiv">
            <c:if test="${empty groupList}">
                <h2> No data Found! </h2>

            </c:if>
            <c:if test="${!empty groupList}">
            <table id="myTable" class="table table-hover table-striped">
                <tbody>
                    <tr>
                        <th>Group Name</th>
                        <th>Group Description</th>
                        <th>Options</th>

                    </tr>
                        <c:forEach items="${groupList}" var="item">
                            <tr id="tr_${item.groupId}">
                                <td>${item.groupName}</td>
                                <td>${item.groupDescription}</td>
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

        <button type="button" class="button" data-bs-toggle="modal" data-bs-target="#myModal" data-modal-title="Add Group">Add a group</button>


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

     <!-- La zone de contenu principal -->
    </main>


<script>
    window.onload = function() {
        var loadingAnimation = document.getElementById('loading');
        loadingAnimation.style.display = 'none';
        var pageContent = document.getElementById('page-content');
        pageContent.style.display = 'block';
    };
</script>

</body>
<script src="${pageContext.request.contextPath}/statics/js/group.js"></script>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Bundle JS (Popper) -->
<!-- Bootstrap JS（ Popper.js） -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>


</html>
