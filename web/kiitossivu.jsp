<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" session="true" %>
<jsp:useBean id="apu" scope="session" 
                  class="tilanvarausjarjestelma.pavut.tila"/>
<jsp:useBean id="apu2" scope="session" 
                  class="tilanvarausjarjestelma.pavut.varaus"/>
<jsp:useBean id="apu4" scope="session" 
                  class="tilanvarausjarjestelma.pavut.asiakas"/>
<jsp:useBean id="apu3" scope="session" 
                  class="tilanvarausjarjestelma.pavut.lisapalvelu"/>
<jsp:useBean id="apu5" scope="session" 
                  class="tilanvarausjarjestelma.pavut.tilatutlisapalvelut"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>MAMK Tilanvaraus</title>
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/simple-sidebar.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <div id="header">
        <a href="index.jsp"><img src="img/MAMK_logo.png" width="300" height="161" alt="Mamkin logo"/></a>
    </div>
    <div id="valikko-nappulan-divi">
        <button href="#menu-toggle" class="valikko-nappi hidden-md hidden-lg hidden-sm" id="menu-toggle"><img src="img/valikkonappi.png" /></button>
        Tilanvaraus
    </div>
    <div id="wrapper">
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li>
                    <a href="index.jsp">Tilat</a>
                </li>
                <li>
                    <a href="yhteystiedot.jsp">Yhteystiedot</a>
                </li>
            </ul>
        </div>
        <div id="page-content-wrapper">
            <div class="container-fluid">
                <%
                    //Varmistetaan merkistö
                    //Kutsu ennen ensimmäistä requestia
                    request.setCharacterEncoding("UTF-8");
                    if(request.getParameter("ORDER_NUMBER").equals("123456")){
                    
                        boolean ok = true;
                        //haetaan kaikki tilauksen tiedot
                        int tilanid = Integer.parseInt(session.getAttribute("tilan_id").toString());
                        String valitut_tunnit = session.getAttribute("valitut_tunnit").toString();
                        String varauksen_hinta = session.getAttribute("varauksen_hinta").toString();
                        String varauksen_paiva = session.getAttribute("varauksen_paiva").toString();
                        String valitut_palvelut = session.getAttribute("valitut_palvelut").toString();
                        String valitut_palvelut_idt = session.getAttribute("valitut_palvelut_idt").toString();

                        String organisaatio = session.getAttribute("organisaatio").toString();
                        String ytunnus = session.getAttribute("ytunnus").toString();
                        String etunimi = session.getAttribute("etunimi").toString();
                        String sukunimi = session.getAttribute("sukunimi").toString();
                        String laskutusosoite = session.getAttribute("laskutusosoite").toString();
                        String postinumero = session.getAttribute("postinumero").toString();
                        String postitoimipaikka = session.getAttribute("postitoimipaikka").toString();
                        String email = session.getAttribute("email").toString();
                        String puhnum = session.getAttribute("puhnum").toString();
                    
                        int asiakasid = 0;
                        int varausid = 0;
                        apu4.setOrganisaatio(organisaatio);
                        apu4.setYtunnus(ytunnus);
                        apu4.setEtunimi(etunimi);
                        apu4.setSukunimi(sukunimi);
                        apu4.setLaskutusosoite(laskutusosoite);
                        apu4.setPostinumero(postinumero);
                        apu4.setPostitoimipaikka(postitoimipaikka);
                        apu4.setEmail(email);
                        apu4.setPuhnum(puhnum);
                        
                        if(!apu4.lisaaAsiakas()){
                            ok=false;
                        }
                        
                        if(apu4.haeAsiakkaanId()){
                            while (apu4.getTulos().next()) {
                                asiakasid = apu4.getTulos().getInt("asiakasid");
                            }//while
                        } else {
                            out.print("Ei tietokantayhteyttä!");
                        }
                        
                        //seuraavana lisätään varaus kantaan...tarvii asiakasidn niin sen takia tässä järjestyksessä
                        apu2.setTilaid(tilanid);
                        apu2.setAsiakasid(asiakasid);
                        apu2.setPaiva(varauksen_paiva);
                        apu2.setVarauksen_klo_aika(valitut_tunnit);
                        apu2.setHinta(Integer.parseInt(varauksen_hinta));
                        
                        if(!apu2.lisaaVaraus()){
                            ok=false;
                        } 
                        if(apu2.haeVarauksenId()){
                            while (apu2.getTulos().next()) {
                                varausid = apu2.getTulos().getInt("varausid");
                            }//while
                        } else {
                            out.print("ei onnistu");
                        }
                        
                        //lisätään varauksen tilatut lisäpalvelut kantaan...
                        if (!valitut_palvelut_idt.equals("")) {
                        String[] lisapalvelutid = valitut_palvelut_idt.split(";");
                            for (int i = 0; i < lisapalvelutid.length; i++) {

                                apu5.setVarauksenid(varausid);
                                apu5.setLisapalvelutid(Integer.parseInt(lisapalvelutid[i]));

                                if (!apu5.lisaaTilattulisapalvelu()) {
                                    ok=false;
                                }

                            }
                        }
                        
                        if(ok){
                            %>
                            <div class="row">
                              <h2>Kiitos varauksestasi!</h2><hr/>
                                <div class="col-lg-12 kiitosdivi">
                                    <h3>Varauksesi on vastaanotettu onnistuneesti!</h3>
                                    <p>Tilauksen tiedot on lähetetty sähköpostiin: <% out.print(email);%>.</p>
                                    <a href="index.jsp" class="tilan-valitsemis-linkki">Takaisin tilojen selailuun</a>
                                </div>
                            </div>    
                            <%
                            session.invalidate();
                        } else {
                            
                            out.print("Tilausta ei vastaanotettu! Joku meni pieleen. Yritä uudelleen.");
                            session.invalidate();
                        }
                    }
                %>
                               
            </div>
        </div>
    </div>
<a href="#" id="back-to-top" title="Back to top">&uarr;</a>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/tilanvarausjarjestelma.js"></script>
</body>
</html>
