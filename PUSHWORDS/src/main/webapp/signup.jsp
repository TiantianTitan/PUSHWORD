<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        body, html {
            height: 100%;
            width: 100%;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            background: radial-gradient(ellipse at bottom, #1b2735 0%, #090a0f 100%);
            overflow: hidden;
        }

        .signup-container {
            background-color: rgba(0,0,0,0);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
            z-index: 10;
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

<div class="signup-container">
    <form action="user" method="post" id="signupForm">
        <input type="hidden" name="actionName" value="register"/>
        <label for="userName" style="color: rgb(248,246,231)">Username:</label>
        <input type="text" id="userName" name="userName" required>
        <label for="userPwd" style="color: rgb(248,246,231)">Password:</label>
        <input type="password" id="userPwd" name="userPwd" required>
        <input type="button" value="Sign Up" onclick="checkSignup()">
        <div>
            <span id="msg" style="color: red;font-size: 12px"></span>
        </div>
    </form>
</div>
<script>
    function checkSignup() {
        var userName = $("#userName").val();
        var userPwd = $("#userPwd").val();

        if (userName.trim() === "" || userPwd.trim() === "") {
            $("#msg").text("Username and password are required.");
            return;
        }

        $("#signupForm").submit();
    }
</script>
</body>
</html>
