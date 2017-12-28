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
                    <a href="yllapitoMuokkaaTilantietoja.jsp">Tilat</a>
                </li>
                <li>
                    <a href="tyokalu.jsp">Takaisin</a>
                </li>
            </ul>
        </div>
        <div id="page-content-wrapper">
            <div class="container-fluid">
                <%
                    if(session.getAttribute("sessionkirjautuminen")=="kirjautunut"){ 
                    //Varmistetaan merkistö
                    //Kutsu ennen ensimmäistä requestia
                    request.setCharacterEncoding("UTF-8");
                    //Tilan haku
                    if(request.getParameter("tallenna") != null){
                    
                        int tilanid = Integer.parseInt(request.getParameter("tilanid"));
                        String tilannimi = request.getParameter("tilannimi");
                        String hklmaara = request.getParameter("hklmaara");
                        String osoite = request.getParameter("osoite");
                        String kuvaus = request.getParameter("kuvaus");
                        String kokoustarjoilut = request.getParameter("kokoustarjoilut");
                        String hintat = request.getParameter("hintat");
                        String hintap = request.getParameter("hintap");
                        String hintayli = request.getParameter("hintayli");
                        String hintaylip = request.getParameter("hintaylip");
                        String minvaraust = request.getParameter("minvaraust");
                    
                        apu.setTilanid(tilanid);
                        apu.setTilannimi(tilannimi);
                        apu.setHnkhmaara(Integer.parseInt(hklmaara));
                        apu.setOsoite(osoite);
                        apu.setKuvaus(kuvaus);
                        apu.setKokoustarjoilut(kokoustarjoilut);
                        apu.setHintat(Integer.parseInt(hintat));
                        apu.setHintap(Integer.parseInt(hintap));
                        apu.setHintayli(Integer.parseInt(hintayli));
                        apu.setHintaylip(Integer.parseInt(hintaylip));
                        apu.setMinvaraust(Integer.parseInt(minvaraust));
                        
                        if(apu.muokkaaTila()){
                            %>
                            <h4>Tilan muokkaus tallennettu!</h4>
                            <a href="yllapitoMuokkaaTilantietoja.jsp">Takaisin</a>
                            <%
                        } else {
                            out.print("Jotain meni mönkään.");
                        }
                    } else {
                        int tilanid = Integer.parseInt(request.getParameter("tilanid"));

                        if (apu.haeTilaIdlla(tilanid)) {
                            while (apu.getTulos().next()) {

                                String kuvaurl = apu.getTulos().getString("kuvaurl");
                                String[] kuvienurlit = kuvaurl.split(";");

                            %>
                            <h2>Muokkaa tilan tietoja</h2><hr/>
                            <div class="row">
                                <div class="col-lg-12 tilantietodivi">
                                    <form action="" method="post">
                                        <div class="isokuva" id="isokuva"><!--tulostetaan eka kuva mikä kannassa isona ja loput pieninä jos niitä on-->
                                            <img src="<%=request.getContextPath()%><%out.print(kuvienurlit[0]);%>" width="600" height="400" class="img-responsive"/><!--tähän iso kuva-->
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
                                        <input type="text" name="tilanid" class="piilotetut_inputit" value="<% out.print(request.getParameter("tilanid"));%>"
                                        <p>Tilan nimi: <input name="tilannimi" type="text" value="<% out.print(apu.getTulos().getString("tilannimi")); %>" size="50"/></p>
                                        <p>Henkilö määrä:<input name="hklmaara" type="text" value="<% out.print(apu.getTulos().getString("hnkhmaara"));%>" size="50"/></p>
                                        <p>Osoite:<input name="osoite" type="text" value="<% out.print(apu.getTulos().getString("osoite"));%>" size="50"/></p>
                                        <p>Kuvaus:</p>
                                        <textarea name="kuvaus" cols="50" rows="10"><% out.print(apu.getTulos().getString("kuvaus")); %></textarea>

                                        <h4>Varustus</h4>
                                            <ul>
                                                <%
                                                //Haetaan varustus kannasta ja ulostetaan. Varustus kannassa ; erotettuna niin täytyy "räjäyttää" arrayhyn kaikki varusteet erikseen.
                                                String varustus = apu.getTulos().getString("varustus");
                                                String[] varuste = varustus.split(";");

                                                for (int i = 0; i < varuste.length; i++) {

                                                    out.print("<li><input type='text' size='100' value='" + varuste[i] + "'/></li>");

                                                }
                                                %>
                                            </ul>

                                        <h4>Kokoustarjoilut:</h4>
                                        <p><input type="text" size="100" name="kokoustarjoilut" value="<% out.print(apu.getTulos().getString("kokoustarjoilu")); %>"</p>
                                        <h4>Hintatiedot</h4>
                                        <p>ma-pe 8-16: <input type="text" size="10" name="hintat" value="<% out.print(apu.getTulos().getString("hintat"));%>"/> €/h tai 
                                           <input type="text" size="5" name="hintap" value="<% out.print(apu.getTulos().getString("hintap"));%>"/>"€/päivä"<br/>
                                           ma-pe 16-22, la-su: <input type="text" size="10" name="hintayli" value="<% out.print(apu.getTulos().getString("hintayli"));%>"/> €/h tai 
                                           <input type="text" size="5" name="hintaylip" value="<% out.print(apu.getTulos().getString("hintaylip"));%>"/>"€/päivä"<br/>
                                           minimiveloitus: <input type="text" size="5" name="minvaraust" value="<% out.print(apu.getTulos().getString("minvaraust"));%>" />h
                                        </p> 
                                        <a href="yllapitoMuokkaaTilantietoja.jsp" class="perunappula">Peru</a>
                                        <input type="submit" name="tallenna" value="Tallenna" class="jatkanappula">
                                    </form>
                                    <form action="" method="post"><input type='submit' name='nappi3' class="tilan-valitsemis-linkki" value='Kirjaudu Ulos'></form>
                                </div>
                            </div>
                            <%
                            }
                        } else {
                             out.print("Tilan haku ei onnistu.");
                        }  // if 
                    }
                    if(request.getParameter("nappi3") != null) {
                        session.invalidate();
                        String site = new String("kirjautuminen.jsp");
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", site); 
                    } 
                %>
                <div class="row"><h5></h5></div>
            </div>
              <%} else {
                out.print("Et ole kirjautunut sisään.");
                String site = new String("kirjautuminen.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site); 
                }  // if %>  
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
