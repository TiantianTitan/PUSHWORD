<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Site de Mémorisation de Mots</title>
    <link rel="stylesheet" href="./statics/css/index.css">
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
            min-height: calc(100vh - 60px);
            overflow-y: auto;
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

        .word-container {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .keyboard {
            display: flex;
            flex-wrap: wrap;
            max-width: 600px;
        }
        .keyboard button {
            margin: 5px;
            padding: 10px;
            font-size: 18px;
            cursor: pointer;
        }

    </style>

</head>
<body>

<div class="icons-container">
    <div class="icon-wrapper">
        <a href="user/profile.jsp"><ion-icon class="custom-icon" name="person-circle-outline"></ion-icon></a>
    </div>
    <div class="nav-links">
        <a class="current" href="index.jsp">Accueil</a>
        <a href="word?actionName=view">Publier</a>
        <a href="group?actionName=list">Gestion des Catégories</a>
        <a href="mem?actionName=list">Memoriser</a>
        <a href="report?actionName=showReports">Rapports de Données</a>
    </div>
    <div class="icon-wrapper">
        <a href="user?actionName=logout"><ion-icon class="custom-icon" name="exit-outline"></ion-icon></a>
    </div>
</div>

<main class="main-content">
    <h1>Testez vos compétences en français</h1>
    <div class="word-container" id="word-container"></div>
    <div class="keyboard" id="keyboard"></div>
    <div id="message"></div>
</main>

<script>
    const words = ["bonjour", "ordinateur", "voiture", "maison", "éducation", "Sorbonne"];
    const maxMistakes = 3;
    let selectedWord, hiddenWord, mistakes;

    function startGame() {
        selectedWord = words[Math.floor(Math.random() * words.length)];
        hiddenWord = selectedWord.split('').map(letter => Math.random() < 0.5 ? '_' : letter).join('');
        mistakes = 0;
        document.getElementById('word-container').innerText = hiddenWord;
        document.getElementById('message').innerText = '';
        document.getElementById('keyboard').innerHTML = '';
        'abcdefghijklmnopqrstuvwxyzéèêëàâäôöûüîïç'.split('').forEach(letter => {
            const button = document.createElement('button');
            button.innerText = letter;
            button.onclick = () => guessLetter(letter);
            document.getElementById('keyboard').appendChild(button);
        });
    }

    function guessLetter(letter) {
        if (selectedWord.includes(letter)) {
            hiddenWord = selectedWord.split('').map((l, i) => hiddenWord[i] === '_' && l === letter ? l : hiddenWord[i]).join('');
            document.getElementById('word-container').innerText = hiddenWord;
            if (hiddenWord === selectedWord) {
                document.getElementById('message').innerText = 'Félicitations ! Vous avez gagné !';
                setTimeout(startGame, 2000);
            }
        } else {
            mistakes++;
            if (mistakes >= maxMistakes) {
                document.getElementById('message').innerText = 'Désolé, vous avez perdu. Le mot était : ' + selectedWord;
                setTimeout(startGame, 2000);
            }
        }
    }

    startGame();
</script>

</body>
</html>
