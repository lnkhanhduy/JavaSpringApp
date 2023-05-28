const changePasswordModal = new bootstrap.Modal(
  document.querySelector("#changepassword"),
  {}
);

const editModal = new bootstrap.Modal(
  document.querySelector("#editaccount"),
  {}
);

const deleteModal = new bootstrap.Modal(
  document.querySelector("#deleteaccount"),
  {}
);

function openchangePasswordModal() {
  changePasswordModal.show();
  const btn_confirm = document.querySelector("#btn-confirm");
  const password = document.querySelector("#password");
  const confirm_password = document.querySelector("#confirm-password");

  btn_confirm.addEventListener("click", () => {
    const form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "/changepassword");
    const FN1 = document.createElement("input");
    FN1.setAttribute("type", "text");
    FN1.setAttribute("name", "password");
    FN1.setAttribute("value", password.value);
    FN1.hidden = true;
    form.appendChild(FN1);
    const FN2 = document.createElement("input");
    FN2.setAttribute("type", "text");
    FN2.setAttribute("name", "confirm-password");
    FN2.setAttribute("value", confirm_password.value);
    FN2.hidden = true;
    form.appendChild(FN2);
    document.getElementsByTagName("body")[0].appendChild(form);
    form.submit();
  });
}

function openEditModal() {
  editModal.show();
  const fullname = document.querySelector("#fullname");
  const email = document.querySelector("#email");
  const btn_edit = document.querySelector("#btn-edit");

  btn_edit.addEventListener("click", () => {
    const form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "/editaccount");
    const FN1 = document.createElement("input");
    FN1.setAttribute("type", "text");
    FN1.setAttribute("name", "fullname");
    FN1.setAttribute("value", fullname.value);
    FN1.hidden = true;
    form.appendChild(FN1);
    const FN2 = document.createElement("input");
    FN2.setAttribute("type", "text");
    FN2.setAttribute("name", "email");
    FN2.setAttribute("value", email.value);
    FN2.hidden = true;
    form.appendChild(FN2);
    document.getElementsByTagName("body")[0].appendChild(form);
    form.submit();
  });
}

function openDeleteModal() {
  deleteModal.show();
  const btn_delete = document.querySelector("#btn-delete");

  btn_delete.addEventListener("click", () => {
    const form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "/deleteaccount");
    document.getElementsByTagName("body")[0].appendChild(form);
    form.submit();
  });
}
