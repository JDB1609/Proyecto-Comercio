<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="utils.Cliente" %>
>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Actualizar Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f8f9fa; }
            .card { margin-top: 50px; max-width: 600px; }
            .form-section { border: 1px solid #e9ecef; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
        </style>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow">
                <h3 class="text-center mb-4">Actualizar Datos del Cliente</h3>

                <%-- Mensaje de error/éxito si viene de ct_actualizarCliente.jsp o ct_buscarCliente.jsp --%>
                <% String mensaje = (String) request.getAttribute("mensajeResultado"); // Desde ct_actualizarCliente.jsp
                   Boolean exito = (Boolean) request.getAttribute("operacionExitosa"); // Desde ct_actualizarCliente.jsp
                   String mensajeBusqueda = (String) request.getAttribute("mensajeBusqueda"); // Desde ct_buscarCliente.jsp

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
                    // Intentar recuperar el cliente si fue enviado por ct_buscarCliente.jsp
                    Cliente clienteEncontrado = (Cliente) request.getAttribute("clienteEncontrado");
                    
                    // Si el formulario se envía por GET (búsqueda), recuperamos la cédula para pre-llenar el campo de búsqueda
                    String cedulaBuscada = request.getParameter("cedulaBuscar");
                    if (cedulaBuscada == null && clienteEncontrado != null) {
                        cedulaBuscada = clienteEncontrado.getCedulaCliente(); // Si el cliente se encontró, usa su cédula
                    } else if (cedulaBuscada == null) {
                        cedulaBuscada = ""; // Valor por defecto si no hay búsqueda previa
                    }
                %>

                <%-- Formulario para buscar cliente --%>
                <div class="form-section">
                    <h5 class="mb-3">Buscar Cliente por Cédula</h5>
                    <form action="../Control/ct_buscarCliente.jsp" method="get">
                        <div class="mb-3">
                            <label for="cedulaBuscar" class="form-label">Cédula del Cliente:</label>
                            <input type="text" class="form-control" id="cedulaBuscar" name="cedulaBuscar" required value="<%= cedulaBuscada %>">
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-info">Buscar Cliente</button>
                        </div>
                    </form>
                </div>

                <%-- Formulario de actualización (visible solo si se encontró un cliente) --%>
                <% if (clienteEncontrado != null) { %>
                    <div class="form-section mt-4">
                        <h5 class="mb-3">Datos del Cliente (<%= clienteEncontrado.getCedulaCliente() %>)</h5>
                        <form action="../Control/ct_actualizarCliente.jsp" method="post">
                            <div class="mb-3">
                                <label for="cedulaCliente" class="form-label">Cédula</label>
                                <input type="text" class="form-control" id="cedulaCliente" name="cedulaCliente" value="<%= clienteEncontrado.getCedulaCliente() %>" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="nombreCliente" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombreCliente" name="nombreCliente" value="<%= clienteEncontrado.getNombreCliente() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="apellidoCliente" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellidoCliente" name="apellidoCliente" value="<%= clienteEncontrado.getApellidoCliente() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="correoCliente" class="form-label">Correo</label>
                                <input type="email" class="form-control" id="correoCliente" name="correoCliente" value="<%= clienteEncontrado.getCorreoCliente() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="passwordCliente" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="passwordCliente" name="passwordCliente" value="<%= clienteEncontrado.getPasswordCliente() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="numeroCliente" class="form-label">Número de Contacto</label>
                                <input type="text" class="form-control" id="numeroCliente" name="numeroCliente" value="<%= clienteEncontrado.getNumeroCliente() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="direccionCliente" class="form-label">Dirección</label>
                                <input type="text" class="form-control" id="direccionCliente" name="direccionCliente" value="<%= clienteEncontrado.getDireccionCliente() %>" required>
                            </div>
                             <div class="mb-3">
                                <label for="estado" class="form-label">Estado</label>
                                <select class="form-select" id="estado" name="estado">
                                    <option value="1" <%= clienteEncontrado.getEstado() == 1 ? "selected" : "" %>>Activo</option>
                                    <option value="0" <%= clienteEncontrado.getEstado() == 0 ? "selected" : "" %>>Inactivo</option>
                                </select>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Actualizar Cliente</button>
                            </div>
                        </form>
                    </div>
                <% } else if (mensajeBusqueda != null && !mensajeBusqueda.contains("Cliente encontrado")) { %>
                    <%-- Mostrar mensaje de "no encontrado" solo si no se encontró y hay un mensaje de búsqueda --%>
                    <div class="alert alert-warning mt-4" role="alert">
                        <%= mensajeBusqueda %>
                    </div>
                <% } %>
            </div>
        </div>
    </body>
</html>