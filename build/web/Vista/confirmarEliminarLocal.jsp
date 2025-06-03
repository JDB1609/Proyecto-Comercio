<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="utils.Local" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Confirmar Desactivación de Local</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f8f9fa; }
            .card { margin-top: 50px; max-width: 600px; }
        </style>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow text-center">
                <h3 class="mb-4">Confirmar Desactivación de Local</h3>

                <% 
                    Local localEncontrado = (Local) request.getAttribute("localEncontrado");
                    String mensajeBusqueda = (String) request.getAttribute("mensajeBusqueda");

                    if (mensajeBusqueda != null) { %>
                        <div class="alert alert-info" role="alert">
                            <%= mensajeBusqueda %>
                        </div>
                <%  }

                    if (localEncontrado != null) { %>
                        <div class="alert alert-warning" role="alert">
                            <strong>¡Atención!</strong> Estás a punto de desactivar el siguiente local. ¿Estás seguro?
                        </div>
                        <ul class="list-group mb-4 text-start">
                            <li class="list-group-item"><strong>Nombre:</strong> <%= localEncontrado.getNombreLocal() %></li>
                            <li class="list-group-item"><strong>Tipo:</strong> <%= localEncontrado.getTipoLocal() %></li>
                            <li class="list-group-item"><strong>Dirección:</strong> <%= localEncontrado.getDireccionLocal() %></li>
                            <li class="list-group-item"><strong>Horario:</strong> <%= localEncontrado.getHorario() %></li>
                            <li class="list-group-item"><strong>Teléfono:</strong> <%= localEncontrado.getTelefonoLocal() %></li>
                            <li class="list-group-item"><strong>Descripción:</strong> <%= localEncontrado.getDescripcion() %></li>
                            <li class="list-group-item"><strong>Estado Actual:</strong> <%= localEncontrado.getEstado() == 1 ? "Activo" : "Inactivo" %></li>
                        </ul>

                        <form action="../Control/ct_eliminarLocal.jsp" method="post">
                            <input type="hidden" name="nombreLocal" value="<%= localEncontrado.getNombreLocal() %>">
                            <input type="hidden" name="confirmacion" value="true">
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-danger btn-lg">Sí, Desactivar Local</button>
                                <a href="formEliminarLocal.jsp" class="btn btn-secondary mt-2">Cancelar</a>
                            </div>
                        </form>
                <% } else { %>
                    <div class="alert alert-danger" role="alert">
                        No se encontraron datos para confirmar la desactivación. Por favor, regresa y busca nuevamente.
                    </div>
                    <a href="formEliminarLocal.jsp" class="btn btn-primary mt-3">Volver al Formulario de Búsqueda</a>
                <% } %>
            </div>
        </div>
    </body>
</html>