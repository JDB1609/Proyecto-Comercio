<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.OwnerLocal" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%--
    Document   : ct_buscarOwner.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Busca un propietario por cédula y lo envía a la vista para mostrar/editar.
--%>

<%
    String cedulaOwnerBuscar = request.getParameter("cedulaOwnerBuscar"); 
    System.out.println("ct_buscarOwner.jsp: Cédula de propietario recibida para buscar: " + cedulaOwnerBuscar); 

    OwnerLocal ownerEncontrado = null;
    String mensajeResultado = null;
    Conexion conexion = null; 

    try {
        if (cedulaOwnerBuscar == null || cedulaOwnerBuscar.trim().isEmpty()) {
            throw new IllegalArgumentException("La cédula del propietario es obligatoria para la búsqueda.");
        }

        conexion = new Conexion();
        System.out.println("ct_buscarOwner.jsp: Estado de conexión: " + conexion.estaConectado());

        if (!conexion.estaConectado()) {
            mensajeResultado = "Error de conexión a la base de datos: " + conexion.getMensaje();
        } else {
            // La tabla es 'owner_local' y la columna de búsqueda es 'cedulaOwner'
            // El orden de las columnas en la DB es: cedulaOwner, nombreOwner, apellidoOwner, correoOwner, passwordOwner, telefonoOwner, estado
            // Asegúrate que tu método consultaFila en Conexion.java devuelva las columnas en este orden para 'owner_local'
            String[] datosOwnerArray = conexion.consultaFila("owner_local", "cedulaOwner", cedulaOwnerBuscar);
            System.out.println("ct_buscarOwner.jsp: Resultado de consultaFila para " + cedulaOwnerBuscar + ": " + (datosOwnerArray != null ? String.join(", ", datosOwnerArray) : "null")); 

            // Asegúrate que datosOwnerArray tenga suficientes elementos para tu constructor de OwnerLocal (7 propiedades)
            if (datosOwnerArray != null && datosOwnerArray.length >= 7) { 
                int estadoOwner = 0; 
                // El estado está en la posición 6 (7mo elemento)
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
                    estadoOwner         // estado (índice 6)
                );
                mensajeResultado = "Propietario encontrado.";
                System.out.println("ct_buscarOwner.jsp: Propietario encontrado y objeto OwnerLocal creado: " + ownerEncontrado.getNombreOwner()); 
            } else {
                mensajeResultado = "No se encontró ningún propietario con la cédula: " + cedulaOwnerBuscar + ". (O los datos están incompletos)";
                System.out.println("ct_buscarOwner.jsp: Propietario NO encontrado o datos incompletos para cédula: " + cedulaOwnerBuscar); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
        System.err.println("ct_buscarOwner.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado al buscar el propietario: " + e.getMessage();
        System.err.println("ct_buscarOwner.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (conexion != null) {
            conexion.cerrarConexion();
            System.out.println("ct_buscarOwner.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("ownerEncontrado", ownerEncontrado);
    request.setAttribute("mensajeBusqueda", mensajeResultado);
    System.out.println("ct_buscarOwner.jsp: Atributos 'ownerEncontrado' y 'mensajeBusqueda' establecidos en el request."); 

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Vista/actualizarOwnerLocal.jsp");
    dispatcher.forward(request, response);
%>