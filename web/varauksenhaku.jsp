<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<jsp:useBean id="apu8" scope="session" 
                  class="tilanvarausjarjestelma.pavut.asiakas"/>
<jsp:useBean id="apu9" scope="session" 
                  class="tilanvarausjarjestelma.pavut.varaus"/>
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
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/tilanvarausjarjestelma.js"></script>
</head>
<body>
    <div id="header">
        <a href="tyokalu.jsp"><img src="img/MAMK_logo.png" width="300" height="161" alt="Mamkin logo"/></a>
    </div>
    <div id="valikko-nappulan-divi">
        <button href="#menu-toggle" class="valikko-nappi hidden-md hidden-lg hidden-sm" id="menu-toggle"><img src="img/valikkonappi.png" /></button>
        Tilanvaraus
    </div>
    <div id="wrapper">
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li>
                    <a href="tyokalu.jsp">Takaisin</a>
                </li>
            </ul>
        </div>
        <div id="page-content-wrapper">
            <div class="container-fluid">
                <h2>TILANVARAUSJÄRJESTELMÄ - Ylläpito</h2><hr/>
                <h3>Muokkaa tai poista varauksia</h3>
                <div class="row">
                <%
                   request.setCharacterEncoding("UTF-8");
                    //pitää olla kirjautunut että sessio on olemassa muuten ei tuo mitään näkyviin
                    if(session.getAttribute("sessionkirjautuminen")=="kirjautunut"){
                          %>   
                       <form method="post" action="">
                       <div id="varauksen_muokkaus">
                        <%
                        if(request.getParameter("nappi0") != null) {

                        String varausid=request.getParameter("varausid");
                        int varausid2 = Integer.parseInt(varausid);
                           int asiakasid = 0;
                           
                            apu9.setVarausid(varausid2);
                            
                            if (apu9.haeVarausIdllaYllapito() && apu9.getTulos().isBeforeFirst()){
                                while (apu9.getTulos().next()) {
                                    %>
                                    <div class="row">
                                    <input type="submit" name="nappi1" class="tilan-valitsemis-linkki" value="Tallenna"/>
                                    <input type="submit" name="nappi2" class="tilan-valitsemis-linkki" value="Poista"/>
                                    </div>    
                                    <%
                                    apu8.setAsiakasnumero(apu9.getTulos().getInt("asiakasid"));
                                    asiakasid = apu9.getTulos().getInt("asiakasid");
                                    %>
                                    <div class="row">
                                    
                                    <h3>Varaus</h3>
                                    Tila:<input type="text" name="tila" value="<%out.print(apu9.getTulos().getString("tilaid"));%>"/><br/>
                                    Päivä:<input type="text" name="paiva" value="<%out.print(apu9.getTulos().getString("paiva"));%>"/><br/>
                                    Aika:<input type="text" name="aika" value="<%out.print(apu9.getTulos().getString("varauksen_klo_aika"));%>"/><br/>
                                    <!--Lisäpalvelut:<input type="text" name="etunimi" value=""/><br/>-->

                                    <%
                                }//while
                                                                
                                if(apu8.haeAsiakkaanIdYllapito()){
                                    while (apu8.getTulos().next()) {
                                        %>
                                       <input type="text" name="varausid2" id="varausid2" class="piilotetut_inputit" value="<%out.print(varausid);%>" />
                                       <input type="text" name="asiakasid" id="asiakasid" class="piilotetut_inputit" value="<%out.print(asiakasid);%>"  /><br/>
                                       Etunimi:<input type="text" name="etunimi" value="<%out.print(apu8.getTulos().getString("etunimi"));%>"/><br/>
                                       Sukunimi:<input type="text" name="sukunimi" value="<%out.print(apu8.getTulos().getString("sukunimi"));%>"/><br/>
                                       Nimike: <input type="text" name="nimike" value="<%out.print(apu8.getTulos().getString("nimike"));%>"/><br/>
                                       Puh:<input type="text" name="puhnum" value="<%out.print(apu8.getTulos().getString("puhnum"));%>"/><br/>
                                       Email: <input type="text" name="email" value="<%out.print(apu8.getTulos().getString("email"));%>"/><br/>
                                       Organisaatio: <input type="text" name="organisaatio" value="<%out.print(apu8.getTulos().getString("organisaatio"));%>"/><br/>
                                       ytunnus: <input type="text" name="ytunnus" value="<%out.print(apu8.getTulos().getString("ytunnus"));%>"/><br/>
                                       laskuosoite:<input type="text" name="laskutusosoite" value="<%out.print(apu8.getTulos().getString("laskutusosoite"));%>"/><br/>
                                       postinumero:<input type="text" name="postinumero" value="<%out.print(apu8.getTulos().getString("postinumero"));%>"/><br/>
                                       Postitoimipaikka:<input type="text" name="postitoimipaikka" value="<%out.print(apu8.getTulos().getString("postitoimipaikka"));%>"/>
                                    
                                    </div><%
                                    }//while
                            
                                } else {
                                    out.print("ei onnistu");
                                }  
                            } else {
                                %>
                                <div class="row"><h4>Varausta ei ole olemassa.</h4>
                                    <a href="varauksenhaku.jsp">Hae uudelleen</a>
                                </div>
                                <%
                            }
                        } else {
                            %>
                            <h4 style="display:inline;">Varauksen-id</h4> <input type="text" name="varausid" size="11"/><input type="submit" name="nappi0" value="Jatka"><br/>
                            <%
                        }
                        //--------
                        //Muokkaus
                        //--------
                         if(request.getParameter("nappi1") != null) {
                    
                            //varauksen tiedot
                            String tila=request.getParameter("tila");
                            int tila2 = Integer.parseInt(tila);
                            String paiva=request.getParameter("paiva");
                            String aika=request.getParameter("aika"); 
                            String varausidlomake = request.getParameter("varausid2");
                            int varausid2 = Integer.parseInt(varausidlomake);
                            //asiakkaan tiedot
                            String asiakaslomake = request.getParameter("asiakasid");
                            int asiakaslomake2 = Integer.parseInt(asiakaslomake);
                            String etunimi=request.getParameter("etunimi");
                            String sukunimi=request.getParameter("sukunimi");
                            String nimike=request.getParameter("nimike");
                            String puhnum=request.getParameter("puhnum");
                            String email=request.getParameter("email");
                            String organisaatio=request.getParameter("organisaatio");
                            String ytunnus=request.getParameter("ytunnus");
                            String laskutusosoite=request.getParameter("laskutusosoite");
                            String postinumero=request.getParameter("postinumero");
                            String postitoimipaikka=request.getParameter("postitoimipaikka");


                            apu8.setAsiakasnumero(asiakaslomake2);
                            apu8.setEtunimi(etunimi);
                            apu8.setSukunimi(sukunimi);
                            apu8.setNimike(nimike);
                            apu8.setPuhnum(puhnum);
                            apu8.setEmail(email);
                            apu8.setOrganisaatio(organisaatio);
                            apu8.setYtunnus(ytunnus);
                            apu8.setLaskutusosoite(laskutusosoite);
                            apu8.setPostinumero(postinumero);
                            apu8.setPostitoimipaikka(postitoimipaikka);
                            apu9.setPaiva(paiva);
                            apu9.setVarauksen_klo_aika(aika);
                            apu9.setVarausid(varausid2);
                            

                            if (apu8.MuokkaaAsiakkaanTietoja()) {
                                out.print("Asiakkaan muokkaus onnistui.<br/>");
                             } else {
                                out.print("Asiakaan muokkaus ei onnistu.<br/>");
                                }

                                if (apu9.MuokkaaVarausYllapito()) {
                                out.print("Varauksen muokkaus onnistui.<br/>");
                             } else {
                                out.print("varauksen muokkaus ei onnistu.<br/>");
                                }

                        
                        }//Muokkaus nappi

                        //--------
                        //POISTO  //asiakkaan poisto
                        //--------
                         if(request.getParameter("nappi2") != null) {
                             String varausid=request.getParameter("varausid2");
                             int varausid2 = Integer.parseInt(varausid);
                           
                        apu9.setVarausid(varausid2);
                        if (apu9.poistaVarausYllapito()) {
                        out.print("Varauksen poisto onnistui");
                                } else {
                                out.print("Varauksen poisto ei onnistunut");
                                    }
                            }
                            

                    } else {
                             out.print("Et ole kirjautunut sisään.");
                        }// if 
                %>
                </div>
                </form>
            </div>
            </div>
        </div>
    </div>
</body>
</html>
