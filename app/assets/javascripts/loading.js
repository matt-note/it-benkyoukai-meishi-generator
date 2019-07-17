document.addEventListener('turbolinks:load', function() {
  if (document.getElementById("meishi-form")) {
    let img = document.createElement('img');
    img.src = "https://media0.giphy.com/media/VBwXWPvUdxzPi/200w_d.gif?cid=5c98ac3e5d2e9e306b7a416e454b6c9f&rid=200w_d.gif"

    let submit_button = document.querySelector("input[type='submit']");
    submit_button.addEventListener("click", () => {
      document.getElementById("loading").appendChild(img)
      document.getElementById("text").innerText = "名刺作成中…"
    })
  }
})
