<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <title>Login Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="statics/js/config.js?version=1.0" type="text/javascript"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: moccasin;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            height: 100vh;
            padding-right: 10%;
        }
        .login-container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
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
            width: 0; /* Sidebar initially hidden */
            position: fixed;
            z-index: 1;
            top: 0;
            left: 0;
            background-color: #111;
            overflow-x: hidden;
            transition: width 0.5s ease; /* Smooth width transition */
            padding-top: 60px; /* Space for the toggle button */
        }
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 25px;
            color: #818181;
            display: block;
            transition: color 0.3s;
        }
        .sidebar a:hover {
            color: #f1f1f1;
        }
        .toggle-btn {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 2;
            background-color: #111;
            color: white;
            border: none;
            cursor: pointer;
            padding: 10px 15px;
            font-size: 20px;
            transition: left 0.5s ease; /* Smooth left transition */
        }

        .password-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        input[type="password"] {
            flex-grow: 1;
            border-radius: 5px 0 0 5px; /* Rounded corners on the left side */
            margin-bottom: 10px;
        }

        #togglePasswordBtn {
            position: absolute;
            right: 10px;
            color: #007bff;
            cursor: pointer;
        }

        /* 你原有的CSS... */

        .slider-container {
            position: relative;
            max-width: 650px; /* 根据需要调整宽度 */
            margin: auto;
            overflow: hidden;
        }

        .slider img {
            width: 100%;
            display: none; /* 默认隐藏所有图片 */
        }

        .btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 100;
            background-color: rgba(255, 255, 255, 0.5); /* 透明按钮 */
            border: none;
            cursor: pointer;
        }

        .prev {
            left: 0;
        }

        .next {
            right: 0;
        }



    </style>
</head>
<body>
    <button class="toggle-btn" onclick="toggleSidebar()">Menu</button>
    <div id="sidebar" class="sidebar">
        <a href="">Home</a>
        <a href="">Services</a>
        <a href="">About</a>
        <a href="">Contact</a>
        <a href="">More</a>
    </div>


    <!-- 你原有的代码... -->

    <div class="slider-container">
        <div class="slider">
            <img src="./statics/images/logo.png" alt="Image 1">
            <img src="./statics/images/words.jpg" alt="Image 2">

            <!-- 添加更多图片 -->
        </div>
        <button class="btn prev">&#10094;</button>
        <button class="btn next">&#10095;</button>
    </div>

    <!-- 你原有的JavaScript位置之前... -->




    <div class="login-container">
        <img style="text-align: center; width: 100%" src="./statics/images/logo.png" alt="logoPushWords">
        <form action="user" method="post" id="loginForm">
            <input type= "hidden" name="actionName" value="login"/>
            <label for="userName">Username:</label>
            <input type="text" id="userName" name="userName" value="${resultInfo.result.uname}" autocomplete="current-username">
            <label for="userPwd">Password:</label>

            <div class="password-container">
                <input type="password" id="userPwd" name="userPwd" value="${resultInfo.result.upwd}" autocomplete="current-password">
                <i id="togglePasswordBtn" class="fas fa-eye" onclick="togglePassword()"></i>
            </div>

            <div>
                <label>
                    <input name = "rem" type="checkbox" value="1" class="input checkbox"/>
                </label>
                <label>remember me</label>
            </div>
            <div>
            <span id="msg" style="color: red;font-size: 12px" >${resultInfo.msg}</span>
            </div>
            <br/>
            <br/>
            <input type="button" value="Login" onclick="checkLogin()">
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
                btn.style.left = "250px"; // Move button right along with the sidebar
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
        let timer = null;

        function showSlide(index) {
            slides.forEach((slide, i) => {
                slide.style.display = i === index ? 'block' : 'none';
            });
            resetTimer();
        }

        function nextSlide() {
            sliderIndex = (sliderIndex + 1) % slides.length;
            showSlide(sliderIndex);
        }

        function prevSlide() {
            sliderIndex = (sliderIndex - 1 + slides.length) % slides.length;
            showSlide(sliderIndex);
        }

        function resetTimer() {
            clearInterval(timer);
            timer = setInterval(nextSlide, 5000); // 5秒切换一次
        }

        document.querySelector('.next').addEventListener('click', nextSlide);
        document.querySelector('.prev').addEventListener('click', prevSlide);

        // 初始化
        resetTimer();
        showSlide(sliderIndex);
</script>
</body>

</html>
