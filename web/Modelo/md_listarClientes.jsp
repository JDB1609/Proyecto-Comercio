<%@page import="utils.Conexion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Obteniendo Listado de Clientes...</title>
    </head>
    <body>
        <%
            // --- INICIO CÓDIGO DEPURACIÓN CRÍTICA ---
            System.out.println("*************** md_listarClientes.jsp HA EMPEZADO A EJECUTARSE ***************");
            // --- FIN CÓDIGO DEPURACIÓN CRÍTICA ---

            Conexion c = null; // Se inicializa a null
            ArrayList<String[]> listaClientes = null;
            String mensajeError = null;

            try {
                c = new Conexion(); // Se crea el objeto Conexion DENTRO del try
                System.out.println("md_listarClientes.jsp: Objeto Conexion creado.");

                // Intentar conectar a la base de datos
                if (c.conectarMySQL()) { // Llamar directamente a conectarMySQL
                    System.out.println("md_listarClientes.jsp: Conexión a MySQL exitosa.");

                    // Consultar los clientes activos
                    listaClientes = c.consultarRegistrosActivos("clientes");

                    if (listaClientes != null && !listaClientes.isEmpty()) {
                        // --- INICIO CÓDIGO DEPURACIÓN ---
                        System.out.println("md_listarClientes.jsp: Tamaño de listaClientes: " + listaClientes.size() + " filas.");
                        if (listaClientes.size() > 0) {
                            String[] primerCliente = listaClientes.get(0);
                            System.out.println("md_listarClientes.jsp: Datos del primer cliente: ");
                            for (int i = 0; i < primerCliente.length; i++) {
                                System.out.println("  Columna " + i + ": " + primerCliente[i]);
                            }
                        }
                        // --- FIN CÓDIGO DEPURACIÓN ---
                        
                        // Convertir ArrayList<String[]> a String[][]
                        String[][] datos = new String[listaClientes.size()][];
                        for (int i = 0; i < listaClientes.size(); i++) {
                            datos[i] = listaClientes.get(i);
                        }

                        session.setAttribute("datos", datos);
                        System.out.println("md_listarClientes.jsp: 'datos' guardado en sesión.");
                        response.sendRedirect("../Vista/listadoClientes.jsp");
                    } else {
                        mensajeError = "La consulta no devolvió clientes activos o la lista está vacía.";
                        System.out.println("md_listarClientes.jsp: " + mensajeError);
                        session.setAttribute("datos", null); // Asegurarse de que no haya datos previos
                        response.sendRedirect("../Vista/listadoClientes.jsp"); // Redirigir para mostrar el mensaje
                    }
                } else {
                    mensajeError = "No se pudo establecer la conexión a la base de datos: " + c.getMensaje();
                    System.out.println("md_listarClientes.jsp: " + mensajeError);
                    session.setAttribute("datos", null);
                    response.sendRedirect("../Vista/listadoClientes.jsp"); // Redirigir para mostrar el mensaje
                }
            } catch (Exception e) {
                mensajeError = "Error inesperado en md_listarClientes.jsp: " + e.getMessage();
                System.err.println("md_listarClientes.jsp ERROR: " + mensajeError);
                e.printStackTrace();
                session.setAttribute("datos", null);
                response.sendRedirect("../Vista/listadoClientes.jsp"); // Redirigir para mostrar el mensaje
            } finally {
                // Asegúrate de cerrar la conexión si se abrió
                if (c != null) {
                    c.cerrarConexion();
                    System.out.println("md_listarClientes.jsp: Conexión cerrada en finally.");
                }
            }
        %>
    </body>
</html>