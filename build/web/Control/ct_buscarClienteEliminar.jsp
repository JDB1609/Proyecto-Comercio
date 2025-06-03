<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Cliente" %>
<%@ page import="utils.Conexion" %>
<%@ page import="javax.servlet.RequestDispatcher" %>
<%@ page import="java.sql.SQLException" %>

<%--
    Document   : ct_buscarClienteEliminar.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Busca un cliente por cédula y lo envía a la vista de confirmación de eliminación.
--%>

<%
    String cedulaClienteBuscar = request.getParameter("cedulaCliente"); 
    System.out.println("ct_buscarClienteEliminar.jsp: Cédula recibida para buscar y eliminar: " + cedulaClienteBuscar); 

    Cliente clienteEncontrado = null;
    String mensajeBusqueda = null;
    Conexion conexion = null; 

    try {
        if (cedulaClienteBuscar == null || cedulaClienteBuscar.trim().isEmpty()) {
            throw new IllegalArgumentException("La cédula del cliente es obligatoria para la búsqueda.");
        }

        conexion = new Conexion();
        System.out.println("ct_buscarClienteEliminar.jsp: Estado de conexión: " + conexion.estaConectado());

        if (!conexion.estaConectado()) {
            mensajeBusqueda = "Error de conexión a la base de datos: " + conexion.getMensaje();
        } else {
            // Reutilizamos consultaFila, que ya está configurada para 'clientes' (con SELECT *)
            String[] datosClienteArray = conexion.consultaFila("clientes", "cedulaCliente", cedulaClienteBuscar);
            System.out.println("ct_buscarClienteEliminar.jsp: Resultado de consultaFila para " + cedulaClienteBuscar + ": " + (datosClienteArray != null ? String.join(", ", datosClienteArray) : "null")); 

            // Asegúrate que datosClienteArray tenga suficientes elementos para tu constructor de Cliente (8 propiedades)
            if (datosClienteArray != null && datosClienteArray.length >= 8) { 
                int estado = 0; 
                // El estado está en la posición 7 (8vo elemento)
                if (datosClienteArray[7] != null && !datosClienteArray[7].trim().isEmpty()) { 
                    try {
                        estado = Integer.parseInt(datosClienteArray[7]);
                    } catch (NumberFormatException e) {
                        System.err.println("Advertencia: No se pudo parsear el estadoCliente '" + datosClienteArray[7] + "' a entero para cédula " + cedulaClienteBuscar + ". Usando valor por defecto (0). Error: " + e.getMessage());
                        estado = 0; 
                    }
                } else {
                    System.err.println("Advertencia: EstadoCliente para cédula " + cedulaClienteBuscar + " es nulo/vacío. Usando valor por defecto (0).");
                    estado = 0; 
                }

                clienteEncontrado = new Cliente(
                    datosClienteArray[0], // cedulaCliente
                    datosClienteArray[1], // nombreCliente
                    datosClienteArray[2], // apellidoCliente
                    datosClienteArray[3], // correoCliente
                    datosClienteArray[4], // passwordCliente
                    datosClienteArray[5], // numeroCliente
                    datosClienteArray[6], // direccionCliente
                    estado        // estadoCliente
                );
                mensajeBusqueda = "Cliente encontrado. Por favor, confirma la desactivación.";
                System.out.println("ct_buscarClienteEliminar.jsp: Cliente encontrado y objeto Cliente creado: " + clienteEncontrado.getNombreCliente()); 
            } else {
                mensajeBusqueda = "No se encontró ningún cliente con la cédula: " + cedulaClienteBuscar + ".";
                System.out.println("ct_buscarClienteEliminar.jsp: Cliente NO encontrado para cédula: " + cedulaClienteBuscar); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeBusqueda = "Error de validación: " + e.getMessage();
        System.err.println("ct_buscarClienteEliminar.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeBusqueda = "Ocurrió un error inesperado al buscar el cliente: " + e.getMessage();
        System.err.println("ct_buscarClienteEliminar.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (conexion != null) {
            conexion.cerrarConexion();
            System.out.println("ct_buscarClienteEliminar.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("clienteEncontrado", clienteEncontrado);
    request.setAttribute("mensajeBusqueda", mensajeBusqueda); 
    
    // Siempre redirigimos a la página de confirmación, incluso si no se encontró
    RequestDispatcher dispatcher = request.getRequestDispatcher("../Vista/confirmarEliminarCliente.jsp");
    dispatcher.forward(request, response);
%>