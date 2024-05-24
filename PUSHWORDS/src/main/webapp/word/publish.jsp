<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
            background: #f4f4f4;
            display: flex;
            flex-direction: column;
        }

        .icons-container {
            display: flex;
            justify-content: space-between; /* Adjust spacing between elements */
            align-items: center;
            background-color: #333;
            color: #fff;
            padding: 10px;
            width: 100%; /* Full width */
            position: fixed;
            top: 0;
            z-index: 1000;
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
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #e8e8e8;
            box-sizing: border-box;
            min-height: calc(100vh - 60px); /* Adjusted for new margin top */
            overflow-y: auto;
        }

        .container {
            background: #ffffff;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
                    <h2>Save your word</h2>
                    <label for="category">Group:</label>
                    <select id="category" name="groupId">
                        <c:forEach var="item" items="${groupList}">
                            <option value="${item.groupId}">${item.groupName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" id="title" name="title" placeholder="Enter the word" value="${resultInfo.result.title}">
                    <button type="button" onclick="translateWord()">Translate</button>
                    <br><br>
                    <label for="definition">Select a Definition:</label>
                    <select id="definition" name="definition" onchange="copyToDescription()">
                        <option>Select a definition</option>
                    </select>
                    <br><br>
                    <label>Explication:</label>
                    <input type="text" id="explication" name="content" placeholder="Enter the description" value="${resultInfo.result.content}">
                    <button type="submit" onclick="return checkForm()">Save</button>
                    &nbsp;<span id="msg" style="font-size: 12px; color:red"></span>
                </div>
            </form>
        </c:if>
    </div>

    <script type="text/javascript">
        function checkForm() {
            var title = $("#title").val();
            var explication = $("#explication").val();

            if (title.trim() === "") {
                $("#msg").html("Enter the word!");
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
                $("#msg").html("Enter the word to translate!");
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
                    $("#msg").html("Translation failed. Please try again.").css("color", "red");
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
