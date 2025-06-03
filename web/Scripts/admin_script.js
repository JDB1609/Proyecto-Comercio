document.addEventListener('DOMContentLoaded', function() {
    // --- Lógica del Menú del Sidebar ---
    const menuLinks = document.querySelectorAll('.admin-sidebar .menu-item > a');

    menuLinks.forEach(link => {
        const submenu = link.querySelector('ul.submenu'); // ul.submenu es hijo de 'a'
        const isLogoutLink = link.getAttribute('id') === 'logout-link-sidebar';

        if (submenu) { // Si el enlace 'a' contiene un submenu
            link.addEventListener('click', function(event) {
                event.preventDefault();
                const parentLi = this.parentElement; // El <li> que es .menu-item

                if (parentLi.classList.contains('active')) {
                    parentLi.classList.remove('active');
                } else {
                    // Cerrar otros submenús abiertos
                    document.querySelectorAll('.admin-sidebar .menu-item.active').forEach(activeItem => {
                        if (activeItem !== parentLi) { // No cerrar el que se está abriendo
                           activeItem.classList.remove('active');
                        }
                    });
                    // Abrir el submenu actual
                    parentLi.classList.add('active');
                }
            });
        } else if (isLogoutLink) {
            link.addEventListener('click', function(event) {
                event.preventDefault();
                // Aquí asumimos que tienes un formulario de logout o una acción JSP
                // Por ejemplo, si el logout se maneja por PaginaPrincipal.jsp
                console.log("Cerrar Sesión desde sidebar clickeado");
                // Simula el click del botón del header o redirige directamente
                // document.getElementById('logout-form-header').submit(); // Si existe ese form
                window.location.href = 'PaginaPrincipal.jsp'; // O la URL de logout
            });
        }
        // Los enlaces que no tienen submenu y no son el logout, navegan normalmente
    });

    // --- (Opcional) Lógica para el toggle del Sidebar en Móvil ---
    // Si añades un botón con id="sidebarToggle" en tu HTML (ej. en .admin-header)
    const sidebarToggler = document.getElementById('sidebarToggle'); // Necesitas añadir este botón al HTML
    const sidebar = document.querySelector('.admin-sidebar');

    if (sidebarToggler && sidebar) {
        sidebarToggler.addEventListener('click', function() {
            sidebar.classList.toggle('open');
        });
    }
});