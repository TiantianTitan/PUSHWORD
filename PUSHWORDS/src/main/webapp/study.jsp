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
            background: radial-gradient(ellipse at bottom, #1b2735 0%, #090a0f 100%);
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

        .question-container {
            width: 100%;
            max-width: 600px;
            background-color: rgba(0,0,0,0);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .question-title {
            font-size: 20px;
            margin-bottom: 10px;
            color: rgb(248,246,231);
            text-align: center;
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

    <!-- Hidden form to submit results -->
    <form id="resultForm" method="post" action="${pageContext.request.contextPath}/study?actionName=saveResult" style="display:none;">
        <input type="hidden" name="userId" id="userId" value="${sessionScope.user.userId}">
        <input type="hidden" name="groupId" id="groupId" value="${param.groupId}">
        <input type="hidden" name="totalWords" id="totalWordsField">
        <input type="hidden" name="correctAnswers" id="correctAnswersField">
        <input type="hidden" name="accuracy" id="accuracyField">
        <input type="hidden" name="timeTaken" id="timeTakenField">
    </form>
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

            document.getElementById('totalWordsField').value = words.length;
            document.getElementById('correctAnswersField').value = correctCount;
            document.getElementById('accuracyField').value = ((correctCount / words.length) * 100).toFixed(2);
            document.getElementById('timeTakenField').value = timeTaken;

            // 确保userId正确设置
            const userIdElement = document.getElementById('userId');
            if (!userIdElement.value) {
                alert("User ID is missing. Please log in.");
                return;
            }

            document.getElementById('studyContainer').style.display = 'none';
            document.getElementById('resultsContainer').style.display = 'flex';

            // 提交表单以保存结果
            document.getElementById('resultForm').submit();
            return;
        }

        // 题目加载逻辑
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
