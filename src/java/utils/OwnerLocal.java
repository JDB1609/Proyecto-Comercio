package utils;

public class OwnerLocal {
    private String cedulaOwner;
    private String nombreOwner;
    private String apellidoOwner;
    private String correoOwner;
    private String passwordOwner; 
    private String telefonoOwner;
    private int estado; 

    public OwnerLocal() {
        this.estado = 1;
    }

    public OwnerLocal(String cedulaOwner, String nombreOwner, String apellidoOwner, 
                      String correoOwner, String passwordOwner, String telefonoOwner, int estado) {
        this.cedulaOwner = cedulaOwner;
        this.nombreOwner = nombreOwner;
        this.apellidoOwner = apellidoOwner;
        this.correoOwner = correoOwner;
        this.passwordOwner = passwordOwner;
        this.telefonoOwner = telefonoOwner;
        this.estado = estado;
    }

    public OwnerLocal(String cedulaOwner, String nombreOwner, String apellidoOwner, 
                      String correoOwner, String passwordOwner, String telefonoOwner) {
        this.cedulaOwner = cedulaOwner;
        this.nombreOwner = nombreOwner;
        this.apellidoOwner = apellidoOwner;
        this.correoOwner = correoOwner;
        this.passwordOwner = passwordOwner;
        this.telefonoOwner = telefonoOwner;
        this.estado = 1; 
    }

    public String getCedulaOwner() {
        return cedulaOwner;
    }

    public void setCedulaOwner(String cedulaOwner) {
        this.cedulaOwner = cedulaOwner;
    }

    public String getNombreOwner() {
        return nombreOwner;
    }

    public void setNombreOwner(String nombreOwner) {
        this.nombreOwner = nombreOwner;
    }

    public String getApellidoOwner() {
        return apellidoOwner;
    }

    public void setApellidoOwner(String apellidoOwner) {
        this.apellidoOwner = apellidoOwner;
    }

    public String getCorreoOwner() {
        return correoOwner;
    }

    public void setCorreoOwner(String correoOwner) {
        this.correoOwner = correoOwner;
    }

    public String getPasswordOwner() {
        return passwordOwner;
    }

    public void setPasswordOwner(String passwordOwner) {
        this.passwordOwner = passwordOwner;
    }

    public String getTelefonoOwner() {
        return telefonoOwner;
    }

    public void setTelefonoOwner(String telefonoOwner) {
        this.telefonoOwner = telefonoOwner;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
}