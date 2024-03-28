// validateLogin.js

function checkLogin() {
    // 获取用户名和密码的值
    var username = $("username").val();
    var password = $("password").val()
    //var username = document.getElementById('username').value;
    //var password = document.getElementById('password').value;

    // 获取用于显示消息的元素
    var messageElement = document.getElementById('msg');




    // 检查用户名和密码是否为空
    if (username.trim() === '' || password.trim() === '') {
        messageElement.textContent = 'Username or Password cannot be empty.'; // 显示错误消息
        return false; // 防止进一步的表单提交逻辑
    } else {
        messageElement.textContent = ''; // 清除错误消息
        $("#loginForm").submit();
        //document.getElementById('loginForm').submit();
        //alert('Login successful!'); // 演示目的显示登录成功消息
        // 这里可以添加其他逻辑，如表单提交

    }
}

