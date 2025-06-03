<%-- 
    
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registro del Dueño del local</title>
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
                        <h2 class="text-center mb-4">Registro Dueño del local</h2>
                        <form action="../Control/ct_adicionarOwnerLocal.jsp" method="post">
                            <div class="mb-3">
                                <label for="cedulaOwner" class="form-label">Cédula</label>
                                <input type="text" class="form-control" id="cedulaOwner" name="cedulaOwner" placeholder="Ingresar cédula" required>
                            </div>
                            <div class="mb-3">
                                <label for="nombreOwner" class="form-label">Nombre</label>
                                <input type="text" class="form-control" name="nombreOwner" placeholder="Ingresar nombre"required>
                            </div>
                            <div class="mb-3">
                                <label for="apellidoOwner" class="form-label">Apellido</label>
                                <input type="text" class="form-control" name="apellidoOwner" placeholder="Ingresar apellido"required>
                            </div>
                            <div class="mb-3">
                                <label for="correoOwner" class="form-label">Correo electrónico</label>
                                <input type="email" class="form-control" id="correoOwner" name="correoOwner" placeholder="Ingresar correo electrónico"required>
                            </div>
                            <div class="mb-3">
                                <label for="passwordOwner" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="passwordOwner" name="passwordOwner" placeholder="Ingresar contraseña" required>
                            </div>
                            <div class="mb-3">
                                <label for="telefonoOwner" class="form-label">Número de teléfono</label>
                                <input type="tel" class="form-control" id="telefonoOwner" name="telefonoOwner" placeholder="Ingresar número de teléfono">
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Registrarse</button>
                            </div>
                        </form>                     
                    </div>
                </div>
            </div>
        </div>
