// toast

const toasts = document.getElementById("pp-toast");
const types = {
  success: "fa-check",
  info: "fa-info",
  error: "fa-exclamation",
};

function createToastPopup({
  color = "#0000ff",
  type = "info",
  title = "Info",
  content = "Info here",
}) {
  let toast = document.createElement("div");
  toast.classList.add("pp-toast");
  toast.style.cssText = `--i: ${color}`;
  toast.innerHTML = `
    <div class="pp-toast-content">
            <i class="fa-solid ${types[type]} pp-icon"></i>
            <div class="pp-message">
                <span class="pp-text pp-title">${title}</span>
                <span class="pp-text pp-content">${content}</span>
            </div>
        </div>
        <i class="fa-solid fa-xmark pp-close"></i>
    <div class="pp-progress"></div>
    `;
  toasts.append(toast);
  showToast(toast);
}

function showToast(toast) {
  let progress = toast.querySelector(".pp-progress");
  let closeBtn = toast.querySelector(".pp-close");

  setTimeout(() => {
    toast.classList.add("pp-active");
    progress.classList.add("progress-active");

    const timeout = setTimeout(() => {
      toast.classList.remove("pp-active");
      removeToast(toast);
    }, 5000);
    closeBtn.addEventListener("click", () => {
      clearTimeout(timeout);
      toast.classList.remove("pp-active");
      removeToast(toast);
    });
  }, 1);
}

function removeToast(toast) {
  setTimeout(() => {
    toasts.removeChild(toast);
  }, 500);
}
