<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Conexion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%
    String cedulaCliente = request.getParameter("cedulaCliente");

    boolean operacionExitosa = false;
    String mensajeResultado = null;
    Conexion c = null;    

    try {
        if (cedulaCliente == null || cedulaCliente.trim().isEmpty()) {
            throw new IllegalArgumentException("La cédula del cliente es obligatoria para la desactivación.");
        }

        c = new Conexion();    
        if (!c.estaConectado()) {    
            mensajeResultado = "Error de conexión a la base de datos: " + c.getMensaje();
        } else {
            ArrayList<String> columnNames = new ArrayList<>();
            columnNames.add("estado");

            ArrayList<Object> values = new ArrayList<>();
            values.add(0);

            String condicionSQLTemplate = "cedulaCliente = ?";    
            ArrayList<Object> condicionParams = new ArrayList<>();
            condicionParams.add(cedulaCliente);

            if (c.actualizar("clientes", columnNames, values, condicionSQLTemplate, condicionParams)) {
                operacionExitosa = true;
                mensajeResultado = "El cliente con cédula " + cedulaCliente + " ha sido desactivado exitosamente.";
            } else {
                mensajeResultado = "Error al desactivar el cliente con cédula " + cedulaCliente + ": " + c.getMensaje();
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado durante la desactivación: " + e.getMessage();
        e.printStackTrace();    
    } finally {
        if (c != null) {
            c.cerrarConexion();    
        }
    }

    request.setAttribute("operacionExitosa", operacionExitosa);
    request.setAttribute("mensajeResultado", mensajeResultado);

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Modelo/md_borrarCliente.jsp");
    dispatcher.forward(request, response);
%>
