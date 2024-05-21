function handleCardClick(groupId, groupName) {
    const pageNum = 1; // Valeur par défaut pour la page
    const pageSize = 10; // Valeur par défaut pour la taille de page

    Swal.fire({
        title: "",
        html: "<h3>Enter the group " + groupName + "?</h3>",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "orange",
        confirmButtonText: "Yes",
        cancelButtonText: "No"
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'word?actionName=showWords&pageNum=' + pageNum + '&pageSize=' + pageSize + '&groupId=' + groupId;
        }
    });
}
