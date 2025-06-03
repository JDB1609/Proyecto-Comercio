<%--
    Document   : md_adicionarCliente
    Created on : 6/05/2025, 1:30:04 p. m.
    Author     : danie
    Purpose    : Muestra el resultado del proceso de registro de cliente.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="utils.Cliente" %> <%-- Necesario para acceder al bean Cliente --%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Resultado del Registro de Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../Styles/estilosFormularios.css">
        <style>
            .success-message {
                color: green;
                font-weight: bold;
            }
            .error-message {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="container min-vh-100 d-flex justify-content-center align-items-center">
                <div class="col-md-8 col-lg-7">
                    <div class="card p-4 shadow">
                        <h2 class="text-center mb-4">Estado del Registro de Cliente</h2>

                      
                        <jsp:useBean id="nuevoCliente" class="utils.Cliente" scope="request"/>
                        <%
                            Boolean registroExitoso = (Boolean) request.getAttribute("registroExitoso");
                            String mensajeResultado = (String) request.getAttribute("mensajeResultado");
                        %>

                        <%-- Muestra el mensaje de éxito o error --%>
                        <% if (registroExitoso != null && registroExitoso.booleanValue()) { %>
                            <div class="alert alert-success" role="alert">
                                <h4 class="alert-heading">¡Registro Exitoso!</h4>
                                <p><%= mensajeResultado %></p>
                                <hr>
                                <p><strong>Cédula:</strong> ${nuevoCliente.cedulaCliente}</p>
                                <p><strong>Nombre Completo:</strong> ${nuevoCliente.nombreCliente} ${nuevoCliente.apellidoCliente}</p>
                                <p><strong>Correo:</strong> ${nuevoCliente.correoCliente}</p>
                                <p><strong>Teléfono:</strong> ${nuevoCliente.numeroCliente}</p>
                                <p><strong>Dirección:</strong> ${nuevoCliente.direccionCliente}</p>
                                <p><strong>Estado:</strong> ${nuevoCliente.estadoCliente == 1 ? "Activo" : "Inactivo"}</p>
                            </div>
                        <% } else { %>
                            <div class="alert alert-danger" role="alert">
                                <h4 class="alert-heading">Error en el Registro</h4>
                                <p><%= mensajeResultado != null ? mensajeResultado : "No se pudo registrar el cliente. Verifique los datos e intente de nuevo." %></p>
                                <p>Si el problema persiste, contacte al administrador.</p>
                            </div>
                        <% } %>

                        <div class="d-grid mt-3">
                            <a href="../registroCliente.jsp" class="btn btn-secondary">Volver al Formulario</a>
                            <% if (registroExitoso != null && registroExitoso.booleanValue()) { %>
                                <a href="../Vista/PaginaPrincipal.jsp" class="btn btn-primary mt-2">Ir a la Página Principal</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>