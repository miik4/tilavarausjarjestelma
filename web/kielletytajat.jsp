<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" session="true" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<jsp:useBean id="apu" scope="session" 
                  class="tilanvarausjarjestelma.pavut.tila"/>
<jsp:useBean id="apu2" scope="session" 
                  class="tilanvarausjarjestelma.pavut.varaus"/>
<jsp:useBean id="apu3" scope="session" 
                  class="tilanvarausjarjestelma.pavut.lisapalvelu"/>
<jsp:useBean id="apu12" scope="session" 
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
    <script src="js/jquery.js"></script>
    <link href="css/jquery-ui.css" rel="stylesheet">
    <script src="js/jquery-ui.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/glDatePicker.js"></script>
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
                <%  
                    if(session.getAttribute("sessionkirjautuminen")=="kirjautunut"){          
                    String paiva = request.getParameter("paiva");
                    
                    int i=0;
                    int[] arrayid= new int[100];
                    //Varmistetaan merkistö
                    //Kutsu ennen ensimmäistä requestia
                    request.setCharacterEncoding("UTF-8");
                    //Tilan haku
                    
                    if(request.getParameter("nappi0") != null){                 
                        apu12.setPaiva(paiva);
                        
                        if(apu12.lisaaKiellettyPaiva()){
                            out.print("<h4>Kielletty päivä lisätty</h4><br/>");
                        } else {
                            out.print("Tietokantaan ei yhteyttä. Epäonnistui.<br/>");
                        }//if
                    }//if
                %>
                <form method="post" action="kielletytajat.jsp?paiva=<% out.print(paiva); %>">
                    <div class="row">
                        <h5><input type='submit' name='nappi0' class="tilan-valitsemis-linkki"value='Poista päivä käytöstä'></h5>
                        <form action="" method="post">
                            <h5>
                                <input type='submit' name='nappi3' class="tilan-valitsemis-linkki" value='Kirjaudu Ulos'></form>
                            </h5>
                    </div>
                    <div id="kalenterindiv">
                        <h4>Valitse päivä</h4>
                        <input type="text" id="yllapitokalenteri" name="yllapitokalenteri"/>
                    </div>
                </form>
            </div>
        </div>
        <div class="row"></div>
        <%                              
            if(request.getParameter("nappi3") != null) {
                session.invalidate();
                String site = new String("kirjautuminen.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site); 
            }  
        }   else{
                out.print("Et ole kirjautunut sisään.");
                String site = new String("kirjautuminen.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site); 
                }  // if %>    
    </div>
</body>
</html>
