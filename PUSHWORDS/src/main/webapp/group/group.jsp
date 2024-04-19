<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Site de Mémorisation de Mots</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/index.css">
    <style>
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
    <header>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
                <li><a href="${pageContext.request.contextPath}/publish.jsp">Publier</a></li>
                <li class="current"><a href="group?actionName=list">Gestion des Catégories</a></li>
                <li><a href="${pageContext.request.contextPath}/user/profile.jsp">Profil Personnel</a></li>
                <li><a href="${pageContext.request.contextPath}/reports.jsp">Rapports de Données</a></li>
                <li><a href="${pageContext.request.contextPath}/user?actionName=logout">Exit</a> </li>
            </ul>
        </nav>
    </header>
    <main>
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
    <footer>
        <p>&copy; 2024 Site de Mémorisation de Mots. Tous droits réservés.</p>
    </footer>

</body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="${pageContext.request.contextPath}/statics/js/group.js"></script>

</html>
