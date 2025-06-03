<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Error de Inicio de Sesión</title>
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
                max-width: 400px;
                width: 100%;
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <div class="card shadow">
            <h3 class="text-center text-danger mb-4">¡Error de Inicio de Sesión!</h3>
            <%
                String mensajeError = (String) request.getAttribute("mensajeError");
                if (mensajeError == null || mensajeError.isEmpty()) {
                    mensajeError = "Credenciales incorrectas o problema en el servidor. Inténtalo de nuevo.";
                }
            %>
            <div class="alert alert-danger" role="alert">
                <%= mensajeError %>
            </div>
            <div class="text-center">
                <a href="login.jsp" class="btn btn-primary mt-3">Volver al Inicio de Sesión</a>
            </div>
        </div>
    </body>
</html>