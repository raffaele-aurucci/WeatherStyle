<%@ page import="java.util.List" %>
<%@ page import="weatherstyle.gestionecitta.applicationlogic.logic.beans.Citta" %>
<%@ page import="weatherstyle.gestioneambiente.applicationlogic.logic.service.RichiestaPromozioneLogicService" %>
<%@ page import="weatherstyle.gestioneambiente.applicationlogic.logic.beans.RichiestaPromozione" %>
<%@ page import="weatherstyle.gestioneambiente.applicationlogic.logic.service.RichiestaPromozioneLogicImpl" %><%--
  Created by IntelliJ IDEA.
  User: angelopalmieri
  Date: 29/01/23
  Time: 12:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Area Personale</title>
    <%@include file="../../links.jsp"%>
</head>
<body>
<%@include file="../../navbar.jsp"%>
<div class="container">
    <%
        Utente utente = (Utente) session.getAttribute("utente");
        RichiestaPromozioneLogicService richiestaPromozioneLogic = new RichiestaPromozioneLogicImpl();
        RichiestaPromozione richiestaPromozione = richiestaPromozioneLogic.ottieniRichiestaPromozionePerIdUtente(utente.getId());
    %>
    <h1>Area personale</h1>

    <%
        if(!utente.isEcologista() && richiestaPromozione == null ) {
            %>
            <form method="post" action="RichiestaPromozioneServlet">
                <div class="d-grid gap-2 mt-2">
                    <button type="submit" class="btn btn-success">Diventa ecologista!</button>
                </div>
            </form>

        <% } else {
            %>
                <h3 class="display-7">Stato richiesta di promozione in ecologista: <%=richiestaPromozione.getStato()%>.</h3>
            <%
        }
    %>

    <h3 class="display-6">I miei dati</h3>
    <table class="table table-striped table-light">
        <thead>
        <tr>
            <th scope="col">Nome</th>
            <th scope="col">Cognome</th>
            <th scope="col">Data di nascita</th>
            <th scope="col">Email</th>
            <th scope="col">Ecologista</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><%=utente.getNome()%></td>
            <td><%=utente.getCognome()%></td>
            <td><%=utente.getDataNascita()%></td>
            <td><%=utente.getEmail()%></td>
            <%
                if(utente.isEcologista()) {
                    %>
                    <td>Si</td>
                <% }
                else {
                    %>
                    <td>No</td>
                <% }
            %>
        </tr>
        </tbody>
    </table>

    <%
        List<Citta> listCitta = utente.getCitta();;
        if(listCitta.size() == 0) {
            %>
            <h3 class="display-6">Non vi sono preferenze per le città.</h3>
        <% }
        else {
                %>
                <h3 class="display-6">Città preferite</h3>
                <table class="table table-striped table-light">
                    <thead>
                    <tr>
                        <th scope="col">Città</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for(Citta citta: listCitta) {
                            %>
                            <tr>
                                <td><%=citta.getNome()%></td>
                            </tr>
                            <%
                        }
                    %>
                    </tbody>
                </table>
                <%
             } %>

</div>
<%@include file="../../footer.jsp"%>
</body>
</html>
