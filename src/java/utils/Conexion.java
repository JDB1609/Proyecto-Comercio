package utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSetMetaData;
import java.sql.PreparedStatement;
import java.util.ArrayList;

public class Conexion {

    private Connection conn; // Objeto para la conexion
    private String mensaje; // Para asignar posibles mensajes de error

    // datos de conexion
    private final String bd = "comerciobuga"; // ¡Verifica que este sea el nombre correcto de tu DB!
    private final String login = "root";    // ¡Verifica que este sea el usuario correcto!
    private final String password = "";     // ¡¡CAMBIA ESTO SI TU USUARIO 'root' TIENE CONTRASEÑA!!
    private final String host = "127.0.0.1"; // Si MySQL está en otro lado, cambia la IP
    private final String port = "3306"; // Variable para el puerto

    public Conexion() {
        conn = null;
        mensaje = "";
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    /**
     * Intenta establecer una conexión con la base de datos MySQL.
     * Retorna true si la conexión fue exitosa, false en caso contrario.
     */
    public boolean conectarMySQL() {
        try {
            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: Intentando cargar el driver JDBC...");
            // --- FIN CÓDIGO DEPURACIÓN ---

            Class.forName("com.mysql.cj.jdbc.Driver");

            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: Driver JDBC cargado.");
            System.out.println("Conexion.java: Intentando conectar a la BD: jdbc:mysql://" + host + ":" + port + "/" + bd);
            // --- FIN CÓDIGO DEPURACIÓN ---

            conn = DriverManager.getConnection("jdbc:mysql://" + host + ":" + port + "/" + bd, login, password);
            this.mensaje = "Conexión exitosa a la base de datos.";
            
            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: Conexión a la BD establecida.");
            // --- FIN CÓDIGO DEPURACIÓN ---
            
            return true;
        } catch (ClassNotFoundException e) {
            this.mensaje = "ERROR: No se encuentra el controlador JDBC de MySQL. Asegúrate de que 'mysql-connector-java.jar' esté en tu classpath. Detalles: " + e.getMessage();
            System.err.println("Conexion.java ERROR: " + this.mensaje);
            e.printStackTrace();
            return false;
        } catch (SQLException ex) {
            this.mensaje = "ERROR: No se pudo conectar con la base de datos '" + bd + "'. Verifica el servidor MySQL, las credenciales (usuario/contraseña) y el host. Detalles: " + ex.getMessage();
            System.err.println("Conexion.java ERROR: " + this.mensaje);
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Verifica si la conexión actual a la base de datos está abierta y válida.
     * SI NO ESTÁ CONECTADA, INTENTA CONECTARSE.
     *
     * @return true si la conexión está abierta y no cerrada (o si se pudo conectar), false en caso contrario.
     */
    public boolean estaConectado() {
        try {
            if (conn != null && !conn.isClosed()) {
                // --- INICIO CÓDIGO DEPURACIÓN ---
                System.out.println("Conexion.java: Conexión ya activa.");
                // --- FIN CÓDIGO DEPURACIÓN ---
                return true; // Ya está conectado
            } else {
                // --- INICIO CÓDIGO DEPURACIÓN ---
                System.out.println("Conexion.java: Conexión no activa, intentando conectar desde estaConectado().");
                // --- FIN CÓDIGO DEPURACIÓN ---
                return conectarMySQL(); // Si no está conectado, intenta conectar
            }
        } catch (SQLException e) {
            System.err.println("Error al verificar el estado de la conexión: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cierra la conexión a la base de datos de forma segura.
     * Ignora errores si la conexión ya está cerrada o es nula.
     */
    public void cerrarConexion() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                // --- INICIO CÓDIGO DEPURACIÓN ---
                System.out.println("Conexion.java: Conexión a la base de datos cerrada exitosamente.");
                // --- FIN CÓDIGO DEPURACIÓN ---
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
            e.printStackTrace();
        } finally {
            conn = null; // Asegura que el objeto de conexión se nulifique
        }
    }

    /**
     * Ejecuta una sentencia INSERT genérica y segura usando PreparedStatement.
     *
     * @param tabla Nombre de la tabla donde insertar.
     * @param columnNames ArrayList con los nombres de las columnas.
     * @param values      ArrayList con los valores a insertar.
     * @return true si la inserción fue exitosa (al menos una fila afectada), false en caso contrario.
     */
    public boolean insertar(String tabla, ArrayList<String> columnNames, ArrayList<Object> values) {
        PreparedStatement ps = null;
        try {
            if (!estaConectado()) {
                System.err.println("Conexion.java ERROR: Fallo de conexión al intentar insertar."); // DEBUG
                return false;
            }

            StringBuilder columnsPart = new StringBuilder("(");
            for (int i = 0; i < columnNames.size(); i++) {
                columnsPart.append(columnNames.get(i));
                if (i < columnNames.size() - 1) {
                    columnsPart.append(", ");
                }
            }
            columnsPart.append(")");

            StringBuilder valuesPart = new StringBuilder("VALUES (");
            for (int i = 0; i < values.size(); i++) {
                valuesPart.append("?");
                if (i < values.size() - 1) {
                    valuesPart.append(", ");
                }
            }
            valuesPart.append(")");

            String query = "INSERT INTO " + tabla + " " + columnsPart.toString() + " " + valuesPart.toString();
            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: SQL a ejecutar (INSERT): " + query);
            // --- FIN CÓDIGO DEPURACIÓN ---

            ps = conn.prepareStatement(query);

            for (int i = 0; i < values.size(); i++) {
                ps.setObject(i + 1, values.get(i));
            }

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            this.mensaje = "Error al realizar la inserción en la tabla '" + tabla + "': " + e.getMessage();
            System.err.println("Error en insertar: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar PreparedStatement en insertar: " + e.getMessage());
                e.printStackTrace();
            }
            cerrarConexion(); // Cierra la conexión después de la operación
        }
    }

    /**
     * Ejecuta una sentencia UPDATE genérica y segura usando PreparedStatement.
     *
     * @param tabla          Nombre de la tabla a actualizar.
     * @param columnNames    ArrayList con los nombres de las columnas a actualizar.
     * @param values         ArrayList con los nuevos valores para las columnas.
     * @param condicionSQLTemplate La cláusula WHERE (ej. "id = ? AND status = ?").
     * @param condicionParams ArrayList con los parámetros para la cláusula WHERE.
     * @return true si la actualización fue exitosa (al menos una fila afectada), false en caso contrario.
     */
    public boolean actualizar(String tabla, ArrayList<String> columnNames, ArrayList<Object> values,
                              String condicionSQLTemplate, ArrayList<Object> condicionParams) {
        PreparedStatement ps = null;
        try {
            if (!estaConectado()) {
                System.err.println("Conexion.java ERROR: Fallo de conexión al intentar actualizar."); // DEBUG
                return false;
            }

            StringBuilder query = new StringBuilder("UPDATE ").append(tabla).append(" SET ");
            for (int i = 0; i < columnNames.size(); i++) {
                query.append(columnNames.get(i)).append(" = ?");
                if (i < columnNames.size() - 1) {
                    query.append(", ");
                }
            }

            if (condicionSQLTemplate != null && !condicionSQLTemplate.trim().isEmpty()) {
                query.append(" WHERE ").append(condicionSQLTemplate);
            }
            query.append(";");

            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: SQL a ejecutar (UPDATE): " + query.toString());
            // --- FIN CÓDIGO DEPURACIÓN ---

            ps = conn.prepareStatement(query.toString());

            int paramIndex = 1;
            for (Object value : values) {
                ps.setObject(paramIndex++, value);
            }

            if (condicionParams != null) {
                for (Object param : condicionParams) {
                    ps.setObject(paramIndex++, param);
                }
            }

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            this.mensaje = "Error al realizar la actualización en la tabla '" + tabla + "': " + e.getMessage();
            System.err.println("Error en actualizar: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar PreparedStatement en actualizar: " + e.getMessage());
                e.printStackTrace();
            }
            cerrarConexion();
        }
    }

    /**
     * Consulta una única fila de una tabla basándose en una condición.
     * Las columnas devueltas están predefinidas para tablas específicas.
     *
     * @param tabla          Nombre de la tabla (locales, owner_local, clientes).
     * @param columnaCondicion Nombre de la columna para la condición WHERE.
     * @param valorCondicion  Valor de la condición.
     * @return Un array de String con los datos de la fila, o null si no se encuentra o hay un error.
     */
    public String[] consultaFila(String tabla, String columnaCondicion, String valorCondicion) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        String fila[] = null;

        try {
            if (!estaConectado()) {
                System.err.println("Conexion.java ERROR: Fallo de conexión al intentar consultaFila."); // DEBUG
                return null;
            }
            
            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: Ejecutando consultaFila para tabla: " + tabla + " donde " + columnaCondicion + " = " + valorCondicion);
            // --- FIN CÓDIGO DEPURACIÓN ---

            String query;
            switch (tabla.toLowerCase()) {
                case "locales":
                    query = "SELECT nombreLocal, tipoLocal, direccionLocal, horario, telefonoLocal, descripcion, estado FROM " + tabla + " WHERE " + columnaCondicion + " = ?;";
                    break;
                case "owner_local":
                    query = "SELECT cedulaOwner, nombreOwner, apellidoOwner, correoOwner, passwordOwner, telefonoOwner, estado FROM " + tabla + " WHERE " + columnaCondicion + " = ?;";
                    break;
                case "clientes":
                    query = "SELECT cedulaCliente, nombreCliente, apellidoCliente, correoCliente, passwordCliente, numeroCliente, direccionCliente, estado FROM " + tabla + " WHERE " + columnaCondicion + " = ?;";
                    break;
                default:
                    query = "SELECT * FROM " + tabla + " WHERE " + columnaCondicion + " = ?;";
                    break;
            }

            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: SQL a ejecutar (consultaFila): " + query);
            // --- FIN CÓDIGO DEPURACIÓN ---

            ps = conn.prepareStatement(query);
            ps.setString(1, valorCondicion);

            rs = ps.executeQuery();

            if (rs.next()) {
                ResultSetMetaData rsmd = rs.getMetaData();
                int cantColumnas = rsmd.getColumnCount();
                fila = new String[cantColumnas];
                for (int i = 1; i <= cantColumnas; i++) {
                    fila[i - 1] = rs.getString(i);
                }
                // --- INICIO CÓDIGO DEPURACIÓN ---
                System.out.println("Conexion.java: Fila encontrada para " + tabla + " con " + columnaCondicion + " = " + valorCondicion);
                // --- FIN CÓDIGO DEPURACIÓN ---
            } else {
                mensaje = "No hay registros que cumplan la condición en la tabla '" + tabla + "'.";
                // --- INICIO CÓDIGO DEPURACIÓN ---
                System.out.println("Conexion.java: " + mensaje);
                // --- FIN CÓDIGO DEPURACIÓN ---
            }
        } catch (SQLException sqle) {
            mensaje = "Error al realizar la consulta de fila en la tabla '" + tabla + "': " + sqle.getMessage();
            System.err.println("Error en consultaFila: " + sqle.getMessage());
            sqle.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar recursos en consultaFila: " + e.getMessage());
                e.printStackTrace();
            }
            cerrarConexion();
        }
        return fila;
    }

