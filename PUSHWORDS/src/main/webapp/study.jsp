<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Study Page</title>
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

        .question-container {
            width: 100%;
            max-width: 600px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .question-title {
            font-size: 20px;
            margin-bottom: 10px;
        }

        .options {
            display: flex;
            flex-direction: column;
        }

        .options button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px;
            margin: 5px 0;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .options button:hover {
            background-color: #45a049;
        }

        .results-container {
            display: none;
            flex-direction: column;
            align-items: center;
        }
    </style>
</head>
<body>

<main class="main-content">
    <div id="studyContainer" class="question-container">
        <div id="questionTitle" class="question-title">Loading...</div>
        <div id="options" class="options"></div>
    </div>
    <div id="resultsContainer" class="results-container">
        <h2>Results</h2>
        <p>Total Words: <span id="totalWords"></span></p>
        <p>Correct Answers: <span id="correctAnswers"></span></p>
        <p>Accuracy: <span id="accuracy"></span>%</p>
        <p>Time Taken: <span id="timeTaken"></span> seconds</p>
        <button class="button" onclick="window.location.href='${pageContext.request.contextPath}/word?actionName=showWords&groupId=${param.groupId}'">Return to Words</button>
    </div>
</main>

<script>
    const words = <%= (new com.alibaba.fastjson.JSON()).toJSONString(request.getAttribute("words")) %>;

    let currentIndex = 0;
    let correctCount = 0;
    const startTime = new Date();

    function shuffle(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
    }

    function loadNextQuestion() {
        if (currentIndex >= words.length) {
            const endTime = new Date();
            const timeTaken = Math.floor((endTime - startTime) / 1000);
            document.getElementById('totalWords').innerText = words.length;
            document.getElementById('correctAnswers').innerText = correctCount;
            document.getElementById('accuracy').innerText = ((correctCount / words.length) * 100).toFixed(2);
            document.getElementById('timeTaken').innerText = timeTaken;

            document.getElementById('studyContainer').style.display = 'none';
            document.getElementById('resultsContainer').style.display = 'flex';
            return;
        }

        const currentWord = words[currentIndex];
        document.getElementById('questionTitle').innerText = currentWord.title;
        const optionsContainer = document.getElementById('options');
        optionsContainer.innerHTML = '';

        let options = words.slice();
        shuffle(options);
        options = options.slice(0, Math.min(4, words.length));

        if (!options.some(option => option.content === currentWord.content)) {
            options[Math.floor(Math.random() * options.length)] = currentWord;
        }

        options.forEach(option => {
            const button = document.createElement('button');
            button.innerText = option.content;
            button.onclick = () => {
                if (option.content === currentWord.content) {
                    Swal.fire('Correct!', '', 'success').then(() => {
                        correctCount++;
                        currentIndex++;
                        loadNextQuestion();
                    });
                } else {
                    Swal.fire('Incorrect!', '', 'error').then(() => {
                        currentIndex++;
                        loadNextQuestion();
                    });
                }
            };
            optionsContainer.appendChild(button);
        });
    }

    shuffle(words);
    loadNextQuestion();
</script>

</body>
</html>
