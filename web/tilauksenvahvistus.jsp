<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" session="true" %>
<jsp:useBean id="apu" scope="session" 
                  class="tilanvarausjarjestelma.pavut.tila"/>
<jsp:useBean id="hash" scope="session" 
                  class="tilanvarausjarjestelma.pavut.Hash"/>
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
                    //haetaan tilaus lomakkeelta kaikki tilauksen tiedot
                    int tilanid = Integer.parseInt(request.getParameter("tilan_id"));
                    String valitut_tunnit = request.getParameter("valitut_tunnit");
                    String varauksen_hinta = request.getParameter("varauksen_hinta");
                    String varauksen_paiva = request.getParameter("varauksen_paiva");
                    String valitut_palvelut = request.getParameter("valitut_palvelut");
                    String valitut_palvelut_idt = request.getParameter("valitut_palvelut_idt");
                    
                    String organisaatio = request.getParameter("organisaatio");
                    String ytunnus = request.getParameter("ytunnus");
                    String etunimi = request.getParameter("etunimi");
                    String sukunimi = request.getParameter("sukunimi");
                    String laskutusosoite = request.getParameter("laskutusosoite");
                    String postinumero = request.getParameter("postinumero");
                    String postitoimipaikka = request.getParameter("postitoimipaikka");
                    String email = request.getParameter("sahkoposti");
                    String puhnum = request.getParameter("puhnum");
                    
                    session.setAttribute("tilan_id", tilanid);
                    session.setAttribute("valitut_tunnit", valitut_tunnit);
                    session.setAttribute("varauksen_hinta", varauksen_hinta);
                    session.setAttribute("varauksen_paiva", varauksen_paiva);
                    session.setAttribute("valitut_palvelut", valitut_palvelut);
                    session.setAttribute("valitut_palvelut_idt", valitut_palvelut_idt);
                    
                    session.setAttribute("organisaatio", organisaatio);
                    session.setAttribute("ytunnus", ytunnus);
                    session.setAttribute("etunimi", etunimi);
                    session.setAttribute("sukunimi", sukunimi);
                    session.setAttribute("laskutusosoite", laskutusosoite);
                    session.setAttribute("postinumero", postinumero);
                    session.setAttribute("postitoimipaikka", postitoimipaikka);
                    session.setAttribute("email", email);
                    session.setAttribute("puhnum", puhnum);
                    
                    //lasketaan pankkivarmenne md5 hasherillä... HUOM! Laskettavassa merkkijonossa ja lomakkeessa pitää olla samat tiedot
                    String pankkivarmenne = hash.md5("6pKF4jkv97zmqBJ3ZL8gUw5DfT2NMQ|13466|"+ varauksen_hinta 
                            +"|123456||Testitilaus|EUR|http://localhost:8084/Tilanvarausjarjestelma/kiitossivu.jsp|http://www.esimerkki.fi/cancel||http://www.esimerkki.fi/notify|S1|fi_FI||1||");
                    
                    //Tilojen haku
                    if (apu.haeTilaIdlla(tilanid)) {
                        
                        while (apu.getTulos().next()) {
                            //haetaan kuvarulrit ja tulostetaan eka kuva valikossa
                                String kuvaurl = apu.getTulos().getString("kuvaurl");
                                String[] kuvienurlit = kuvaurl.split(";");
                        %>
                        
                        <div class="row">
                            
                                <h2>Vahvista tilauksen tiedot</h2><hr/>
                                <div class="col-lg-12 varauksentiedotdivi">
                                    <h3>Tilan tiedot</h3>
                                    <img src="<%=request.getContextPath()%><%out.print(kuvienurlit[0]);%>" width="150" height="100"/>
                                    <h4><% out.print(apu.getTulos().getString("tilannimi"));%></h4>
                                    <p>Päivämäärä: <% out.print(varauksen_paiva);%></p>
                                    <p>Aika:<br/>
                                    <% 
                                        String[] tunnit = valitut_tunnit.split(";");
                                        for (int i = 0; i < tunnit.length; i++) {
                                            out.print(tunnit[i] + "<br/>");
                                        }

                                    %>
                                    </p>
                                    <p>Osoite: <% out.print(apu.getTulos().getString("osoite"));%></p>
                                    <p>Tilatut lisäpalvelut:<br/>
                                    <% 
                                        String[] palvelut = valitut_palvelut.split(";");
                                        if(palvelut[0].equals("")){
                                             out.print("Ei tilattuja lisäpalveluita.");
                                        } else {
                                            for (int i = 0; i < palvelut.length; i++) {
                                                out.print(palvelut[i] + "<br/>");
                                            }
                                        }
                                    %>
                                    </p>
                                    <p>Hinta:<% out.print(varauksen_hinta + "€");%></p>
                                </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 varauksentiedotdivi">
                                <h3>Varaajan tiedot</h3>

                                <p><% out.print(organisaatio);%></p>
                                <p><% out.print(ytunnus);%></p>
                                <p><% out.print(etunimi + " " + sukunimi);%></p>
                                <p><% out.print(laskutusosoite);%></p>
                                <p><% out.print(postinumero + " " + postitoimipaikka);%></p>
                                <p><% out.print(email);%></p>
                                <p><% out.print(puhnum);%></p>
                            </div>
                            <!--kaikki tilauksen tiedot hidden inputeissa-->
                            <input type="text" name="tilan_id" class="piilotetut_inputit" value="<%out.print(tilanid);%>"/>
                            <input type="text" name="valitut_tunnit" class="piilotetut_inputit" value="<%out.print(valitut_tunnit);%>"/>
                            <input type="text" name="varauksen_hinta" class="piilotetut_inputit" value="<%out.print(varauksen_hinta);%>"/>
                            <input type="text" name="varauksen_paiva" class="piilotetut_inputit" value="<%out.print(varauksen_paiva);%>"/>
                            <input type="text" name="valitut_palvelut" class="piilotetut_inputit" value="<%out.print(valitut_palvelut);%>"/>
                            <input type="text" name="valitut_palvelut_idt" class="piilotetut_inputit" value="<%out.print(valitut_palvelut_idt);%>"/><br/>

                            <input type="text" name="organisaatio" class="piilotetut_inputit" value="<%out.print(organisaatio);%>"/>
                            <input type="text" name="ytunnus" class="piilotetut_inputit" value="<%out.print(ytunnus);%>"/>
                            <input type="text" name="etunimi" class="piilotetut_inputit" value="<%out.print(etunimi);%>"/>
                            <input type="text" name="sukunimi" class="piilotetut_inputit" value="<%out.print(sukunimi);%>"/>
                            <input type="text" name="laskutusosoite" class="piilotetut_inputit" value="<%out.print(laskutusosoite);%>"/>
                            <input type="text" name="postinumero" class="piilotetut_inputit" value="<%out.print(postinumero);%>"/>
                            <input type="text" name="postitoimipaikka" class="piilotetut_inputit" value="<%out.print(postitoimipaikka);%>"/>
                            <input type="text" name="sahkoposti" class="piilotetut_inputit" value="<%out.print(email);%>"/>
                            <input type="text" name="puhnum" class="piilotetut_inputit" value="<%out.print(puhnum);%>"/>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 varauksentiedotdivi">
                                <br/><br/>
                                <form action="https://payment.paytrail.com/" method="post">
                                    <input name="MERCHANT_ID" type="hidden" value="13466">
                                    <input name="AMOUNT" type="hidden" value="<% out.print(varauksen_hinta);%>">
                                    <input name="ORDER_NUMBER" type="hidden" value="123456">
                                    <input name="REFERENCE_NUMBER" type="hidden" value="">
                                    <input name="ORDER_DESCRIPTION" type="hidden" value="Testitilaus">
                                    <input name="CURRENCY" type="hidden" value="EUR">
                                    <input name="RETURN_ADDRESS" type="hidden" value="http://localhost:8084/Tilanvarausjarjestelma/kiitossivu.jsp"><!--localhostin tilalle ip jos kokeillaan muilla laitteilla samassa lähiverkossa-->
                                    <input name="CANCEL_ADDRESS" type="hidden" value="http://www.esimerkki.fi/cancel">
                                    <input name="PENDING_ADDRESS" type="hidden" value="">
                                    <input name="NOTIFY_ADDRESS" type="hidden" value="http://www.esimerkki.fi/notify">
                                    <input name="TYPE" type="hidden" value="S1">
                                    <input name="CULTURE" type="hidden" value="fi_FI">
                                    <input name="PRESELECTED_METHOD" type="hidden" value="">
                                    <input name="MODE" type="hidden" value="1">
                                    <input name="VISIBLE_METHODS" type="hidden" value="">
                                    <input name="GROUP" type="hidden" value="">
                                    <input name="AUTHCODE" type="hidden" value="<% out.print(pankkivarmenne.toUpperCase());%>">
                                    <input type="submit" name="tilauksen_vahvistus_nappi" class="jatkanappula" value="Vahvista ja siirry maksamaan varaus">
                                </form>
                                <br/>
                                <button class="perunappula" id="peru_nappi">Peru</button>
                            </div>
                        </div>
                        <%
                        }  // while
                    } else {
                         out.print("Tilojen haku ei onnistu.");
                    }  // if 
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
