<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Cliente" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%--
    Document   : ct_buscarCliente.jsp
    Created on : (Tu fecha de creación)
    Author     : (Tu nombre)
    Purpose    : Busca un cliente por cédula y lo envía a la vista para mostrar/editar.
--%>

<%
    String cedulaBuscar = request.getParameter("cedulaBuscar"); 
    System.out.println("ct_buscarCliente.jsp: Cédula recibida para buscar: " + cedulaBuscar); // Debug

    Cliente clienteEncontrado = null;
    String mensajeResultado = null;
    Conexion conexion = null; 

    try {
        if (cedulaBuscar == null || cedulaBuscar.trim().isEmpty()) {
            throw new IllegalArgumentException("La cédula de búsqueda no puede estar vacía.");
        }

        conexion = new Conexion();
        System.out.println("ct_buscarCliente.jsp: Estado de conexión: " + conexion.estaConectado()); // Debug

        if (!conexion.estaConectado()) {
            mensajeResultado = "Error de conexión a la base de datos: " + conexion.getMensaje();
        } else {
            String[] datosClienteArray = conexion.consultaFila("clientes", "cedulaCliente", cedulaBuscar);
            System.out.println("ct_buscarCliente.jsp: Resultado de consultaFila para " + cedulaBuscar + ": " + (datosClienteArray != null ? String.join(", ", datosClienteArray) : "null")); // Debug

            if (datosClienteArray != null && datosClienteArray.length >= 8) { // Asegura que el array tiene suficientes elementos
                int estadoCliente = 0; 

                if (datosClienteArray[7] != null && !datosClienteArray[7].trim().isEmpty()) {
                    try {
                        estadoCliente = Integer.parseInt(datosClienteArray[7]);
                    } catch (NumberFormatException e) {
                        System.err.println("Advertencia: No se pudo parsear el estadoCliente '" + datosClienteArray[7] + "' a entero para cédula " + cedulaBuscar + ". Usando valor por defecto (0). Error: " + e.getMessage());
                        estadoCliente = 0; 
                    }
                } else {
                    System.err.println("Advertencia: EstadoCliente para cédula " + cedulaBuscar + " es nulo/vacío. Usando valor por defecto (0).");
                    estadoCliente = 0; 
                }

                clienteEncontrado = new Cliente(
                    datosClienteArray[0], 
                    datosClienteArray[1], 
                    datosClienteArray[2], 
                    datosClienteArray[3], 
                    datosClienteArray[4], 
                    datosClienteArray[5], 
                    datosClienteArray[6], 
                    estadoCliente         
                );
                mensajeResultado = "Cliente encontrado.";
                System.out.println("ct_buscarCliente.jsp: Cliente encontrado y objeto Cliente creado: " + clienteEncontrado.getNombreCliente()); // Debug
            } else {
                mensajeResultado = "No se encontró ningún cliente con la cédula: " + cedulaBuscar + ". (O los datos están incompletos)";
                System.out.println("ct_buscarCliente.jsp: Cliente NO encontrado o datos incompletos para cédula: " + cedulaBuscar); // Debug
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
        System.err.println("ct_buscarCliente.jsp: Error de validación: " + e.getMessage()); // Debug
        e.printStackTrace();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado al buscar el cliente: " + e.getMessage();
        System.err.println("ct_buscarCliente.jsp: Error inesperado: " + e.getMessage()); // Debug
        e.printStackTrace();
    } finally {
        if (conexion != null) {
            conexion.cerrarConexion();
            System.out.println("ct_buscarCliente.jsp: Conexión cerrada."); // Debug
        }
    }

    request.setAttribute("clienteEncontrado", clienteEncontrado);
    request.setAttribute("mensajeBusqueda", mensajeResultado);
    System.out.println("ct_buscarCliente.jsp: Atributos 'clienteEncontrado' y 'mensajeBusqueda' establecidos en el request."); // Debug

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Vista/actualizarCliente.jsp");
    dispatcher.forward(request, response);
%>