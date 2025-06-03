<%-- 
    Document   : ct_adicionarDueñoLocal
    Created on : 8/05/2025, 3:06:51 p. m.
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adicionar Dueño Local</title>
    </head>
    <body>
        <h1>Adicionar Dueño Local</h1>
    <%
        String cedula = request.getParameter("cedulaOwner");
        String nombre = request.getParameter("nombreOwner");
        String apellido = request.getParameter("apellidoOwner");
        String correo = request.getParameter("correoOwner");
        String password = request.getParameter("passwordOwner");
        String telefono = request.getParameter("telefonoOwner");

        ArrayList<String> datosOwnerLocal = new ArrayList<>();
        datosOwnerLocal.add(cedula);
        datosOwnerLocal.add(nombre);
        datosOwnerLocal.add(apellido);
        datosOwnerLocal.add(correo);
        datosOwnerLocal.add(password);
        datosOwnerLocal.add(telefono);

        session.setAttribute("datosDueñoLocal", datosOwnerLocal);
        response.sendRedirect("../Modelo/md_adicionarOwnerLocal.jsp"); // Redirige al modelo
    %>
    </body>
</html>
