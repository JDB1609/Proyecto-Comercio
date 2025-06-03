<%--
    Document   : ct_adicionarLocal.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Procesa los datos del formulario de registro de local,
                 crea un objeto Local, inserta en la DB y reenvía a la vista de resultado.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Local" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>


<jsp:useBean id="nuevoLocal" class="utils.Local" scope="request">
    <jsp:setProperty name="nuevoLocal" property="nombreLocal" param="nombreLocal"/>
    <jsp:setProperty name="nuevoLocal" property="tipoLocal" param="tipoLocal"/>
    <jsp:setProperty name="nuevoLocal" property="direccionLocal" param="direccionLocal"/>
    <jsp:setProperty name="nuevoLocal" property="horario" param="horario"/>
    <jsp:setProperty name="nuevoLocal" property="telefonoLocal" param="telefonoLocal"/>
    <jsp:setProperty name="nuevoLocal" property="descripcion" param="descripcion"/>
    <jsp:setProperty name="nuevoLocal" property="estado" value="1"/>
</jsp:useBean>

<%
    boolean registroExitoso = false;
    String mensajeResultado = null;
    Conexion c = null; // Declara la conexión fuera del try para cerrarla en finally

    try {
       
        if (nuevoLocal.getNombreLocal() == null || nuevoLocal.getNombreLocal().trim().isEmpty() ||
            nuevoLocal.getTipoLocal() == null || nuevoLocal.getTipoLocal().trim().isEmpty() ||
            nuevoLocal.getDireccionLocal() == null || nuevoLocal.getDireccionLocal().trim().isEmpty() ||
            nuevoLocal.getHorario() == null || nuevoLocal.getHorario().trim().isEmpty() ||
            nuevoLocal.getTelefonoLocal() == null || nuevoLocal.getTelefonoLocal().trim().isEmpty()) {
            throw new IllegalArgumentException("Todos los campos obligatorios deben ser completados (Nombre, Tipo, Dirección, Horario, Teléfono).");
        }

        
        c = new Conexion(); // El constructor ahora intenta conectar

        
        if (!c.estaConectado()) {
            registroExitoso = false;
            mensajeResultado = "Error de conexión a la base de datos: " + c.getMensaje();
        } else {
         
            ArrayList<String> columnNames = new ArrayList<>();
            columnNames.add("nombreLocal");
            columnNames.add("tipoLocal");
            columnNames.add("direccionLocal");
            columnNames.add("horario");
            columnNames.add("telefonoLocal");
            columnNames.add("descripcion");
            columnNames.add("estado");

           
            ArrayList<Object> values = new ArrayList<>();
            values.add(nuevoLocal.getNombreLocal());
            values.add(nuevoLocal.getTipoLocal());
            values.add(nuevoLocal.getDireccionLocal());
            values.add(nuevoLocal.getHorario());
            values.add(nuevoLocal.getTelefonoLocal());
            values.add(nuevoLocal.getDescripcion());
            values.add(nuevoLocal.getEstado()); 

            if (c.insertar("locales", columnNames, values)) {
                registroExitoso = true;
                mensajeResultado = "El local ha sido registrado exitosamente.";
            } else {
                registroExitoso = false;
                mensajeResultado = "Error al registrar el local en la base de datos: " + c.getMensaje();
            }
        }

    } catch (IllegalArgumentException e) {
        registroExitoso = false;
        mensajeResultado = "Error de validación: " + e.getMessage();
    } catch (Exception e) {
        registroExitoso = false;
        mensajeResultado = "Ocurrió un error inesperado durante el registro del local: " + e.getMessage();
        e.printStackTrace();
    } finally {
        
        if (c != null) {
            c.cerrarConexion(); 
        }
    }

    request.setAttribute("registroExitoso", registroExitoso);
    request.setAttribute("mensajeResultado", mensajeResultado);

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Modelo/md_adicionarLocal.jsp");
    dispatcher.forward(request, response);
%>