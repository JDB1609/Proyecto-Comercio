document.addEventListener('DOMContentLoaded', function() {
    const menuToggleButton = document.querySelector('.menu-toggle-button');
    const sideMenu = document.querySelector('.side-menu');
    const closeMenuButton = document.querySelector('.close-menu-button');
    const body = document.querySelector('body');
    const mainContent = document.querySelector('.main-content');

    menuToggleButton.addEventListener('click', function() {
        const isExpanded = this.getAttribute('aria-expanded') === 'true' || false;
        this.setAttribute('aria-expanded', !isExpanded);
        sideMenu.classList.toggle('open');
        body.classList.toggle('menu-open');
        mainContent.classList.toggle('menu-open');
    });

    closeMenuButton.addEventListener('click', function() {
        menuToggleButton.setAttribute('aria-expanded', false);
        sideMenu.classList.remove('open');
        body.classList.remove('menu-open');
        mainContent.classList.remove('menu-open');
    });
});