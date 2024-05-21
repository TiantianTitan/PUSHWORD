<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des mots</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/index.css">
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

        .main-content {
            width: 100%;
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

        nav {
            margin: 20px 0;
            display: flex;
            justify-content: center;
        }

        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .pagination li {
            margin: 0 5px;
        }

        .pagination a {
            display: block;
            padding: 10px 15px;
            text-decoration: none;
            color: #333;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }

        .pagination a:hover, .pagination li.active a {
            background-color: #4CAF50;
            color: white;
        }

        .pagination .disabled a {
            color: #ccc;
            pointer-events: none;
            border-color: #ccc;
        }
    </style>
</head>
<body>

<main class="main-content">
    <h1>Liste des mots pour le groupe</h1>
    <c:if test="${empty page.dataList}">
        <h2>No data found for groupId ${param.groupId}</h2>
    </c:if>
    <c:if test="${!empty page.dataList}">
        <table class="table">
            <thead>
            <tr>
                <th>Title</th>
                <th>Content</th>
                <th>Publication Time</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.dataList}" var="word">
                <tr>
                    <td>${word.title}</td>
                    <td>${word.content}</td>
                    <td><fmt:formatDate value="${word.pubTime}" pattern="yyyy-MM-dd" /></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <nav>
            <ul class="pagination">
                <li class="page-item ${page.pageNum == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?actionName=showWords&pageNum=${page.pageNum - 1}&pageSize=${page.pageSize}&groupId=${param.groupId}">Prev</a>
                </li>
                <c:forEach begin="${page.startNavPage}" end="${page.endNavPage}" var="p">
                    <li class="page-item ${page.pageNum == p ? 'active' : ''}">
                        <a class="page-link" href="?actionName=showWords&pageNum=${p}&pageSize=${page.pageSize}&groupId=${param.groupId}">${p}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${page.pageNum == page.totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?actionName=showWords&pageNum=${page.pageNum + 1}&pageSize=${page.pageSize}&groupId=${param.groupId}">Next</a>
                </li>
            </ul>
        </nav>
    </c:if>
</main>

</body>
</html>
