function deleteDom(groupId) {
    var myTable = $("#myTable");
    var trLength = $("#myTable tr").length;
    if(trLength <= 2){
        $("#myTable").remove();
        $("#myDiv").html("<h2> No data Found! </h2>");
    }else{
        $("#tr_"+groupId).remove();
    }
}

function deleteGroup(groupId) {
    Swal.fire({
        title: "",
        html: "<h3>Are you sure? Delete it?</h3>",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "orange",
        confirmButtonText: "Yes",
        cancelButtonText: "No"
    }).then((result) => {
        // Only proceed with the deletion if the user confirmed by clicking "Yes"
        if (result.isConfirmed) {
            $.ajax({
                type: "post",
                url: "group",
                data: {
                    actionName: "delete",
                    groupId: groupId
                },
                success: function (result) {
                    if (result.code == 1) {
                        Swal.fire("", "<h3>Deleted successfully</h3>", "success");
                        deleteDom(groupId);
                    } else {
                        Swal.fire("", "<h3>" + result.msg + "</h3>", "error");
                    }
                },
                error: function () {
                    Swal.fire("", "<h3>Error: Unable to process your request.</h3>", "error");
                }
            });
        }
    });
}




document.addEventListener('DOMContentLoaded', function () {

    const modal = document.getElementById('myModal');
    const modalTitle = modal.querySelector('.modal-title');
    const groupIdInput = modal.querySelector('input[name="groupId"]');
    const groupNameInput = modal.querySelector('input[name="groupname"]');
    const groupDescriptionInput = modal.querySelector('input[name="groupdescription"]');


    document.querySelectorAll('[data-bs-toggle="modal"][data-bs-target="#myModal"]').forEach(button => {
        button.addEventListener('click', function () {
            // 获取按钮的 data-modal-title 属性值并设置模态框标题
            const title = button.getAttribute('data-modal-title');
            modalTitle.textContent = title;

            const groupId = button.getAttribute('data-group-id');
            const groupName = button.getAttribute('data-group-name');
            const groupDescription = button.getAttribute('data-group-description');

            groupIdInput.value = groupId || '';
            groupNameInput.value = groupName || '';
            groupDescriptionInput.value = groupDescription || '';
        });
    });
});
// Clear error messages and reset the form when the modal is opened
$('[data-bs-toggle="modal"][data-bs-target="#myModal"]').on('click', function () {
    $('#msg').html(''); // Clear error messages
    $('#groupId').val(''); // Reset form values
    $('#groupname').val('');
    $('#groupdescription').val('');
});

// Handle the form submission for saving a group
$("#btn_submit").click(function (event) {
    event.preventDefault(); // Prevent default form submission

    // Retrieve input values
    var groupName = $("#groupname").val().trim();
    var groupId = $("#groupId").val();
    var groupDescription = $("#groupdescription").val().trim();

    // Validation: Check if the group name is empty
    if (groupName === "") {
        $("#msg").html("Group Name could not be empty!");
        return; // Stop further execution
    }

    // AJAX request to add or update the group
    $.ajax({
        type: "post",
        url: "group",
        data: {
            actionName: "addOrUpdate",
            groupName: groupName,
            groupId: groupId,
            groupDescription: groupDescription
        },
        success: function (result) {
            if (result.code == 1) {
                $('#myModal').modal('hide'); // Close the modal
                Swal.fire({
                    title: "",
                    html: "<h3>Group saved successfully!</h3>",
                    icon: "success",
                    confirmButtonText: "OK"
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Reload the page after clicking "OK"
                        location.reload();
                    }
                });
            } else {
                $("#msg").html(result.msg); // Show error message
            }
        },
        error: function () {
            $("#msg").html("Error: Unable to process your request.");
        }
    });
});

