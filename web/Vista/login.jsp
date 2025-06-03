<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Iniciar Sesión - Comercio Buga</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="../Styles/estilosLogin.css"> 
    </head>
    <body class="d-flex align-items-stretch"> <div class="login-container row g-0"> <div class="col-md-6 login-left-panel d-flex flex-column justify-content-center align-items-center text-center">
                <img src="../Assets/scooter_icon.png" alt="Icono de entrega" class="promo-icon mb-4"> <h1 class="promo-title mb-3">¡Descubre Buga en tus manos!</h1>
                <p class="promo-text mb-4">Regístrate hoy para explorar los mejores locales y ofertas de la ciudad.</p>
                <div class="promo-offer">
                    <p class="mb-0"><strong>¡Nuevos usuarios!</strong></p>
                    <p class="mb-0">Obtén descuentos exclusivos en tu primer pedido.</p>
                </div>
            </div>

            <div class="col-md-6 login-right-panel d-flex flex-column justify-content-center align-items-center">
                <div class="login-form-wrapper">
                    <div class="text-center mb-5">
                        <img src="../Assets/logo.png" alt="Logo Comercio Buga" class="login-logo mb-3">
                        <h2 class="login-main-title">Inicia sesión o regístrate para continuar</h2>
                    </div>

                    <form method="post" action="../Control/ct_login.jsp">
                        <div class="mb-3">
                            <label for="correo" class="form-label">Correo electrónico</label>
                            <input type="email" id="correo" name="correo" class="form-control form-control-lg" placeholder="tu@ejemplo.com" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <input type="password" id="password" name="password" class="form-control form-control-lg" placeholder="Ingresa tu contraseña" required>
                        </div>
                        <div class="mb-4">
                            <label for="tipoUsuario" class="form-label">Tipo de Usuario</label>
                            <select id="tipoUsuario" class="form-select form-select-lg" name="tipoUsuario" required>
                                <option value="">Seleccione su rol</option>
                                <option value="admin">Administrador</option>
                                <option value="cliente">Cliente</option>
                                <option value="dueno">Dueño del Local</option>
                            </select>
                        </div>

                        <div class="d-grid gap-2 mb-3">
                            <button type="submit" class="btn btn-primary btn-lg btn-login">Iniciar Sesión</button>
                        </div>

                        <div class="text-center">
                            <a href="#" class="forgot-password-link">¿Olvidaste tu contraseña?</a>
                        </div>
                    </form>

                    <div class="divider my-4"></div> <div class="text-center">
                        <p class="text-muted mb-3">¿No tienes una cuenta?</p>
                        <a href="formAdicionarCliente.jsp" class="btn btn-outline-secondary btn-lg btn-register">Regístrate como Cliente</a>
                        </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../Script/script.js"></script>
    </body>
</html>