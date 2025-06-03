<%@page import="utils.Cliente"%>
<%@page import="utils.OwnerLocal"%>
<%@page import="utils.Conexion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.servlet.RequestDispatcher"%>

<%
    String tipoUsuario = request.getParameter("tipoUsuario");
    String correo = request.getParameter("correo");
    String password = request.getParameter("password");

    Conexion conexion = null;
    String paginaRedireccion = "../Vista/errorLogin.jsp";
    String mensajeError = "Usuario o contraseña incorrectos.";

    try {
        conexion = new Conexion();

        if (!conexion.estaConectado()) {
            mensajeError = "No se pudo conectar a la base de datos: " + conexion.getMensaje();
        } else {
            if ("cliente".equals(tipoUsuario)) {
                String sqlCliente = "SELECT cedulaCliente, nombreCliente, apellidoCliente, correoCliente, passwordCliente, numeroCliente, direccionCliente FROM clientes WHERE correoCliente = ? AND passwordCliente = ?";
                ArrayList<Object> paramsCliente = new ArrayList<>();
                paramsCliente.add(correo);
                paramsCliente.add(password);

                String[][] resultadoCliente = conexion.consultaMatriz(sqlCliente, paramsCliente);

                if (resultadoCliente != null && resultadoCliente.length > 0) {
                    Cliente cliente = new Cliente();
                    cliente.setCedulaCliente(resultadoCliente[0][0]);
                    cliente.setNombreCliente(resultadoCliente[0][1]);
                    cliente.setApellidoCliente(resultadoCliente[0][2]);
                    cliente.setCorreoCliente(resultadoCliente[0][3]);
                    cliente.setPasswordCliente(resultadoCliente[0][4]);
                    cliente.setNumeroCliente(resultadoCliente[0][5]);
                    cliente.setDireccionCliente(resultadoCliente[0][6]);

                    request.getSession().setAttribute("usuario", cliente);
                    paginaRedireccion = "../Vista/menuCliente.jsp";
                } else {
                    mensajeError = "Correo o contraseña de cliente incorrectos.";
                }
            }
            else if ("dueno".equals(tipoUsuario)) {
                String sqlOwner = "SELECT cedulaOwner, nombreOwner, apellidoOwner, correoOwner, passwordOwner, telefonoOwner FROM owner_local WHERE correoOwner = ? AND passwordOwner = ?";
                ArrayList<Object> paramsOwner = new ArrayList<>();
                paramsOwner.add(correo);
                paramsOwner.add(password);

                String[][] resultadoOwner = conexion.consultaMatriz(sqlOwner, paramsOwner);

                if (resultadoOwner != null && resultadoOwner.length > 0) {
                    OwnerLocal owner = new OwnerLocal();
                    owner.setCedulaOwner(resultadoOwner[0][0]);
                    owner.setNombreOwner(resultadoOwner[0][1]);
                    owner.setApellidoOwner(resultadoOwner[0][2]);
                    owner.setCorreoOwner(resultadoOwner[0][3]);
                    owner.setPasswordOwner(resultadoOwner[0][4]);
                    owner.setTelefonoOwner(resultadoOwner[0][5]);

                    request.getSession().setAttribute("usuario", owner);
                    paginaRedireccion = "../Vista/menuOwner.jsp";
                } else {
                    mensajeError = "Correo o contraseña de dueño incorrectos.";
                }
            }
            else if ("admin".equals(tipoUsuario)) {
                if ("admin@gmail.com".equals(correo) && "admin".equals(password)) {
                    request.getSession().setAttribute("usuario", "admin");
                    paginaRedireccion = "../Vista/menuAdmin.jsp";
                } else {
                    mensajeError = "Correo o contraseña de administrador incorrectos.";
                }
            }
            else {
                mensajeError = "Tipo de usuario no válido.";
            }
        }
    } catch (Exception e) {
        mensajeError = "Ocurrió un error inesperado durante el login: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if (conexion != null) {
            conexion.cerrarConexion();
        }
    }

    if (!paginaRedireccion.equals("../Vista/errorLogin.jsp")) {
        response.sendRedirect(paginaRedireccion);
    } else {
        request.setAttribute("mensajeError", mensajeError);
        RequestDispatcher dispatcher = request.getRequestDispatcher(paginaRedireccion);
        dispatcher.forward(request, response);
    }
%>