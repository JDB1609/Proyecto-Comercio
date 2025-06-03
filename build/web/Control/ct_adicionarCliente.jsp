<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Cliente" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.util.ArrayList" %>

<jsp:useBean id="nuevoCliente" class="utils.Cliente" scope="request">
    <jsp:setProperty name="nuevoCliente" property="cedulaCliente" param="cedulaCliente"/>
    <jsp:setProperty name="nuevoCliente" property="nombreCliente" param="nombreCliente"/>
    <jsp:setProperty name="nuevoCliente" property="apellidoCliente" param="apellidoCliente"/>
    <jsp:setProperty name="nuevoCliente" property="correoCliente" param="correoCliente"/>
    <jsp:setProperty name="nuevoCliente" property="passwordCliente" param="passwordCliente"/>
    <jsp:setProperty name="nuevoCliente" property="numeroCliente" param="numeroCliente"/>
    <jsp:setProperty name="nuevoCliente" property="direccionCliente" param="direccion"/>
    <jsp:setProperty name="nuevoCliente" property="estado" value="1"/>
</jsp:useBean>

<%
    boolean registroExitoso = false;
    String mensajeResultado = null;
    Conexion c = null;

    try {
        if (nuevoCliente.getCedulaCliente() == null || nuevoCliente.getCedulaCliente().trim().isEmpty() ||
            nuevoCliente.getNombreCliente() == null || nuevoCliente.getNombreCliente().trim().isEmpty() ||
            nuevoCliente.getCorreoCliente() == null || nuevoCliente.getCorreoCliente().trim().isEmpty() ||
            nuevoCliente.getPasswordCliente() == null || nuevoCliente.getPasswordCliente().trim().isEmpty() ||
            nuevoCliente.getDireccionCliente() == null || nuevoCliente.getDireccionCliente().trim().isEmpty()) {
            throw new IllegalArgumentException("Todos los campos obligatorios deben ser completados (Cédula, Nombre, Correo, Contraseña, Dirección).");
        }

        c = new Conexion();

        if (!c.estaConectado()) {
            registroExitoso = false;
            mensajeResultado = "Error de conexión a la base de datos: " + c.getMensaje();
        } else {
            ArrayList<String> columnNames = new ArrayList<>();
            columnNames.add("cedulaCliente");
            columnNames.add("nombreCliente");
            columnNames.add("apellidoCliente");
            columnNames.add("correoCliente");
            columnNames.add("passwordCliente");
            columnNames.add("numeroCliente");
            columnNames.add("direccionCliente");
            columnNames.add("estado");

            ArrayList<Object> values = new ArrayList<>();
            values.add(nuevoCliente.getCedulaCliente());
            values.add(nuevoCliente.getNombreCliente());
            values.add(nuevoCliente.getApellidoCliente());
            values.add(nuevoCliente.getCorreoCliente());
            values.add(nuevoCliente.getPasswordCliente());
            values.add(nuevoCliente.getNumeroCliente());
            values.add(nuevoCliente.getDireccionCliente());
            values.add(nuevoCliente.getEstado());

            if (c.insertar("clientes", columnNames, values)) {
                registroExitoso = true;
                mensajeResultado = "El cliente ha sido registrado exitosamente.";
            } else {
                registroExitoso = false;
                mensajeResultado = "Error al registrar el cliente en la base de datos: " + c.getMensaje();
            }
        }

    } catch (IllegalArgumentException e) {
        registroExitoso = false;
        mensajeResultado = "Error de validación: " + e.getMessage();
    } catch (Exception e) {
        registroExitoso = false;
        mensajeResultado = "Ocurrió un error inesperado durante el registro: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if (c != null) {
            c.cerrarConexion();
        }
    }

    request.setAttribute("registroExitoso", registroExitoso);
    request.setAttribute("mensajeResultado", mensajeResultado);

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Modelo/md_adicionarCliente.jsp");
    dispatcher.forward(request, response);
%>