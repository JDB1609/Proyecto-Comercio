/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

public class Local {
    private String nombreLocal;
    private String tipoLocal;
    private String direccionLocal;
    private String horario;
    private String telefonoLocal;
    private String descripcion;
    private int estado; 

    public Local() {
        
    }

    public Local(String nombreLocal, String tipoLocal, String direccionLocal,
                 String horario, String telefonoLocal, String descripcion) {
        this.nombreLocal = nombreLocal;
        this.tipoLocal = tipoLocal;
        this.direccionLocal = direccionLocal;
        this.horario = horario;
        this.telefonoLocal = telefonoLocal;
        this.descripcion = descripcion;
        this.estado = 1; 
    }

    public Local(String nombreLocal, String tipoLocal, String direccionLocal,
                 String horario, String telefonoLocal, String descripcion, int estado) {
        this.nombreLocal = nombreLocal;
        this.tipoLocal = tipoLocal;
        this.direccionLocal = direccionLocal;
        this.horario = horario;
        this.telefonoLocal = telefonoLocal;
        this.descripcion = descripcion;
        this.estado = estado;
    }

 

    public String getNombreLocal() {
        return nombreLocal;
    }

    public void setNombreLocal(String nombreLocal) {
        this.nombreLocal = nombreLocal;
    }

    public String getTipoLocal() {
        return tipoLocal;
    }

    public void setTipoLocal(String tipoLocal) {
        this.tipoLocal = tipoLocal;
    }

    public String getDireccionLocal() {
        return direccionLocal;
    }

    public void setDireccionLocal(String direccionLocal) {
        this.direccionLocal = direccionLocal;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public String getTelefonoLocal() {
        return telefonoLocal;
    }

    public void setTelefonoLocal(String telefonoLocal) {
        this.telefonoLocal = telefonoLocal;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
}