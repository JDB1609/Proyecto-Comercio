<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registro del Dueño del local</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Estilo CSS personalizado -->
        <link rel="stylesheet" href="../Styles/estilosFormularios.css">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="container min-vh-100 d-flex justify-content-center align-items-center">
                <div class="col-md-6 col-lg-5">
                    <div class="card-box p-4 shadow">
                        <h2 class="text-center mb-4">Registro Local</h2>
                        <form action="../Control/ct_adicionarLocal.jsp" method="post">
                            <div class="mb-3">
                                <label for="nombreLocal" class="form-label">Nombre del local</label>
                                <input type="text" class="form-control" id="nombreLocal" name="nombreLocal" placeholder="Ingresar nombre del local" required>
                            </div>
                            <div class="mb-3">
                                <label for="tipoLocal" class="form-label">Tipo de local:</label>
                                <select class="form-select" id="tipoLocal" name="tipoLocal" required>
                                    <option value="">Selecciona una opción</option>
                                    <option value="restaurante">Restaurante</option>
                                    <option value="ropa">Ropa</option>
                                    <option value="accesorios">Accesorios</option>
                                    <option value="otro">Otro</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="direccionLocal" class="form-label">Dirección del local</label>
                                <input type="text" class="form-control" name="direccionLocal" placeholder="Ingresar dirección del local" required>
                            </div>
                            <div class="mb-3">
                                <label for="horario" class="form-label">Horario de atención</label>
                                <input type="text" class="form-control" id="horario" name="horario" placeholder="Ej: 9:00 a.m - 8:00 p.m" required>
                            </div>
                            <div class="mb-3">
                                <label for="telefonoLocal" class="form-label">Teléfono del local</label>
                                <input type="tel" class="form-control" id="telefonoLocal" name="telefonoLocal" placeholder="Ingresar teléfono del local" required>
                            </div>
                            <div class="mb-3">
                                <label for="descripcion" class="form-label">Descripción</label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion" placeholder="Ingresar una pequeña descripción">
                            </div>

                            <!-- Botón de registro del local -->
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Registrarse</button>
                            </div>

                            <!-- Botón Registrar Dueño (nuevo) -->
                            <div class="d-flex justify-content-end mt-3">
                                <a href="formDueñoLocal.jsp" class="btn btn-danger">Registrar dueño</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
