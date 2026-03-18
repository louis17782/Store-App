document.addEventListener("turbo:load", () => {
  const sidebar = document.getElementById("categorySidebar");
  const openBtn = document.getElementById("openSidebar");
  const closeBtn = document.getElementById("closeSidebar");

  if (!sidebar || !openBtn || !closeBtn) return;

  // Abrir sidebar
  openBtn.addEventListener("click", () => {
    sidebar.classList.add("open");
  });

  // Cerrar sidebar con botón X
  closeBtn.addEventListener("click", () => {
    sidebar.classList.remove("open");
  });

  // Cerrar sidebar al hacer clic en una categoría
  document.querySelectorAll(".category-link").forEach(link => {
    link.addEventListener("click", () => {
      sidebar.classList.remove("open");
    });
  });

  // Cerrar sidebar al hacer clic fuera
  document.addEventListener("click", (event) => {
    const clickedInside = sidebar.contains(event.target) || openBtn.contains(event.target);

    if (!clickedInside) {
      sidebar.classList.remove("open");
    }
  });
});
