package tilanvarausjarjestelma.pavut;

public class asiakas extends perus{
    
    //Nämä vastaa asiakas-taulun kenttiä
    protected int asiakasid = 0;
    protected String etunimi = "";
    protected String sukunimi = "";
    protected String nimike = "";
    protected String puhnum = "";
    protected String email = "";
    protected String organisaatio = "";
    protected String ytunnus = "";
    protected String laskutusosoite = "";
    protected String postinumero = "";
    protected String postitoimipaikka = "";
    

    public asiakas() {
        this.avaaYhteys("root", "");
    }

    //---------------setterit---------------------------------------------------
    public void setAsiakasnumero(int asiakasid) {
        this.asiakasid = asiakasid;
    }

    public void setEtunimi(String etunimi) {
        this.etunimi = etunimi;
    }

    public void setSukunimi(String sukunimi) {
        this.sukunimi = sukunimi;
    }

    public void setNimike(String nimike) {
        this.nimike = nimike;
    }

    public void setPuhnum(String puhnum) {
        this.puhnum = puhnum;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setOrganisaatio(String organisaatio) {
        this.organisaatio = organisaatio;
    }

    public void setYtunnus(String ytunnus) {
        this.ytunnus = ytunnus;
    }

    public void setLaskutusosoite(String laskutusosoite) {
        this.laskutusosoite = laskutusosoite;
    }

    public void setPostinumero(String postinumero) {
        this.postinumero = postinumero;
    }

    public void setPostitoimipaikka(String postitoimipaikka) {
        this.postitoimipaikka = postitoimipaikka;
    }
    
    //--------------------------------------------------------------------------
    
    //-------------------------getterit-----------------------------------------
    public int getAsiakasid() {
        return asiakasid;
    }

    public String getEtunimi() {
        return etunimi;
    }

    public String getSukunimi() {
        return sukunimi;
    }

    public String getNimike() {
        return nimike;
    }

    public String getPuhnum() {
        return puhnum;
    }

    public String getEmail() {
        return email;
    }

    public String getOrganisaatio() {
        return organisaatio;
    }

    public String getYtunnus() {
        return ytunnus;
    }

    public String getLaskutusosoite() {
        return laskutusosoite;
    }

    public String getPostinumero() {
        return postinumero;
    }

    public String getPostitoimipaikka() {
        return postitoimipaikka;
    }
    //--------------------------------------------------------------------------
    
    //------------------------metodit-------------------------------------------
    
    public boolean lisaaAsiakas() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "INSERT INTO asiakastiedot (etunimi, sukunimi, nimike, puhnum, email, organisaatio, ytunnus, laskutusosoite, postinumero, postitoimipaikka) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setString(1, this.getEtunimi());
        this.komento.setString(2, this.getSukunimi());
        this.komento.setString(3, this.getNimike());
        this.komento.setString(4, this.getPuhnum());
        this.komento.setString(5, this.getEmail());
        this.komento.setString(6, this.getOrganisaatio());
        this.komento.setString(7, this.getYtunnus());
        this.komento.setString(8, this.getLaskutusosoite());
        this.komento.setString(9, this.getPostinumero());
        this.komento.setString(10, this.getPostitoimipaikka());
        
        // Lisätään asiakas
        this.komento.executeUpdate();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//lisaaAsiakas
    
    public boolean haeAsiakkaanId() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "SELECT * FROM asiakastiedot WHERE etunimi = ? AND sukunimi = ? AND nimike = ? AND puhnum = ? AND email = ? AND organisaatio = ? AND ytunnus = ? AND laskutusosoite = ? AND postinumero = ? AND postitoimipaikka = ?";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setString(1, this.getEtunimi());
        this.komento.setString(2, this.getSukunimi());
        this.komento.setString(3, this.getNimike());
        this.komento.setString(4, this.getPuhnum());
        this.komento.setString(5, this.getEmail());
        this.komento.setString(6, this.getOrganisaatio());
        this.komento.setString(7, this.getYtunnus());
        this.komento.setString(8, this.getLaskutusosoite());
        this.komento.setString(9, this.getPostinumero());
        this.komento.setString(10, this.getPostitoimipaikka());
        
        this.tulos = this.komento.executeQuery();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//haeAsiakkaanId
    
    public boolean haeAsiakkaanIdYllapito() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "SELECT * FROM asiakastiedot WHERE asiakasid = ?";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setInt(1, this.getAsiakasid());
        
        this.tulos = this.komento.executeQuery();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//haeAsiakkaanId
    
    
    public boolean MuokkaaAsiakkaanTietoja() {
    boolean ok = true;
    try {
        
        //Luodaan ja ajetaan SQL lause
        String lause = "UPDATE asiakastiedot SET  etunimi = ?, sukunimi = ?, nimike = ?, puhnum = ?, email = ?, organisaatio = ?, ytunnus = ?, laskutusosoite = ?, postinumero = ?, postitoimipaikka = ? WHERE asiakasid = ?;";
        
        // Esikäännetään SQL-lause
        this.komento = this.yhteys.prepareStatement(lause);
        
        // Syötetään parametrit
        this.komento.setString(1, this.getEtunimi());
        this.komento.setString(2, this.getSukunimi());
        this.komento.setString(3, this.getNimike());
        this.komento.setString(4, this.getPuhnum());
        this.komento.setString(5, this.getEmail());
        this.komento.setString(6, this.getOrganisaatio());
        this.komento.setString(7, this.getYtunnus());
        this.komento.setString(8, this.getLaskutusosoite());
        this.komento.setString(9, this.getPostinumero());
        this.komento.setString(10, this.getPostitoimipaikka());
        this.komento.setInt(11, this.getAsiakasid());
        
        this.komento.executeUpdate();

    } catch (Exception e1) {
        ok = false;
    } finally {
        return ok;
    }// try
    }//haeAsiakkaanId
    
    
    
    
    
    //--------------------------------------------------------------------------
}
