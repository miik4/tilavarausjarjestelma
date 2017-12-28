<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MAMK Tilanvaraus</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/simple-sidebar.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/jquery-ui.css" rel="stylesheet">
   
    <!--Kalenterin tyyli-->
    <link href="css/glDatePicker.default.css" rel="stylesheet" type="text/css">
    <link href="css/glDatePicker.flatwhite.css" rel="stylesheet" type="text/css">
    

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

        <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <!-- Tämä on valikkoon semmonen isompi otsikko juttu
                <li class="sidebar-brand">
                    <a href="#">
                        
                    </a>
                </li>
                -->
                <li>
                    <a href="index.jsp">Tilat</a>
                </li>
                <li>
                    <a href="yhteystiedot.jsp">Yhteystiedot</a>
                </li>
                <!-- Tähän voi lisäillä navigointiin lisää nappeja jos on tarpeellista
                <li>
                    <a href="#"></a>
                </li>
                <li>
                    <a href="#"></a>
                </li>
                <li>
                    <a href="#"></a>
                </li>
                <li>
                    <a href="#"></a>
                </li>
                -->
            </ul>
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid" id="haku_kokonaan">
                <a id="hakupalkki_nappi" class="btn btn-primary" role="button" data-toggle="collapse" href="#hakunamatata" aria-expanded="false" aria-controls="collapseExample">
                    <img src="img/suurennuslasi.png" width="25" height="25" alt="Haku"/><b style="margin-left: 5px;margin-right: 5px;">Hae tiloja</b><span id="hakunuoli" class="glyphicon glyphicon-chevron-down"></span>
                </a>
            
                <div id="hakunamatata" class="container-fluid collapse">
                    <div class="row hakuKone">
                        <div id="haku_divi">
                            <form method="post" action="index.jsp">
                                <div id="haku_slider_divi"><p><b>Henkilömäärä</b></p><div id="haku_slider"></div><input type="number" name="haku_hklmaara" id="haku_hklmaara" value="1"/></div>
                                <div id="haku_chekboxit_divi">
                                    <h4>Varustus</h4>
                                    <div id="haku_vasemmat">
                                    <input type="checkbox" value="pc" name="varusteet" id="pc"/><label>PC</label><br/>
                                    <input type="checkbox" value="netti" name="varusteet" id="netti"/><label>Nettiyhteys</label><br/>
                                    <input type="checkbox" value="videotykki" id="videotykki" name="varusteet"/><label>Videotykki</label><br/>
                                    <input type="checkbox" value="aanentoisto" id="aanentoisto" name="varusteet"/><label>Äänentoisto</label><br/>
                                    </div>
                                    <div id="haku_oikeat">
                                    <input type="checkbox" value="omapc" id="omapc" name="varusteet"/><label>Mahdollisuus omalle PC:lle</label><br/>
                                    <input type="checkbox" value="taulu" name="varusteet" id="taulu"/><label>Taulu</label><br/>
                                    <input type="checkbox" value="piirtoheitin" id="piirtoheitin" name="varusteet"/><label>Piirtoheitin</label><br/>
                                    <input type="checkbox" value="saunatilat" id="saunatilat" name="varusteet"/><label>Saunatilat</label><br/>
                                    </div>
                                </div>
                                <input type="submit" name="haku_nappi" id="haku_nappi" class="jatkanappula" value="Hae"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
