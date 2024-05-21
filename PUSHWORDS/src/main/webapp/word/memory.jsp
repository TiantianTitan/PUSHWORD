<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des mots</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/index.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

        .pagination a:hover, .pagination a.active {
            background-color: #4CAF50;
            color: white;
        }

        .pagination .disabled {
            color: #ccc;
            pointer-events: none;
        }

        .modal-header .btn-close {
            background-color: #f44336;
            border: none;
            color: white;
            cursor: pointer;
        }

        .modal-header .btn-close:hover {
            background-color: #c33c24;
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
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.dataList}" var="word">
                <tr>
                    <td>${word.title}</td>
                    <td>${word.content}</td>
                    <td><fmt:formatDate value="${word.pubTime}" pattern="yyyy-MM-dd" /></td>
                    <td>
                        <button class="button" onclick="editWord(${word.wordId}, '${word.title}', '${word.content}')">Edit</button>
                        <button class="button delete" onclick="deleteWord(${word.wordId}, ${param.groupId})">Delete</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <nav>
            <ul class="pagination">
                <c:if test="${page.pageNum > 1}">
                    <li class="page-item">
                        <a class="page-link" href="?actionName=showWords&pageNum=${page.prePage}&pageSize=${page.pageSize}&groupId=${param.groupId}">Prev</a>
                    </li>
                </c:if>
                <c:forEach begin="${page.startNavPage}" end="${page.endNavPage}" var="p">
                    <li class="page-item <c:if test='${page.pageNum == p}'>active</c:if>'">
                        <a class="page-link" href="?actionName=showWords&pageNum=${p}&pageSize=${page.pageSize}&groupId=${param.groupId}">${p}</a>
                    </li>
                </c:forEach>
                <c:if test="${page.pageNum < page.totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="?actionName=showWords&pageNum=${page.nextPage}&pageSize=${page.pageSize}&groupId=${param.groupId}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>
</main>

<!-- Edit Word Modal -->
<div id="editWordModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="editWordModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="editWordForm" method="post" action="${pageContext.request.contextPath}/word?actionName=updateWord">
                <div class="modal-header">
                    <h5 class="modal-title" id="editWordModalLabel">Edit Word</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editWordId" name="wordId">
                    <input type="hidden" name="groupId" value="${param.groupId}">
                    <div class="mb-3">
                        <label for="editWordTitle" class="form-label">Title:</label>
                        <input type="text" id="editWordTitle" name="title" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="editWordContent" class="form-label">Content:</label>
                        <textarea id="editWordContent" name="content" class="form-control"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function editWord(wordId, title, content) {
        document.getElementById('editWordId').value = wordId;
        document.getElementById('editWordTitle').value = title;
        document.getElementById('editWordContent').value = content;
        var editWordModal = new bootstrap.Modal(document.getElementById('editWordModal'));
        editWordModal.show();
    }

    function deleteWord(wordId, groupId) {
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = '${pageContext.request.contextPath}/word?actionName=deleteWord&wordId=' + wordId + '&groupId=' + groupId;
            }
        });
    }
</script>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
