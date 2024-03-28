// validateLogin.js

function checkLogin() {
    var userName = $("#userName").val();
    var userPwd = $("#userPwd").val();
    //var userName = document.getElementById("userName").value; // Corrected the selector
    //var usrPwd = document.getElementById("userPwd").value; // Corrected the selector

    // 获取用于显示消息的元素
    // var messageElement = document.getElementById("msg");

    // 检查用户名和密码是否为空
    if (userName == null || userName.trim() == "") {
        $("#msg").html("Username cannot be empty.");
    //    messageElement.textContent = "Username cannot be empty."; // 显示错误消息
        return; // 防止进一步的表单提交逻辑
    }
    if (userPwd == null || userPwd.trim() == "") {
              $("#msg").html("Password cannot be empty.");
      //  messageElement.textContent = "Password cannot be empty."; // 显示错误消息
        return; // 防止进一步的表单提交逻辑
    }

      $("#loginForm").submit(); // Assuming you have jQuery, this is correct

}
