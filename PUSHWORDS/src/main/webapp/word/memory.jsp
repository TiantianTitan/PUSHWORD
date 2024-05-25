<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title style="color: rgb(248,246,231)">Liste des mots</title>
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
            background: radial-gradient(ellipse at bottom, #1b2735 0%, #090a0f 100%);
            height: 100vh;
            overflow: hidden;
            position: relative;
        }

        .main-content {
            width: 100%;
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: rgba(232, 232, 232, 0);
            box-sizing: border-box;
            min-height: 100vh;
            overflow-y: auto;
            z-index: 10;
            position: relative;
            border-radius: 10px;
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

        .night {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            transform: rotateZ(45deg);
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
            filter: drop-shadow(0 0 6px #699bff);
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
            transform: translateX(50%) rotateZ(45deg);
            border-radius: 100%;
            animation: shining 3000ms ease-in-out infinite;
        }

        .shooting_star::after {
            transform: translateX(50%) rotateZ(-45deg);
        }

        .shooting_star:nth-child(1) {
            top: calc(50% - 185px);
            left: calc(50% - 150px);
            animation-delay: 8971ms;
        }

        .shooting_star:nth-child(2) {
            top: calc(50% - 50px);
            left: calc(50% - 179px);
            animation-delay: 9256ms;
        }

        .shooting_star:nth-child(3) {
            top: calc(50% - -146px);
            left: calc(50% - 135px);
            animation-delay: 8700ms;
        }

        .shooting_star:nth-child(4) {
            top: calc(50% - -77px);
            left: calc(50% - 157px);
            animation-delay: 3147ms;
        }

        .shooting_star:nth-child(5) {
            top: calc(50% - -183px);
            left: calc(50% - 8px);
            animation-delay: 6588ms;
        }

        .shooting_star:nth-child(6) {
            top: calc(50% - -29px);
            left: calc(50% - 195px);
            animation-delay: 8009ms;
        }

        .shooting_star:nth-child(7) {
            top: calc(50% - 95px);
            left: calc(50% - 69px);
            animation-delay: 5420ms;
        }

        .shooting_star:nth-child(8) {
            top: calc(50% - -59px);
            left: calc(50% - 70px);
            animation-delay: 9378ms;
        }

        .shooting_star:nth-child(9) {
            top: calc(50% - 76px);
            left: calc(50% - 238px);
            animation-delay: 2845ms;
        }

        .shooting_star:nth-child(10) {
            top: calc(50% - 83px);
            left: calc(50% - 6px);
            animation-delay: 5205ms;
        }

        .shooting_star:nth-child(11) {
            top: calc(50% - -137px);
            left: calc(50% - 267px);
            animation-delay: 808ms;
        }

        .shooting_star:nth-child(12) {
            top: calc(50% - 12px);
            left: calc(50% - 8px);
            animation-delay: 2406ms;
        }

        .shooting_star:nth-child(13) {
            top: calc(50% - 148px);
            left: calc(50% - 47px);
            animation-delay: 7566ms;
        }

        .shooting_star:nth-child(14) {
            top: calc(50% - -28px);
            left: calc(50% - 75px);
            animation-delay: 7634ms;
        }

        .shooting_star:nth-child(15) {
            top: calc(50% - -37px);
            left: calc(50% - 203px);
            animation-delay: 7743ms;
        }

        .shooting_star:nth-child(16) {
            top: calc(50% - 41px);
            left: calc(50% - 256px);
            animation-delay: 2888ms;
        }

        .shooting_star:nth-child(17) {
            top: calc(50% - -35px);
            left: calc(50% - 121px);
            animation-delay: 5864ms;
        }

        .shooting_star:nth-child(18) {
            top: calc(50% - 73px);
            left: calc(50% - 225px);
            animation-delay: 7883ms;
        }

        .shooting_star:nth-child(19) {
            top: calc(50% - -69px);
            left: calc(50% - 47px);
            animation-delay: 3339ms;
        }

        .shooting_star:nth-child(20) {
            top: calc(50% - 162px);
            left: calc(50% - 129px);
            animation-delay: 7963ms;
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

        @keyframes shooting {
            0% {
                transform: translateX(0);
            }

            100% {
                transform: translateX(300px);
            }
        }

        @keyframes sky {
            0% {
                transform: rotate(45deg);
            }

            100% {
                transform: rotate(405deg);
            }
        }
    </style>
</head>
<body>

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
    <h1 style="color: rgb(248,246,231);">Liste des mots pour le groupe</h1>
    <div>
        <button class="button" onclick="window.location.href='${pageContext.request.contextPath}/mem?actionName=list'">Retour à Memoriser</button>
        <button class="button" onclick="window.location.href='${pageContext.request.contextPath}/study?actionName=startStudy&groupId=${param.groupId}'">Étudier</button>
        <button class="button" onclick="window.location.href='${pageContext.request.contextPath}/word?actionName=view'">Ajouter un nouveau mot</button>
    </div>

    <c:if test="${empty page.dataList}">
        <h2 style="color: rgb(248,246,231)">No data found for groupId ${param.groupId}</h2>
    </c:if>
    <c:if test="${!empty page.dataList}">
        <table class="table">
            <thead>
            <tr>
                <th style="color: rgb(248,246,231)">Title</th>
                <th style="color: rgb(248,246,231)">Content</th>
                <th style="color: rgb(248,246,231)">Publication Time</th>
                <th style="color: rgb(248,246,231)">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.dataList}" var="word">
                <tr>
                    <td style="color: rgb(248,246,231)">${word.title}</td>
                    <td style="color: rgb(248,246,231)">${word.content}</td>
                    <td style="color: rgb(248,246,231)"><fmt:formatDate value="${word.pubTime}" pattern="yyyy-MM-dd" /></td>
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
