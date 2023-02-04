<%@ Page Language="C#" MasterPageFile="~/Site.master" %>

<%@ import Namespace = "System" %>
<%@ import Namespace = "System.Data"%>
<%@ import Namespace = "System.Data.OracleClient"%>

<script runat="server">
/*
    protected void Button1_Click(object sender, EventArgs e)
    {
        string vConnectionString = ConfigurationSettings.AppSettings["OracleConnectionString"];
        OracleConnection _Conn = new OracleConnection();
        _Conn.ConnectionString = vConnectionString;
        _Conn.Open();

        //// conectate al oracle

    }*/
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<table width="100%">

    <tr><td align="center">

        <table border="1" >
                <tr><td class="auto-style1">01</td><td align="left"><a href="admin_enc.aspx">ADMINISTRACION DE ENCUESTA<br/>Administracion de preguntas y respuesta asociadas</a></td></tr>    
                <tr><td class="auto-style1">02</td><td align="left"><a href="area_tematica.aspx">AREA_TEMATICA<br/>Define el area tematica que clasifica cada pregunta.</a></td></tr>
                <tr><td class="auto-style1">03</td><td align="left"><a href="encuesta.aspx">ENCUESTA<br/>Crea la cabecera de ENCUESTA para luego poder asociar preguntas.</a></td></tr>
                <tr><td class="auto-style1">04</td><td align="left"><a href="estilo.aspx">ESTILO<br/>Define los ESTILO HTML que pueden asociase a cada pregunta.</a></td></tr>
                <tr><td class="auto-style1">05</td><td align="left"><a href="gerencia.aspx">GERENCIA<br/>Define gernecias alcanzadas por una encuesta.</a></td></tr>
                <tr><td class="auto-style1">06</td><td align="left"><a href="perfil.aspx">PERFIL<br/>Define pefiles de usuarios alcanzados por una encuesta.</a></td></tr>                
                <tr><td class="auto-style1">07</td><td align="left"><a href="sector.aspx">SECTOR<br/>Define sectores de usuarios alcanzados por una encuesta.</a></td></tr>
                <tr><td class="auto-style1">08</td><td align="left"><a href="tabla_resp.aspx">TABLA DE RESPUESTAS COMUNES<br/>Respuestas comunes para asociar a una pregunta.</a></td></tr>
                <tr><td class="auto-style1">09</td><td align="left"><a href="usuario.aspx">USUARIOS<br/>Define usuarios alcanzados por una encuesta.</a></td></tr>
                <tr><td class="auto-style1">10</td><td align="left"><a href="respuesta.aspx">RESPUESTAS<br/>Define usuarios alcanzados por una encuesta.</a></td></tr>
        </table>

        </td></tr></table>

</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="HeadContent">
    <style type="text/css">
        .auto-style1 {
            width: 49px;
        }
    </style>
</asp:Content>
