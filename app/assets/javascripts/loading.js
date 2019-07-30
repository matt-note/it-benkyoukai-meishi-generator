document.addEventListener("turbolinks:load", () => {
  if (document.getElementById("meishi-form")) {
    let img = document.createElement("img");
    img.src = "https://raw.githubusercontent.com/matt-note/it-benkyokai-meishi-generator/master/app/assets/images/giphy-downsized.gif";

    let submit_button = document.querySelector("input[type='submit']");
    submit_button.addEventListener("click", () => {
      let error_message = document.getElementById("error_explanation");
      if (error_message) {
        error_message.style.display = "none";
      }
      document.getElementById("loading").appendChild(img);
      document.getElementById("text").innerText = "作成中…";
    })
  }
})
