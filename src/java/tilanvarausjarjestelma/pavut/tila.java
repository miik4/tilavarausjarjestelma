package tilanvarausjarjestelma.pavut;

public class tila extends perus{
    
    protected int tilanid = 0;
    protected int hintat = 0; // tuntihinta arkisin 8-16
    protected int hintap = 0;// päivä hinta arkisin
    protected int hintayli = 0;//tuntihinta vkloppuisin ja 16 jälkeen
    protected int hintaylip = 0;//päivähinta vkloppuisin kait?
    protected int hintam = 0;//minimiveloitus tätä ei kai välttämättä tarviis? kun on sama asia ku tuo minvaraustunnit tai siis sen avulla pystyy laskee tän
    protected int minvaraust = 0;//minimi tuntimäärä 
    protected String tilannimi = "";
    protected String osoite = "";
    protected String kuvaus = "";
    protected String varustus = "";
    protected String kuvaurl = "";
    protected int hnkhmaara = 0;
    protected String kokoustarjoilut = "";
    
    //--------huom! nämä vain haku toimintoa varten, tarkemmat laitteistot aina kuvauksessa----------
    protected int netti = 0;
    protected int videotykki = 0;
    protected int saunatilat = 0;
    protected int piirtoheitin = 0;
    protected int pc = 0;
    protected int omapc = 0;
    protected int taulu = 0;
    protected int aanentoisto = 0;
    //------------------------------------------------------------------------------------------------
    
    public tila() {
        this.avaaYhteys("root", "");
    }

    //---------------------setterit---------------------------------------------
    public void setTilanid(int tilanid) {
        this.tilanid = tilanid;
    }

    public void setHintat(int hintat) {
        this.hintat = hintat;
    }

    public void setHintap(int hintap) {
        this.hintap = hintap;
    }

    public void setHintayli(int hintayli) {
        this.hintayli = hintayli;
    }

    public void setHintaylip(int hintaylip) {
        this.hintaylip = hintaylip;
    }

    public void setHintam(int hintam) {
        this.hintam = hintam;
    }

    public void setMinvaraust(int minvaraust) {
        this.minvaraust = minvaraust;
    }

    public void setTilannimi(String tilannimi) {
        this.tilannimi = tilannimi;
    }

    public void setOsoite(String osoite) {
        this.osoite = osoite;
    }

    public void setKuvaus(String kuvaus) {
        this.kuvaus = kuvaus;
    }

    public void setVarustus(String varustus) {
        this.varustus = varustus;
    }

    public void setKuvaurl(String kuvaurl) {
        this.kuvaurl = kuvaurl;
    }

    public void setHnkhmaara(int hnkhmaara) {
        this.hnkhmaara = hnkhmaara;
    }

    public void setNetti(int netti) {
        this.netti = netti;
    }

    public void setVideotykki(int videotykki) {
        this.videotykki = videotykki;
    }

    public void setSaunatilat(int saunatilat) {
        this.saunatilat = saunatilat;
    }

    public void setPiirtoheitin(int piirtoheitin) {
        this.piirtoheitin = piirtoheitin;
    }

    public void setOmapc(int omapc) {
        this.omapc = omapc;
    }

    public void setTaulu(int taulu) {
        this.taulu = taulu;
    }

    public void setAanentoisto(int aanentoisto) {
        this.aanentoisto = aanentoisto;
    }

    public void setPc(int pc) {
        this.pc = pc;
    }

    public void setKokoustarjoilut(String kokoustarjoilut) {
        this.kokoustarjoilut = kokoustarjoilut;
    }
    
    
    //--------------------------------------------------------------------------
    
    //----------------------getterit--------------------------------------------
        public int getTilanid() {
        return tilanid;
    }

    public int getHintat() {
        return hintat;
    }

    public int getHintap() {
        return hintap;
    }

    public int getHintayli() {
        return hintayli;
    }

    public int getHintaylip() {
        return hintaylip;
    }

    public int getHintam() {
        return hintam;
    }

    public int getMinvaraust() {
        return minvaraust;
    }

