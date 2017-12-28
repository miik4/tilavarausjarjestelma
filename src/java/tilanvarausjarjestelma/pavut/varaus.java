

package tilanvarausjarjestelma.pavut;

public class varaus extends perus{
    
    protected int varausid = 0;
    protected int tilaid = 0;
    protected int asiakasid = 0;
    protected String paiva = "";
    protected String varauksen_klo_aika = "";
    protected int hinta = 0;
    
    public varaus() {
        this.avaaYhteys("root", "");
    }
    
    //---------------------setterit---------------------------------------------

    public void setVarausid(int varausid) {
        this.varausid = varausid;
    }
    
    public void setTilaid(int tilaid) {
        this.tilaid = tilaid;
    }

    public void setAsiakasid(int asiakasid) {
        this.asiakasid = asiakasid;
    }

    public void setPaiva(String paiva) {
        this.paiva = paiva;
    }

    public void setVarauksen_klo_aika(String varauksen_klo_aika) {
        this.varauksen_klo_aika = varauksen_klo_aika;
    }

    public void setHinta(int hinta) {
        this.hinta = hinta;
    }

    
   
    
    //-------------------getterit-----------------------------------------------

    public int getVarausid() {
        return varausid;
    }

    public int getTilaid() {
        return tilaid;
    }

    public int getAsiakasid() {
        return asiakasid;
    }

    public String getPaiva() {
        return paiva;
    }

    public String getVarauksen_klo_aika() {
        return varauksen_klo_aika;
    }

    public int getHinta() {
        return hinta;
    }

    
    //--------------------------------------------------------------------------
    
    //-------------------------metodit------------------------------------------
    
    public boolean haeKaikkiVaraukset() {
        boolean ok = true;
        try {
           String lause = "SELECT * FROM varaukset;";
           this.komento = this.yhteys.prepareStatement(lause);
           this.tulos = this.komento.executeQuery();
        } catch (Exception e1) {
           ok = false;
        } finally {
           return ok; 
        }  // try         
    }//haeKaikkiVaraukset
    
    public boolean haeVarauksetTilaIdllaJaPaivalla(int tilaid, String paiva) {
        boolean ok = true;
        try {
           String lause = "SELECT * FROM varaukset WHERE tilaid = ? AND paiva = ?;";
           
           this.komento = this.yhteys.prepareStatement(lause);
           
           this.komento.setInt(1, tilaid);
           this.komento.setString(2, paiva);
           
           this.tulos = this.komento.executeQuery();
        } catch (Exception e1) {
           ok = false;
        } finally {
           return ok; 
        }  // try         
    }//haeVarauksetTilaIdllaJaPaivalla
    
    public boolean haeVarausIdllaYllapito() {
        boolean ok = true;
        try {
           String lause = "SELECT * FROM varaukset WHERE varausid = ? ;";
           
           this.komento = this.yhteys.prepareStatement(lause);
           
           this.komento.setInt(1, this.getVarausid());
           
           this.tulos = this.komento.executeQuery();
        } catch (Exception e1) {
           ok = false;
        } finally {
           return ok; 
        }  // try         
    }//haeVarausIdlla
    
    public boolean lisaaVaraus() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "INSERT INTO varaukset (tilaid, asiakasid, paiva, varauksen_klo_aika, hinta) VALUES (?, ?, ?, ?, ?);";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setInt(1, this.getTilaid());
        this.komento.setInt(2, this.getAsiakasid());
        this.komento.setString(3, this.getPaiva());
        this.komento.setString(4, this.getVarauksen_klo_aika());
        this.komento.setInt(5, this.getHinta());

        
        // Lisätään varaus
        this.komento.executeUpdate();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//lisaaVaraus
    
    public boolean haeVarauksenId() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "SELECT * FROM varaukset WHERE tilaid = ? AND asiakasid = ? AND paiva = ? AND varauksen_klo_aika = ? AND hinta = ? ;";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setInt(1, this.getTilaid());
        this.komento.setInt(2, this.getAsiakasid());
        this.komento.setString(3, this.getPaiva());
        this.komento.setString(4, this.getVarauksen_klo_aika());
        this.komento.setString(5, Integer.toString(this.getHinta()));

        this.tulos = this.komento.executeQuery();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//haeVarauksenId
    
    public boolean poistaVarausYllapito() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "DELETE FROM varaukset WHERE varausid = ?;";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setInt(1, this.getVarausid());
        
       this.komento.executeUpdate();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//poistaAsiakasYllapito
    
    
    public boolean MuokkaaVarausYllapito() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "UPDATE varaukset SET Paiva = ?, Varauksen_klo_aika = ? WHERE varausid = ?;";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setString(1, this.getPaiva());
        this.komento.setString(2, this.getVarauksen_klo_aika());
       // this.komento.setString(3, Integer.toString(this.getHinta()));
        this.komento.setInt(3, this.getVarausid());
        
        this.komento.executeUpdate();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//poistaAsiakasYllapito

}
