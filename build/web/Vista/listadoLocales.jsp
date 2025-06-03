<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Listado de Locales</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <style>
            /* Variables CSS para colores */
            :root {
                --primary-color: #4A90E2; /* Un azul vibrante */
                --secondary-color: #6c757d; /* Gris para botones secundarios */
                --text-color: #333;
                --light-gray: #e9ecef;
                --white: #ffffff;
                --shadow-light: rgba(0, 0, 0, 0.05);
                --shadow-medium: rgba(0, 0, 0, 0.1);
                --success-bg: #d4edda;
                --success-text: #155724;
                --warning-bg: #fff3cd;
                --warning-text: #856404;
            }

            /* Estilos Generales para el cuerpo */
            body {
                font-family: 'Poppins', sans-serif; /* Usamos la fuente de Google Fonts */
                background-color: #f8f9fa; /* Fondo muy claro */
                margin: 0;
                padding: 30px;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                min-height: 100vh;
                color: var(--text-color);
            }

            /* Contenedor principal */
            .container {
                background-color: var(--white);
                padding: 40px;
                border-radius: 12px; /* Más redondeado */
                box-shadow: 0 8px 25px var(--shadow-medium); /* Sombra más suave y extendida */
                width: 95%;
                max-width: 1200px; /* Un poco más ancho */
                margin: auto;
                animation: fadeIn 0.8s ease-out; /* Animación de entrada */
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }

            h1 {
                color: var(--primary-color);
                text-align: center;
                margin-bottom: 35px;
                font-size: 2.8em; /* Más grande */
                font-weight: 600; /* Más peso para el título */
                position: relative;
                padding-bottom: 15px;
            }
            h1::after { /* Línea decorativa moderna bajo el título */
                content: '';
                position: absolute;
                left: 50%;
                bottom: 0;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background-color: var(--primary-color);
                border-radius: 2px;
            }

            /* Estilos de la tabla */
            .table-container {
                overflow-x: auto; /* Permite scroll horizontal en pantallas pequeñas */
            }

            table {
                width: 100%;
                border-collapse: separate; /* Cambiado a separate para bordes redondeados */
                border-spacing: 0;
                margin-top: 25px;
                box-shadow: 0 4px 15px var(--shadow-light);
                border-radius: 10px; /* Bordes redondeados para la tabla */
                overflow: hidden; /* Asegura que los bordes redondeados funcionen */
            }

            th, td {
                padding: 15px 20px;
                text-align: left;
                font-size: 0.9em;
                border-bottom: 1px solid #f0f0f0; /* Líneas divisorias más suaves */
                transition: background-color 0.3s ease;
            }

            th {
                background-color: var(--primary-color);
                color: var(--white);
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.05em; /* Espaciado entre letras */
            }
            /* Redondeado para las esquinas de los encabezados */
            th:first-child { border-top-left-radius: 10px; }
            th:last-child { border-top-right-radius: 10px; }


            tr:nth-child(even) {
                background-color: #fdfdff; /* Fondo muy sutil para filas pares */
            }

            tr:hover {
                background-color: #eaf6ff; /* Azul claro al pasar el ratón */
            }

            /* Estilos para los enlaces dentro de la tabla (ej. Cédula) */
            td a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            td a:hover {
                color: #357ABD; /* Un azul más oscuro al pasar el ratón */
                text-decoration: underline;
            }

            /* Estilo para el mensaje de "no hay locales" */
            .no-locales-message {
                text-align: center;
                padding: 25px;
                background-color: var(--warning-bg);
                border: 1px solid #ffda6a; /* Borde más amigable */
                color: var(--warning-text);
                border-radius: 8px;
                margin-top: 30px;
                font-size: 1.1em;
                box-shadow: 0 2px 10px var(--shadow-light);
            }

            /* Estilo para el botón/enlace de volver */
            .back-link {
                display: inline-block; /* Permite centrar con text-align en el padre */
                width: 220px;
                margin-top: 40px;
                padding: 15px 30px;
                background: linear-gradient(135deg, var(--primary-color), #347bc7); /* Degradado sutil */
                color: var(--white);
                text-align: center;
                text-decoration: none;
                border-radius: 8px; /* Más redondeado */
                transition: transform 0.3s ease, box-shadow 0.3s ease; /* Transiciones suaves */
                font-weight: 600;
                letter-spacing: 0.03em;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); /* Sombra para efecto 3D */
            }

            .back-link:hover {
                transform: translateY(-3px); /* Efecto de "levantar" */
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3); /* Sombra más grande al pasar el ratón */
                text-decoration: none;
            }

            /* Estilos responsivos */
            @media (max-width: 992px) { /* Ajuste para tablets */
                .container {
                    padding: 30px;
                }
                h1 {
                    font-size: 2.2em;
                }
                th, td {
                    padding: 12px 15px;
                    font-size: 0.88em;
                }
            }

            @media (max-width: 768px) {
                body {
                    padding: 15px;
                }
                .container {
                    padding: 25px;
                }
                h1 {
                    font-size: 2em;
                }
                th, td {
                    padding: 10px 12px;
                    font-size: 0.85em;
                }
                .back-link {
                    width: 100%; /* El botón ocupa todo el ancho en móviles */
                    margin-top: 25px;
                }
            }

            @media (max-width: 480px) {
                h1 {
                    font-size: 1.8em;
                }
                .container {
                    padding: 15px;
                }
                .table-container {
                    border-radius: 5px; /* Menos redondeado en móvil */
                }
                th:first-child { border-top-left-radius: 5px; }
                th:last-child { border-top-right-radius: 5px; }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Listado de Locales</h1>

            <%
                // --- INICIO CÓDIGO DEPURACIÓN CRÍTICA (NO ELIMINAR) ---
                System.out.println("*************** listadoLocales.jsp HA EMPEZADO A EJECUTARSE ***************");
                // --- FIN CÓDIGO DEPURACIÓN CRÍTICA ---

                System.out.println("listadoLocales.jsp: Intentando obtener 'datosLocales' de la sesión.");

                // Recuperar la matriz de datos de la sesión (ahora "datosLocales")
                String datosLocales[][] = (String[][]) session.getAttribute("datosLocales");
                
                if (datosLocales == null || datosLocales.length == 0) {
                    // --- INICIO CÓDIGO DEPURACIÓN (NO ELIMINAR) ---
                    if (datosLocales == null) {
                        System.out.println("listadoLocales.jsp: 'datosLocales' es NULL en la sesión.");
                    } else if (datosLocales.length == 0) {
                        System.out.println("listadoLocales.jsp: 'datosLocales' es una matriz vacía (length = 0).");
                    }
                    // --- FIN CÓDIGO DEPURACIÓN ---
                    out.print("<p class='no-locales-message'>No hay locales para mostrar o no se pudieron cargar los datos.</p>");
                } else {
                    // --- INICIO CÓDIGO DEPURACIÓN (NO ELIMINAR) ---
                    System.out.println("listadoLocales.jsp: Se encontraron " + datosLocales.length + " filas de locales.");
                    // --- FIN CÓDIGO DEPURACIÓN ---

                    out.print("<div class='table-container'>"); // Envuelve la tabla para scroll horizontal
                    out.print("<table>");
                    out.print("<thead><tr>");
                    // Los encabezados de las columnas deben coincidir con el orden de la consulta en Conexion.java
                    // Para 'locales': nombreLocal, tipoLocal, direccionLocal, horario, telefonoLocal, descripcion, estado
                    out.print("<th>Nombre Local</th>"); // dato[0]
                    out.print("<th>Tipo</th>");        // dato[1]
                    out.print("<th>Dirección</th>");   // dato[2]
                    out.print("<th>Horario</th>");     // dato[3]
                    out.print("<th>Teléfono</th>");    // dato[4]
                    out.print("<th>Descripción</th>"); // dato[5]
                    out.print("<th>Estado</th>");      // dato[6]
                    out.print("</tr></thead>");

                    out.print("<tbody>");
                    // Iterar sobre cada fila (local)
                    for (String[] registro : datosLocales) {
                        out.print("<tr>");
                        // Asegúrate de que los índices coincidan con la consulta en Conexion.java
                        // Puedes añadir un enlace similar a clientes si tienes una página de detalle para locales
                        out.print("<td>" + registro[0] + "</td>"); // nombreLocal
                        out.print("<td>" + registro[1] + "</td>"); // tipoLocal
                        out.print("<td>" + registro[2] + "</td>"); // direccionLocal
                        out.print("<td>" + registro[3] + "</td>"); // horario
                        out.print("<td>" + registro[4] + "</td>"); // telefonoLocal
                        out.print("<td>" + registro[5] + "</td>"); // descripcion
                        out.print("<td>" + (registro[6] != null && registro[6].equals("1") ? "Activo" : "Inactivo") + "</td>"); // estado
                        out.print("</tr>");
                    }
                    out.print("</tbody>");
                    out.print("</table>");
                    out.print("</div>"); // Cierra .table-container
                }
            %>
            <a href="menuAdmin.jsp" class="back-link">Volver al menú</a> <%-- Asegúrate de que este enlace sea correcto para tu menú --%>
        </div>
    </body>
</html>