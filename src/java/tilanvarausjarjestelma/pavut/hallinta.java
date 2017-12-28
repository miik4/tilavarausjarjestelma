package tilanvarausjarjestelma.pavut;
import java.sql.*;

public class hallinta extends perus{
    
    //Nämä vastaa asiakas-taulun kenttiä
    protected int hallintaid = 0;
    protected String user = "";
    protected String password = "";

    

    public hallinta() {
        this.avaaYhteys("root", "");
    }

    //---------------setterit---------------------------------------------------
    public void setHallintaid(int hallintaid) {
        this.hallintaid = hallintaid;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    //--------------------------------------------------------------------------
    
    //-------------------------getterit-----------------------------------------
    public int getHallintaid() {
        return hallintaid;
    }

    public String getUser() {
        return user;
    }

    public String getPassword() {
        return password;
    }
    //--------------------------------------------------------------------------
    
    //------------------------metodit-------------------------------------------
    
    public boolean tarkistaTunnus() {
        boolean ok = true;
        try {
           String lause = "SELECT * FROM hallinta;";
           this.komento = this.yhteys.prepareStatement(lause);
           this.tulos = this.komento.executeQuery();
        } catch (Exception e1) {
           ok = false;
        } finally {
           return ok; 
        }
    }
    
    
    
    //--------------------------------------------------------------------------
}
