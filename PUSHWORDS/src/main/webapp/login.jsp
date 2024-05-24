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
        body {
            font-family: Arial, sans-serif;
            background-color: moccasin;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }
        .content-container {
            flex-grow: 1;
            margin-right: 200px;
        }
        .login-container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
            position: absolute;
            right: 20px;
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
            z-index: 1;
            top: 0;
            left: 0;
            background-color: #111;
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
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: absolute;
            top: 50%;
            transform: translate(-20%,-50%);
            width: 800px;
            height: 800px;

        }

    </style>
</head>
<body>

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

        <img src="./statics/images/SB.png" width="30%"/>

    </div>

    <div id="contact" class="content-section content-box" style="display:none; margin-left: 500px">

        <img src="./statics/images/SB.png" width="30%"/>

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
                section.style.display = 'block';
            } else {
                section.style.display = 'none';
            }
        });
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
