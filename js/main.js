
document.querySelectorAll("[data-year]").forEach(function (el) {
  el.textContent = new Date().getFullYear();
});

(function () {
  var root = document.documentElement;
  var toggle = document.querySelector(".theme-toggle");
  var meta = document.querySelector('meta[name="theme-color"]');

  if (!toggle) {
    return;
  }

  function setTheme(theme, remember) {
    var isDark = theme === "dark";

    root.setAttribute("data-theme", isDark ? "dark" : "light");
    toggle.setAttribute(
      "aria-label",
      isDark ? "Preklopi na svetli način" : "Preklopi na temni način"
    );

    if (meta) {
      meta.setAttribute("content", isDark ? "#14161a" : "#3a3f45");
    }

    if (remember) {
      try {
        localStorage.setItem("adum-theme", isDark ? "dark" : "light");
      } catch (error) {
      
      }
    }
  }

  setTheme(root.getAttribute("data-theme") === "dark" ? "dark" : "light", false);

  toggle.addEventListener("click", function () {
    setTheme(root.getAttribute("data-theme") === "dark" ? "light" : "dark", true);
  });

  if (window.matchMedia) {
    var systemTheme = window.matchMedia("(prefers-color-scheme: dark)");

    systemTheme.addEventListener("change", function (event) {
      var saved = null;

      try {
        saved = localStorage.getItem("adum-theme");
      } catch (error) {
        saved = null;
      }

      if (!saved) {
        setTheme(event.matches ? "dark" : "light", false);
      }
    });
  }
})();


document.addEventListener("DOMContentLoaded", function () {
  var toggle = document.querySelector(".nav-toggle");
  var nav = document.querySelector(".main-nav");

  if (!toggle || !nav) {
    return;
  }

  function closeMenu() {
    nav.classList.remove("is-open");
    toggle.setAttribute("aria-expanded", "false");
    toggle.setAttribute("aria-label", "Odpri meni");
  }

  toggle.addEventListener("click", function () {
    var isOpen = nav.classList.toggle("is-open");

    toggle.setAttribute("aria-expanded", isOpen ? "true" : "false");
    toggle.setAttribute("aria-label", isOpen ? "Zapri meni" : "Odpri meni");
  });

  
  nav.querySelectorAll("a").forEach(function (link) {
    link.addEventListener("click", closeMenu);
  });


  document.addEventListener("click", function (event) {
    if (
      nav.classList.contains("is-open") &&
      !nav.contains(event.target) &&
      !toggle.contains(event.target)
    ) {
      closeMenu();
    }
  });

  document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
      closeMenu();
    }
  });

  window.addEventListener("resize", function () {
    if (window.innerWidth > 960) {
      closeMenu();
    }
  });
});
