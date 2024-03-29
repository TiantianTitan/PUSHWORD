<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Site de Mémorisation de Mots</title>
    <link rel="stylesheet" href="statics/css/index.css"">

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

</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="index.jsp">Accueil</a></li>
                <li><a href="publish.jsp">Publier</a></li>
                <li><a href="category-management.jsp">Gestion des Catégories</a></li>
                <li class="current"><a href="profile.jsp">Profil Personnel</a></li>
                <li><a href="reports.jsp">Rapports de Données</a></li>
                <li><a href="user?actionName=logout">Exit</a> </li>
            </ul>
        </nav>
    </header>
    <main>
        <div class="container">
                <h2>Profil</h2>
                <form action="your_processing_script.jsp" method="post">
                     <div class="form-group">
                     <img style="width:260px;height:180px" src="user?actionName=userHead&imageName=${user.head}">
                     </div>
                    <div class="form-group">
                        <label for="userNick">NickName:</label>
                        <input type="text" id="userNick" name="userNick" value="${user.nick}">
                    </div>
                    <div class="form-group">
                        <label for="mood">Mood:</label>
                        <textarea id="mood" name="mood"> ${user.mood}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="img">Head:</label>
                        <input type="file" id="img" name="img"></textarea>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Modify">
                    </div>
                </form>
            </div>
    </main>
    <footer>
        <p>&copy; 2024 Site de Mémorisation de Mots. Tous droits réservés.</p>
    </footer>
</body>
</html>
