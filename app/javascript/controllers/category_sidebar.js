document.addEventListener("turbo:load", () => {
  const sidebar = document.getElementById("categorySidebar");
  const openBtn = document.getElementById("openSidebar");
  const closeBtn = document.getElementById("closeSidebar");

  if (sidebar && openBtn && closeBtn) {
    openBtn.addEventListener("click", () => {
      sidebar.classList.add("open");
    });

    closeBtn.addEventListener("click", () => {
      sidebar.classList.remove("open");
    });

    document.querySelectorAll(".category-link").forEach(link => {
      link.addEventListener("click", () => {
        sidebar.classList.remove("open");
      });
    });

    document.addEventListener("click", event => {
      const clickedInside =
        sidebar.contains(event.target) || openBtn.contains(event.target);

      if (!clickedInside) {
        sidebar.classList.remove("open");
      }
    });
  }

  const searchInput = document.getElementById("product-search-input");
  const searchForm = document.getElementById("product-search-form");

  if (!searchInput || !searchForm) return;

  let searchTimeout;

  searchInput.addEventListener("input", () => {
    clearTimeout(searchTimeout);

    searchTimeout = setTimeout(() => {
      searchForm.requestSubmit();
    }, 400);
  });

  document.querySelectorAll(".dropdown-options a, .dropdown-options button").forEach(option => {
  option.addEventListener("click", () => {
    option.closest("details").open = false;
  });
});
});
