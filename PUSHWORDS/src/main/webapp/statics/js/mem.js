function  handleCardClick(groupId,groupName){
    Swal.fire({
        title: "",
        html: "<h3>Enter the group " + groupName + "?</h3>",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "orange",
        confirmButtonText: "Yes",
        cancelButtonText: "No"
    }).then((result)=>{

        if(result.isConfirmed){
            alert(0);
        }
    })


}