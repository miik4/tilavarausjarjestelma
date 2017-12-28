<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <h2>Yhteystiedot</h2><hr/>
                <div class="row">
                    <div class="col-lg-12 ">
                        <h3>Tilaukset ja tiedustelut</h3>
                        <p>myyntipalvelu@mamk.fi<br/>
                           puh. 0153 556 303.</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 ">
                        <h3>Mikkelin catering palvelut</h3>
                        <p><b>Kampuskahvitus</b><br/>
                           puh. 040 8420 588<br/>
                           sähköposti: kahvitus@mamk.fi
                        </p>
                        
                        <p><b>Ravintola Talli</b><br/>
                           Patteristonkatu 2<br/>
                           50100 Mikkeli<br/>
                           puh. 0153 557 419<br/>
                           sähköposti: ravintolatalli@mamk.fi<br/>
                           <a href="http://www.ravintolatalli.fi" target="blank">www.ravintolatalli.fi</a><br/>
                        </p>
                        
                        <p><b>Ravintola DeXi</b><br/>
                           Patteristonkatu 3<br/>
                           50100 Mikkeli<br/>
                           puh. 0153 556 090<br/>
                           sähköposti: dexi@mamk.fi<br/>
                           <a href="http://www.dexi.fi" target="blank">www.dexi.fi</a><br/>
                        </p>
                        
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 ">
                        <h3>Savonlinan catering palvelut</h3>
                        <p><b>Fazer Amica Kaarisali</b><br/>
                           puh. 040 482 0789<br/>
                           sähköposti: kaarisali@amica.fi<br/>
                           <a href="http://www.amica.fi" target="blank">www.amica.fi</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    </script>
</body>
</html>
