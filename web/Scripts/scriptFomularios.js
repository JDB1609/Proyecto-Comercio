/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");

    form.addEventListener("submit", function (e) {
        const usuario = form.usuario.value.trim();
        const password = form.password.value.trim();

        if (!usuario || !password) {
            alert("Por favor complete todos los campos.");
            e.preventDefault(); // evita el envío del formulario
        }
    });
});
