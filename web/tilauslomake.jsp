<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" session="true"%>
<jsp:useBean id="apu4" scope="session" 
                  class="tilanvarausjarjestelma.pavut.asiakas"/>
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
                <h2>Tilauslomake</h2><hr/>
                <div class="row">
                    <form method="post" action="tilauksenvahvistus.jsp" id="tilauslomake">
                        <%
                            //Varmistetaan merkistö
                            //Kutsu ennen ensimmäistä requestia
                            request.setCharacterEncoding("UTF-8");
                            //Tuodaan tilauksen tiedot edelliseltä sivulta hidden inputteihin. Tältä formilta voi sitten viedä ne taas seuraavalle sivulle eteenpäin.
                            int tilanid = Integer.parseInt(request.getParameter("tilan_id"));
                            String valitut_tunnit = request.getParameter("valitut_tunnit");
                            String varauksen_hinta = request.getParameter("varauksen_hinta");
                            String varauksen_paiva = request.getParameter("varauksen_paiva");
                            String valitut_palvelut = request.getParameter("valitut_palvelut");
                            String valitut_palvelut_idt = request.getParameter("valitut_palvelut_idt");
                        %>
                        
                        <input type="text" name="tilan_id" class="piilotetut_inputit" value="<%out.print(tilanid);%>"/>
                        <input type="text" name="valitut_tunnit" class="piilotetut_inputit" value="<%out.print(valitut_tunnit);%>"/>
                        <input type="text" name="varauksen_hinta" class="piilotetut_inputit" value="<%out.print(varauksen_hinta);%>"/>
                        <input type="text" name="varauksen_paiva" class="piilotetut_inputit" value="<%out.print(varauksen_paiva);%>"/>
                        <input type="text" name="valitut_palvelut" class="piilotetut_inputit" value="<%out.print(valitut_palvelut);%>"/>
                        <input type="text" name="valitut_palvelut_idt" class="piilotetut_inputit" value="<%out.print(valitut_palvelut_idt);%>"/><br/>
                        
                        <label for="organisaatio" id="organisaatioLabel"><p>Yrityksen nimi</p></label>
                        <br/><input type="text" value="" name="organisaatio" id="organisaatio"/>

                        <br/><label for="ytunnus" id="ytunnusLabel"><p>Y-tunnus</p></label>
                        <br/><input type="text" name="ytunnus" value="" id="ytunnus">

                        <br/><label for="etunimi" id="etunimiLabel"><p>Etunimi</p></label>
                        <br/><input type="text" name="etunimi" id="etunimi" value="">

                       <br/> <label for="sukunimi" id="sukunimiLabel"><p>Sukunimi</p></label>
                        <br/><input type="text" name="sukunimi" id="sukunimi" value="">

                        <br/><label for="laskutusosoite" id="laskutusosoiteLabel"><p>Laskutusosoite</p></label>
                        <br/><input type="text" name="laskutusosoite" id="laskutusosoite" value="">

                        <br/><label for="postinumero" id="postinumeroLabel"><p>Postinumero</p></label>
                        <br/><input type="text" name="postinumero" id="postinumero" value="">

                        <br/><label for="postitoimipaikka" id="postitoimipaikkaLabel"><p>Postitoimipaikka</p></label>
                        <br/><input type="text" name="postitoimipaikka" id="postitoimipaikka" value="">

                        <br/><label for="sahkoposti" id="sahkopostiLabel"><p>Email</p></label>
                        <br/><input type="text" name="sahkoposti" id="sahkoposti" value="">

                        <br/><label for="puhnum" id="puhnumLabel"><p>Puhelinnumero</p></label>
                        <br/><input type="text" name="puhnum" value="" id="puhnum"><br/>
                        
                        <br/><label for="ehdot" id="ehdotLabel"><p>Hyväksyn <a href="ehdot.jsp">tilaus- ja käyttöehdot</a></p></label>
                        <input type="checkbox" name="ehdot" id="ehdot"><br/>

                        <br/><br/>
                        <button class="perunappula" id="peru_nappi">Peru</button>
                        <input type="submit" class="jatkanappula" name="nappi" value="Jatka varausta">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <a href="#" id="back-to-top" title="Back to top">&uarr;</a>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/tilanvarausjarjestelma.js"></script>
</body>
</html>
