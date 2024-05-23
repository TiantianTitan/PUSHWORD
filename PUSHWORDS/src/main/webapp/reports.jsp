<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
    </style>
</head>
<body>

<main class="main-content">
    <h1>Test Reports</h1>
    <c:out value="${testResults}"></c:out>
    <button class="button" onclick="window.location.href='${pageContext.request.contextPath}/mem?actionName=list'">Retour à Memoriser</button>


    <c:choose>
        <c:when test="${empty testResults}">
            <h2>No test records found.</h2>
        </c:when>
        <c:otherwise>
            <table class="table">
                <thead>
                <tr>
                    <th>Date</th>
                    <th>Group</th>
                    <th>Total Words</th>
                    <th>Correct Answers</th>
                    <th>Accuracy</th>
                    <th>Time Taken (seconds)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${testResults}" var="result">
                    <tr>
                        <td><fmt:formatDate value="${result.testDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>${result.groupName}</td>
                        <td>${result.totalWords}</td>
                        <td>${result.correctAnswers}</td>
                        <td>${result.accuracy}%</td>
                        <td>${result.timeTaken}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
