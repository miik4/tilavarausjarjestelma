<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<jsp:useBean id="apu" scope="session" 
                  class="tilanvarausjarjestelma.pavut.tila"/>
<%@ include file="includes/header.jsp" %>
            <%  
            //tultiinko haku napilla
            request.setCharacterEncoding("UTF-8");

            if(request.getParameter("haku_nappi") == null){
                        
            %>
                <div class="container-fluid">

                    <h2>Mikkelin tilat</h2><hr/>
                    <%
                        DateFormat dateFormat = new SimpleDateFormat("d.M.yyyy");
                        Date date = new Date();
                        String paiva = dateFormat.format(date);
                        
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
                                            <img src="<%=request.getContextPath()%><%out.print(kuvienurlit[0]);%>" width="225" height="150" alt="kuva tilasta"/>
                                            <div class="otsikko">
                                            <h4><% out.print(apu.getTulos().getString("tilannimi") + "  <h5>" + apu.getTulos().getString("hnkhmaara") + "henkilölle"); %></h5></h4>
                                            <p><% out.print(apu.getTulos().getString("kuvaus")); %></p>
                                            </div>
                                            <div class="kts_tarkemmin"><a href="tilantiedot.jsp?tilanid=<%out.print(apu.getTulos().getInt("tilanid"));%>&paiva=<%out.print(paiva);%>" class="tilan-valitsemis-linkki">Katso tarkemmin & varaa</a></div>
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
                            <img src="<%=request.getContextPath()%><%out.print(kuvienurlit[0]);%>" width="225" height="150" alt="kuva tilasta"/>
                            <div class="otsikko">
                            <h4><% out.print(apu.getTulos().getString("tilannimi") + "  <h5>" + apu.getTulos().getString("hnkhmaara") + "henkilölle"); %></h5></h4>
                            <p><% out.print(apu.getTulos().getString("kuvaus")); %></p>
                            </div>
                            <div class="kts_tarkemmin"><a href="tilantiedot.jsp?tilanid=<%out.print(apu.getTulos().getInt("tilanid"));%>&paiva=<%out.print(paiva);%>" class="tilan-valitsemis-linkki">Katso tarkemmin & varaa</a></div>
                        </div>
                    </div>
                    <%
                            }
                        }  // while
                    } else {
                         out.print("Tilojen haku ei onnistu.");
                    }  // if 
                } else {
                    
                    int pc = 0;
                    int netti = 0;
                    int videotykki = 0;
                    int aanentoisto = 0;
                    int omapc = 0;
                    int taulu = 0;
                    int piirtoheitin = 0;
                    int saunatilat = 0;
                    int hkl_maara = Integer.parseInt(request.getParameter("haku_hklmaara"));

                    String[] varusteet = request.getParameterValues("varusteet");
                    
                    if(varusteet != null){
                        for (int i = 0; i < varusteet.length; i++) {

                            if(varusteet[i].equals("pc")){
                                pc = 1;
                            }
                            if(varusteet[i].equals("netti")){
                                netti = 1;
                            }
                            if(varusteet[i].equals("videotykki")){
                                videotykki = 1;
                            }
                            if(varusteet[i].equals("aanentoisto")){
                                aanentoisto = 1;
                            }
                            if(varusteet[i].equals("omapc")){
                                omapc = 1;
                            }
                            if(varusteet[i].equals("taulu")){
                                taulu = 1;
                            }
                            if(varusteet[i].equals("piirtoheitin")){
                                piirtoheitin = 1;
                            }
                            if(varusteet[i].equals("saunatilat")){
                                saunatilat = 1;
                            }
                        }
                    }
                    
                    apu.setHnkhmaara(hkl_maara);
                    apu.setPc(pc);
                    apu.setNetti(netti);
                    apu.setVideotykki(videotykki);
                    apu.setAanentoisto(aanentoisto);
                    apu.setOmapc(omapc);
                    apu.setTaulu(taulu);
                    apu.setPiirtoheitin(piirtoheitin);
                    apu.setSaunatilat(saunatilat);
                                                            
                    if(apu.hakuKone()){
                        //tämä päivä otetaan ylös kun tarvii se urlissa viedä seuraavalle tilantieto sivulle
                        DateFormat dateFormat = new SimpleDateFormat("dd.M.yyyy");
                        Date date = new Date();
                        String paiva = dateFormat.format(date);
                        %>
                        
                        <h4>Haun tulokset</h4>
                        
                        <%
                        if(apu.getTulos().isBeforeFirst()){
                            while (apu.getTulos().next()) {
                            //haetaan kuvarulrit ja tulostetaan eka kuva valikossa
                            String kuvaurl = apu.getTulos().getString("kuvaurl");
                            String[] kuvienurlit = kuvaurl.split(";");
                            %>
                            <div class="row">
                                <div class="col-lg-12 pikkutiladivi">
                                    <img src="<%=request.getContextPath()%><%out.print(kuvienurlit[0]);%>" width="225" height="150" alt="kuva tilasta"/>
                                    <div class="otsikko">
                                    <h4><% out.print(apu.getTulos().getString("tilannimi") + "  <h5>" + apu.getTulos().getString("hnkhmaara") + "henkilölle"); %></h5></h4>
                                    <p><% out.print(apu.getTulos().getString("kuvaus")); %></p>
                                    </div>
                                    <div class="kts_tarkemmin"><a href="tilantiedot.jsp?tilanid=<%out.print(apu.getTulos().getInt("tilanid"));%>&paiva=<%out.print(paiva);%>" class="tilan-valitsemis-linkki">Katso tarkemmin & varaa</a></div>
                                </div>
                            </div>
                            <%    
                            }
                        } else {
                        %>    
                            <div class="row">
                                    <div class="col-lg-12 hakuKone">
                                        <p>Valitettavasti sopivia tiloja hakemillasi kriteereillä ei löytynyt.</p>
                                        
                                    </div>
                            </div>
                        <%  
                        } 
                    } else {
                        out.print("Tilojen haku ei onnistu.");
                    }// if 
                }
                %>
            </div>
<%@ include file="includes/footer.jsp" %>
