<%-- 
    Document   : menuCliente
    Created on : 16/05/2025, 9:15:58 a. m.
    Author     : Usuario
--%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menú del Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="styleMenuCliente.css">
    </head>
    <body class="d-flex flex-column min-vh-100"> 

        <header class="main-header py-3 shadow-sm"> 
            <div class="container d-flex justify-content-between align-items-center">
                <a href="#" class="navbar-brand text-dark text-decoration-none h1 mb-0">Plataforma De Gestion De Tiendas</a>
                <div class="user-info">
                    <span class="me-3">Bienvenido</span>
                    <!--<button class="btn btn-outline-danger btn-sm" type="button">Cerrar Sesión</button>-->
                </div>
            </div>
        </header>

        <main class="container mt-4 mb-4 flex-grow-1">
            <div class="row">
                <div class="col-md-4 col-lg-3">
                    <div class="client-menu-container">
                        <h2 class="mb-3 h4">Mi Cuenta</h2>
                        <div class="card"> 
                            <div class="list-group list-group-flush">
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-person-fill me-2"></i>Editar Perfil
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-receipt-cutoff me-2"></i>Mis Pedidos y Reservas
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-heart-fill me-2"></i>Mis Negocios Favoritos
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-bell-fill me-2"></i>Notificaciones
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-gear-fill me-2"></i>Configuración
                                </a>
                                <a href="PaginaPrincipal.jsp" class="list-group-item list-group-item-action text-danger fw-medium"> 
                                    <i class="bi bi-box-arrow-right me-2"></i>Cerrar Sesión
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 col-lg-9">
                    <div class="client-content-area card"> 
                        <div class="card-header fw-medium"> 
                            Panel Principal del Cliente
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Bienvenido a tu panel</h5>
                            <p class="card-text">Desde aquí podrás gestionar toda la información de tu cuenta, tus pedidos, negocios favoritos y mucho más.</p>
                            <a href="#" class="btn btn-primary mt-3">
                                <i class="bi bi-eye-fill me-1"></i>Ver mis pedidos
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer class="bg-dark text-light py-3"> 
            <div class="container text-center">
                <p class="mb-0">&copy; 2025 Plataforma de Gestion De Tiendas.</p>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
        <script src="scriptMenuCliente.js"></script>
    </body>
</html>
