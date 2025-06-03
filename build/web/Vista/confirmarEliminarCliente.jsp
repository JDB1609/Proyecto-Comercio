<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="utils.Cliente" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Confirmar Desactivación de Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f8f9fa; }
            .card { margin-top: 50px; max-width: 600px; }
        </style>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow text-center">
                <h3 class="mb-4">Confirmar Desactivación de Cliente</h3>

                <% 
                    Cliente clienteEncontrado = (Cliente) request.getAttribute("clienteEncontrado");
                    String mensajeBusqueda = (String) request.getAttribute("mensajeBusqueda");

                    if (mensajeBusqueda != null) { %>
                        <div class="alert alert-info" role="alert">
                            <%= mensajeBusqueda %>
                        </div>
                <%  }

                    if (clienteEncontrado != null) { %>
                        <div class="alert alert-warning" role="alert">
                            <strong>¡Atención!</strong> Estás a punto de desactivar al siguiente cliente. ¿Estás seguro?
                        </div>
                        <ul class="list-group mb-4 text-start">
                            <li class="list-group-item"><strong>Cédula:</strong> <%= clienteEncontrado.getCedulaCliente() %></li>
                            <li class="list-group-item"><strong>Nombre:</strong> <%= clienteEncontrado.getNombreCliente() %></li>
                            <li class="list-group-item"><strong>Apellido:</strong> <%= clienteEncontrado.getApellidoCliente() %></li>
                            <li class="list-group-item"><strong>Correo:</strong> <%= clienteEncontrado.getCorreoCliente() %></li>
                            <li class="list-group-item"><strong>Teléfono:</strong> <%= clienteEncontrado.getNumeroCliente() %></li>
                            <li class="list-group-item"><strong>Dirección:</strong> <%= clienteEncontrado.getDireccionCliente() %></li>
                            <li class="list-group-item"><strong>Estado Actual:</strong> <%= clienteEncontrado.getEstado() == 1 ? "Activo" : "Inactivo" %></li>
                        </ul>

                        <form action="../Control/ct_eliminarCliente.jsp" method="post">
                            <input type="hidden" name="cedulaCliente" value="<%= clienteEncontrado.getCedulaCliente() %>">
                            <input type="hidden" name="confirmacion" value="true">
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-danger btn-lg">Sí, Desactivar Cliente</button>
                                <a href="formEliminarCliente.jsp" class="btn btn-secondary mt-2">Cancelar</a>
                            </div>
                        </form>
                <% } else { %>
                    <div class="alert alert-danger" role="alert">
                        No se encontraron datos para confirmar la desactivación. Por favor, regresa y busca nuevamente.
                    </div>
                    <a href="formEliminarCliente.jsp" class="btn btn-primary mt-3">Volver al Formulario de Búsqueda</a>
                <% } %>
            </div>
        </div>
    </body>
</html>