<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Procesando Cliente...</title>
    </head>
    <body>
        <%
            // El nombre del parámetro en la URL es "cedulaCliente"
            String cedulaClienteBuscar = request.getParameter("cedulaCliente");
            System.out.println("ct_verCliente.jsp: Cédula recibida para consulta de detalle: " + cedulaClienteBuscar);
            
            if (cedulaClienteBuscar != null && !cedulaClienteBuscar.trim().isEmpty()) {
                // Almacenar la cédula en la sesión para que el siguiente JSP (modelo) pueda acceder a ella
                session.setAttribute("cedulaClienteParaVer", cedulaClienteBuscar); 
                
                // Redirigir al JSP del modelo que se encargará de consultar el cliente
                // Asumo que tienes o crearás un JSP como md_obtenerCliente.jsp
                out.print("<script>location.href=\"../modelo/md_obtenerCliente.jsp\";</script>");
            } else {
                // Si no se proporcionó una cédula, redirigir al listado con un mensaje de error
                session.setAttribute("mensajeBusqueda", "Error: No se proporcionó una cédula de cliente para ver detalles.");
                out.print("<script>location.href=\"../vista/listadoClientes.jsp\";</script>");
            }
        %>    
    </body>
</html>