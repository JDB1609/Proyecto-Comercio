<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="utils.OwnerLocal" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Confirmar Desactivación de Propietario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f8f9fa; }
            .card { margin-top: 50px; max-width: 600px; }
        </style>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow text-center">
                <h3 class="mb-4">Confirmar Desactivación de Propietario</h3>

                <% 
                    OwnerLocal ownerEncontrado = (OwnerLocal) request.getAttribute("ownerEncontrado");
                    String mensajeBusqueda = (String) request.getAttribute("mensajeBusqueda");

                    if (mensajeBusqueda != null) { %>
                        <div class="alert alert-info" role="alert">
                            <%= mensajeBusqueda %>
                        </div>
                <%  }

                    if (ownerEncontrado != null) { %>
                        <div class="alert alert-warning" role="alert">
                            <strong>¡Atención!</strong> Estás a punto de desactivar al siguiente propietario. ¿Estás seguro?
                        </div>
                        <ul class="list-group mb-4 text-start">
                            <li class="list-group-item"><strong>Cédula:</strong> <%= ownerEncontrado.getCedulaOwner() %></li>
                            <li class="list-group-item"><strong>Nombre:</strong> <%= ownerEncontrado.getNombreOwner() %></li>
                            <li class="list-group-item"><strong>Apellido:</strong> <%= ownerEncontrado.getApellidoOwner() %></li>
                            <li class="list-group-item"><strong>Correo:</strong> <%= ownerEncontrado.getCorreoOwner() %></li>
                            <li class="list-group-item"><strong>Teléfono:</strong> <%= ownerEncontrado.getTelefonoOwner() %></li>
                            <li class="list-group-item"><strong>Estado Actual:</strong> <%= ownerEncontrado.getEstado() == 1 ? "Activo" : "Inactivo" %></li>
                        </ul>

                        <form action="../Control/ct_eliminarOwner.jsp" method="post">
                            <input type="hidden" name="cedulaOwner" value="<%= ownerEncontrado.getCedulaOwner() %>">
                            <input type="hidden" name="confirmacion" value="true">
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-danger btn-lg">Sí, Desactivar Propietario</button>
                                <a href="borrarOwner.jsp" class="btn btn-secondary mt-2">Cancelar</a>
                            </div>
                        </form>
                <% } else { %>
                    <div class="alert alert-danger" role="alert">
                        No se encontraron datos para confirmar la desactivación. Por favor, regresa y busca nuevamente.
                    </div>
                    <a href="borrarOwner.jsp" class="btn btn-primary mt-3">Volver al Formulario de Búsqueda</a>
                <% } %>
            </div>
        </div>
    </body>
</html>