    public String getTilannimi() {
        return tilannimi;
    }

    public String getOsoite() {
        return osoite;
    }

    public String getKuvaus() {
        return kuvaus;
    }

    public String getVarustus() {
        return varustus;
    }

    public String getKuvaurl() {
        return kuvaurl;
    }

    public int getHnkhmaara() {
        return hnkhmaara;
    }

    public int getNetti() {
        return netti;
    }

    public int getVideotykki() {
        return videotykki;
    }

    public int getSaunatilat() {
        return saunatilat;
    }

    public int getPiirtoheitin() {
        return piirtoheitin;
    }

    public int getPc() {
        return pc;
    }

    public int getOmapc() {
        return omapc;
    }

    public int getTaulu() {
        return taulu;
    }

    public int getAanentoisto() {
        return aanentoisto;
    }

    public String getKokoustarjoilut() {
        return kokoustarjoilut;
    }
    
    

    //--------------------------------------------------------------------------

    //--------------------------metodit-----------------------------------------
    public boolean haeKaikkiTilat() {
        boolean ok = true;
        try {
           String lause = "SELECT * FROM tilantiedot;";
           this.komento = this.yhteys.prepareStatement(lause);
           this.tulos = this.komento.executeQuery();
        } catch (Exception e1) {
           ok = false;
        } finally {
           return ok; 
        }  // try         
    }//haeKaikkiTilat
    
     public boolean haeTilaIdlla(int id) {
        boolean ok = true;
        try {
           String lause = "SELECT * FROM tilantiedot WHERE tilanid= ?";
           
           // Esikäännetään SQL-lause
           this.komento = this.yhteys.prepareStatement(lause);
           
           this.komento.setInt(1, id);
           
           this.tulos = this.komento.executeQuery();
           
        } catch (Exception e1) {
           ok = false;
        } finally {
           return ok; 
        }  // try         
    }//haeTilaIdlla
    
    public boolean hakuKone() {
    boolean ok = true;
    try {
       String lause = "SELECT * FROM tilantiedot WHERE hnkhmaara>=? AND netti>=? AND videotykki>=? AND saunatilat>=? AND piirtoheitin>=? AND pc>=? AND omapc>=? AND taulu>=? AND aanentoisto>=?;";

       // Esikäännetään SQL-lause
       this.komento = this.yhteys.prepareStatement(lause);

       this.komento.setInt(1, this.getHnkhmaara());
       this.komento.setInt(2, this.getNetti());
       this.komento.setInt(3, this.getVideotykki());
       this.komento.setInt(4, this.getSaunatilat());
       this.komento.setInt(5, this.getPiirtoheitin());
       this.komento.setInt(6, this.getPc());
       this.komento.setInt(7, this.getOmapc());
       this.komento.setInt(8, this.getTaulu());
       this.komento.setInt(9, this.getAanentoisto());
       
       this.tulos = this.komento.executeQuery();

    } catch (Exception e1) {
       ok = false;
    } finally {
       return ok; 
    }  // try         
}//hakuKone
    
    public boolean muokkaaTila() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "UPDATE tilantiedot SET hintat=?,hintap=?,hintayli=?,hintaylip=?,minvaraust=?,tilannimi=?,osoite=?,kuvaus=?,hnkhmaara=?,kokoustarjoilu=? WHERE tilanid=?;";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setInt(1, this.getHintat());
        this.komento.setInt(2, this.getHintap());
        this.komento.setInt(3, this.getHintayli());
        this.komento.setInt(4, this.getHintaylip());
        this.komento.setInt(5, this.getMinvaraust());
        this.komento.setString(6, this.getTilannimi());
        this.komento.setString(7, this.getOsoite());
        this.komento.setString(8, this.getKuvaus());
        this.komento.setInt(9, this.getHnkhmaara());
        this.komento.setString(10, this.getKokoustarjoilut());
        this.komento.setInt(11, this.getTilanid());

        // lisätään tiedot
        this.komento.executeUpdate();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//muokkaaTila
    
     
    //--------------------------------------------------------------------------
    
}//class