    /**
     * Consulta todos los registros "activos" (estado = 1) de una tabla específica.
     * Las columnas devueltas y el orden están predefinidos para tablas clave.
     *
     * @param tabla Nombre de la tabla (locales, owner_local, clientes).
     * @return Un ArrayList de arrays de String, donde cada array representa una fila.
     * Retorna un ArrayList vacío si no hay registros o si ocurre un error.
     */
    public ArrayList<String[]> consultarRegistrosActivos(String tabla) {
        ArrayList<String[]> resultados = new ArrayList<>();
        String query = "";
        ResultSet rs = null;
        PreparedStatement ps = null;

        try {
            if (!estaConectado()) {
                System.err.println("Conexion.java ERROR: La conexión no se pudo establecer para consultarRegistrosActivos."); // DEBUG
                return resultados;
            }
            
            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: Ejecutando consultarRegistrosActivos para tabla: " + tabla);
            // --- FIN CÓDIGO DEPURACIÓN ---

            switch (tabla.toLowerCase()) {
                case "locales":
                    query = "SELECT nombreLocal, tipoLocal, direccionLocal, horario, telefonoLocal, descripcion, estado FROM " + tabla + " WHERE estado = 1 ORDER BY nombreLocal ASC;";
                    break;
                case "owner_local":
                    query = "SELECT cedulaOwner, nombreOwner, apellidoOwner, correoOwner, passwordOwner, telefonoOwner, estado FROM " + tabla + " WHERE estado = 1 ORDER BY apellidoOwner, nombreOwner ASC;";
                    break;
                case "clientes":
                    query = "SELECT cedulaCliente, nombreCliente, apellidoCliente, correoCliente, passwordCliente, numeroCliente, direccionCliente, estado FROM " + tabla + " WHERE estado = 1 ORDER BY apellidoCliente, nombreCliente ASC;";
                    break;
                default:
                    query = "SELECT * FROM " + tabla + " WHERE estado = 1;";
                    break;
            }

            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: SQL a ejecutar (consultarRegistrosActivos): " + query);
            // --- FIN CÓDIGO DEPURACIÓN ---

            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();

            while (rs.next()) {
                String[] fila = new String[columnCount];
                for (int i = 1; i <= columnCount; i++) {
                    fila[i - 1] = rs.getString(i);
                }
                resultados.add(fila);
            }
            this.mensaje = "Consulta de registros activos exitosa para la tabla '" + tabla + "'.";
            
            // --- INICIO CÓDIGO DEPURACIÓN ---
            System.out.println("Conexion.java: Consulta exitosa. Filas encontradas: " + resultados.size());
            // --- FIN CÓDIGO DEPURACIÓN ---

        } catch (SQLException e) {
            this.mensaje = "Error al consultar registros activos de la tabla '" + tabla + "': " + e.getMessage();
            System.err.println("Conexion.java ERROR: " + this.mensaje);
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Conexion.java ERROR al cerrar recursos: " + e.getMessage());
                e.printStackTrace();
            }
            cerrarConexion(); // Importante: cierra la conexión
        }
        return resultados;
    }

    /**
     * Realiza una consulta SQL genérica y devuelve los resultados en una matriz de String.
     * Permite pasar parámetros para PreparedStatement.
     *
     * @param sql    La sentencia SQL a ejecutar (ej. "SELECT * FROM users WHERE status = ?").
     * @param params ArrayList de Object con los parámetros para la sentencia SQL. Puede ser null.
     * @return Una matriz bidimensional de String con los resultados, o null si no hay registros o error.
     */
    public String[][] consultaMatriz(String sql, ArrayList<Object> params) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        String matrizRegistros[][] = null;

        try {
            if (!estaConectado()) {
                System.err.println("Conexion.java ERROR: Fallo de conexión al intentar consultaMatriz."); // DEBUG
                return null;
            }

            ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);

            if (params != null) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }
            }

            rs = ps.executeQuery();

            int canFilas = 0;
            if (rs.last()) {
                canFilas = rs.getRow();
                rs.beforeFirst();
            }

            if (canFilas > 0) {
                int canColumnas = rs.getMetaData().getColumnCount();
                matrizRegistros = new String[canFilas][canColumnas];
                int f = 0;
                while (rs.next()) {
                    for (int c = 0; c < canColumnas; c++) {
                        matrizRegistros[f][c] = rs.getString(c + 1);
                    }
                    f++;
                }
            } else {
                mensaje = "No hay registros que cumplan con la condición para la consulta de matriz.";
                // --- INICIO CÓDIGO DEPURACIÓN ---
                System.out.println("Conexion.java: " + mensaje);
                // --- FIN CÓDIGO DEPURACIÓN ---
            }
        } catch (SQLException sqle) {
            mensaje = "Error al ejecutar la consulta de matriz: " + sqle.getMessage();
            System.err.println("Error en consultaMatriz: " + sqle.getMessage());
            sqle.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar recursos en consultaMatriz: " + e.getMessage());
                e.printStackTrace();
            }
            cerrarConexion();
        }
        return matrizRegistros;
    }

    /**
     * Cuenta el número de registros en una tabla que cumplen una condición.
     *
     * @param tabla      Nombre de la tabla.
     * @param condicionSQL La cláusula WHERE (ej. "status = ?"). Puede ser null o vacío.
     * @param params     ArrayList de Object con los parámetros para la cláusula WHERE. Puede ser null.
     * @return El número de registros que cumplen la condición, o -1 si ocurre un error.
     */
    public int contar(String tabla, String condicionSQL, ArrayList<Object> params) {
        int cont = -1;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            if (!estaConectado()) {
                System.err.println("Conexion.java ERROR: Fallo de conexión al intentar contar."); // DEBUG
                return -1;
            }

            String query = "SELECT COUNT(*) FROM " + tabla;
            if (condicionSQL != null && !condicionSQL.trim().isEmpty()) {
                query += " WHERE " + condicionSQL;
            }

            ps = conn.prepareStatement(query);

            if (params != null) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                cont = rs.getInt(1);
            }
        } catch (SQLException sqle) {
            cont = -1;
            mensaje = "Error al realizar la consulta de conteo para la tabla '" + tabla + "': " + sqle.getMessage();
            System.err.println("Error en contar: " + sqle.getMessage());
            sqle.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar recursos en contar: " + e.getMessage());
                e.printStackTrace();
            }
            cerrarConexion();
        }
        return cont;
    }

    /**
     * Suma los valores de una columna numérica en una tabla que cumplen una condición.
     *
     * @param tabla      Nombre de la tabla.
     * @param campo      Nombre de la columna a sumar.
     * @param condicionSQL La cláusula WHERE (ej. "id_producto = ?"). Puede ser null o vacío.
     * @param params     ArrayList de Object con los parámetros para la cláusula WHERE. Puede ser null.
     * @return La suma de los valores, o -1 si ocurre un error.
     */
    public double sumar(String tabla, String campo, String condicionSQL, ArrayList<Object> params) {
        double suma = -1;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            if (!estaConectado()) {
                System.err.println("Conexion.java ERROR: Fallo de conexión al intentar sumar."); // DEBUG
                return -1;
            }

            String query = "SELECT SUM(" + campo + ") FROM " + tabla;
            if (condicionSQL != null && !condicionSQL.trim().isEmpty()) {
                query += " WHERE " + condicionSQL;
            }

            ps = conn.prepareStatement(query);

            if (params != null) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                suma = rs.getDouble(1);
            }
        } catch (SQLException sqle) {
            suma = -1;
            mensaje = "Error al realizar la consulta de suma para el campo '" + campo + "' en la tabla '" + tabla + "': " + sqle.getMessage();
            System.err.println("Error en sumar: " + sqle.getMessage());
            sqle.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar recursos en sumar: " + e.getMessage());
                e.printStackTrace();
            }
            cerrarConexion();
        }
        return suma;
    }
}