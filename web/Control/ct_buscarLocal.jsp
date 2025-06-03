<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.Local" %>
<%@ page import="utils.Conexion" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<%--
    Document   : ct_buscarLocal.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Busca un local por nombre y lo envía a la vista para mostrar/editar.
--%>

<%
    String nombreLocalBuscar = request.getParameter("nombreLocalBuscar"); 
    System.out.println("ct_buscarLocal.jsp: Nombre de local recibido para buscar: " + nombreLocalBuscar); 

    Local localEncontrado = null;
    String mensajeResultado = null;
    Conexion conexion = null; 

    try {
        if (nombreLocalBuscar == null || nombreLocalBuscar.trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del local es obligatorio para la búsqueda.");
        }

        conexion = new Conexion();
        System.out.println("ct_buscarLocal.jsp: Estado de conexión: " + conexion.estaConectado());

        if (!conexion.estaConectado()) {
            mensajeResultado = "Error de conexión a la base de datos: " + conexion.getMensaje();
        } else {
            // La consultaFila ahora seleccionará las columnas en el orden:
            // nombreLocal, tipoLocal, direccionLocal, horario, telefonoLocal, descripcion, estado
            String[] datosLocalArray = conexion.consultaFila("locales", "nombreLocal", nombreLocalBuscar);
            System.out.println("ct_buscarLocal.jsp: Resultado de consultaFila para " + nombreLocalBuscar + ": " + (datosLocalArray != null ? String.join(", ", datosLocalArray) : "null")); 

            // Asegúrate que datosLocalArray tenga suficientes elementos para tu constructor de Local (7 propiedades)
            // Ahora esperamos 7 elementos (índices 0 a 6)
            if (datosLocalArray != null && datosLocalArray.length >= 7) { 
                int estadoLocal = 0; 
                // El estado está en la posición 6 (7mo elemento)
                if (datosLocalArray[6] != null && !datosLocalArray[6].trim().isEmpty()) { 
                    try {
                        estadoLocal = Integer.parseInt(datosLocalArray[6]);
                    } catch (NumberFormatException e) {
                        System.err.println("Advertencia: No se pudo parsear el estado '" + datosLocalArray[6] + "' a entero para local " + nombreLocalBuscar + ". Usando valor por defecto (0). Error: " + e.getMessage());
                        estadoLocal = 0; 
                    }
                } else {
                    System.err.println("Advertencia: Estado para local " + nombreLocalBuscar + " es nulo/vacío. Usando valor por defecto (0).");
                    estadoLocal = 0; 
                }

                localEncontrado = new Local(
                    datosLocalArray[0], // nombreLocal
                    datosLocalArray[1], // tipoLocal
                    datosLocalArray[2], // direccionLocal
                    datosLocalArray[3], // horario
                    datosLocalArray[4], // telefonoLocal
                    datosLocalArray[5], // descripcion
                    estadoLocal         // estado (índice 6)
                );
                mensajeResultado = "Local encontrado.";
                System.out.println("ct_buscarLocal.jsp: Local encontrado y objeto Local creado: " + localEncontrado.getNombreLocal()); 
            } else {
                mensajeResultado = "No se encontró ningún local con el nombre: " + nombreLocalBuscar + ". (O los datos están incompletos)";
                System.out.println("ct_buscarLocal.jsp: Local NO encontrado o datos incompletos para nombre: " + nombreLocalBuscar); 
            }
        }

    } catch (IllegalArgumentException e) {
        mensajeResultado = "Error de validación: " + e.getMessage();
        System.err.println("ct_buscarLocal.jsp: Error de validación: " + e.getMessage()); 
        e.printStackTrace();
    } catch (Exception e) {
        mensajeResultado = "Ocurrió un error inesperado al buscar el local: " + e.getMessage();
        System.err.println("ct_buscarLocal.jsp: Error inesperado: " + e.getMessage()); 
        e.printStackTrace();
    } finally {
        if (conexion != null) {
            conexion.cerrarConexion();
            System.out.println("ct_buscarLocal.jsp: Conexión cerrada."); 
        }
    }

    request.setAttribute("localEncontrado", localEncontrado);
    request.setAttribute("mensajeBusqueda", mensajeResultado);
    System.out.println("ct_buscarLocal.jsp: Atributos 'localEncontrado' y 'mensajeBusqueda' establecidos en el request."); 

    RequestDispatcher dispatcher = request.getRequestDispatcher("../Vista/actualizarLocal.jsp");
    dispatcher.forward(request, response);
%>