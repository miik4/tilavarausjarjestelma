<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="apu6" scope="session" 
                  class="tilanvarausjarjestelma.pavut.hallinta"/>
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
        <div id="page-content-wrapper">
            <div class="container-fluid">
                <h2>TILANVARAUSJÄRJESTELMÄ - Ylläpito</h2><hr/>
                <div class="row">
                        <form method="post" action="">
                            <h5><input type="text" value="" name="tunnus"></h5>
                            <h5><input type="password" value="" name="salasana"></h5>
                            <h5><input type="submit" value="Kirjaudu" name="nappi"/></h5>
                        </form>
                <%
                    if (apu6.tarkistaTunnus()) {
                        while (apu6.getTulos().next()) {
                        String user=apu6.getTulos().getString("user");
                        String password=apu6.getTulos().getString("password");
                        String kayttaja = request.getParameter("tunnus");
                        String salasana = request.getParameter("salasana");
                        
                        if((request.getParameter("nappi") != null)){
                         if(user.equals(kayttaja) && password.equals(salasana)){
                            //session homma
                                String name = "kirjautunut";
                                session.setAttribute( "sessionkirjautuminen", name );
                                out.print("Olet kirjaantunut.");
                                //työkalu-sivustolle siirtyminen kun onnistunut sessio on aloitettu
                                String site = new String("tyokalu.jsp");
                                response.setStatus(response.SC_MOVED_TEMPORARILY);
                                response.setHeader("Location", site);  
                         }
                        else if(!user.equals(kayttaja)){
                            out.print("Käyttäjää ei ole.");
                        }
                        else{
                            out.print("Käyttäjätunnus tai salasana väärin.");
                        }
                        %>                            
                        </div>
                        <%
                        }  // while
                        }
                    } else {
                         out.print("Ei tietokanta yhteyttä.");
                    }  // if 
                %>
            </div>
        </div> 
    </div>
</body>
</html>
