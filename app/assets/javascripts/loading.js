document.addEventListener('turbolinks:load', function() {
  if (document.getElementById("meishi-form")) {
    let img = document.createElement('img');
    img.src = "https://media.giphy.com/media/VBwXWPvUdxzPi/giphy.gif"

    let submit_button = document.querySelector("input[type='submit']");
    submit_button.addEventListener("click", () => {
      document.getElementById("loading").appendChild(img)
      document.getElementById("text").innerText = "名刺作成中…"
    })
  }
})
