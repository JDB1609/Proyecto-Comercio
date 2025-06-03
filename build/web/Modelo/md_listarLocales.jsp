<%@page import="utils.Conexion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Obteniendo Listado de Locales...</title>
    </head>
    <body>
        <%
            // --- INICIO CÓDIGO DEPURACIÓN CRÍTICA ---
            System.out.println("*************** md_listarLocales.jsp HA EMPEZADO A EJECUTARSE ***************");
            // --- FIN CÓDIGO DEPURACIÓN CRÍTICA ---

            Conexion c = null; // Se inicializa a null
            ArrayList<String[]> listaLocales = null;
            String mensajeError = null;

            try {
                c = new Conexion(); // Se crea el objeto Conexion DENTRO del try
                System.out.println("md_listarLocales.jsp: Objeto Conexion creado.");

                // Intentar conectar a la base de datos
                if (c.conectarMySQL()) { // Llamar directamente a conectarMySQL
                    System.out.println("md_listarLocales.jsp: Conexión a MySQL exitosa.");

                    // Consultar los locales activos
                    // Asegúrate de que tu método consultarRegistrosActivos pueda manejar "locales"
                    // y que las columnas sean las esperadas (nombreLocal, tipoLocal, direccionLocal, horario, telefonoLocal, descripcion, estado)
                    listaLocales = c.consultarRegistrosActivos("locales");

                    if (listaLocales != null && !listaLocales.isEmpty()) {
                        // --- INICIO CÓDIGO DEPURACIÓN ---
                        System.out.println("md_listarLocales.jsp: Tamaño de listaLocales: " + listaLocales.size() + " filas.");
                        if (listaLocales.size() > 0) {
                            String[] primerLocal = listaLocales.get(0);
                            System.out.println("md_listarLocales.jsp: Datos del primer local: ");
                            for (int i = 0; i < primerLocal.length; i++) {
                                System.out.println("  Columna " + i + ": " + primerLocal[i]);
                            }
                        }
                        // --- FIN CÓDIGO DEPURACIÓN ---
                        
                        // Convertir ArrayList<String[]> a String[][]
                        String[][] datos = new String[listaLocales.size()][];
                        for (int i = 0; i < listaLocales.size(); i++) {
                            datos[i] = listaLocales.get(i);
                        }

                        session.setAttribute("datosLocales", datos); // Usamos "datosLocales" para no confundir con "datos" de clientes
                        System.out.println("md_listarLocales.jsp: 'datosLocales' guardado en sesión.");
                        response.sendRedirect("../Vista/listadoLocales.jsp");
                    } else {
                        mensajeError = "La consulta no devolvió locales activos o la lista está vacía.";
                        System.out.println("md_listarLocales.jsp: " + mensajeError);
                        session.setAttribute("datosLocales", null); // Asegurarse de que no haya datos previos
                        response.sendRedirect("../Vista/listadoLocales.jsp"); // Redirigir para mostrar el mensaje
                    }
                } else {
                    mensajeError = "No se pudo establecer la conexión a la base de datos para locales: " + c.getMensaje();
                    System.out.println("md_listarLocales.jsp: " + mensajeError);
                    session.setAttribute("datosLocales", null);
                    response.sendRedirect("../Vista/listadoLocales.jsp"); // Redirigir para mostrar el mensaje
                }
            } catch (Exception e) {
                mensajeError = "Error inesperado en md_listarLocales.jsp: " + e.getMessage();
                System.err.println("md_listarLocales.jsp ERROR: " + mensajeError);
                e.printStackTrace();
                session.setAttribute("datosLocales", null);
                response.sendRedirect("../Vista/listadoLocales.jsp"); // Redirigir para mostrar el mensaje
            } finally {
                // Asegúrate de cerrar la conexión si se abrió
                if (c != null) {
                    c.cerrarConexion();
                    System.out.println("md_listarLocales.jsp: Conexión cerrada en finally.");
                }
            }
        %>
    </body>
</html>