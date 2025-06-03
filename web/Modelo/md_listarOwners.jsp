<%@page import="utils.Conexion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Obteniendo Listado de Dueños de Locales...</title>
    </head>
    <body>
        <%
            // --- INICIO CÓDIGO DEPURACIÓN CRÍTICA ---
            System.out.println("*************** md_listarOwners.jsp HA EMPEZADO A EJECUTARSE ***************");
            // --- FIN CÓDIGO DEPURACIÓN CRÍTICA ---

            Conexion c = null; 
            ArrayList<String[]> listaOwners = null;
            String mensajeError = null;

            try {
                c = new Conexion(); 
                System.out.println("md_listarOwners.jsp: Objeto Conexion creado.");

                if (c.conectarMySQL()) { 
                    System.out.println("md_listarOwners.jsp: Conexión a MySQL exitosa.");

                    // Consultar los owner_local activos
                    // Asegúrate de que tu método consultarRegistrosActivos pueda manejar "owner_local"
                    listaOwners = c.consultarRegistrosActivos("owner_local");

                    if (listaOwners != null && !listaOwners.isEmpty()) {
                        // --- INICIO CÓDIGO DEPURACIÓN ---
                        System.out.println("md_listarOwners.jsp: Tamaño de listaOwners: " + listaOwners.size() + " filas.");
                        if (listaOwners.size() > 0) {
                            String[] primerOwner = listaOwners.get(0);
                            System.out.println("md_listarOwners.jsp: Datos del primer dueño: ");
                            for (int i = 0; i < primerOwner.length; i++) {
                                System.out.println("  Columna " + i + ": " + primerOwner[i]);
                            }
                        }
                        // --- FIN CÓDIGO DEPURACIÓN ---
                        
                        // Convertir ArrayList<String[]> a String[][]
                        String[][] datos = new String[listaOwners.size()][];
                        for (int i = 0; i < listaOwners.size(); i++) {
                            datos[i] = listaOwners.get(i);
                        }

                        session.setAttribute("datosOwners", datos); // Usamos "datosOwners"
                        System.out.println("md_listarOwners.jsp: 'datosOwners' guardado en sesión.");
                        response.sendRedirect("../Vista/listadoOwners.jsp");
                    } else {
                        mensajeError = "La consulta no devolvió dueños de locales activos o la lista está vacía.";
                        System.out.println("md_listarOwners.jsp: " + mensajeError);
                        session.setAttribute("datosOwners", null); 
                        response.sendRedirect("../Vista/listadoOwners.jsp"); 
                    }
                } else {
                    mensajeError = "No se pudo establecer la conexión a la base de datos para dueños de locales: " + c.getMensaje();
                    System.out.println("md_listarOwners.jsp: " + mensajeError);
                    session.setAttribute("datosOwners", null);
                    response.sendRedirect("../Vista/listadoOwners.jsp"); 
                }
            } catch (Exception e) {
                mensajeError = "Error inesperado en md_listarOwners.jsp: " + e.getMessage();
                System.err.println("md_listarOwners.jsp ERROR: " + mensajeError);
                e.printStackTrace();
                session.setAttribute("datosOwners", null);
                response.sendRedirect("../Vista/listadoOwners.jsp"); 
            } finally {
                if (c != null) {
                    c.cerrarConexion();
                    System.out.println("md_listarOwners.jsp: Conexión cerrada en finally.");
                }
            }
        %>
    </body>
</html>