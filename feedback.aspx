<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Security" %>

<!DOCTYPE html>

<SCRIPT runat="server">

    public string ID_ENC
    {
        get
        {
            if (ViewState["ID_ENC"] != null)
                return Convert.ToString(ViewState["ID_ENC"]);
            return "-1";
        }
        set
        {
            ViewState["ID_ENC"] = value;
        }
    }

    public string PRESENT_LOGIN
    {
        get
        {
            return Convert.ToString(System.Security.Principal.WindowsIdentity.GetCurrent().Name);
        }
    }
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["ID_ENC"] == null)
                Response.Redirect ("alert.aspx?message=DEBE DEFINIR UNA ENCUESTA.");
            
            if (Request.QueryString["REP"] == null && EsRepetido(Convert.ToString (Request.QueryString["ID_ENC"])))
                 Response.Redirect ("alert.aspx?message=UD YA COMPLETO LA ENCUESTA.");
                
            if (Request.QueryString["ID_ENC"] != null)
            {
                this.ID_ENC = Convert.ToString(Request.QueryString["ID_ENC"]);
                PrintEncuesta();
            }
        }
    }
    private void PrintEncuesta()
    {
        try
        {
            string vControlHtml = "";

            Label1.Text = BuildTable(this.ID_ENC);

            DataTable dtencuesta = OracleConn.GetData("SELECT DESCRIPCION FROM ENCUESTA WHERE ID_ENC=" + this.ID_ENC);

            /// TITULO ENCUESTA ///
            Label1.Text = Label1.Text.Replace("[TITULO]", Convert.ToString(dtencuesta.Rows[0][0]));

            DataTable dtpreguntas = OracleConn.GetData("SELECT * FROM PREGUNTA WHERE ID_ENC=" + this.ID_ENC + " ORDER BY ORDEN");

            for (int preg = 0; preg < dtpreguntas.Rows.Count; preg++)
            {
                /// PRINT PREGUNTA
                Label1.Text = Label1.Text.Replace("[PREGUNTA_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + "]", Convert.ToString(dtpreguntas.Rows[preg]["TEXTO_PREG"]));
                Label1.Text = Label1.Text.Replace("[PREGUNTA_OBS_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + "]", Convert.ToString(dtpreguntas.Rows[preg]["TEXTO_OBS"]));
                vControlHtml = "";

                /// PRINT RESPUESTAS
                if (Convert.ToInt32(dtpreguntas.Rows[preg]["ID_TIPO_RESPUESTA"]) == 1)
                {
                    vControlHtml = "<TEXTAREA NAME='ID_PREG_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + "' ROWS='4' COLS='50'></TEXTAREA>";
                    Label1.Text = Label1.Text.Replace("[RESPUESTA_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + "]", vControlHtml);
                }
                else
                {
                    DataTable dtrespuestas = OracleConn.GetData("SELECT * FROM RESPUESTA WHERE ID_PREG=" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + " ORDER BY ORDEN");

                    if (dtrespuestas.Rows.Count > 0)
                    {
                        if (Convert.ToInt32(dtpreguntas.Rows[preg]["ID_TIPO_RESPUESTA"]) == 2)
                        {
                            vControlHtml = "<SELECT NAME='ID_PREG_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + "'>";
                            for (int i = 0; i < dtrespuestas.Rows.Count; i++)
                                vControlHtml += "<OPTION VALUE='" + Convert.ToString(dtrespuestas.Rows[i]["ID_RESP"]) + "'>" + Convert.ToString(dtrespuestas.Rows[i]["TEXTO_RESP"]) + "</OPTION>";
                            vControlHtml += "</SELECT>";
                        }
                        if (Convert.ToInt32(dtpreguntas.Rows[preg]["ID_TIPO_RESPUESTA"]) == 3)
                        {
                            vControlHtml = "";
                            for (int i = 0; i < dtrespuestas.Rows.Count; i++)
                                vControlHtml += "<INPUT TYPE='checkbox' NAME='ID_PREG_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + "' VALUE='" + Convert.ToString(dtrespuestas.Rows[i]["ID_RESP"]) + "'>" + Convert.ToString(dtrespuestas.Rows[i]["TEXTO_RESP"]);
                        }
                        if (Convert.ToInt32(dtpreguntas.Rows[preg]["ID_TIPO_RESPUESTA"]) == 4)
                        {
                            vControlHtml = "<div class='acidjs-rating-stars' id='" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + "'>";
                            for (int i = 0; i < dtrespuestas.Rows.Count; i++)
                                vControlHtml += "<input type='radio' name='ID_PREG_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + "' id='ID_RESP_" + Convert.ToString(dtrespuestas.Rows[i]["ID_RESP"]) + "-1-" + Convert.ToString(i) + "' value='" + Convert.ToString(dtrespuestas.Rows.Count - i) + "' /><label for='ID_RESP_" + Convert.ToString(dtrespuestas.Rows[i]["ID_RESP"]) + "-1-" + Convert.ToString(i) + "'></label>";
                            vControlHtml += "</div>";
                        }                        
                        Label1.Text = Label1.Text.Replace("[RESPUESTA_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]) + "]", vControlHtml);
                    }
                }
            }
        }
        catch //(Exception ex)
        {
            Response.Redirect("alert.aspx?message=ERROR: La encuesta no puede ser desplegada.");
        }
        
    }
    private string BuildTable(string pID)
    {
        string vResult = "";
        DataTable dtpreguntas = OracleConn.GetData("SELECT * FROM PREGUNTA WHERE ID_ENC=" + pID + " ORDER BY ORDEN");
        vResult += "<TABLE class= titulo><TR><TD><H2>[TITULO]<H2/></TD></TR></TABLE>";
        vResult += "<TABLE class=contenedor CELLSPACING='5' CELLPADDING='5'>";
        for (int i = 0; i < dtpreguntas.Rows.Count; i++)
        {
            vResult += "<TR class= border_bottom td><TD><b>[PREGUNTA_" + Convert.ToString(dtpreguntas.Rows[i]["ID_PREG"]) + "]</b><br/>[PREGUNTA_OBS_" + Convert.ToString(dtpreguntas.Rows[i]["ID_PREG"]) + "]<br/></TD><TD valign='top'>[RESPUESTA_" + Convert.ToString(dtpreguntas.Rows[i]["ID_PREG"]) + "]</TD></TR>";
        }
        vResult += "</TABLE>";
        return vResult;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string ID_PREG ,ID_RESP ,TEXTO_RESP ,FECHA;
        
        DataTable dtpreguntas = OracleConn.GetData("SELECT * FROM PREGUNTA WHERE ID_ENC=" + this.ID_ENC + " ORDER BY ORDEN");
        
        for (int preg = 0; preg < dtpreguntas.Rows.Count; preg++)
        {
            ID_PREG = Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"]);
            try
            {
                ID_RESP = Convert.ToString (Convert.ToInt32(Request.Form["ID_PREG_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"])]));
            }
            catch
            {
                ID_RESP = "-1";
            }
            
            TEXTO_RESP = Convert.ToString (Request.Form["ID_PREG_" + Convert.ToString(dtpreguntas.Rows[preg]["ID_PREG"])]);
            FECHA = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
            
            string vSql = "INSERT INTO RESULTADO (ID_PREG,ID_RESP,TEXTO_RESP,USUARIO,FECHA) VALUES (:ID_PREG,:ID_RESP,:TEXTO_RESP,:USUARIO,:FECHA)";
            string vParamNames = ":ID_PREG|:ID_RESP|:TEXTO_RESP|:USUARIO|:FECHA";
            string vParamValues = ID_PREG + "|" + ID_RESP + "|" + TEXTO_RESP + "|" + PRESENT_LOGIN + "|" + FECHA;

            OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
        }

        Response.Redirect("alert.aspx?message=GRACIAS POR COMPLETAR LA ENCUESTA!");
    }
    private bool EsRepetido(string pENC_ID)
    {
        string vSql = "SELECT COUNT(1) FROM RESULTADO A WHERE A.ID_PREG IN (SELECT B.ID_PREG FROM PREGUNTA B WHERE B.ID_ENC=" + pENC_ID + ") AND A.USUARIO='" + this.PRESENT_LOGIN + "'";
        DataTable dt = OracleConn.GetData(vSql);
        return (Convert.ToInt32(dt.Rows[0][0]) > 0);
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
     <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="Content/total.css" rel="stylesheet" />
    <link href="Styles/start.css" rel="stylesheet" />
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/font-awesome.min.css" rel="stylesheet" />
    <link href="Content/jquery-ui-custom.css" rel="stylesheet" />
    <link href="Content/ui.jqgrid.css" rel="stylesheet" />
    <title></title>
</head>
<body style="font-family: Calibri">
    <form id="form1" runat="server">
    <div>
                    <div class="title">
                <table width="100%"><tr><td>
                <table width="100%"><tr><td width="1"><img src="Styles/logo.png" /></td><td>
                   </td></tr>
                </table>                
                    </td></tr></table>                
            </div>
        <table width="100%">
            <tr>
                <td width="100%" align="center">
                            <table >
                                <tr><td align="center">
                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                        <br />
                                        <asp:Button CssClass="btn" ID="Button1" runat="server" Text="FINALIZAR ENCUESTA" OnClick="Button1_Click" />
                                        <br />                                        
                                    </td>
                                    </tr>
                                </table>
                    </td>
                </tr>
            </table>
    </div>
    </form>
</body>
</html>

