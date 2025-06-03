<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Desactivar Local</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f8f9fa; }
            .card { margin-top: 50px; max-width: 500px; }
        </style>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow">
                <h3 class="text-center mb-4">Desactivar Local Comercial</h3>

                <%-- Mensajes de resultado (si viene de md_eliminarLocal.jsp) --%>
                <% 
                   String mensaje = (String) request.getAttribute("mensajeResultado");
                   Boolean exito = (Boolean) request.getAttribute("operacionExitosa");

                   if (mensaje != null) { %>
                    <div class="alert <%= (exito != null && exito) ? "alert-success" : "alert-danger" %>" role="alert">
                        <%= mensaje %>
                    </div>
                <% } %>

                <form action="../Control/ct_buscarLocalEliminar.jsp" method="get">
                    <div class="mb-3">
                        <label for="nombreLocalBuscar" class="form-label">Nombre del Local a Desactivar:</label>
                        <input type="text" class="form-control" id="nombreLocalBuscar" name="nombreLocalBuscar" required>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-warning">Buscar para Desactivar</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>