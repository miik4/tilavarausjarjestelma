<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<jsp:useBean id="apu" scope="session" 
                  class="tilanvarausjarjestelma.pavut.tila"/>
<jsp:useBean id="apu2" scope="session" 
                  class="tilanvarausjarjestelma.pavut.varaus"/>
<jsp:useBean id="apu3" scope="session" 
                  class="tilanvarausjarjestelma.pavut.lisapalvelu"/>
<jsp:useBean id="apu11" scope="session" 
                  class="tilanvarausjarjestelma.pavut.kielletytpaivat"/>
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
    <link href="css/glDatePicker.default.css" rel="stylesheet" type="text/css">
    <link href="css/glDatePicker.flatwhite.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <link href="css/jquery-ui.css" rel="stylesheet">
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
                    //Tilan haku
                    
                    int tilanid = Integer.parseInt(request.getParameter("tilanid"));
                    
                    if (apu.haeTilaIdlla(tilanid)) {
                        while (apu.getTulos().next()) {
                            
                            String kuvaurl = apu.getTulos().getString("kuvaurl");
                            String[] kuvienurlit = kuvaurl.split(";");
                            
                        %>
                        <h2><% out.print(apu.getTulos().getString("tilannimi")); %></h2><h4><% out.print("(" + apu.getTulos().getString("hnkhmaara") + " henkilölle) " + apu.getTulos().getString("osoite")); %></h4><hr/>
                        <div class="row">
                            <div class="col-lg-12 tilantietodivi">
                                <div class="isokuva" id="isokuva"><!--tulostetaan eka kuva mikä kannassa isona ja loput pieninä jos niitä on-->
                                    <a href="<%=request.getContextPath()%><%out.print(kuvienurlit[0]);%>" class="img-responsive" id="jattikuvahref"/><!--tähän iso kuva-->
                                    <img src="<%=request.getContextPath()%><%out.print(kuvienurlit[0]);%>" width="800" height="600" id="jattikuva" class="img-responsive"/>
                                    </a>
                                </div>
                                <div class="pikkukuvat row" id="pikkukuvat">
                                    <%
                                        for(int i = 0; i < kuvienurlit.length; i++){
                                            %>
                                            <div class="pikkukuva col-xs-3">
                                                <img src="<%=request.getContextPath()%><%out.print(kuvienurlit[i]);%>" width="120" height="80" class="img-responsive"/>
                                            </div>
                                            <%
                                        }
                                    %>
                                </div>
                                <p><% out.print(apu.getTulos().getString("kuvaus")); %></p>
                                
                                <h4>Varustus</h4>
                                    <ul>
                                        <%
                                        //Haetaan varustus kannasta ja ulostetaan. Varustus kannassa ; erotettuna niin täytyy "räjäyttää" arrayhyn kaikki varusteet erikseen.
                                        String varustus = apu.getTulos().getString("varustus");
                                        String[] varuste = varustus.split(";");

                                        for (int i = 0; i < varuste.length; i++) {

                                            out.print("<li>" + varuste[i] + "</li>");

                                        }
                                        %>
                                    </ul>
                                
                                <h4>Kokoustarjoilut</h4>
                                <p><% out.print(apu.getTulos().getString("kokoustarjoilu")); %></p>
                                
                                <h4>Hintatiedot</h4>
                                <p>ma-pe 8-16: <% out.print(apu.getTulos().getString("hintat") + "€/h tai " + apu.getTulos().getString("hintap") + "€/päivä");%><br/>
                                   ma-pe 16-22, la-su: <% out.print(apu.getTulos().getString("hintayli") + "€/h tai " + apu.getTulos().getString("hintaylip") + "€/päivä");%><br/>
                                   minimiveloitus: <% out.print(apu.getTulos().getString("minvaraust") + "h");%>
                                </p>
                                
                                <h3>Varaa nyt</h3><br/>
                                <form method="post" action="tilauslomake.jsp">
                                        <div id="kalenterindiv">
                                        <h4>Valitse päivä</h4>
                                        <input type="text" id="kalenteri" name="kalenteri"/>
                                        </div>
                                    
                                    <div id="tuntienvalinta">
                                        <h4>Valitse aika</h4>
                                    <%
                                    //tarkistetaan onko tila varattuna valittuna päivänä ja määritetään tunnit jolloin varattu
                                    String paiva = request.getParameter("paiva");
                                    String varatut_tunnit = "";
                                    
                                    //tarkistetaan onko valittu päivä kiellettyjen päivien listalla
                                    boolean onkokielletty = false;
                                    
                                    if(apu11.haeKaikkiKielletytPaivat()){
                                        while (apu11.getTulos().next()) {
                                            if(apu11.getTulos().getString("paiva").equals(paiva)){
                                                onkokielletty = true;
                                            }
                                        }  // while
                                    } else {
                                            out.print("Ei tietokanta yhteyttä.");
                                    }
                                    
                                    if (onkokielletty) {
                                        
                                        out.print("Valitettavasti tätä päivää ei voi varata.");
                                        
                                    } else {
                                        if (apu2.haeVarauksetTilaIdllaJaPaivalla(tilanid, paiva)) {
                                        while (apu2.getTulos().next()) {
                                             varatut_tunnit += apu2.getTulos().getString("varauksen_klo_aika");
                                            }  // while
                                        } else {
                                             out.print("Tilojen haku ei onnistu.");
                                        }  // if 

                                        String[] varattutunti = varatut_tunnit.split(";");

                                        String tunti8 = "vapaa";
                                        String tunti9 = "vapaa";
                                        String tunti10 = "vapaa";
                                        String tunti11 = "vapaa";
                                        String tunti12 = "vapaa";
                                        String tunti13 = "vapaa";
                                        String tunti14 = "vapaa";
                                        String tunti15 = "vapaa";
                                        String tunti16 = "vapaa";
                                        String tunti17 = "vapaa";
                                        String tunti18 = "vapaa";
                                        String tunti19 = "vapaa";
                                        String tunti20 = "vapaa";
                                        String tunti21 = "vapaa";
                                        String tunti22 = "vapaa";

                                        for (int i = 0; i < varattutunti.length; i++) {

                                            if (varattutunti[i].equals("08.00-09.00")) {
                                                tunti8 = "varattu";
                                            }
                                            if (varattutunti[i].equals("09.00-10.00")) {
                                                tunti9 = "varattu";
                                            }
                                            if (varattutunti[i].equals("10.00-11.00")) {
                                                tunti10 = "varattu";
                                            }
                                            if (varattutunti[i].equals("11.00-12.00")) {
                                                tunti11 = "varattu";
                                            }
                                            if (varattutunti[i].equals("12.00-13.00")) {
                                                tunti12 = "varattu";
                                            }
                                            if (varattutunti[i].equals("13.00-14.00")) {
                                                tunti13 = "varattu";
                                            }
                                            if (varattutunti[i].equals("14.00-15.00")) {
                                                tunti14 = "varattu";
                                            }
                                            if (varattutunti[i].equals("15.00-16.00")) {
                                                tunti15 = "varattu";
                                            }
                                            if (varattutunti[i].equals("16.00-17.00")) {
                                                tunti16 = "varattu";
                                            }
                                            if (varattutunti[i].equals("17.00-18.00")) {
                                                tunti17 = "varattu";
                                            }
                                            if (varattutunti[i].equals("18.00-19.00")) {
                                                tunti18 = "varattu";
                                            }
                                            if (varattutunti[i].equals("19.00-20.00")) {
                                                tunti19 = "varattu";
                                            }
                                            if (varattutunti[i].equals("20.00-21.00")) {
                                                tunti20 = "varattu";
                                            }
                                            if (varattutunti[i].equals("21.00-22.00")) {
                                                tunti21 = "varattu";
                                            }
                                            if (varattutunti[i].equals("22.00-23.00")) {
                                                tunti22 = "varattu";
                                            }

                                    }
                                        %>
                                            <div class="tuntilaatikko <% out.print(tunti8); %>" data-hinta="<% out.print(apu.getTulos().getString("hintat"));%>"><% if (tunti8.equals("varattu")) {out.print("Varattu");}else{out.print("08.00-09.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti9); %>" data-hinta="<% out.print(apu.getTulos().getString("hintat"));%>"><% if (tunti9.equals("varattu")) {out.print("Varattu");}else{out.print("09.00-10.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti10); %>" data-hinta="<% out.print(apu.getTulos().getString("hintat"));%>"><% if (tunti10.equals("varattu")) {out.print("Varattu");}else{out.print("10.00-11.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti11); %>" data-hinta="<% out.print(apu.getTulos().getString("hintat"));%>"><% if (tunti11.equals("varattu")) {out.print("Varattu");}else{out.print("11.00-12.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti12); %>" data-hinta="<% out.print(apu.getTulos().getString("hintat"));%>"><% if (tunti12.equals("varattu")) {out.print("Varattu");}else{out.print("12.00-13.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti13); %>" data-hinta="<% out.print(apu.getTulos().getString("hintat"));%>"><% if (tunti13.equals("varattu")) {out.print("Varattu");}else{out.print("13.00-14.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti14); %>" data-hinta="<% out.print(apu.getTulos().getString("hintat"));%>"><% if (tunti14.equals("varattu")) {out.print("Varattu");}else{out.print("14.00-15.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti15); %>" data-hinta="<% out.print(apu.getTulos().getString("hintat"));%>"><% if (tunti15.equals("varattu")) {out.print("Varattu");}else{out.print("15.00-16.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti16); %>" data-hinta="<% out.print(apu.getTulos().getString("hintayli"));%>"><% if (tunti16.equals("varattu")) {out.print("Varattu");}else{out.print("16.00-17.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti17); %>" data-hinta="<% out.print(apu.getTulos().getString("hintayli"));%>"><% if (tunti17.equals("varattu")) {out.print("Varattu");}else{out.print("17.00-18.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti18); %>" data-hinta="<% out.print(apu.getTulos().getString("hintayli"));%>"><% if (tunti18.equals("varattu")) {out.print("Varattu");}else{out.print("18.00-19.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti19); %>" data-hinta="<% out.print(apu.getTulos().getString("hintayli"));%>"><% if (tunti19.equals("varattu")) {out.print("Varattu");}else{out.print("19.00-20.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti20); %>" data-hinta="<% out.print(apu.getTulos().getString("hintayli"));%>"><% if (tunti20.equals("varattu")) {out.print("Varattu");}else{out.print("20.00-21.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti21); %>" data-hinta="<% out.print(apu.getTulos().getString("hintayli"));%>"><% if (tunti21.equals("varattu")) {out.print("Varattu");}else{out.print("21.00-22.00");} %></div>
                                            <div class="tuntilaatikko <% out.print(tunti22); %>" data-hinta="<% out.print(apu.getTulos().getString("hintayli"));%>"><% if (tunti22.equals("varattu")) {out.print("Varattu");}else{out.print("22.00-23.00");} %></div>
                                        <%
                                        }
                                    %>
                                    </div>
                                    <div id="lisapalvelut">
                                        <h4>Valitse lisäpalvelut</h4>
                                        <p>Tarjoilut:</p>
                                        Anna henkilö määrä:<input type="number" name="hklmaara" id="hklmaara" min="0" max="<% out.print(apu.getTulos().getString("hnkhmaara"));%>"/><br/>
                                        <%
                                        if (apu3.haeKaikkiLisapalvelut()) {
                                            while (apu3.getTulos().next()) {
                                                if(apu3.getTulos().getString("lisapalvelutyyppi").equals("tarjoilu")){
                                                    %>
                                                    <input type="checkbox" class="tarjoilutboxit" name="<% out.print(apu3.getTulos().getString("lisapalvelunnimi"));%>" value="<% out.print(apu3.getTulos().getString("lisapalveluhinta") + ";" + apu3.getTulos().getString("lisapalvelutid"));%>"/><label><% out.print(apu3.getTulos().getString("lisapalvelunnimi") + " (" + apu3.getTulos().getString("lisapalveluhinta") + "€/henkilö)");%></label><br>
                                                    <%
                                                }
                                            }  // while
                                        } else {
                                             out.print("Lisäpalveluiden haku ei onnistu.");
                                        }  // if 

                                        %>
                                        
                                        <br/>
                                        <p>Muut palvelut:</p>
                                        <%
                                        if (apu3.haeKaikkiLisapalvelut()) {
                                            while (apu3.getTulos().next()) {
                                                if(apu3.getTulos().getString("lisapalvelutyyppi").equals("muu")){
                                                    %>
                                                    <input type="checkbox" class="muutpalveluboxit" name="<% out.print(apu3.getTulos().getString("lisapalvelunnimi"));%>" value="<% out.print(apu3.getTulos().getString("lisapalveluhinta") + ";" + apu3.getTulos().getString("lisapalvelutid"));%>"/><label><% out.print(apu3.getTulos().getString("lisapalvelunnimi") + " (" + apu3.getTulos().getString("lisapalveluhinta") + "€/h)");%></label><br>
                                                    <%
                                                }
                                            }  // while
                                        } else {
                                             out.print("Lisäpalveluiden haku ei onnistu.");
                                        }  // if 
                                        %>
                                        
                                    </div>
                                    <div id="tilauksentiedot">
                                        <h4>Jatka varausta</h4>
                                        <p>Varauksen hinta: <div id="hinta"><b>0€</b></div></p>
                                        <input type="submit" name="varausnappi" id="varausnappula" value="Jatka"/>
                                        <!--Hidden inputteja tietojen viemiseksi eteenpäin-->
                                        <input type="text" class="piilotetut_inputit" id="valitut_tunnit" name="valitut_tunnit"/><br/>
                                        <input type="text" class="piilotetut_inputit" id="varauksen_hinta" name="varauksen_hinta"/><br/>
                                        <input type="text" class="piilotetut_inputit" id="varauksen_paiva" name="varauksen_paiva" value="<% out.print(paiva);%>"/><br/>
                                        <input type="text" class="piilotetut_inputit" id="tilan_id" name="tilan_id" value="<% out.print(tilanid);%>"/><br/>
                                        <input type="text" class="piilotetut_inputit" id="valitut_palvelut" name="valitut_palvelut"/><br/>
                                        <input type="text" class="piilotetut_inputit" id="valitut_palvelut_idt" name="valitut_palvelut_idt"/><br/>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <%
                        }
                    } else {
                         out.print("Tilan haku ei onnistu.");
                    }  // if 
                %>
            </div>
        </div>
    </div>
<a href="#" id="back-to-top" title="Back to top">&uarr;</a>
</body>
    <script src="js/jquery.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/glDatePicker.js"></script>
    <script src="js/tilanvarausjarjestelma.js"></script>
</html>
