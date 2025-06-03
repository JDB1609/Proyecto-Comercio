<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plataforma de Gestión de Tiendas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <link rel="stylesheet" href="../Styles/StylesMenu.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header class="main-header">
        <div class="container">
            <div class="menu-button-container">
                <button class="menu-toggle-button" aria-expanded="false" aria-controls="mainNavigation">
                    <span class="hamburger-icon"></span>
                </button>
            </div>
            <div class="auth-buttons-header">
                <a href="login.jsp" class="btn btn-outline-success me-2" type="button">Ingreso</a>
                <a href="elegirUsuario.jsp" class="btn btn-primary">Registro</a>

            </div>
        </div>
    </header>

    <aside class="side-menu">
        <button class="close-menu-button">
            <span aria-hidden="true">&times;</span>
        </button>
        <ul class="side-menu-items">
            <li class="side-item"><button class="btn btn-success w-100 mb-2">Ingreso</button></li>
            <li class="side-item"><button href="formCliente.jsp" class="btn btn-primary w-100 mb-2">Registro</button></li>
            <li class="side-item"><a href="#">Restaurantes</a></li>
            <li class="side-item"><a href="#">Mercados</a></li>
            <li class="side-item"><a href="#">Farmacia</a></li>
            <li class="side-item"><a href="#">Express</a></li>
            <li class="side-item"><a href="formLocal.jsp">Registrar Tienda</a></li>
        </ul>
    </aside>

    <section class="hero py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h1>Descubre los negocios locales de Buga</h1>
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="¿Dónde quieres comprar?" aria-label="¿Dónde quieres comprar?" aria-describedby="ubicacion-addon">
                        <button class="btn btn-outline-secondary" type="button" id="ubicacion-addon">Buscar</button>
                    </div>
                </div>
                <div class="col-md-6">
                    <!-- Espacio adicional -->
                </div>
            </div>
        </div>
    </section>

    <main class="main-content">
        <section class="categories py-4">
            <div class="container">
                <h2>Explorar por categorías</h2>
                <div class="row">
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Restaurantes</h5>
                                <p class="card-text">Descubre los mejores lugares para comer en Buga.</p>
                                <a href="#" class="btn btn-outline-primary">Ver más</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Ropa</h5>
                                <p class="card-text">Encuentra las últimas tendencias en moda local.</p>
                                <a href="#" class="btn btn-outline-primary">Ver más</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="info py-5 bg-light">
            <div class="container">
                <h2>¿Por qué usar nuestra plataforma?</h2>
                <div class="row">
                    <div class="col-md-6">
                        <h3>Para usuarios</h3>
                        <ul>
                            <li>Encuentra fácilmente lo que necesitas.</li>
                            <li>Descubre negocios locales.</li>
                            <li>Lee reseñas de otros usuarios.</li>
                            <li>Sigue tus pedidos en tiempo real.</li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h3>Para comerciantes</h3>
                        <ul>
                            <li>Mayor visibilidad en línea.</li>
                            <li>Llega a más clientes en Buga.</li>
                            <li>Obtén feedback de tus clientes.</li>
                            <li>Una plataforma fácil de usar.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer class="bg-dark text-light py-3">
        <div class="container text-center">
            <p>&copy; 2025 Plataforma de Gestión de Tiendas.</p>
        </div>
    </footer>

    <script src="../Scripts/menuPrincipal.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
</body>
</html>
