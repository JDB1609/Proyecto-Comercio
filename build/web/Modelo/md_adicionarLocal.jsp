<%--
    Document   : md_adicionarLocal.jsp
    Created on : 23/05/2025
    Author     : Daniel
    Purpose    : Muestra el resultado del proceso de registro de local.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="utils.Local" %> <%-- ¡Importa tu clase Local para poder usarla! --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultado del Registro de Local</title>
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
                    <h2 class="text-center mb-4">Estado del Registro de Local</h2>

                    <jsp:useBean id="nuevoLocal" class="utils.Local" scope="request"/>
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
                            <p><strong>Nombre del Local:</strong> ${nuevoLocal.nombreLocal}</p>
                            <p><strong>Tipo de Local:</strong> ${nuevoLocal.tipoLocal}</p>
                            <p><strong>Dirección:</strong> ${nuevoLocal.direccionLocal}</p>
                            <p><strong>Horario:</strong> ${nuevoLocal.horario}</p>
                            <p><strong>Teléfono:</strong> ${nuevoLocal.telefonoLocal}</p>
                            <p><strong>Descripción:</strong> ${nuevoLocal.descripcion}</p>
                            <p><strong>Estado:</strong> ${nuevoLocal.estado == 1 ? "Activo" : "Inactivo"}</p>
                        </div>
                    <% } else { %>
                        <div class="alert alert-danger" role="alert">
                            <h4 class="alert-heading">Error en el Registro</h4>
                            <p><%= mensajeResultado != null ? mensajeResultado : "No se pudo registrar el local. Verifique los datos e intente de nuevo." %></p>
                            <p>Si el problema persiste, contacte al administrador.</p>
                        </div>
                    <% } %>

                    <div class="d-grid mt-3">
                        <a href="../formLocal.jsp" class="btn btn-secondary">Volver al Formulario de Local</a>
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