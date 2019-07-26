document.addEventListener("turbolinks:load", () => {
  document.getElementById("dl-btn").addEventListener("click", (ev) => {
    ev.currentTarget.classList.add("disabled");
    document.getElementById("raksul-btn").classList.remove("disabled");
  });
});
