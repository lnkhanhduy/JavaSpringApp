const addProductModal = new bootstrap.Modal(
  document.querySelector("#addProductModal"),
  {}
);
const editProductModal = new bootstrap.Modal(
  document.querySelector("#editProductModal"),
  {}
);
const deleteProductModal = new bootstrap.Modal(
  document.querySelector("#deleteProductModal"),
  {}
);
const moreInfoProductModal = new bootstrap.Modal(
  document.querySelector("#moreInfoProductModal"),
  {}
);

function openMoreInfoModal(e, event) {
  if (event.target.parentNode !== event.currentTarget) {
    return;
  }
  document.querySelector("#moreInfoProductModal #name-product").value =
    e.dataset.name;
  document.querySelector("#moreInfoProductModal #price-product").value =
    e.dataset.price;
  document.querySelector("#moreInfoProductModal #desc-product").value =
    e.dataset.desc;
  document.querySelector("#moreInfoProductModal #quantity-product").value =
    e.dataset.quantity;
    document.querySelector("#moreInfoProductModal #category-product").value =
    e.dataset.category;
  document
    .querySelector("#moreInfoProductModal #image1")
    .setAttribute("src", "../../images/" + e.dataset.image1);
  document
    .querySelector("#moreInfoProductModal #image2")
    .setAttribute("src", "../../images/" + e.dataset.image2);
  document
    .querySelector("#moreInfoProductModal #image3")
    .setAttribute("src", "../../images/" + e.dataset.image3);
  document
    .querySelector("#moreInfoProductModal #image4")
    .setAttribute("src", "../../images/" + e.dataset.image4);
  document
    .querySelector("#moreInfoProductModal #image5")
    .setAttribute("src", "../../images/" + e.dataset.image5);

  moreInfoProductModal.show();
}

function openNewProductModal() {
  addProductModal.show();
}

function openEditProductModal(e) {
  document.querySelector("#editProductModal #id-product").value = e.dataset.id;
  document.querySelector("#editProductModal #name-product").value =
    e.dataset.name;
  document.querySelector("#editProductModal #price-product").value =
    e.dataset.price;
  document.querySelector("#editProductModal #desc-product").value =
    e.dataset.desc;
  document.querySelector("#editProductModal #quantity-product").value =
    e.dataset.quantity;
  const category = document.querySelector(
    "#editProductModal #category-product"
  );
  for (let i = 0; i < category.options.length; i++) {
    if (category.options[i].text == e.dataset.category) {
      category.options[i].selected = true;
      break;
    }
  }
  editProductModal.show();
}

function openDeleteProductModal(e) {
  var form = document.createElement("form");
  form.setAttribute("method", "post");
  form.setAttribute("action", "/admin/productmanagement/delete");

  var FN = document.createElement("input");
  FN.setAttribute("type", "text");
  FN.setAttribute("name", "id-product");
  FN.setAttribute("value", e.dataset.id);
  form.appendChild(FN);
  document.getElementsByTagName("body")[0].appendChild(form);
  document
    .querySelector("#deleteProductModal #btn-delete-flower")
    .addEventListener("click", function () {
      form.submit();
    });
  deleteProductModal.show();
}
