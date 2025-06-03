<%-- 
    
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registro de Cliente</title>
         <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
         <!-- Estilo CSS -->
        <link rel="stylesheet" href="../Styles/estilosFormularios.css">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="container min-vh-100 d-flex justify-content-center align-items-center">
                <div class="col-md-6 col-lg-5">
                    <div class="card p-4 shadow">
                        <h2 class="text-center mb-4">Registro de Cliente</h2>
                        <form action="../Control/ct_adicionarCliente.jsp" method="post">
                            <div class="mb-3">
                                <label for="cedulaCliente" class="form-label">Cédula</label>
                                <input type="text" class="form-control" name="cedulaCliente" placeholder="Ingresar cédula" required>
                            </div>
                            <div class="mb-3">
                                <label for="nombreCliente" class="form-label">Nombre</label>
                                <input type="text" class="form-control" name="nombreCliente" placeholder="Ingresar nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="apellidoCliente" class="form-label">Apellido</label>
                                <input type="text" class="form-control" name="apellidoCliente" placeholder="Ingresar apellido" required>
                            </div>
                            <div class="mb-3">
                                <label for="correoCliente" class="form-label">Correo electrónico</label>
                                <input type="email" class="form-control" id="correoCliente" name="correoCliente" placeholder="Ingresar correo electrónico" required>
                            </div>
                            <div class="mb-3">
                                <label for="passwordCliente" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="passwordCliente" name="passwordCliente" placeholder="Ingresar contraseña" required>
                            </div>
                            <div class="mb-3">
                                <label for="telefonoCliente" class="form-label">Número de teléfono</label>
                                <input type="tel" class="form-control" id="telefonoCliente" name="numeroCliente" placeholder="Ingresar número de teléfono">
                            </div>
                            <div class="mb-3">
                                <label for="direccion" class="form-label">Dirección</label>
                                <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Ingresar dirección de residencia" required=>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Registrarse</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
