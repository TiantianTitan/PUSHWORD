<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="statics/js/config.js?version=1.0" type="text/javascript"></script>

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
        .content-container {
            flex-grow: 1;
            margin-right: 200px;
            z-index: 10;
        }
        .login-container {
            margin-top: 100px;
            margin-right: 50px;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
            position: absolute;
            right: 20px;
            z-index: 100;
        }
        input[type="text"], input[type="password"], input[type="button"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="button"] {
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        input[type="button"]:hover {
            background-color: #0056b3;
        }
        .sidebar {
            height: 100%;
            width: 150px;
            position: fixed;
            z-index: 100;
            top: 0;
            left: 0;
            background-color: rgba(0,0,0,0);
            overflow-x: hidden;
            padding-top: 60px;
        }
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 25px;
            color: #818181;
            display: block;
        }
        .sidebar a:hover {
            color: #f1f1f1;
        }
        .password-container {
            position: relative;
            display: flex;
            align-items: center;
        }
        input[type="password"] {
            flex-grow: 1;
            border-radius: 5px 0 0 5px;
            margin-bottom: 10px;
        }
        #togglePasswordBtn {
            position: absolute;
            right: 10px;
            color: #007bff;
            cursor: pointer;
        }
        .slider-container {
            overflow: hidden;
            max-width: 800px;
            max-height: 800px;
            margin: 20px auto;
            position: relative;
            width: 100%;
        }
        .slider {
            display: flex;
            transition: transform 0.5s ease;
        }
        .slider img {
            width: 100%;
            flex-shrink: 0;
            display: inline-block;
            height: auto;
            object-fit: contain;
        }
        .btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 100;
            background-color: rgba(255, 255, 255, 0.5);
            border: none;
            cursor: pointer;
        }
        .prev {
            left: 0;
        }
        .next {
            right: 0;
        }

        .button-style {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }

        .button-style:hover {
            background-color: #0056b3;
        }

        .content-box {
            background-color: rgba(0,0,0,0);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: absolute;
            top: 50%;
            transform: translate(-20%,-50%);
            width: 800px;
            height: 800px;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .fade {
            animation: fadeIn 1s ease-in-out;
        }

        .night {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            -webkit-transform: rotateZ(45deg);
            transform: rotateZ(45deg);
            -webkit-animation: sky 200000ms linear infinite;
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
            -webkit-filter: drop-shadow(0 0 6px #699bff);
            filter: drop-shadow(0 0 6px #699bff);
            -webkit-animation: tail 3000ms ease-in-out infinite, shooting 3000ms ease-in-out infinite;
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
            -webkit-transform: translateX(50%) rotateZ(45deg);
            transform: translateX(50%) rotateZ(45deg);
            border-radius: 100%;
            -webkit-animation: shining 3000ms ease-in-out infinite;
            animation: shining 3000ms ease-in-out infinite;
        }

        .shooting_star::after {
            -webkit-transform: translateX(50%) rotateZ(-45deg);
            transform: translateX(50%) rotateZ(-45deg);
        }

        .shooting_star:nth-child(1) {
            top: calc(50% - 185px);
            left: calc(50% - 150px);
            -webkit-animation-delay: 8971ms;
            animation-delay: 8971ms;
        }

        .shooting_star:nth-child(1)::before,
        .shooting_star:nth-child(1)::after,
        .shooting_star:nth-child(1)::after {
            -webkit-animation-delay: 8971ms;
            animation-delay: 8971ms;
        }

        .shooting_star:nth-child(2) {
            top: calc(50% - 50px);
            left: calc(50% - 179px);
            -webkit-animation-delay: 9256ms;
            animation-delay: 9256ms;
        }

        .shooting_star:nth-child(2)::before,
        .shooting_star:nth-child(2)::after,
        .shooting_star:nth-child(2)::after {
            -webkit-animation-delay: 9256ms;
            animation-delay: 9256ms;
        }

        .shooting_star:nth-child(3) {
            top: calc(50% - -146px);
            left: calc(50% - 135px);
            -webkit-animation-delay: 8700ms;
            animation-delay: 8700ms;
        }

        .shooting_star:nth-child(3)::before,
        .shooting_star:nth-child(3)::after,
        .shooting_star:nth-child(3)::after {
            -webkit-animation-delay: 8700ms;
            animation-delay: 8700ms;
        }

        .shooting_star:nth-child(4) {
            top: calc(50% - -77px);
            left: calc(50% - 157px);
            -webkit-animation-delay: 3147ms;
            animation-delay: 3147ms;
        }

        .shooting_star:nth-child(4)::before,
        .shooting_star:nth-child(4)::after,
        .shooting_star:nth-child(4)::after {
            -webkit-animation-delay: 3147ms;
            animation-delay: 3147ms;
        }

        .shooting_star:nth-child(5) {
            top: calc(50% - -183px);
            left: calc(50% - 8px);
            -webkit-animation-delay: 6588ms;
            animation-delay: 6588ms;
        }

        .shooting_star:nth-child(5)::before,
        .shooting_star:nth-child(5)::after,
        .shooting_star:nth-child(5)::after {
            -webkit-animation-delay: 6588ms;
            animation-delay: 6588ms;
        }

        .shooting_star:nth-child(6) {
            top: calc(50% - -29px);
            left: calc(50% - 195px);
            -webkit-animation-delay: 8009ms;
            animation-delay: 8009ms;
        }

        .shooting_star:nth-child(6)::before,
        .shooting_star:nth-child(6)::after,
        .shooting_star:nth-child(6)::after {
            -webkit-animation-delay: 8009ms;
            animation-delay: 8009ms;
        }

        .shooting_star:nth-child(7) {
            top: calc(50% - 95px);
            left: calc(50% - 69px);
            -webkit-animation-delay: 5420ms;
            animation-delay: 5420ms;
        }

        .shooting_star:nth-child(7)::before,
        .shooting_star:nth-child(7)::after,
        .shooting_star:nth-child(7)::after {
            -webkit-animation-delay: 5420ms;
            animation-delay: 5420ms;
        }

        .shooting_star:nth-child(8) {
            top: calc(50% - -59px);
            left: calc(50% - 70px);
            -webkit-animation-delay: 9378ms;
            animation-delay: 9378ms;
        }

        .shooting_star:nth-child(8)::before,
        .shooting_star:nth-child(8)::after,
        .shooting_star:nth-child(8)::after {
            -webkit-animation-delay: 9378ms;
            animation-delay: 9378ms;
        }

        .shooting_star:nth-child(9) {
            top: calc(50% - 76px);
            left: calc(50% - 238px);
            -webkit-animation-delay: 2845ms;
            animation-delay: 2845ms;
        }

        .shooting_star:nth-child(9)::before,
        .shooting_star:nth-child(9)::after,
        .shooting_star:nth-child(9)::after {
            -webkit-animation-delay: 2845ms;
            animation-delay: 2845ms;
        }

        .shooting_star:nth-child(10) {
            top: calc(50% - 83px);
            left: calc(50% - 6px);
            -webkit-animation-delay: 5205ms;
            animation-delay: 5205ms;
        }

        .shooting_star:nth-child(10)::before,
        .shooting_star:nth-child(10)::after,
        .shooting_star:nth-child(10)::after {
            -webkit-animation-delay: 5205ms;
            animation-delay: 5205ms;
        }

        .shooting_star:nth-child(11) {
            top: calc(50% - -137px);
            left: calc(50% - 267px);
            -webkit-animation-delay: 808ms;
            animation-delay: 808ms;
        }

        .shooting_star:nth-child(11)::before,
        .shooting_star:nth-child(11)::after,
        .shooting_star:nth-child(11)::after {
            -webkit-animation-delay: 808ms;
            animation-delay: 808ms;
        }

        .shooting_star:nth-child(12) {
            top: calc(50% - 12px);
            left: calc(50% - 8px);
            -webkit-animation-delay: 2406ms;
            animation-delay: 2406ms;
        }

        .shooting_star:nth-child(12)::before,
        .shooting_star:nth-child(12)::after,
        .shooting_star:nth-child(12)::after {
            -webkit-animation-delay: 2406ms;
            animation-delay: 2406ms;
        }

        .shooting_star:nth-child(13) {
            top: calc(50% - 148px);
            left: calc(50% - 47px);
            -webkit-animation-delay: 7566ms;
            animation-delay: 7566ms;
        }

        .shooting_star:nth-child(13)::before,
        .shooting_star:nth-child(13)::after,
        .shooting_star:nth-child(13)::after {
            -webkit-animation-delay: 7566ms;
            animation-delay: 7566ms;
        }

        .shooting_star:nth-child(14) {
            top: calc(50% - -28px);
            left: calc(50% - 75px);
            -webkit-animation-delay: 7634ms;
            animation-delay: 7634ms;
        }

        .shooting_star:nth-child(14)::before,
        .shooting_star:nth-child(14)::after,
        .shooting_star:nth-child(14)::after {
            -webkit-animation-delay: 7634ms;
            animation-delay: 7634ms;
        }

        .shooting_star:nth-child(15) {
            top: calc(50% - -37px);
            left: calc(50% - 203px);
            -webkit-animation-delay: 7743ms;
            animation-delay: 7743ms;
        }

        .shooting_star:nth-child(15)::before,
        .shooting_star:nth-child(15)::after,
        .shooting_star:nth-child(15)::after {
            -webkit-animation-delay: 7743ms;
            animation-delay: 7743ms;
        }

        .shooting_star:nth-child(16) {
            top: calc(50% - 41px);
            left: calc(50% - 256px);
            -webkit-animation-delay: 2888ms;
            animation-delay: 2888ms;
        }

        .shooting_star:nth-child(16)::before,
        .shooting_star:nth-child(16)::after,
        .shooting_star:nth-child(16)::after {
            -webkit-animation-delay: 2888ms;
            animation-delay: 2888ms;
        }

        .shooting_star:nth-child(17) {
            top: calc(50% - -35px);
            left: calc(50% - 121px);
            -webkit-animation-delay: 5864ms;
            animation-delay: 5864ms;
        }

        .shooting_star:nth-child(17)::before,
        .shooting_star:nth-child(17)::after,
        .shooting_star:nth-child(17)::after {
            -webkit-animation-delay: 5864ms;
            animation-delay: 5864ms;
        }

        .shooting_star:nth-child(18) {
            top: calc(50% - 73px);
            left: calc(50% - 225px);
            -webkit-animation-delay: 7883ms;
            animation-delay: 7883ms;
        }

        .shooting_star:nth-child(18)::before,
        .shooting_star:nth-child(18)::after,
        .shooting_star:nth-child(18)::after {
            -webkit-animation-delay: 7883ms;
            animation-delay: 7883ms;
        }

        .shooting_star:nth-child(19) {
            top: calc(50% - -69px);
            left: calc(50% - 47px);
            -webkit-animation-delay: 3339ms;
            animation-delay: 3339ms;
        }

        .shooting_star:nth-child(19)::before,
        .shooting_star:nth-child(19)::after,
        .shooting_star:nth-child(19)::after {
            -webkit-animation-delay: 3339ms;
            animation-delay: 3339ms;
        }

        .shooting_star:nth-child(20) {
            top: calc(50% - 162px);
            left: calc(50% - 129px);
            -webkit-animation-delay: 7963ms;
            animation-delay: 7963ms;
        }

        .shooting_star:nth-child(20)::before,
        .shooting_star:nth-child(20)::after,
        .shooting_star:nth-child(20)::after {
            -webkit-animation-delay: 7963ms;
            animation-delay: 7963ms;
        }

        @-webkit-keyframes tail {
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

        @-webkit-keyframes shining {
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

        @-webkit-keyframes shooting {
            0% {
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }

            100% {
                -webkit-transform: translateX(300px);
                transform: translateX(300px);
            }
        }

        @keyframes shooting {
            0% {
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }

            100% {
                -webkit-transform: translateX(300px);
                transform: translateX(300px);
            }
        }

        @-webkit-keyframes sky {
            0% {
                -webkit-transform: rotate(45deg);
                transform: rotate(45deg);
            }

            100% {
                -webkit-transform: rotate(405deg);
                transform: rotate(405deg);
            }
        }

        @keyframes sky {
            0% {
                -webkit-transform: rotate(45deg);
                transform: rotate(45deg);
            }

            100% {
                -webkit-transform: rotate(405deg);
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

<div id="sidebar" class="sidebar">
    <a href="javascript:void(0)" onclick="showSection('home')">Home</a>
    <a href="javascript:void(0)" onclick="showSection('about')">About</a>
    <a href="javascript:void(0)" onclick="showSection('contact')">Contact</a>
</div>

<div class="content-container">
    <div id="home" class="content-section">
        <div class="slider-container">
            <div class="slider">
                <img src="./statics/images/logo.png" alt="Image 1">
                <img src="./statics/images/words.jpg" alt="Image 2">
                <img src="./statics/images/SB.png" alt="Image 3">
            </div>
            <button class="btn prev">&#10094;</button>
            <button class="btn next">&#10095;</button>
        </div>
    </div>

    <div id="about" class="content-section content-box" style="display:none; margin-left: 500px">
        <img src="./statics/images/SB.png" width="30%" alt="Sorbonne-logo"/>
        <p style="color: rgb(248,246,231)">C'est le Projet du cours PC3R de la majeure STL à Sorbonne Université en 2024.</p>
        <br>
        <p style="color: rgb(248,246,231)">Ce projet est conçu pour aider à apprendre l'anglais.</p>
        <br>
        <p style="color: rgb(248,246,231)">Les utilisateurs peuvent créer leur propre compte ou se connecter dans le module de connexion
            à droite. Les informations seront enregistrées dans la base de données.
        </p>
        <br>
        <p style="color: rgb(248,246,231)">Les utilisateurs peuvent traduire et regrouper les mots anglais inconnus qu'ils rencontrent
            et les stocker dans la base de données correspondante. Vous pouvez ensuite mémoriser des mots en regardant le contenu des
            différents groupes. Habituellement, vérifier le contenu d'un groupe signifie que cette page Web affichera aléatoirement tous
            les mots anglais du groupe et donnera 4 traductions françaises correspondantes à choisir par l'utilisateur.
            Une fois que l'utilisateur a terminé tous les tests, il verra les résultats des tests (scores).
        </p>
        <br>
        <p style="color: rgb(248,246,231)">De plus, sur la page Acceuil, nous avons mis en place un jeu simple de remplissage de mots pour
            tester le niveau de vocabulaire anglais de l'utilisateur. (Mais en fait c'est plus pour s'amuser)
        </p>
        <br>
        <p style="color: rgb(248,246,231)">Haotian XUE</p>
        <p style="color: rgb(248,246,231)">Hejun CAO</p>
        <p style="color: rgb(248,246,231)">25/05/2024</p>
    </div>

    <div id="contact" class="content-section content-box" style="display:none; margin-left: 500px">
        <img src="./statics/images/SB.png" width="30%" alt="Sorbonne-logo"/>
        <br>
        <br>
        <br>
        <img src="./statics/images/HAOTIAN.jpg" width="20%" alt="HAOTIAN"/>
        <p style="color:rgb(248,246,231);">Haotian XUE</p>
        <p style="color:rgb(248,246,231);">Haotian.XUE@etu.sorbonne-universite.fr</p>
        <br>
        <img src="./statics/images/HEJUN.jpg" width="20%" alt="HEJUN"/>
        <p style="color:rgb(248,246,231);">Hejun CAO</p>
        <p style="color:rgb(248,246,231);">Hejun.Cao@etu.sorbonne-universite.fr</p>
    </div>
</div>

<div class="login-container">
    <img style="text-align: center; width: 100%" src="./statics/images/logo.png" alt="logoPushWords">
    <form action="user" method="post" id="loginForm">
        <input type="hidden" name="actionName" value="login"/>
        <label for="userName">Username:</label>
        <input type="text" id="userName" name="userName" value="${resultInfo.result.uname}" autocomplete="current-username">
        <label for="userPwd">Password:</label>

        <div class="password-container">
            <input type="password" id="userPwd" name="userPwd" value="${resultInfo.result.upwd}" autocomplete="current-password">
            <i id="togglePasswordBtn" class="fas fa-eye" onclick="togglePassword()"></i>
        </div>

        <div>
            <label>
                <input name="rem" type="checkbox" value="1" class="input checkbox"/>
            </label>
            <label>remember me</label>
        </div>
        <div>
            <span id="msg" style="color: red;font-size: 12px">${resultInfo.msg}</span>
        </div>
        <br/>
        <br/>
        <input type="button" value="Login" onclick="checkLogin()">
    </form>

    <form action="signup.jsp" method="get">
        <input type="submit" value="Sign Up" class="button-style">
    </form>
</div>

<script>
    function toggleSidebar() {
        let sidebar = document.getElementById("sidebar");
        let btn = document.querySelector(".toggle-btn");
        if (sidebar.style.width === "250px") {
            sidebar.style.width = "0";
            btn.style.left = "0px";
        } else {
            sidebar.style.width = "250px";
            btn.style.left = "250px";
        }
    }

    function togglePassword() {
        let pwd = document.getElementById("userPwd");
        let toggleBtn = document.getElementById("togglePasswordBtn");
        if (pwd.type === "password") {
            pwd.type = "text";
            toggleBtn.classList.remove("fa-eye");
            toggleBtn.classList.add("fa-eye-slash");
        } else {
            pwd.type = "password";
            toggleBtn.classList.remove("fa-eye-slash");
            toggleBtn.classList.add("fa-eye");
        }
    }

    let sliderIndex = 0;
    let slides = document.querySelectorAll('.slider img');
    let slider = document.querySelector('.slider');
    let containerWidth = document.querySelector('.slider-container').offsetWidth;
    let timer;

    function updateSliderPosition() {
        slider.style.transform = 'translateX(' + (-sliderIndex * containerWidth) + 'px)';
    }

    function nextSlide() {
        sliderIndex = (sliderIndex + 1) % slides.length;
        updateSliderPosition();
        resetTimer(); // Reset the timer whenever manually navigate
    }

    function prevSlide() {
        sliderIndex = (sliderIndex - 1 + slides.length) % slides.length;
        updateSliderPosition();
        resetTimer(); // Reset the timer whenever manually navigate
    }

    function resetTimer() {
        clearInterval(timer);
        timer = setInterval(function() {
            sliderIndex = (sliderIndex + 1) % slides.length;
            updateSliderPosition();
        }, 5000); // Change slide every 5 seconds
    }

    document.querySelector('.next').addEventListener('click', nextSlide);
    document.querySelector('.prev').addEventListener('click', prevSlide);

    // Initialize the slider position and start the automatic slideshow
    updateSliderPosition();
    resetTimer();

    function showSection(sectionId) {
        let sections = document.querySelectorAll('.content-section');
        sections.forEach(section => {
            if (section.id === sectionId) {
                section.classList.add('fade');
                section.style.display = 'block';
            } else {
                section.style.display = 'none';
                section.classList.remove('fade');
            }
        });
        let loginContainer = document.querySelector('.login-container');
        loginContainer.classList.add('fade');

        if (sectionId === 'home') {
            resetTimer();
        } else {
            clearInterval(timer);
        }
    }

    // Show the home section by default
    showSection('home');
</script>
</body>
</html>
