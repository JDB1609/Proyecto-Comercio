<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Buscar Dueño Local</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="col-md-6 offset-md-3">
                <div class="card p-4 shadow">
                    <h3 class="text-center mb-4">Buscar Dueño Local por Cédula</h3>
                    <form action="../Control/ct_buscarOwnerLocal.jsp" method="post">
                        <div class="mb-3">
                            <label for="cedulaOwner" class="form-label">Cédula</label>
                            <input type="text" class="form-control" name="cedulaOwner" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Buscar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>

