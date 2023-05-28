// active selected tab item when click
const tabs = document.querySelectorAll(".ct-navigation li");

function activeLink() {
    tabs.forEach((item) => {
        item.classList.remove("active");
    })
    this.classList.add('active');
}

tabs.forEach((item) => item.addEventListener('click', activeLink));

// menu toggle
// const ctToggle = document.querySelector(".ct-toggle");
// const ctNavigation = document.querySelector(".ct-navigation");
// const ctContent = document.querySelector(".ct-content");

// ctToggle.onclick = () => {
//     ctNavigation.classList.toggle("active-toggle");
//     ctContent.classList.toggle("active-toggle");
// }