<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Site de Mémorisation de Mots</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/index.css">


    <style>
        main {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            margin: 0 auto;
            width: 50%;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 10px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            padding: 10px 15px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
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
<header>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
            <li><a href="${pageContext.request.contextPath}/publish.jsp">Publier</a></li>
            <li><a href="${pageContext.request.contextPath}/group?actionName=list">Gestion des Catégories</a></li>
            <li class="current"><a href="profile.jsp">Profil Personnel</a></li>
            <li><a href="${pageContext.request.contextPath}/reports.jsp">Rapports de Données</a></li>
            <li><a href="${pageContext.request.contextPath}/user?actionName=logout">Exit</a> </li>
        </ul>
    </nav>
</header>
<main>
    <div class="container">
        <h2>Profil</h2>
        <form id="formModify" method="post" action="../user?actionName=updateUser" enctype="multipart/form-data">
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
    </div>

</main>
<footer>
    <p>&copy; 2024 Site de Mémorisation de Mots. Tous droits réservés.</p>
</footer>
</body>

</html>