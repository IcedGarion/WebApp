package Beans;

import org.apache.struts.action.ActionForm;

import java.util.Date;

/**
 * Created by ubuntu on 31/05/17.
 */
public class PharmacyBean extends ActionForm
{
    private String cf;
    private String username;
    private String password;
    private String passwordConfirm;
    private String nome;
    private String cognome;
    private String dataNascita;
    private String codRegionale;
    private String usernameF;
    private String passwordF;
    private String nomeF;


    public PharmacyBean()
    {}

    public String getUsernameF() {
        return usernameF;
    }

    public void setUsernameF(String usernameF) {
        this.usernameF = usernameF;
    }

    public String getPasswordF() {
        return passwordF;
    }

    public void setPasswordF(String passwordF) {
        this.passwordF = passwordF;
    }

    public String getNomeF() {
        return nomeF;
    }

    public void setNomeF(String nomeF) {
        this.nomeF = nomeF;
    }

    public String getCf() {
        return cf;
    }

    public void setCf(String cf) {
        this.cf = cf;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getDataNascita() {
        return dataNascita;
    }

    public void setDataNascita(String dataNascita) {
        this.dataNascita = dataNascita;
    }

    public String getCodRegionale() {
        return codRegionale;
    }

    public void setCodRegionale(String codRegionale) {
        this.codRegionale = codRegionale;
    }
}
