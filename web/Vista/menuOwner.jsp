<%-- 
    Document   : menuOwner
    Created on : 16/05/2025, 9:21:07 a. m.
    Author     : Usuario
--%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel de Control del Negocio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="styleMenuOwner.css">
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
                    <div class="owner-menu-container">
                        <h2 class="mb-3 h4">Panel de Gestión</h2>
                        <div class="card">
                            <div class="list-group list-group-flush">
                                <a href="#" class="list-group-item list-group-item-action active" aria-current="true">
                                    <i class="bi bi-speedometer2 me-2"></i>Resumen General
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-shop-window me-2"></i>Perfil de Mi Negocio
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-box-seam-fill me-2"></i>Gestionar Productos/Servicios
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-receipt me-2"></i>Gestionar Pedidos
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-calendar-check-fill me-2"></i>Gestionar Reservas
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-bar-chart-line-fill me-2"></i>Estadísticas y Reportes
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-bell-fill me-2"></i>Notificaciones
                                </a>
                                <a href="#" class="list-group-item list-group-item-action">
                                    <i class="bi bi-sliders me-2"></i>Configuración de la Tienda
                                </a>
                                <a href="PaginaPrincipal.jsp" class="list-group-item list-group-item-action text-danger fw-medium">
                                    <i class="bi bi-box-arrow-right me-2"></i>Cerrar Sesión
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 col-lg-9">
                    <div class="owner-content-area card">
                        <div class="card-header fw-medium">
                            Resumen General de tu Negocio
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">¡Hola!</h5>
                            <p class="card-text">Aquí encontrarás un resumen del rendimiento de tu negocio en la plataforma. Utiliza el menú de la izquierda para acceder a las diferentes herramientas de gestión.</p>

                            <div class="row mt-4">
                                <div class="col-md-6 mb-3">
                                    <div class="card text-center">
                                        <div class="card-body">
                                            <h3 class="card-title">0</h3>
                                            <p class="card-text text-muted">Pedidos Hoy</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="card text-center">
                                        <div class="card-body">
                                            <h3 class="card-title">0</h3>
                                            <p class="card-text text-muted">Reservas Pendientes</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <a href="#" class="btn btn-success mt-3">
                                <i class="bi bi-plus-circle-fill me-1"></i>Añadir Nuevo Producto
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer class="bg-dark text-light py-3">
            <div class="container text-center">
                <p class="mb-0">&copy; 2025 Plataforma De Gestion De Tiendas.</p>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
        <script src="scriptMenuOwner.js"></script>
    </body>
</html>