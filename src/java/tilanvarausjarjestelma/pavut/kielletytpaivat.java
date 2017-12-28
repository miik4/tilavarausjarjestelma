
package tilanvarausjarjestelma.pavut;

public class kielletytpaivat extends perus{
    
    protected int id = 0;
    protected String paiva = "";
    
    public kielletytpaivat() {
        this.avaaYhteys("root", "");
    }

    public int getId() {
        return id;
    }

    public String getPaiva() {
        return paiva;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setPaiva(String paiva) {
        this.paiva = paiva;
    }
    
    //--------------------METODIT-----------------------------------------------
   
    public boolean haeKaikkiKielletytPaivat() {
        boolean ok = true;
        try {
           String lause = "SELECT * FROM kielletytpaivat;";
           this.komento = this.yhteys.prepareStatement(lause);
           this.tulos = this.komento.executeQuery();
        } catch (Exception e1) {
           ok = false;
        } finally {
           return ok; 
        }  // try         
    }//haeKaikkiKielletytPaivat
    
    public boolean lisaaKiellettyPaiva() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "INSERT INTO kielletytpaivat (paiva) VALUES (?);";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setString(1, this.getPaiva());
        
        // Lisätään paiva
        this.komento.executeUpdate();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//lisaaKiellettyPaiva
    
}
