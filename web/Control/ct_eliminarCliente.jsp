<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Cliente" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%--
    Document   : ct_eliminarCliente.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Procesa la confirmación de eliminación (desactivación) de un cliente.
--%>

<%
    boolean operacionExitosa = false;
    String mensajeResultado = null;
    Conexion c = null;

    try {
        String cedulaClienteAEliminar = request.getParameter("cedulaCliente");
        String confirmacion = request.getParameter("confirmacion");

        // Debug:
        System.out.println("ct_eliminarCliente.jsp: Cédula recibida para desactivar: " + cedulaClienteAEliminar);
        System.out.println("ct_eliminarCliente.jsp: Confirmación recibida: " + confirmacion);

        if (cedulaClienteAEliminar == null || cedulaClienteAEliminar.trim().isEmpty() ||
            confirmacion == null || !"true".equals(confirmacion)) {
            throw new IllegalArgumentException("No se proporcionó la cédula del cliente o la confirmación es inválida.");
        }

        c = new Conexion();
        System.out.println("ct_eliminarCliente.jsp: Estado de conexión: " + c.estaConectado()); 

        if (!c.estaConectado()) {
            mensajeResultado = "Error de conexión a la base de datos: " + c.getMensaje();
        } else {
            ArrayList<String> columnNames = new ArrayList<>();
            columnNames.add("estado"); 

            ArrayList<Object> values = new ArrayList<>();
            values.add(0); // 0 para inactivo

            String condicionSQLTemplate = "cedulaCliente = ?"; 
            ArrayList<Object> condicionParams = new ArrayList<>();
            condicionParams.add(cedulaClienteAEliminar); 
            
            System.out.println("ct_eliminarCliente.jsp: Llamando a c.actualizar() para desactivar cliente: " + cedulaClienteAEliminar); 
            if (c.actualizar("clientes", columnNames, values, condicionSQLTemplate, condicionParams)) {
                operacionExitosa = true;
                mensajeResultado = "El cliente con cédula '" + cedulaClienteAEliminar + "' ha sido **desactivado** exitosamente.";
                System.out.println("ct_eliminarCliente.jsp: Desactivación exitosa."); 
            } else {
                operacionExitosa = false;
                mensajeResultado = "Error al desactivar el cliente en la base de datos: " + c.getMensaje();
                System.err.println("ct_eliminarCliente.jsp: Falló la desactivación. Mensaje de conexión: " + c.getMensaje()); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
        System.err.println("ct_eliminarCliente.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado durante la desactivación: " + e.getMessage();
        System.err.println("ct_eliminarCliente.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (c != null) {
            c.cerrarConexion();
            System.out.println("ct_eliminarCliente.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("operacionExitosa", operacionExitosa); 
    request.setAttribute("mensajeResultado", mensajeResultado);
    System.out.println("ct_eliminarCliente.jsp: Atributos 'operacionExitosa' y 'mensajeResultado' establecidos en el request."); 

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Modelo/md_eliminarCliente.jsp");
    dispatcher.forward(request, response);
%>