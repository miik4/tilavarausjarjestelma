<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<jsp:useBean id="apu" scope="session" 
                  class="tilanvarausjarjestelma.pavut.tila"/>
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
            //tultiinko haku napilla
            request.setCharacterEncoding("UTF-8");
            %>
                <div class="container-fluid">
                    <h2>Mikkelin tilat</h2><hr/>
                    <%
                        if(session.getAttribute("sessionkirjautuminen")=="kirjautunut"){ 
                        //tämä päivä otetaan ylös kun tarvii se urlissa viedä seuraavalle tilantieto sivulle

                        //Tilojen haku jotka ovat mikkelissä
                        if (apu.haeKaikkiTilat()) {
                            while (apu.getTulos().next()) {
                                if(apu.getTulos().getString("paikkakunta").equals("mikkeli")) {
                                //haetaan kuvarulrit ja tulostetaan eka kuva valikossa
                                String kuvaurl = apu.getTulos().getString("kuvaurl");
                                String[] kuvienurlit = kuvaurl.split(";");
                            %>
                                    <div class="row">
                                        <div class="col-lg-12 pikkutiladivi">
                                            <div class="otsikko">
                                            <h4><% out.print(apu.getTulos().getString("tilannimi"));%></h4>
                                            </div>
                                            <div class="kts_tarkemmin"><a href="tilanmuokkaus.jsp?tilanid=<%out.print(apu.getTulos().getInt("tilanid"));%>" class="tilan-valitsemis-linkki">Muokkaa</a></div>
                                        </div>
                                    </div>
                            <%
                                }
                            }  // while
                        } else {
                             out.print("Tilojen haku ei onnistu.");
                        }  // if 
                    %>  
                        <h2>Savonlinnan tilat</h2><hr/>
                    <%
                    //Tilojen haku jotka ovat savonlinnassa
                    if (apu.haeKaikkiTilat()) {
                        while (apu.getTulos().next()) {
                            if(apu.getTulos().getString("paikkakunta").equals("savonlinna")) {
                                //haetaan kuvarulrit ja tulostetaan eka kuva valikossa
                                String kuvaurl = apu.getTulos().getString("kuvaurl");
                                String[] kuvienurlit = kuvaurl.split(";");

                    %>
                    <div class="row">
                        <div class="col-lg-12 pikkutiladivi">
                            <div class="otsikko">
                            <h4><% out.print(apu.getTulos().getString("tilannimi"));%></h4>
                            </div>
                            <div class="kts_tarkemmin"><a href="tilanmuokkaus.jsp?tilanid=<%out.print(apu.getTulos().getInt("tilanid"));%>" class="tilan-valitsemis-linkki">Muokkaa</a></div>
                        </div>
                    </div>
                    <%
                            }
                        }  // while
                    } else {
                         out.print("Tilojen haku ei onnistu.");
                    }  //if 
                    if(request.getParameter("nappi3") != null) {
                        session.invalidate();
                        String site = new String("kirjautuminen.jsp");
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", site); 
                    }
                %>
                <div class="row"><h5><form action="" method="post"><input type='submit' name='nappi3' class="tilan-valitsemis-linkki" value='Kirjaudu Ulos'></form></h5></div>
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

