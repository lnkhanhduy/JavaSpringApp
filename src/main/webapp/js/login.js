const changeSignupFormBtn = document.querySelector(".changeSignupFormBtn");
const changeSigninFormBtn = document.querySelector(".changeSigninFormBtn");
const validationBox = document.querySelector(".validation-box");
const formBox = document.querySelector(".formBox");

// input login form
const inputLoginUsername = document.querySelector("#login-username");
const inputLoginPassword = document.querySelector("#login-password");
// input signup form
const inputSignupUsername = document.querySelector("#signup-username");
const inputSignupFullname = document.querySelector("#signup-fullname");
const inputSignupEmail = document.querySelector("#signup-email");
const inputSignupPassword = document.querySelector("#signup-password");
const inputSignupConfirmPassword = document.querySelector(
  "#signup-confirmPassword"
);

// complete part
let loginComplete = 0;
let signupComplete = 0;

changeSignupFormBtn.addEventListener("click", () => {
  formBox.classList.add("active");
  validationBox.classList.add("active");
  validationBox.classList.remove("login-complete-1", "login-complete-2");
  inputLoginUsername.value = "";
  inputLoginPassword.value = "";
  loginComplete = 0;
});

changeSigninFormBtn.addEventListener("click", () => {
  formBox.classList.remove("active");
  validationBox.classList.remove("active");
  validationBox.classList.remove(
    "signup-complete-1",
    "signup-complete-2",
    "signup-complete-3",
    "signup-complete-4",
    "signup-complete-5"
  );
  inputSignupUsername.value = "";
  inputSignupFullname.value = "";
  inputSignupEmail.value = "";
  inputSignupPassword.value = "";
  inputSignupConfirmPassword.value = "";
  signupComplete = 0;
});

inputLoginUsername.onchange = () => {
  if (inputLoginUsername.value) {
    loginComplete += 1;
  } else {
    loginComplete -= 1;
  }
  checkCompleteLoginCount();
};

inputLoginPassword.onchange = () => {
  if (inputLoginPassword.value) {
    loginComplete += 1;
  } else {
    loginComplete -= 1;
  }
  checkCompleteLoginCount();
};

function checkCompleteLoginCount() {
  switch (loginComplete) {
    case 0:
      validationBox.classList.remove("login-complete-1");
      validationBox.classList.add("login-complete-0");
      break;
    case 1:
      validationBox.classList.remove("login-complete-2", "login-complete-0");
      validationBox.classList.add("login-complete-1");
      break;
    case 2:
      validationBox.classList.remove("login-complete-1", "login-complete-3");
      validationBox.classList.add("login-complete-2");
      break;
  }
}

inputSignupUsername.onchange = () => {
  if (inputSignupUsername.value) {
    signupComplete += 1;
  } else {
    signupComplete -= 1;
  }
  checkCompleteSignupCount();
};
inputSignupFullname.onchange = () => {
  if (inputSignupFullname.value) {
    signupComplete += 1;
  } else {
    signupComplete -= 1;
  }
  checkCompleteSignupCount();
};
inputSignupEmail.onchange = () => {
  if (inputSignupEmail.value) {
    signupComplete += 1;
  } else {
    signupComplete -= 1;
  }
  checkCompleteSignupCount();
};
inputSignupPassword.onchange = () => {
  if (inputSignupPassword.value) {
    signupComplete += 1;
  } else {
    signupComplete -= 1;
  }
  checkCompleteSignupCount();
};
inputSignupConfirmPassword.onchange = () => {
  if (inputSignupConfirmPassword.value) {
    signupComplete += 1;
  } else {
    signupComplete -= 1;
  }
  checkCompleteSignupCount();
};

function checkCompleteSignupCount() {
  switch (signupComplete) {
    case 0:
      validationBox.classList.remove("signup-complete-1");
      validationBox.classList.add("signup-complete-0");
      break;
    case 1:
      validationBox.classList.remove("signup-complete-2", "signup-complete-0");
      validationBox.classList.add("signup-complete-1");
      break;
    case 2:
      validationBox.classList.remove("signup-complete-1", "signup-complete-3");
      validationBox.classList.add("signup-complete-2");
      break;
    case 3:
      validationBox.classList.remove("signup-complete-2", "signup-complete-4");
      validationBox.classList.add("signup-complete-3");
      break;
    case 4:
      validationBox.classList.remove("signup-complete-3", "signup-complete-5");
      validationBox.classList.add("signup-complete-4");
      break;
    case 5:
      validationBox.classList.remove("signup-complete-4");
      validationBox.classList.add("signup-complete-5");
      break;
  }
}

const forgotModal = new bootstrap.Modal(
  document.querySelector("#forgotpasswordmodal"),
  {}
);

function openForgotModal(e) {
  forgotModal.show();
  const btn_send = document.querySelector("#btn-send");
  const email = document.querySelector("#forgot-email");
  btn_send.addEventListener("click", () => {
    $.ajax({
      type: "POST",
      contentType: "application/json",
      url: "/forgot",
      data: email.value,
      dataType: "json",
      cache: false,
      timeout: 60000,
      success: function (data) {
        console.log(data);
      },
      error: function (e) {
        console.log("ERROR : ", e);
        if (e.responseText == "Sent email success") {
          createToastPopup({
            color: "#0000ff",
            type: "info",
            title: "Thành công",
            content: "Mật khẩu mới đã được gửi tới email của bạn!",
          });
        } else {
          createToastPopup({
            color: "#ff0000",
            type: "info",
            title: "Lỗi",
            content: "Email không chính xác!",
          });
        }
      },
    });
  });
}
