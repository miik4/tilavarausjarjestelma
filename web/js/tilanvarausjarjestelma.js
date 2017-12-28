var currentlySelected = null;
var selected = [];
var paiva;
var paivapalasina;
var tilanid;
var tamapaiva;
var valitut_tunnit = []; 
var valitut_tunnit_hinta = [];
$(function () {
 
       //pikku kuvat dialogi ikkunaan
        $(".pikkukuva").click(function (e) {
          
           var imagenscr = $(e.target).attr('src');
            $("#jattikuva").attr('src',imagenscr);
            $("jattikuvahref").attr('href',imagenscr);
            return false;
           
       });
     
    var getUrlParameter = function getUrlParameter(sParam) {
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : sParameterName[1];
            }
        }
    };
    //haetaan tilanid ja päivä urlista
    tilanid = getUrlParameter("tilanid");
    paiva = getUrlParameter("paiva");
    
    if(paiva !== undefined){
        paivapalasina = paiva.split(".");
    }
    //menun piilottelu/näyttö pätkä
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    
    if(document.getElementById("varausnappula")){
        document.getElementById("varausnappula").disabled = true;
    }
    
    tamapaiva = new Date();
    
//-----------kalenterin ja tuntien valinta scriptit-----------------------------

//käyttäjä kalenteri
    if(document.getElementById("kalenteri")){
    var kalenteri = $("#kalenteri").glDatePicker({
                showAlways:true,
                selectableDOW : [1,2,3,4,5],//sallitut viikon päivät... viikonloput kielletty tällä
                selectableMonths : [0,1,2,3,4,7,8,9,10,11],
                selectedDate: new Date(paivapalasina[2], paivapalasina[1]-1, paivapalasina[0]),
                borderSize: 1,
                monthNames: ["Tammikuu","Helmikuu","Maaliskuu","Huhtikuu","Toukokuu","Kesäkuu","Heinäkuu","Elokuu","Syyskuu","Lokakuu","Marraskuu","Joulukuu"],
                dowNames: ["Su","Ma","Ti","Ke","To","Pe","La"],
                dowOffset: 1,
                selectableDateRange: [
                { from: new Date(tamapaiva.getFullYear(), tamapaiva.getMonth(), tamapaiva.getDate()), to: new Date (2018, 1, 1) }
                ],
                onClick: (function(el, cell, date, data) {
                    el.val(date.toLocaleDateString());
                    var urlipaiva = date.getDate() + "." + (date.getMonth()+1) + "." + date.getFullYear();
                    $('#tuntienvalinta .ui-selected').removeClass("ui-selected");
                    //kun valitaan eri päivä niin ladataan sivu uusiks (#kalenteri scrollaa sivun automaattisesti tuon divin kohdalle kun sivu ladataan uudelleen... muuten sivunäkymä on ihan sivun ylhäällä)
                    document.location.href = "tilantiedot.jsp?tilanid=" + tilanid + "&paiva=" + urlipaiva + "#kalenteri";
                })  
	});
	}
		
	//ylläpito kalenteri
	if(document.getElementById("yllapitokalenteri")){
            $("#yllapitokalenteri").glDatePicker({
                showAlways:true,
				selectableDOW : [1,2,3,4,5],//sallitut viikon päivät... viikonloput kielletty tällä
                selectedDate: new Date(paivapalasina[2], paivapalasina[1]-1, paivapalasina[0]),
                borderSize: 1,
                monthNames: ["Tammikuu","Helmikuu","Maaliskuu","Huhtikuu","Toukokuu","Kesäkuu","Heinäkuu","Elokuu","Syyskuu","Lokakuu","Marraskuu","Joulukuu"],
                dowNames: ["Su","Ma","Ti","Ke","To","Pe","La"],
                dowOffset: 1,
                selectableDateRange: [
                { from: new Date(tamapaiva.getFullYear(), tamapaiva.getMonth(), tamapaiva.getDate()), to: new Date (2018, 1, 1) }
                ],
                onClick: (function(el, cell, date, data) {
                    el.val(date.toLocaleDateString());
                    var urlipaivakalu = date.getDate() + "." + (date.getMonth()+1) + "." + date.getFullYear();
                    $('#tuntienvalinta .ui-selected').removeClass("ui-selected");
                    //kun valitaan eri päivä niin ladataan sivu uusiks (#kalenteri scrollaa sivun automaattisesti tuon divin kohdalle kun sivu ladataan uudelleen... muuten sivunäkymä on ihan sivun ylhäällä)
                    window.location.href = "kielletytajat.jsp?paiva=" + urlipaivakalu + "#kalenteri";
                })    
    });
    }
    
    if(document.getElementById("tuntienvalinta")){
    $('#tuntienvalinta').selectable({
        filter: ".vapaa",
        start: function(event, ui) {
            currentlySelected = $('#tuntienvalinta .ui-selected');
            valitutTunnit();
        },
        stop: function(event, ui) {
            for (var i = 0; i < selected.length; i++) {
                if ($.inArray(selected[i], currentlySelected) >= 0) {
                  $(selected[i]).removeClass('ui-selected');
                }
            }
            selected = [];
            valitutTunnit();
            laskeHinta();
        },
        selecting: function(event, ui) {
            currentlySelected.addClass('ui-selected');
        },
        selected: function(event, ui) {
            selected.push(ui.selected);
        }
    });
    }
    
