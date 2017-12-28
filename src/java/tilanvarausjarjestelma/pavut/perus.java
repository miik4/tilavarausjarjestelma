package tilanvarausjarjestelma.pavut;
import java.io.*;
import java.sql.*;

public class perus implements Serializable{
    
    protected Connection yhteys = null;
    protected PreparedStatement komento = null;
    protected ResultSet tulos = null;

    public ResultSet getTulos() {
        return tulos;
    }
    
   public boolean avaaYhteys(String tunnus, String sala) {
        boolean ok = true;
        try {
            // Ladataan ajuri ja avataan yhteys - JDBC
            Class.forName("com.mysql.jdbc.Driver");//merkkijono vaihtuu tietokannan mukaan mistä ajuri löytyy... 
            String yhteysjono = "jdbc:mysql://localhost:3306/tilanvarausjarjestelma";//tähän kannan nimi
            this.yhteys = DriverManager.getConnection(yhteysjono,tunnus,sala);
            
        } catch (Exception e1) {
            ok = false;
        } finally {
            return ok;
        }// try
    } //avaaYhteys
    
   public boolean suljeYhteys() {
        boolean ok = true;
        try {
            this.yhteys.close();
        } catch (Exception e1) {
            ok = false;
        } finally {
            return ok;
        }// try
    } //suljeYhteys
}//class
