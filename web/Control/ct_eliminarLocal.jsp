<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Local" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%--
    Document   : ct_eliminarLocal.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Procesa la confirmación de eliminación (desactivación) de un local.
--%>

<%
    boolean operacionExitosa = false;
    String mensajeResultado = null;
    Conexion c = null;

    try {
        String nombreLocalAEliminar = request.getParameter("nombreLocal");
        String confirmacion = request.getParameter("confirmacion");

        // Debug:
        System.out.println("ct_eliminarLocal.jsp: Nombre de local recibido para desactivar: " + nombreLocalAEliminar);
        System.out.println("ct_eliminarLocal.jsp: Confirmación recibida: " + confirmacion);

        // --- Validación de Datos y Confirmación ---
        if (nombreLocalAEliminar == null || nombreLocalAEliminar.trim().isEmpty() ||
            confirmacion == null || !"true".equals(confirmacion)) {
            throw new IllegalArgumentException("No se proporcionó el nombre del local o la confirmación es inválida.");
        }

        // --- Conexión a la Base de Datos y Actualización del Estado ---
        c = new Conexion();
        System.out.println("ct_eliminarLocal.jsp: Estado de conexión: " + c.estaConectado()); 

        if (!c.estaConectado()) {
            mensajeResultado = "Error de conexión a la base de datos: " + c.getMensaje();
        } else {
            // Columnas a actualizar
            ArrayList<String> columnNames = new ArrayList<>();
            columnNames.add("estado"); 

            // Valores para actualizar (cambiar estado a 0 = inactivo)
            ArrayList<Object> values = new ArrayList<>();
            values.add(0); // 0 para inactivo

            // Condición para la actualización (por nombreLocal)
            String condicionSQLTemplate = "nombreLocal = ?"; 
            ArrayList<Object> condicionParams = new ArrayList<>();
            condicionParams.add(nombreLocalAEliminar); 
            
            System.out.println("ct_eliminarLocal.jsp: Llamando a c.actualizar() para desactivar local: " + nombreLocalAEliminar); 
            if (c.actualizar("locales", columnNames, values, condicionSQLTemplate, condicionParams)) {
                operacionExitosa = true;
                mensajeResultado = "El local '" + nombreLocalAEliminar + "' ha sido **desactivado** exitosamente.";
                System.out.println("ct_eliminarLocal.jsp: Desactivación exitosa."); 
            } else {
                operacionExitosa = false;
                mensajeResultado = "Error al desactivar el local en la base de datos: " + c.getMensaje();
                System.err.println("ct_eliminarLocal.jsp: Falló la desactivación. Mensaje de conexión: " + c.getMensaje()); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
        System.err.println("ct_eliminarLocal.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado durante la desactivación: " + e.getMessage();
        System.err.println("ct_eliminarLocal.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (c != null) {
            c.cerrarConexion();
            System.out.println("ct_eliminarLocal.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("operacionExitosa", operacionExitosa); 
    request.setAttribute("mensajeResultado", mensajeResultado);
    System.out.println("ct_eliminarLocal.jsp: Atributos 'operacionExitosa' y 'mensajeResultado' establecidos en el request."); 

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Modelo/md_eliminarLocal.jsp");
    dispatcher.forward(request, response);
%>