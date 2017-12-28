package tilanvarausjarjestelma.pavut;

public class lisapalvelu extends perus{
    
    protected int lisapalveluid = 0;
    protected String lisapalvelutyyppi = "";
    protected String lisapalvennimi = "";
    protected double lisapalveluhinta = 0;
    
    public lisapalvelu() {
        this.avaaYhteys("root", "");
    }
    
    //---------------------------setterit---------------------------------------

    public void setLisapalveluid(int lisapalveluid) {
        this.lisapalveluid = lisapalveluid;
    }

    public void setLisapalvelutyyppi(String lisapalvelutyyppi) {
        this.lisapalvelutyyppi = lisapalvelutyyppi;
    }

    public void setLisapalvennimi(String lisapalvennimi) {
        this.lisapalvennimi = lisapalvennimi;
    }

    public void setLisapalveluhinta(double lisapalveluhinta) {
        this.lisapalveluhinta = lisapalveluhinta;
    }
    
    //--------------------------Getterit----------------------------------------

    public int getLisapalveluid() {
        return lisapalveluid;
    }

    public String getLisapalvelutyyppi() {
        return lisapalvelutyyppi;
    }

    public String getLisapalvennimi() {
        return lisapalvennimi;
    }

    public double getLisapalveluhinta() {
        return lisapalveluhinta;
    }
    
    
    //---------------------------metodit----------------------------------------
    
    public boolean haeKaikkiLisapalvelut() {
        boolean ok = true;
        try {
           String lause = "SELECT * FROM lisapalvelut;";
           this.komento = this.yhteys.prepareStatement(lause);
           this.tulos = this.komento.executeQuery();
        } catch (Exception e1) {
           ok = false;
        } finally {
           return ok; 
        }  // try         
    }//haeKaikkiLisapalvelut
    
    
    
}
