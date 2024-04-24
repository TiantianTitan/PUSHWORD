<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Site de Mémorisation de Mots</title>
    <link rel="stylesheet" href="statics/css/index.css">
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
    </style>
</head>
<body>
<div class="icons-container">
    <a href="user/profile.jsp"><ion-icon size="large" name="person-circle-outline"></ion-icon></a>
    <a href="user?actionName=logout"><ion-icon size="large" name="exit-outline"></ion-icon></a>
</div>

        <div class="sidebar">
            <ul>
                <li><a href="index.jsp">Accueil</a></li>
                <li><a href="publish.jsp">Publier</a></li>
                <li><a href="group?actionName=list">Gestion des Catégories</a></li>
                <li class="current"><a href="reports.jsp">Rapports de Données</a></li>
            </ul>
        </div>

    <main class="main-content">
        <h1>Statics Page</h1>

        <!-- La zone de contenu principal -->
    </main>

</body>
</html>
