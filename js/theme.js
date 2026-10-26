
(function () {
  var saved = null;

  try {
    saved = localStorage.getItem("adum-theme");
  } catch (error) {
   
    saved = null;
  }

  var systemPrefersDark =
    window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches;

  var theme = "light";

  if (saved === "dark" || saved === "light") {
    theme = saved;
  } else if (systemPrefersDark) {
    theme = "dark";
  }

  document.documentElement.setAttribute("data-theme", theme);

  var meta = document.querySelector('meta[name="theme-color"]');
  if (meta) {
    meta.setAttribute("content", theme === "dark" ? "#14161a" : "#3a3f45");
  }
})();
