<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración Avanzado</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../Styles/admin_style.css"> </head>
<body>
    <div class="admin-container">
        <aside class="admin-sidebar">
            <div class="sidebar-brand">
                <a href="#"> <i class="fas fa-rocket"></i> AdminPro </a>
            </div>
            <ul class="sidebar-menu">
                <li class="menu-header"><span>Principal</span></li>
                <li class="menu-item">
                    <a href="#">
                        <span><i class="fas fa-users icon"></i> Clientes <i class="fas fa-chevron-right arrow"></i></span>
                        <ul class="submenu">
                            <li><a href="actualizarCliente.jsp"><i class="fas fa-user-edit sub-icon"></i> Actualizar</a></li>
                            <li><a href="borrarCliente.jsp"><i class="fas fa-user-minus sub-icon"></i> Borrar</a></li>
                            <li><a href="../Modelo/md_listarClientes.jsp"><i class="fas fa-list-ul sub-icon"></i> Listar</a></li>
                        </ul>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="#">
                        <span><i class="fas fa-store icon"></i> Dueños de Local <i class="fas fa-chevron-right arrow"></i></span>
                        <ul class="submenu">
                            <li><a href="actualizarOwnerLocal.jsp"><i class="fas fa-edit sub-icon"></i> Actualizar</a></li>
                            <li><a href="borrarOwner.jsp"><i class="fas fa-user-tag sub-icon"></i> Borrar</a></li>
                            <li><a href="../Modelo/md_listarOwners.jsp"><i class="fas fa-list-alt sub-icon"></i> Listar</a></li>
                        </ul>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="#">
                        <span><i class="fas fa-building-user icon"></i> Locales <i class="fas fa-chevron-right arrow"></i></span>
                        <ul class="submenu">
                            <li><a href="actualizarLocal.jsp"><i class="fas fa-building-circle-check sub-icon"></i> Actualizar</a></li>
                            <li><a href="borrarLocal.jsp"><i class="fas fa-building-circle-xmark sub-icon"></i> Borrar</a></li>
                            <li><a href="../Modelo/md_listarLocales.jsp"><i class="fas fa-clipboard-list sub-icon"></i> Listar</a></li>
                        </ul>
                    </a>
                </li>

                <li class="menu-header"><span>Configuración</span></li>
                 <li class="menu-item">
                    <a href="#logout" id="logout-link-sidebar"> <span><i class="fas fa-sign-out-alt icon"></i> Cerrar Sesión</span>
                    </a>
                </li>
            </ul>
            <div class="sidebar-footer">
                <p>&copy; 2024 Tu Compañía</p>
            </div>
        </aside>

        <main class="admin-main-content">
            <header class="admin-header">
                <div class="header-title">
                    <h1><i class="fas fa-tachometer-alt"></i> Panel Principal</h1>
                    <p>Bienvenido de nuevo, Administrador.</p>
                </div>
                <div class="header-actions">
                    <form action="PaginaPrincipal.jsp" method="get" id="logout-form-header" style="display:none;">
                        </form>
                    <a href="#" class="btn btn-primary btn-sm" onclick="document.getElementById('logout-form-header').submit(); return false;">
                        <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                    </a>
                    </div>
            </header>

            <div class="content-wrapper">
                <div class="row gy-4">
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card card-1">
                            <div class="stat-card-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-card-info">
                                <h4>1,250</h4>
                                <p>Clientes Activos</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card card-2">
                            <div class="stat-card-icon">
                                <i class="fas fa-store-alt"></i>
                            </div>
                            <div class="stat-card-info">
                                <h4>320</h4>
                                <p>Locales Registrados</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card card-3">
                             <div class="stat-card-icon">
                                <i class="fas fa-hand-holding-usd"></i>
                            </div>
                            <div class="stat-card-info">
                                <h4>$15,780</h4>
                                <p>Ingresos (Mes)</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card card-4">
                            <div class="stat-card-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <div class="stat-card-info">
                                <h4>+12%</h4>
                                <p>Crecimiento</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="main-panel-content mt-4">
                    <div class="card">
                        <div class="card-header">
                            <h5>Actividad Reciente</h5>
                        </div>
                        <div class="card-body">
                            <p>Aquí podrías listar las últimas acciones realizadas en el sistema, como nuevos registros, actualizaciones importantes, etc.</p>
                            <p>Utilice el menú lateral para navegar por las diferentes secciones de administración.</p>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    <script src="../Scripts/admin_script.js"></script> </body>
</html>