//------------------------------------------------------------------------------
//-------------------------event listenereitä hinnan laskemiselle---------------
$(".tarjoilutboxit").change(laskeHinta);
$(".muutpalveluboxit").change(laskeHinta);
$("#hklmaara").change(laskeHinta);
//------------------------------------------------------------------------------
//------------------------tilauslomakkeen tarkistus ja lähetys------------------
    $("#tilauslomake").submit(function( event ) {
      if(validateForm()){//formin tarkistus funktio globaalina alempana
          $("#tilauslomake").submit();
      } else {
          event.preventDefault();
      }
    });
    $("#peru_nappi").click(function(e){
        e.preventDefault();
        document.location.href = "index.jsp";
    });
//------------------------------------------------------------------------------
//------------------------Haku--------------------------------------------------
    if(document.getElementById("haku_slider")){
        $("#haku_slider").slider({
                                    min:0,
                                    max:301,
                                    slide: function( event, ui ) {
                                        var arvo = $( "#haku_slider" ).slider( "option", "value" );
                                        $("#haku_hklmaara").val(arvo);
                                    },
                                    change: function( event, ui ) {
                                        var arvo = $( "#haku_slider" ).slider( "option", "value" );
                                        $("#haku_hklmaara").val(arvo);
                                    }
                                });
    }

//------------------------------------------------------------------------------
$("#hakupalkki_nappi").click(function (e) {
        $("#hakunuoli").toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
});
try{
   console;
}catch(e){
   console={}; console.log = function(){};
}

});//sivun lataus

//--------------------------Globaaaleja funktioita------------------------------
function laskeHinta() {
    var valitut_palvelut_id = "";
    var hinta = 0;
    for (var i = 0; i < valitut_tunnit_hinta.length; i++) {
        
        hinta += valitut_tunnit_hinta[i];
        
    }

    var henkilot = $("#hklmaara").val();
    var valitut_tarjoilut = [];
    var valitut_palvelut_tekstina = "";
    var tarjoiluiden_hinta = 0;
    
    $('.tarjoilutboxit:checked').each(function() {
        var hinta_tiedot = $(this).val().split(";");
        valitut_tarjoilut.push(hinta_tiedot[0]);
        valitut_palvelut_id += hinta_tiedot[1] + ";";
        valitut_palvelut_tekstina += $(this).next("label").text() + ";";
    });
    
    for (var i = 0; i < valitut_tarjoilut.length; i++) {
        tarjoiluiden_hinta = tarjoiluiden_hinta + (henkilot * valitut_tarjoilut[i]);
    }
    
    hinta = hinta + tarjoiluiden_hinta;

    var valitutmuutlisapalvelut = [];
    $('.muutpalveluboxit:checked').each(function() {
        var hinta_tiedot = $(this).val().split(";");
        valitutmuutlisapalvelut.push(hinta_tiedot[0]);
        valitut_palvelut_id += hinta_tiedot[1] + ";";
        valitut_palvelut_tekstina += $(this).next("label").text() + ";";
    });
    
    for (var i = 0; i < valitutmuutlisapalvelut.length; i++) {
        hinta = hinta + (valitut_tunnit.length * valitutmuutlisapalvelut[i]);
    }

    $("#hinta").html(hinta + "€");
    $("#varauksen_hinta").val(hinta);
    $("#valitut_palvelut").val(valitut_palvelut_tekstina);
    $("#valitut_palvelut_idt").val(valitut_palvelut_id);
    
}



