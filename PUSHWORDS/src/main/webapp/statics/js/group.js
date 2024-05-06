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
        html: "<h3>Are you sure ? Delete it ?</h3>",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "orange",
        confirmButtonText: "Yes",
        cancelButtonText: "No"
    }).then(function () {
        $.ajax({
            type: "post",
            url: "group",
            data:{
                actionName:"delete",
                groupId: groupId
            },
            success:function (result){
                if(result.code == 1){
                    Swal.fire("","<h3> delete successfully</h3>","success");
                    deleteDom(groupId);
                }else{
                    Swal.fire("","<h3"+result.msg+"</h3>","error");

                }
            }


        })
    });
}