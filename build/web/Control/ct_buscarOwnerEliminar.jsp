<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.OwnerLocal" %>
<%@ page import="utils.Conexion" %>
<%@ page import="javax.servlet.RequestDispatcher" %>
<%@ page import="java.sql.SQLException" %>

<%--
    Document   : ct_buscarOwnerEliminar.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Busca un propietario por cédula y lo envía a la vista de confirmación de eliminación.
--%>

<%
    String cedulaOwnerBuscar = request.getParameter("cedulaOwnerBuscar"); 
    System.out.println("ct_buscarOwnerEliminar.jsp: Cédula recibida para buscar y eliminar: " + cedulaOwnerBuscar); 

    OwnerLocal ownerEncontrado = null;
    String mensajeBusqueda = null;
    Conexion conexion = null; 

    try {
        if (cedulaOwnerBuscar == null || cedulaOwnerBuscar.trim().isEmpty()) {
            throw new IllegalArgumentException("La cédula del propietario es obligatoria para la búsqueda.");
        }

        conexion = new Conexion();
        System.out.println("ct_buscarOwnerEliminar.jsp: Estado de conexión: " + conexion.estaConectado());

        if (!conexion.estaConectado()) {
            mensajeBusqueda = "Error de conexión a la base de datos: " + conexion.getMensaje();
        } else {
            // Reutilizamos consultaFila, que ya está configurada para 'owner_local'
            String[] datosOwnerArray = conexion.consultaFila("owner_local", "cedulaOwner", cedulaOwnerBuscar);
            System.out.println("ct_buscarOwnerEliminar.jsp: Resultado de consultaFila para " + cedulaOwnerBuscar + ": " + (datosOwnerArray != null ? String.join(", ", datosOwnerArray) : "null")); 

            if (datosOwnerArray != null && datosOwnerArray.length >= 7) { 
                int estadoOwner = 0; 
                if (datosOwnerArray[6] != null && !datosOwnerArray[6].trim().isEmpty()) { 
                    try {
                        estadoOwner = Integer.parseInt(datosOwnerArray[6]);
                    } catch (NumberFormatException e) {
                        System.err.println("Advertencia: No se pudo parsear el estado '" + datosOwnerArray[6] + "' a entero para propietario " + cedulaOwnerBuscar + ". Usando valor por defecto (0). Error: " + e.getMessage());
                        estadoOwner = 0; 
                    }
                } else {
                    System.err.println("Advertencia: Estado para propietario " + cedulaOwnerBuscar + " es nulo/vacío. Usando valor por defecto (0).");
                    estadoOwner = 0; 
                }

                ownerEncontrado = new OwnerLocal(
                    datosOwnerArray[0], // cedulaOwner
                    datosOwnerArray[1], // nombreOwner
                    datosOwnerArray[2], // apellidoOwner
                    datosOwnerArray[3], // correoOwner
                    datosOwnerArray[4], // passwordOwner
                    datosOwnerArray[5], // telefonoOwner
                    estadoOwner         // estado
                );
                mensajeBusqueda = "Propietario encontrado. Por favor, confirma la desactivación.";
                System.out.println("ct_buscarOwnerEliminar.jsp: Propietario encontrado y objeto OwnerLocal creado: " + ownerEncontrado.getNombreOwner()); 
            } else {
                mensajeBusqueda = "No se encontró ningún propietario con la cédula: " + cedulaOwnerBuscar + ".";
                System.out.println("ct_buscarOwnerEliminar.jsp: Propietario NO encontrado para cédula: " + cedulaOwnerBuscar); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeBusqueda = "Error de validación: " + e.getMessage();
        System.err.println("ct_buscarOwnerEliminar.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeBusqueda = "Ocurrió un error inesperado al buscar el propietario: " + e.getMessage();
        System.err.println("ct_buscarOwnerEliminar.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (conexion != null) {
            conexion.cerrarConexion();
            System.out.println("ct_buscarOwnerEliminar.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("ownerEncontrado", ownerEncontrado);
    request.setAttribute("mensajeBusqueda", mensajeBusqueda); 
    
    // Siempre redirigimos a la página de confirmación, incluso si no se encontró
    RequestDispatcher dispatcher = request.getRequestDispatcher("../Vista/confirmarEliminarOwner.jsp");
    dispatcher.forward(request, response);
%>