function valitutTunnit(){
    
    $("#valitut_tunnit").val("");
    
    valitut_tunnit = []; //valitut tunnit haetaan arrayhyn
    valitut_tunnit_hinta = [];//haetaan hinnat myös arrayhyn
    var valitutpotkossa = "";
    
    $("#tuntienvalinta > .ui-selected").each(function () {
            
            valitut_tunnit.push($(this).html());
            valitut_tunnit_hinta.push($(this).data("hinta"));
            
    });
    
    for(var i = 0; i < valitut_tunnit.length; i++){
        
        valitutpotkossa += valitut_tunnit[i] + ";";
        
    }
    
    $("#valitut_tunnit").val(valitutpotkossa);
    
    //varausnappi disaploituna jos ei tunteja valittuna
    if (valitutpotkossa !== "") {
        document.getElementById("varausnappula").disabled = false;
    } else {
        document.getElementById("varausnappula").disabled = true;
    }
}
//------------------------------------------------------------------------------
//-------------------------Tilauslomakkeen tarkistus----------------------------
function validateForm(){//varastettu netistä ja muokattu omaan käyttöön
    
    ok = true;
    var nameReg = /^[A-Za-z-ä-ö-Ä-Ö]+$/;
    var numberReg =  /^[0-9]+$/;
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

    var organisaatio = $('#organisaatio').val();
    var ytunnus = $('#ytunnus').val();
    var etunimi = $('#etunimi').val();
    var sukunimi = $('#sukunimi').val();
    var laskutusosoite = $('#laskutusosoite').val();
    var postinumero = $('#postinumero').val();
    var postitoimipaikka = $('#postitoimipaikka').val();
    var email = $('#sahkoposti').val();
    var puhnum = $('#puhnum').val();
    var ehdot = false;
    var inputVal = new Array(organisaatio, ytunnus, etunimi, sukunimi, laskutusosoite, postinumero, postitoimipaikka, email, puhnum);
    var inputMessage = new Array("yrityksen nimi", "y-tunnus", "etunimi", "sukunimi", "laskutusosoite", "postinumero", "postitoimipaikka", "email", "puhelinnumero", "tilaus- ja käyttöehdot");

     $('.error').hide();
        if($("#ehdot").is(':checked')){
            ehdot = true;
        }
        
        if(ehdot != true){
            $('#ehdot').after('<span class="error"> *Sinun täytyy hyväksyä ' + inputMessage[9] + '</span>');
            ok = false;
        }
     
        if(inputVal[0] == ""){
            $('#organisaatio').after('<span class="error"> *Anna ' + inputMessage[0] + '</span>');
            ok = false;
        }
        
        if(inputVal[1] == ""){
            $('#ytunnus').after('<span class="error"> *Anna ' + inputMessage[1] + '</span>');
            ok = false;
        }
        
        if(inputVal[2] == ""){
            $('#etunimi').after('<span class="error"> *Anna ' + inputMessage[2] + '</span>');
            ok = false;
        } 
        else if(!nameReg.test(etunimi)){
            $('#etunimi').after('<span class="error"> *Anna vain kirjaimia</span>');
            ok = false;
        }
        
        if(inputVal[3] == ""){
            $('#sukunimi').after('<span class="error"> *Anna ' + inputMessage[3] + '</span>');
            ok = false;
        } 
        else if(!nameReg.test(sukunimi)){
            $('#sukunimi').after('<span class="error"> *Anna vain kirjaimia</span>');
            ok = false;
        }

        if(inputVal[4] == ""){
            $('#laskutusosoite').after('<span class="error"> *Anna ' + inputMessage[4] + '</span>');
            ok = false;
        }

        if(inputVal[5] == ""){
            $('#postinumero').after('<span class="error"> *Anna ' + inputMessage[5] + '</span>');
            ok = false;
        }
        else if(!numberReg.test(postinumero)){
            $('#postinumero').after('<span class="error"> *Anna vain numeroita</span>');
            ok = false;
        }
        else if(postinumero.length !== 5){
            $('#postinumero').after('<span class="error"> *Tarkista postinumero. Postinumeron pituus tulee olla 5 numeroa</span>');
            ok = false;
        }
        
        if(inputVal[6] == ""){
            $('#postitoimipaikka').after('<span class="error"> *Anna ' + inputMessage[6] + '</span>');
            ok = false;
        } 
        else if(!nameReg.test(postitoimipaikka)){
            $('#postitoimipaikka').after('<span class="error"> *Anna vain kirjaimia</span>');
            ok = false;
        }
        
        if(inputVal[7] == ""){
            $('#sahkoposti').after('<span class="error"> *Anna ' + inputMessage[7] + '</span>');
            ok = false;
        } 
        else if(!emailReg.test(email)){
            $('#sahkoposti').after('<span class="error"> *Anna kelvollinen sähköpostiosoite</span>');
            ok = false;
        }

        if(inputVal[8] == ""){
            $('#puhnum').after('<span class="error"> *Anna ' + inputMessage[8] + '</span>');
            ok = false;
        } 
        else if(!numberReg.test(puhnum)){
            $('#puhnum').after('<span class="error"> *Anna vain numeroita</span>');
            ok = false;
        }
        return ok;
}  

if ($('#back-to-top').length) {
    var scrollTrigger = 100, // px
        backToTop = function () {
            var scrollTop = $(window).scrollTop();
            if (scrollTop > scrollTrigger) {
                $('#back-to-top').addClass('show');
            } else {
                $('#back-to-top').removeClass('show');
            }
        };
    backToTop();
    $(window).on('scroll', function () {
        backToTop();
    });
    $('#back-to-top').on('click', function (e) {
        e.preventDefault();
        $('html,body').animate({
            scrollTop: 0
        }, 700);
    });
}
//------------------------------------------------------------------------------
