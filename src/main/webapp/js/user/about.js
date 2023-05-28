const button_toggle = document.querySelectorAll(".ct-card-btn");
const ct_container = document.querySelectorAll(".ct-container");

for (let index = 0; index < button_toggle.length; index++) {
  button_toggle[index].addEventListener("click", () => {
    ct_container[index].classList.toggle("ct-change");
  });
}

