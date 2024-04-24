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

        .form-group {
            margin-bottom: 10px;
        }
        label {
            display: flex;
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
    <div class="icons-container">
        <a href="user/profile.jsp"><ion-icon size="large" name="person-circle-outline" color="red"></ion-icon></a>
        <a href="user?actionName=logout"><ion-icon size="large" name="exit-outline"></ion-icon></a>
    </div>

    <div class="sidebar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
            <li><a href="${pageContext.request.contextPath}/publish.jsp">Publier</a></li>
            <li><a href="${pageContext.request.contextPath}/group?actionName=list">Gestion des Catégories</a></li>
            <li><a href="${pageContext.request.contextPath}/reports.jsp">Rapports de Données</a></li>
        </ul>
    </div>

    <main class="main-content">

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

    </main>

</body>

</html>