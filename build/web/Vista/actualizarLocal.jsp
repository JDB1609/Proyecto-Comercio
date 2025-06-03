<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="utils.Local" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Actualizar Local</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f8f9fa; }
            .card { margin-top: 50px; max-width: 700px; }
            .form-section { border: 1px solid #e9ecef; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
        </style>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow">
                <h3 class="text-center mb-4">Actualizar Datos del Local</h3>

                <%-- Mensajes de resultado --%>
                <% 
                   String mensaje = (String) request.getAttribute("mensajeResultado"); // Desde ct_actualizarLocal.jsp
                   Boolean exito = (Boolean) request.getAttribute("operacionExitosa"); // Desde ct_actualizarLocal.jsp
                   String mensajeBusqueda = (String) request.getAttribute("mensajeBusqueda"); // Desde ct_buscarLocal.jsp

                   if (mensaje != null) { %>
                    <div class="alert <%= (exito != null && exito) ? "alert-success" : "alert-danger" %>" role="alert">
                        <%= mensaje %>
                    </div>
                <% } else if (mensajeBusqueda != null) { %>
                    <div class="alert alert-info" role="alert">
                        <%= mensajeBusqueda %>
                    </div>
                <% } %>

                <%
                    // Recuperar el objeto Local si fue enviado por ct_buscarLocal.jsp
                    Local localEncontrado = (Local) request.getAttribute("localEncontrado");
                    
                    // Pre-llenar el campo de búsqueda si ya se hizo una búsqueda
                    String nombreLocalBuscado = request.getParameter("nombreLocalBuscar");
                    if (nombreLocalBuscado == null && localEncontrado != null) {
                        nombreLocalBuscado = localEncontrado.getNombreLocal(); 
                    } else if (nombreLocalBuscado == null) {
                        nombreLocalBuscado = ""; 
                    }
                %>

                <%-- Formulario para buscar local --%>
                <div class="form-section">
                    <h5 class="mb-3">Buscar Local por Nombre</h5>
                    <form action="../Control/ct_buscarLocal.jsp" method="get">
                        <div class="mb-3">
                            <label for="nombreLocalBuscar" class="form-label">Nombre del Local:</label>
                            <input type="text" class="form-control" id="nombreLocalBuscar" name="nombreLocalBuscar" required value="<%= nombreLocalBuscado %>">
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-info">Buscar Local</button>
                        </div>
                    </form>
                </div>

                <%-- Formulario de actualización (visible solo si se encontró un local) --%>
                <% if (localEncontrado != null) { %>
                    <div class="form-section mt-4">
                        <h5 class="mb-3">Datos del Local (<%= localEncontrado.getNombreLocal() %>)</h5>
                        <form action="../Control/ct_actualizarLocal.jsp" method="post">
                            <div class="mb-3">
                                <label for="nombreLocal" class="form-label">Nombre del Local</label>
                                <input type="text" class="form-control" id="nombreLocal" name="nombreLocal" value="<%= localEncontrado.getNombreLocal() %>" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="tipoLocal" class="form-label">Tipo de Local</label>
                                <input type="text" class="form-control" id="tipoLocal" name="tipoLocal" value="<%= localEncontrado.getTipoLocal() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="direccionLocal" class="form-label">Dirección</label>
                                <input type="text" class="form-control" id="direccionLocal" name="direccionLocal" value="<%= localEncontrado.getDireccionLocal() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="horario" class="form-label">Horario</label>
                                <input type="text" class="form-control" id="horario" name="horario" value="<%= localEncontrado.getHorario() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="telefonoLocal" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="telefonoLocal" name="telefonoLocal" value="<%= localEncontrado.getTelefonoLocal() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="descripcion" class="form-label">Descripción</label>
                                <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required><%= localEncontrado.getDescripcion() %></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="estado" class="form-label">Estado</label>
                                <select class="form-select" id="estado" name="estado">
                                    <option value="1" <%= localEncontrado.getEstado() == 1 ? "selected" : "" %>>Activo</option>
                                    <option value="0" <%= localEncontrado.getEstado() == 0 ? "selected" : "" %>>Inactivo</option>
                                </select>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Actualizar Local</button>
                            </div>
                        </form>
                    </div>
                <% } else if (mensajeBusqueda != null && !mensajeBusqueda.contains("Local encontrado")) { %>
                    <div class="alert alert-warning mt-4" role="alert">
                        <%= mensajeBusqueda %>
                    </div>
                <% } %>
            </div>
        </div>
    </body>
</html>