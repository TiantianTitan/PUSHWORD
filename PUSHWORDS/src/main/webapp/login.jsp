<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <title>Login Page</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="statics/js/config.js?version=1.1" type="text/javascript"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
 <div class="login-container">
        <form action="user" method="post" id="loginForm">

            <input type= "hidden" name="actionName" value="login"/>

            <label for="username">Username:</label>
            <input type="text" id="userName" name="userName" value="${resultInfo.result.uname}" autocomplete="current-username">
            <label for="password">Password:</label>
            <input type="password" id="userPwd" name="userPwd" value="${resultInfo.result.upwd}" autocomplete="current-password">
            <input name = "rem" type="checkbox" value="1" class="inputcheckbox"/> <label>remember me</label>
            <span id="msg" style="color: red;font-size: 12px" >${resultInfo.msg}</span>
            <br/>
            <br/>
            <input type="button" value="Login" onclick="checkLogin()">
        </form>
    </div>
</body>
</html>
