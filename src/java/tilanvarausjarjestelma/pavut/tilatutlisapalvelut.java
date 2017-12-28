package tilanvarausjarjestelma.pavut;

public class tilatutlisapalvelut extends perus{
    
    protected int tilatutlisapalvelutid = 0;
    protected int varauksenid = 0;
    protected int lisapalvelutid = 0;

    
    public tilatutlisapalvelut() {
        this.avaaYhteys("root", "");
    }
    
    //--------------------------------setterit----------------------------------
    public void setTilatutlisapalvelutid(int tilatutlisapalvelutid) {
        this.tilatutlisapalvelutid = tilatutlisapalvelutid;
    }

    public void setVarauksenid(int varauksenid) {
        this.varauksenid = varauksenid;
    }

    public void setLisapalvelutid(int lisapalvelutid) {
        this.lisapalvelutid = lisapalvelutid;
    }
//--------------------------getterit--------------------------------------------
    public int getTilatutlisapalvelutid() {
        return tilatutlisapalvelutid;
    }

    public int getVarauksenid() {
        return varauksenid;
    }

    public int getLisapalvelutid() {
        return lisapalvelutid;
    }
    
    //---------------------------metodit----------------------------------------
    
    public boolean lisaaTilattulisapalvelu() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "INSERT INTO tilatutlisapalvelut (varauksenid, lisapalvelutid) VALUES (?, ?);";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setInt(1, this.getVarauksenid());
        this.komento.setInt(2, this.getLisapalvelutid());

        // Lisätään 
        this.komento.executeUpdate();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//lisaa
    
    
}//class
