<%-- 
    Document   : md_adicionarDueñoLocal
    Created on : 8/05/2025, 3:11:24 p. m.
    Author     : Usuario
--%>

<%@page import="utils.Conexion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adicionar Dueño Local</title>
    </head>
    <body>
        <h1>Adicionar Dueño Local</h1>
        <%
            ArrayList<String> datos = (ArrayList<String>) session.getAttribute("datosDueñoLocal"); //Obtiene los datos Cliente
            for (String dato : datos) {
                out.println(dato);
            }
            Conexion c = new Conexion();
            if (c.insertar("owner_local", datos)) {
                out.print("Registro exitoso");
            } else {
                out.print("Error: " + c.getMensaje());
            }
            
            response.sendRedirect("../Vista/PaginaPrincipal.jsp");
        %>

    </body>
</html>

