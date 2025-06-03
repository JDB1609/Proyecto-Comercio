}<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.OwnerLocal" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%--
    Document   : ct_eliminarOwner.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Procesa la confirmación de eliminación (desactivación) de un propietario.
--%>

<%
    boolean operacionExitosa = false;
    String mensajeResultado = null;
    Conexion c = null;

    try {
        String cedulaOwnerAEliminar = request.getParameter("cedulaOwner");
        String confirmacion = request.getParameter("confirmacion");

        // Debug:
        System.out.println("ct_eliminarOwner.jsp: Cédula recibida para desactivar: " + cedulaOwnerAEliminar);
        System.out.println("ct_eliminarOwner.jsp: Confirmación recibida: " + confirmacion);

        // --- Validación de Datos y Confirmación ---
        if (cedulaOwnerAEliminar == null || cedulaOwnerAEliminar.trim().isEmpty() ||
            confirmacion == null || !"true".equals(confirmacion)) {
            throw new IllegalArgumentException("No se proporcionó la cédula del propietario o la confirmación es inválida.");
        }

        // --- Conexión a la Base de Datos y Actualización del Estado ---
        c = new Conexion();
        System.out.println("ct_eliminarOwner.jsp: Estado de conexión: " + c.estaConectado()); 

        if (!c.estaConectado()) {
            mensajeResultado = "Error de conexión a la base de datos: " + c.getMensaje();
        } else {
            // Columnas a actualizar
            ArrayList<String> columnNames = new ArrayList<>();
            columnNames.add("estado"); 

            // Valores para actualizar (cambiar estado a 0 = inactivo)
            ArrayList<Object> values = new ArrayList<>();
            values.add(0); // 0 para inactivo

            // Condición para la actualización (por cedulaOwner)
            String condicionSQLTemplate = "cedulaOwner = ?"; 
            ArrayList<Object> condicionParams = new ArrayList<>();
            condicionParams.add(cedulaOwnerAEliminar); 
            
            System.out.println("ct_eliminarOwner.jsp: Llamando a c.actualizar() para desactivar propietario: " + cedulaOwnerAEliminar); 
            if (c.actualizar("owner_local", columnNames, values, condicionSQLTemplate, condicionParams)) {
                operacionExitosa = true;
                mensajeResultado = "El propietario con cédula '" + cedulaOwnerAEliminar + "' ha sido **desactivado** exitosamente.";
                System.out.println("ct_eliminarOwner.jsp: Desactivación exitosa."); 
            } else {
                operacionExitosa = false;
                mensajeResultado = "Error al desactivar el propietario en la base de datos: " + c.getMensaje();
                System.err.println("ct_eliminarOwner.jsp: Falló la desactivación. Mensaje de conexión: " + c.getMensaje()); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
        System.err.println("ct_eliminarOwner.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado durante la desactivación: " + e.getMessage();
        System.err.println("ct_eliminarOwner.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (c != null) {
            c.cerrarConexion();
            System.out.println("ct_eliminarOwner.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("operacionExitosa", operacionExitosa); 
    request.setAttribute("mensajeResultado", mensajeResultado);
    System.out.println("ct_eliminarOwner.jsp: Atributos 'operacionExitosa' y 'mensajeResultado' establecidos en el request."); 

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Modelo/md_eliminarOwner.jsp");
    dispatcher.forward(request, response);
%>