<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: moccasin;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .signup-container {
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
    </style>
</head>
<body>
<div class="signup-container">
    <form action="user" method="post" id="signupForm">
        <input type="hidden" name="actionName" value="register"/>
        <label for="userName">Username:</label>
        <input type="text" id="userName" name="userName" required>
        <label for="userPwd">Password:</label>
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
