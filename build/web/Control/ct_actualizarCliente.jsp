<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Cliente" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%--
    Document   : ct_actualizarCliente.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Procesa los datos del formulario de actualización, actualiza en la DB y reenvía a la vista de resultado.
--%>

<jsp:useBean id="clienteActualizado" class="utils.Cliente" scope="request">
    <jsp:setProperty name="clienteActualizado" property="cedulaCliente" param="cedulaCliente"/>
    <jsp:setProperty name="clienteActualizado" property="nombreCliente" param="nombreCliente"/>
    <jsp:setProperty name="clienteActualizado" property="apellidoCliente" param="apellidoCliente"/>
    <jsp:setProperty name="clienteActualizado" property="correoCliente" param="correoCliente"/>
    <jsp:setProperty name="clienteActualizado" property="passwordCliente" param="passwordCliente"/>
    <jsp:setProperty name="clienteActualizado" property="numeroCliente" param="numeroCliente"/>
    <jsp:setProperty name="clienteActualizado" property="direccionCliente" param="direccionCliente"/>
    <jsp:setProperty name="clienteActualizado" property="estado" param="estado"/> 
</jsp:useBean>

<%
    boolean actualizacionExitosa = false;
    String mensajeResultado = null;
    Conexion c = null;

    try {
        // Debug: Imprimir los datos recibidos del formulario
        System.out.println("ct_actualizarCliente.jsp: Datos recibidos para actualizar:");
        System.out.println("  Cédula: " + clienteActualizado.getCedulaCliente());
        System.out.println("  Nombre: " + clienteActualizado.getNombreCliente());
        System.out.println("  Correo: " + clienteActualizado.getCorreoCliente());
        System.out.println("  Estado: " + clienteActualizado.getEstado());


        // --- Validación de Datos Obligatorios ---
        if (clienteActualizado.getCedulaCliente() == null || clienteActualizado.getCedulaCliente().trim().isEmpty() ||
            clienteActualizado.getNombreCliente() == null || clienteActualizado.getNombreCliente().trim().isEmpty() ||
            clienteActualizado.getCorreoCliente() == null || clienteActualizado.getCorreoCliente().trim().isEmpty() ||
            clienteActualizado.getPasswordCliente() == null || clienteActualizado.getPasswordCliente().trim().isEmpty()) {
            throw new IllegalArgumentException("Los campos de Cédula, Nombre, Correo y Contraseña son obligatorios.");
        }

        // --- Conexión a la Base de Datos y Actualización ---
        c = new Conexion();
        System.out.println("ct_actualizarCliente.jsp: Estado de conexión: " + c.estaConectado()); // Debug

        if (!c.estaConectado()) {
            mensajeResultado = "Error de conexión a la base de datos: " + c.getMensaje();
        } else {
            // Nombres de las columnas a actualizar
            ArrayList<String> columnNames = new ArrayList<>();
            columnNames.add("nombreCliente");
            columnNames.add("apellidoCliente");
            columnNames.add("correoCliente");
            columnNames.add("passwordCliente");
            columnNames.add("numeroCliente");
            columnNames.add("direccionCliente");
            columnNames.add("estado");

            ArrayList<Object> values = new ArrayList<>();
            values.add(clienteActualizado.getNombreCliente());
            values.add(clienteActualizado.getApellidoCliente());
            values.add(clienteActualizado.getCorreoCliente());
            values.add(clienteActualizado.getPasswordCliente());
            values.add(clienteActualizado.getNumeroCliente());
            values.add(clienteActualizado.getDireccionCliente());
            values.add(clienteActualizado.getEstado());

            String condicionSQLTemplate = "cedulaCliente = ?"; 
            ArrayList<Object> condicionParams = new ArrayList<>();
            condicionParams.add(clienteActualizado.getCedulaCliente()); 
            
            System.out.println("ct_actualizarCliente.jsp: Llamando a c.actualizar() para cédula: " + clienteActualizado.getCedulaCliente()); // Debug
            if (c.actualizar("clientes", columnNames, values, condicionSQLTemplate, condicionParams)) {
                actualizacionExitosa = true;
                mensajeResultado = "El cliente ha sido actualizado exitosamente.";
                System.out.println("ct_actualizarCliente.jsp: Actualización exitosa."); // Debug
            } else {
                actualizacionExitosa = false;
                mensajeResultado = "Error al actualizar el cliente en la base de datos: " + c.getMensaje();
                System.err.println("ct_actualizarCliente.jsp: Falló la actualización. Mensaje de conexión: " + c.getMensaje()); // Debug
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
        System.err.println("ct_actualizarCliente.jsp: Error de validación: " + e.getMessage()); // Debug
        e.printStackTrace();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado durante la actualización: " + e.getMessage();
        System.err.println("ct_actualizarCliente.jsp: Error inesperado: " + e.getMessage()); // Debug
        e.printStackTrace();
    } finally {
        if (c != null) {
            c.cerrarConexion();
            System.out.println("ct_actualizarCliente.jsp: Conexión cerrada."); // Debug
        }
    }

    request.setAttribute("operacionExitosa", actualizacionExitosa); 
    request.setAttribute("mensajeResultado", mensajeResultado);
    System.out.println("ct_actualizarCliente.jsp: Atributos 'operacionExitosa' y 'mensajeResultado' establecidos en el request."); // Debug

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Modelo/md_actualizarCliente.jsp");
    dispatcher.forward(request, response);
%>