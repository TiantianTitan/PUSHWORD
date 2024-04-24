<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Site de Mémorisation de Mots</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/index.css">
    <script nomodule src="https://cdn.jsdelivr.net/npm/@ionic/core/dist/ionic/ionic.js"></script>
    <script type="module" src="https://cdn.jsdelivr.net/npm/@ionic/core/dist/ionic/ionic.esm.js"></script>
    <style>
        /* 添加新的图标容器样式 */
        .icons-container {
            display: flex;
            justify-content: space-between;
            background-color: #333;
            color: #fff;
            padding: 10px;
            width: 200px; /* 与sidebar宽度一致 */
            position: fixed;
            top: 0;
            z-index: 5;
        }
        .icons-container ion-icon {
            color: #FFFFFF; /* 这里可以设置您喜欢的颜色 */
        }


        /* 更新sidebar的样式 */
        .sidebar {
            background-color: #333;
            color: #fff;
            padding: 10px;
            height: calc(100% - 50px); /* 减去图标容器的高度 */
            width: 200px;
            position: fixed;
            top: 50px; /* 从图标容器下方开始 */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .sidebar ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .sidebar li {
            margin-bottom: 10px;
        }

        .sidebar li a {
            color: white;
            text-decoration: none;
        }

        .sidebar li a:hover {
            background-color: #555;
        }

        .main-content {
            display: flex;
            margin-left: 220px; /* 考虑到sidebar宽度和一些间隙 */
            padding: 20px;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: gray;
            width: 1447px;
            overflow: hidden;
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

    </style>
</head>
<body>
<div class="icons-container">
    <a href="user/profile.jsp"><ion-icon size="large" name="person-circle-outline"></ion-icon></a>
    <a href="user?actionName=logout"><ion-icon size="large" name="exit-outline"></ion-icon></a>
</div>

        <div class="sidebar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
                <li><a href="${pageContext.request.contextPath}/publish.jsp">Publier</a></li>
                <li class="current"><a href="group?actionName=list">Gestion des Catégories</a></li>
                <li><a href="${pageContext.request.contextPath}/reports.jsp">Rapports de Données</a></li>
            </ul>
        </div>

    <main class="main-content">
        <div id="myDiv">
            <c:if test="${empty groupList}">
                <h2> data not found </h2>
            </c:if>
            <c:if test="${!empty groupList}">
            <table class="table table-hover table-striped">
                <tbody>
                    <tr>
                        <th>Group ID</th>
                        <th>Group Name</th>
                        <th>Group Description</th>
                        <th>Options</th>

                    </tr>
                        <c:forEach items="${groupList}" var="item">
                            <tr id="tr_${item.groupId}">
                                <td>${item.groupId}</td>
                                <td>${item.groupName}</td>
                                <td>${item.groupDescription}</td>
                                <td>
                                    <button class="button">modify</button>
                                    <button class="button delete" onclick="deleteGroup(${item.groupId})">delete</button>
                                </td>

                            </tr>
                        </c:forEach>
                </tbody>
            </table>
        </c:if>
        </div>

     <!-- La zone de contenu principal -->
    </main>

</body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="${pageContext.request.contextPath}/statics/js/group.js"></script>

</html>
