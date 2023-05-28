const btn_reset_account = document.querySelector("#btn-reset-account");
const btn_delete_account = document.querySelector("#btn-delete-account");

function resetAccount(e) {
  const username = e.dataset.username;
  btn_reset_account.setAttribute("data-username", username);
}

function deleteAccount(e) {
  const username = e.dataset.username;
  btn_delete_account.setAttribute("data-username", username);
}

btn_reset_account.addEventListener("click", (e) => {
  const username = btn_reset_account.dataset.username;
  var form = document.createElement("form");
  form.setAttribute("method", "post");
  form.setAttribute("action", "/admin/usermanagement/reset");

  var FN = document.createElement("input");
  FN.setAttribute("type", "text");
  FN.setAttribute("name", "username");
  FN.setAttribute("value", username);
  form.appendChild(FN);
  document.getElementsByTagName("body")[0].appendChild(form);
  form.submit();
});

btn_delete_account.addEventListener("click", (e) => {
  const username = btn_delete_account.dataset.username;
  var form = document.createElement("form");
  form.setAttribute("method", "post");
  form.setAttribute("action", "/admin/usermanagement/delete");

  var FN = document.createElement("input");
  FN.setAttribute("type", "text");
  FN.setAttribute("name", "username");
  FN.setAttribute("value", username);
  form.appendChild(FN);
  document.getElementsByTagName("body")[0].appendChild(form);
  form.submit();
});
