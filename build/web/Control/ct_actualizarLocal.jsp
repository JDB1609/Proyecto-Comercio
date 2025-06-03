<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Local" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%--
    Document   : ct_actualizarLocal.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Procesa los datos del formulario de actualización de un local, actualiza en la DB y reenvía a la vista de resultado.
--%>

<jsp:useBean id="localActualizado" class="utils.Local" scope="request">
    <jsp:setProperty name="localActualizado" property="nombreLocal" param="nombreLocal"/>
    <jsp:setProperty name="localActualizado" property="tipoLocal" param="tipoLocal"/>
    <jsp:setProperty name="localActualizado" property="direccionLocal" param="direccionLocal"/>
    <jsp:setProperty name="localActualizado" property="horario" param="horario"/>
    <jsp:setProperty name="localActualizado" property="telefonoLocal" param="telefonoLocal"/>
    <jsp:setProperty name="localActualizado" property="descripcion" param="descripcion"/>
    <jsp:setProperty name="localActualizado" property="estado" param="estado"/> 
</jsp:useBean>

<%
    boolean actualizacionExitosa = false;
    String mensajeResultado = null;
    Conexion c = null;

    try {
        // Debug: Imprimir los datos recibidos del formulario
        System.out.println("ct_actualizarLocal.jsp: Datos recibidos para actualizar:");
        System.out.println("  Nombre Local: " + localActualizado.getNombreLocal());
        System.out.println("  Tipo Local: " + localActualizado.getTipoLocal());
        System.out.println("  Estado: " + localActualizado.getEstado());


        // --- Validación de Datos Obligatorios ---
        if (localActualizado.getNombreLocal() == null || localActualizado.getNombreLocal().trim().isEmpty() ||
            localActualizado.getTipoLocal() == null || localActualizado.getTipoLocal().trim().isEmpty() ||
            localActualizado.getDireccionLocal() == null || localActualizado.getDireccionLocal().trim().isEmpty()) {
            throw new IllegalArgumentException("Los campos de Nombre, Tipo y Dirección del Local son obligatorios.");
        }

        // --- Conexión a la Base de Datos y Actualización ---
        c = new Conexion();
        System.out.println("ct_actualizarLocal.jsp: Estado de conexión: " + c.estaConectado()); 

        if (!c.estaConectado()) {
            mensajeResultado = "Error de conexión a la base de datos: " + c.getMensaje();
        } else {
            // Nombres de las columnas a actualizar
            ArrayList<String> columnNames = new ArrayList<>();
            columnNames.add("tipoLocal");
            columnNames.add("direccionLocal");
            columnNames.add("horario");
            columnNames.add("telefonoLocal");
            columnNames.add("descripcion");
            columnNames.add("estado"); 

            // Valores para actualizar 
            ArrayList<Object> values = new ArrayList<>();
            values.add(localActualizado.getTipoLocal());
            values.add(localActualizado.getDireccionLocal());
            values.add(localActualizado.getHorario());
            values.add(localActualizado.getTelefonoLocal());
            values.add(localActualizado.getDescripcion());
            values.add(localActualizado.getEstado()); 

            String condicionSQLTemplate = "nombreLocal = ?"; 
            ArrayList<Object> condicionParams = new ArrayList<>();
            condicionParams.add(localActualizado.getNombreLocal()); 
            
            System.out.println("ct_actualizarLocal.jsp: Llamando a c.actualizar() para local: " + localActualizado.getNombreLocal()); 
            if (c.actualizar("locales", columnNames, values, condicionSQLTemplate, condicionParams)) {
                actualizacionExitosa = true;
                mensajeResultado = "El local '" + localActualizado.getNombreLocal() + "' ha sido actualizado exitosamente.";
                System.out.println("ct_actualizarLocal.jsp: Actualización exitosa."); 
            } else {
                actualizacionExitosa = false;
                mensajeResultado = "Error al actualizar el local en la base de datos: " + c.getMensaje();
                System.err.println("ct_actualizarLocal.jsp: Falló la actualización. Mensaje de conexión: " + c.getMensaje()); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
        System.err.println("ct_actualizarLocal.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado durante la actualización: " + e.getMessage();
        System.err.println("ct_actualizarLocal.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (c != null) {
            c.cerrarConexion();
            System.out.println("ct_actualizarLocal.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("operacionExitosa", actualizacionExitosa); 
    request.setAttribute("mensajeResultado", mensajeResultado);
    System.out.println("ct_actualizarLocal.jsp: Atributos 'operacionExitosa' y 'mensajeResultado' establecidos en el request."); 

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Modelo/md_actualizarLocal.jsp");
    dispatcher.forward(request, response);
%>