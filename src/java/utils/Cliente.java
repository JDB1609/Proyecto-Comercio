package utils;

public class Cliente {

    private String cedulaCliente;
    private String nombreCliente;
    private String apellidoCliente;
    private String correoCliente;
    private String passwordCliente;
    private String numeroCliente;
    private String direccionCliente;

    private int estado;

    // --- Constructores ---

    // Constructor vacío (siempre buena práctica para JavaBeans)
    public Cliente() {
        this.estado = 1; // Por defecto activo
    }

    public Cliente(String cedulaCliente, String nombreCliente, String apellidoCliente, String correoCliente,
                   String passwordCliente, String numeroCliente, String direccionCliente, int estado) {
        this.cedulaCliente = cedulaCliente;
        this.nombreCliente = nombreCliente;
        this.apellidoCliente = apellidoCliente;
        this.correoCliente = correoCliente;
        this.passwordCliente = passwordCliente;
        this.numeroCliente = numeroCliente;
        this.direccionCliente = direccionCliente;
        this.estado = estado;
    }

    public Cliente(String cedulaCliente, String nombreCliente, String apellidoCliente, String correoCliente,
                   String passwordCliente, String numeroCliente, String direccionCliente) {
        this.cedulaCliente = cedulaCliente;
        this.nombreCliente = nombreCliente;
        this.apellidoCliente = apellidoCliente;
        this.correoCliente = correoCliente;
        this.passwordCliente = passwordCliente;
        this.numeroCliente = numeroCliente;
        this.direccionCliente = direccionCliente;
        this.estado = 1; // Por defecto activo
    }

    // --- Getters y Setters ---

    // Genera estos métodos con NetBeans (Alt + Insert -> Getter and Setter...)
    public String getCedulaCliente() {
        return cedulaCliente;
    }

    public void setCedulaCliente(String cedulaCliente) {
        this.cedulaCliente = cedulaCliente;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getApellidoCliente() {
        return apellidoCliente;
    }

    public void setApellidoCliente(String apellidoCliente) {
        this.apellidoCliente = apellidoCliente;
    }

    public String getCorreoCliente() {
        return correoCliente;
    }

    public void setCorreoCliente(String correoCliente) {
        this.correoCliente = correoCliente;
    }

    public String getPasswordCliente() {
        return passwordCliente;
    }

    public void setPasswordCliente(String passwordCliente) {
        this.passwordCliente = passwordCliente;
    }

    public String getNumeroCliente() {
        return numeroCliente;
    }

    public void setNumeroCliente(String numeroCliente) {
        this.numeroCliente = numeroCliente;
    }

    public String getDireccionCliente() {
        return direccionCliente;
    }

    public void setDireccionCliente(String direccionCliente) {
        this.direccionCliente = direccionCliente;
    }

    // ¡CRÍTICO! El getter para 'estado' debe ser getEstado()
    public int getEstado() {
        return estado;
    }

    // ¡CRÍTICO! El setter para 'estado' debe ser setEstado()
    public void setEstado(int estado) {
        this.estado = estado;
    }

    // Opcional: Método toString() para facilitar la depuración
    @Override
    public String toString() {
        return "Cliente{" +
               "cedulaCliente='" + cedulaCliente + '\'' +
               ", nombreCliente='" + nombreCliente + '\'' +
               ", apellidoCliente='" + apellidoCliente + '\'' +
               ", correoCliente='" + correoCliente + '\'' +
               ", passwordCliente='" + (passwordCliente != null ? "[PROTECTED]" : null) + '\'' +
               ", numeroCliente='" + numeroCliente + '\'' +
               ", direccionCliente='" + direccionCliente + '\'' +
               ", estado=" + estado +
               '}';
    }
}