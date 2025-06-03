<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="utils.OwnerLocal" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Actualizar Propietario de Local</title>
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
                <h3 class="text-center mb-4">Actualizar Datos del Propietario</h3>

                <%-- Mensajes de resultado --%>
                <% 
                   String mensaje = (String) request.getAttribute("mensajeResultado"); 
                   Boolean exito = (Boolean) request.getAttribute("operacionExitosa"); 
                   String mensajeBusqueda = (String) request.getAttribute("mensajeBusqueda"); 

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
                    // Recuperar el objeto OwnerLocal si fue enviado por ct_buscarOwner.jsp
                    OwnerLocal ownerEncontrado = (OwnerLocal) request.getAttribute("ownerEncontrado");
                    
                    // Pre-llenar el campo de búsqueda si ya se hizo una búsqueda
                    String cedulaOwnerBuscada = request.getParameter("cedulaOwnerBuscar");
                    if (cedulaOwnerBuscada == null && ownerEncontrado != null) {
                        cedulaOwnerBuscada = ownerEncontrado.getCedulaOwner(); 
                    } else if (cedulaOwnerBuscada == null) {
                        cedulaOwnerBuscada = ""; 
                    }
                %>

                <%-- Formulario para buscar propietario --%>
                <div class="form-section">
                    <h5 class="mb-3">Buscar Propietario por Cédula</h5>
                    <form action="../Control/ct_buscarOwnerLocal.jsp" method="get">
                        <div class="mb-3">
                            <label for="cedulaOwnerBuscar" class="form-label">Cédula del Propietario:</label>
                            <input type="text" class="form-control" id="cedulaOwnerBuscar" name="cedulaOwnerBuscar" required value="<%= cedulaOwnerBuscada %>">
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-info">Buscar Propietario</button>
                        </div>
                    </form>
                </div>

               
                <% if (ownerEncontrado != null) { %>
                    <div class="form-section mt-4">
                        <h5 class="mb-3">Datos del Propietario (<%= ownerEncontrado.getCedulaOwner() %>)</h5>
                        <form action="../Control/ct_actualizarOwnerLocal.jsp" method="post">
                            <div class="mb-3">
                                <label for="cedulaOwner" class="form-label">Cédula</label>
                                <input type="text" class="form-control" id="cedulaOwner" name="cedulaOwner" value="<%= ownerEncontrado.getCedulaOwner() %>" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="nombreOwner" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombreOwner" name="nombreOwner" value="<%= ownerEncontrado.getNombreOwner() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="apellidoOwner" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellidoOwner" name="apellidoOwner" value="<%= ownerEncontrado.getApellidoOwner() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="correoOwner" class="form-label">Correo</label>
                                <input type="email" class="form-control" id="correoOwner" name="correoOwner" value="<%= ownerEncontrado.getCorreoOwner() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="passwordOwner" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="passwordOwner" name="passwordOwner" value="<%= ownerEncontrado.getPasswordOwner() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="telefonoOwner" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="telefonoOwner" name="telefonoOwner" value="<%= ownerEncontrado.getTelefonoOwner() %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="estado" class="form-label">Estado</label>
                                <select class="form-select" id="estado" name="estado">
                                    <option value="1" <%= ownerEncontrado.getEstado() == 1 ? "selected" : "" %>>Activo</option>
                                    <option value="0" <%= ownerEncontrado.getEstado() == 0 ? "selected" : "" %>>Inactivo</option>
                                </select>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Actualizar Propietario</button>
                            </div>
                        </form>
                    </div>
                <% } else if (mensajeBusqueda != null && !mensajeBusqueda.contains("Propietario encontrado")) { %>
                    <div class="alert alert-warning mt-4" role="alert">
                        <%= mensajeBusqueda %>
                    </div>
                <% } %>
            </div>
        </div>
    </body>
</html>