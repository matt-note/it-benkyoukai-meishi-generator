document.addEventListener("turbolinks:load", () => {
  document.getElementById("dl-btn").addEventListener("click", (ev) => {
    ev.currentTarget.classList.add("disabled");
  });

  let fetchData = document.getElementById("fetch-data");
  fetchData.addEventListener("mouseover", (ev) => {
    ev.currentTarget.style.color = "rgba(0,0,0,.5)";
    ev.currentTarget.style.fill = "rgba(0,0,0,.5)";
  });
  fetchData.addEventListener("mouseout", (ev) => {
    ev.currentTarget.style.color = "rgba(0,0,0,1)";
    ev.currentTarget.style.fill = "rgba(0,0,0,1)";
  });

  let submitAttention = document.getElementById("submit-attention");
  submitAttention.addEventListener("mouseover", (ev) => {
    ev.currentTarget.style.color = "rgba(0,0,0,.5)";
    ev.currentTarget.style.fill = "rgba(0,0,0,.5)";
  });
  submitAttention.addEventListener("mouseout", (ev) => {
    ev.currentTarget.style.color = "rgba(0,0,0,1)";
    ev.currentTarget.style.fill = "rgba(0,0,0,1)";
  });
});
