<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.OwnerLocal" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%--
    Document   : ct_actualizarOwner.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Procesa los datos del formulario de actualización de un propietario, actualiza en la DB y reenvía a la vista de resultado.
--%>

<jsp:useBean id="ownerActualizado" class="utils.OwnerLocal" scope="request">
    <jsp:setProperty name="ownerActualizado" property="cedulaOwner" param="cedulaOwner"/>
    <jsp:setProperty name="ownerActualizado" property="nombreOwner" param="nombreOwner"/>
    <jsp:setProperty name="ownerActualizado" property="apellidoOwner" param="apellidoOwner"/>
    <jsp:setProperty name="ownerActualizado" property="correoOwner" param="correoOwner"/>
    <jsp:setProperty name="ownerActualizado" property="passwordOwner" param="passwordOwner"/>
    <jsp:setProperty name="ownerActualizado" property="telefonoOwner" param="telefonoOwner"/>
    <jsp:setProperty name="ownerActualizado" property="estado" param="estado"/> 
</jsp:useBean>

<%
    boolean actualizacionExitosa = false;
    String mensajeResultado = null;
    Conexion c = null;

    try {
        // Debug: Imprimir los datos recibidos del formulario
        System.out.println("ct_actualizarOwnerLocal.jsp: Datos recibidos para actualizar:");
        System.out.println("  Cédula: " + ownerActualizado.getCedulaOwner());
        System.out.println("  Nombre: " + ownerActualizado.getNombreOwner());
        System.out.println("  Correo: " + ownerActualizado.getCorreoOwner());
        System.out.println("  Estado: " + ownerActualizado.getEstado());


        // --- Validación de Datos Obligatorios ---
        if (ownerActualizado.getCedulaOwner() == null || ownerActualizado.getCedulaOwner().trim().isEmpty() ||
            ownerActualizado.getNombreOwner() == null || ownerActualizado.getNombreOwner().trim().isEmpty() ||
            ownerActualizado.getCorreoOwner() == null || ownerActualizado.getCorreoOwner().trim().isEmpty() ||
            ownerActualizado.getPasswordOwner() == null || ownerActualizado.getPasswordOwner().trim().isEmpty()) {
            throw new IllegalArgumentException("Los campos de Cédula, Nombre, Correo y Contraseña son obligatorios.");
        }

        // --- Conexión a la Base de Datos y Actualización ---
        c = new Conexion();
        System.out.println("ct_actualizarOwnerLocal.jsp: Estado de conexión: " + c.estaConectado()); 

        if (!c.estaConectado()) {
            mensajeResultado = "Error de conexión a la base de datos: " + c.getMensaje();
        } else {
            ArrayList<String> columnNames = new ArrayList<>();
            columnNames.add("nombreOwner");
            columnNames.add("apellidoOwner");
            columnNames.add("correoOwner");
            columnNames.add("passwordOwner");
            columnNames.add("telefonoOwner");
            columnNames.add("estado"); 

            // Valores para actualizar (el ORDEN debe coincidir con columnNames)
            ArrayList<Object> values = new ArrayList<>();
            values.add(ownerActualizado.getNombreOwner());
            values.add(ownerActualizado.getApellidoOwner());
            values.add(ownerActualizado.getCorreoOwner());
            values.add(ownerActualizado.getPasswordOwner());
            values.add(ownerActualizado.getTelefonoOwner());
            values.add(ownerActualizado.getEstado()); 

            // Condición para la actualización (por cedulaOwner)
            String condicionSQLTemplate = "cedulaOwner = ?"; 
            ArrayList<Object> condicionParams = new ArrayList<>();
            condicionParams.add(ownerActualizado.getCedulaOwner()); 
            
            System.out.println("ct_actualizarOwner.jsp: Llamando a c.actualizar() para propietario: " + ownerActualizado.getCedulaOwner()); 
            if (c.actualizar("owner_local", columnNames, values, condicionSQLTemplate, condicionParams)) {
                actualizacionExitosa = true;
                mensajeResultado = "El propietario con cédula '" + ownerActualizado.getCedulaOwner() + "' ha sido actualizado exitosamente.";
                System.out.println("ct_actualizarOwner.jsp: Actualización exitosa."); 
            } else {
                actualizacionExitosa = false;
                mensajeResultado = "Error al actualizar el propietario en la base de datos: " + c.getMensaje();
                System.err.println("ct_actualizarOwner.jsp: Falló la actualización. Mensaje de conexión: " + c.getMensaje()); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
        System.err.println("ct_actualizarOwnerLocal.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado durante la actualización: " + e.getMessage();
        System.err.println("ct_actualizarOwnerLocal.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (c != null) {
            c.cerrarConexion();
            System.out.println("ct_actualizarOwnerLocal.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("operacionExitosa", actualizacionExitosa); 
    request.setAttribute("mensajeResultado", mensajeResultado);
    System.out.println("ct_actualizarOwnerLocal.jsp: Atributos 'operacionExitosa' y 'mensajeResultado' establecidos en el request."); 

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Modelo/md_actualizarOwnerLocal.jsp");
    dispatcher.forward(request, response);
%>