<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Local" %>
<%@ page import="utils.Conexion" %>
<%@ page import="javax.servlet.RequestDispatcher" %>
<%@ page import="java.sql.SQLException" %>

<%--
    Document   : ct_buscarLocalEliminar.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Busca un local por nombre y lo envía a la vista de confirmación de eliminación.
--%>

<%
    String nombreLocalBuscar = request.getParameter("nombreLocalBuscar"); 
    System.out.println("ct_buscarLocalEliminar.jsp: Nombre de local recibido para buscar y eliminar: " + nombreLocalBuscar); 

    Local localEncontrado = null;
    String mensajeBusqueda = null;
    Conexion conexion = null; 

    try {
        if (nombreLocalBuscar == null || nombreLocalBuscar.trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del local es obligatorio para la búsqueda.");
        }

        conexion = new Conexion();
        System.out.println("ct_buscarLocalEliminar.jsp: Estado de conexión: " + conexion.estaConectado());

        if (!conexion.estaConectado()) {
            mensajeBusqueda = "Error de conexión a la base de datos: " + conexion.getMensaje();
        } else {
            // Reutilizamos consultaFila, que ya está configurada para 'locales'
            // El orden de las columnas en la DB es: nombreLocal, tipoLocal, direccionLocal, horario, telefonoLocal, descripcion, estado
            String[] datosLocalArray = conexion.consultaFila("locales", "nombreLocal", nombreLocalBuscar);
            System.out.println("ct_buscarLocalEliminar.jsp: Resultado de consultaFila para " + nombreLocalBuscar + ": " + (datosLocalArray != null ? String.join(", ", datosLocalArray) : "null")); 

            // Asegúrate que datosLocalArray tenga suficientes elementos para tu constructor de Local (7 propiedades)
            if (datosLocalArray != null && datosLocalArray.length >= 7) { 
                int estadoLocal = 0; 
                // El estado está en la posición 6 (7mo elemento)
                if (datosLocalArray[6] != null && !datosLocalArray[6].trim().isEmpty()) { 
                    try {
                        estadoLocal = Integer.parseInt(datosLocalArray[6]);
                    } catch (NumberFormatException e) {
                        System.err.println("Advertencia: No se pudo parsear el estado '" + datosLocalArray[6] + "' a entero para local " + nombreLocalBuscar + ". Usando valor por defecto (0). Error: " + e.getMessage());
                        estadoLocal = 0; 
                    }
                } else {
                    System.err.println("Advertencia: Estado para local " + nombreLocalBuscar + " es nulo/vacío. Usando valor por defecto (0).");
                    estadoLocal = 0; 
                }

                localEncontrado = new Local(
                    datosLocalArray[0], // nombreLocal
                    datosLocalArray[1], // tipoLocal
                    datosLocalArray[2], // direccionLocal
                    datosLocalArray[3], // horario
                    datosLocalArray[4], // telefonoLocal
                    datosLocalArray[5], // descripcion
                    estadoLocal         // estado
                );
                mensajeBusqueda = "Local encontrado. Por favor, confirma la desactivación.";
                System.out.println("ct_buscarLocalEliminar.jsp: Local encontrado y objeto Local creado: " + localEncontrado.getNombreLocal()); 
            } else {
                mensajeBusqueda = "No se encontró ningún local con el nombre: " + nombreLocalBuscar + ".";
                System.out.println("ct_buscarLocalEliminar.jsp: Local NO encontrado para nombre: " + nombreLocalBuscar); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeBusqueda = "Error de validación: " + e.getMessage();
        System.err.println("ct_buscarLocalEliminar.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeBusqueda = "Ocurrió un error inesperado al buscar el local: " + e.getMessage();
        System.err.println("ct_buscarLocalEliminar.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (conexion != null) {
            conexion.cerrarConexion();
            System.out.println("ct_buscarLocalEliminar.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("localEncontrado", localEncontrado);
    request.setAttribute("mensajeBusqueda", mensajeBusqueda); 
    
    // Siempre redirigimos a la página de confirmación, incluso si no se encontró
    RequestDispatcher dispatcher = request.getRequestDispatcher("../Vista/confirmarEliminarLocal.jsp");
    dispatcher.forward(request, response);
%>