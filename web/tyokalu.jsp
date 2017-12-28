<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<jsp:useBean id="apu7" scope="session" 
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
            <ul class="sidebar-nav"></ul>
        </div>
        <div id="page-content-wrapper">
            <div class="container-fluid">
                <h2>TILANVARAUSJÄRJESTELMÄ - Ylläpito</h2><hr/>
                <h2>VALITSE TYÖKALU</h2><hr/>
                <div class="row">
                <form method="post" action="">
                <%
                    //pitää olla kirjautunut että sessio on olemassa muuten ei tuo mitään näkyviin
                    if(session.getAttribute("sessionkirjautuminen")=="kirjautunut"){
                        %><div class="row"><h5><input type='submit' name='nappi0' class="tilan-valitsemis-linkki" value='Muokkaa tai poista varauksia'></h5></div>
                        <div class="row"><h5><input type='submit' name='nappi1' class="tilan-valitsemis-linkki" value='Määritä päivät joita ei voi varata'></h5></div>
                        <div class="row"><h5><input type='submit' name='nappi2' class="tilan-valitsemis-linkki" value='Muokkaa tiloja'></h5></div>
                        <div class="row"><h5><input type='submit' name='nappi3' class="tilan-valitsemis-linkki" value='Kirjaudu Ulos'></h5></div><%
                        //muokkaa tai poista varauksia napin toiminto
                        if(request.getParameter("nappi0") != null) {
                            String site = new String("varauksenhaku.jsp");
                            response.setStatus(response.SC_MOVED_TEMPORARILY);
                            response.setHeader("Location", site); 
                        }
                        //määritä ajat joita ei voi varata napin toiminto
                        if(request.getParameter("nappi1") != null) {
                            DateFormat dateFormat = new SimpleDateFormat("d.M.yyyy");
                            Date date = new Date();
                            String paiva = dateFormat.format(date);
                            
                            String site = new String("kielletytajat.jsp?paiva="+paiva);
                            response.setStatus(response.SC_MOVED_TEMPORARILY);
                            response.setHeader("Location", site); 
                        }
                        //muokkaa tai poista tiloja napin toiminto
                        if(request.getParameter("nappi2") != null) {
                            String site = new String("yllapitoMuokkaaTilantietoja.jsp");
                            response.setStatus(response.SC_MOVED_TEMPORARILY);
                            response.setHeader("Location", site); 
                        }
                        //uloskirjautumis napin toiminto
                        if(request.getParameter("nappi3") != null) {
                            session.invalidate();
                            String site = new String("kirjautuminen.jsp");
                            response.setStatus(response.SC_MOVED_TEMPORARILY);
                            response.setHeader("Location", site); 
                        }
                        } else {
                            out.print("Et ole kirjautunut sisään.");
                            String site = new String("kirjautuminen.jsp");
                            response.setStatus(response.SC_MOVED_TEMPORARILY);
                            response.setHeader("Location", site); 
                        }  // if 
                %>
                </form>
            </div>
        </div>	
    </div>
</body>
</html>
