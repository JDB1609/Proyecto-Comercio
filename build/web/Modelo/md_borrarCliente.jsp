<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Resultado de Desactivación de Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .card {
                max-width: 500px;
                width: 100%;
                padding: 30px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                border-radius: 8px;
            }
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border-color: #c3e6cb;
            }
            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border-color: #f5c6cb;
            }
        </style>
    </head>
    <body>
        <div class="card shadow text-center">
            <%
                boolean operacionExitosa = (Boolean) request.getAttribute("operacionExitosa");
                String mensajeResultado = (String) request.getAttribute("mensajeResultado");
                String alertClass = operacionExitosa ? "alert-success" : "alert-danger";
            %>
            <h3 class="mb-4">Resultado de la Desactivación</h3>
            <div class="alert <%= alertClass %>" role="alert">
                <%= mensajeResultado %>
            </div>
            <div class="d-grid gap-2 mt-3">
                <a href="../Vista/borrarCliente.jsp" class="btn btn-secondary">Desactivar otro cliente</a>
                <a href="../Vista/menuAdmin.jsp" class="btn btn-primary">Volver al Menú Administrador</a>
            </div>
        </div>
    </body>
</html>