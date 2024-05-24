<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Site de Mémorisation de Mots</title>
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
            justify-content: space-between; /* Center icons horizontally */
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
    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            var previousNick = '${user.nick}';

            $("#nickName").blur(function(){
                var nickName = $(this).val();
                if(nickName.trim() === ""){
                    $("#msg").html("Nickname can't be empty!");
                } else if (nickName !== previousNick) {
                    $.ajax({
                        type: "GET",
                        url: "${pageContext.request.contextPath}/user",
                        data: {
                            actionName: "checkNick",
                            nick: nickName
                        },
                        success: function (data) {
                            if(data.trim() === '1'){
                                $("#msg").html("");
                            } else {
                                $("#msg").html("This nickname exists!");
                            }
                        }
                    });
                } else {
                    $("#msg").html("");
                }
            });
        });

        function updateUser(event){
            // 防止表单默认提交
            event.preventDefault();

            var nickName = $("#nickName").val();
            if(nickName.trim() === ""){
                $("#msg").html("Nickname can't be empty!");
                return false;
            } else {
                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/user",
                    data: {
                        actionName: "checkNick",
                        nick: nickName
                    },
                    success: function (data) {
                        if(data.trim() === '1'){
                            $("#msg").html("");
                            $("#formModify").submit();
                        } else {
                            $("#msg").html("This nickname exists!");
                        }
                    }
                });
            }
        }


        $(document).ready(function() {
            $('#btn').on('click', updateUser);
        });

    </script>
</head>
<body>
    <div class="icons-container">
        <div class="icon-wrapper">
            <a href="profile.jsp"><ion-icon class="custom-icon" name="person-circle-outline"></ion-icon></a>
        </div>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index.jsp">Accueil</a>
            <a href="${pageContext.request.contextPath}/word?actionName=view">Publier</a>
            <a href="${pageContext.request.contextPath}/group?actionName=list">Gestion des Catégories</a>
            <a href="${pageContext.request.contextPath}/mem?actionName=list">Memoriser</a>
            <a href="${pageContext.request.contextPath}/report?actionName=showReports">Rapports de Données</a>
        </div>

        <div class="icon-wrapper">
            <a href="${pageContext.request.contextPath}/user?actionName=logout"><ion-icon class="custom-icon" name="exit-outline"></ion-icon></a>
        </div>
    </div>

    <main class="main-content">

            <h2>Profil</h2>
            <form id="formModify" method="post" action="${pageContext.request.contextPath}/user?actionName=updateUser" enctype="multipart/form-data">
                <input type="hidden" name="actionName" value="updateUser">

                <div class="form-group">
                    <img style="width:260px;height:180px" src="${pageContext.request.contextPath}/user?actionName=userHead&imageName=${user.head}">
                </div>

                <label for="nickName">NickName:</label>

                <div class="form-group">
                    <input type="text" id="nickName" name="nick" placeholder="nickName" value="${user.nick}">
                </div>

                <label for="mood">Mood:</label>

                <div class="form-group">
                    <textarea id="mood" name="mood"> ${user.mood}</textarea>
                </div>

                <label for="img">Head:</label>

                <div class="form-group">
                    <input type="file" id="img" name="img"></textarea>
                </div>

                <div class="form-group">
                    <button type="submit" id="btn" onclick="return updateUser();"> Modify</button>
                    <span style="color:red;font-size:12px;" id="msg"></span>
                </div>
            </form>
    </main>
</body>

</html>