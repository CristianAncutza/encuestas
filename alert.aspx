<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Close_Click(object sender, EventArgs e)
    {
        Response.Write("<SCRIPT>WINDOW.CLOSE();<\\/SCRIPT>");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
 <div class="title">
                <table width="100%"><tr><td>
                <table width="100%"><tr><td width="1"><img src="Styles/logo.png" /></td><td>
                   </td></tr>
                </table>                
                    </td></tr></table>                
            </div>
    <div style="text-align: center">
        <hr/>
        <h2><%=Convert.ToString (Request.QueryString["message"]) %></h2>
        <hr/>
        <asp:Button ID="Close" runat="server" OnClick="Close_Click" Text="CERRAR" />
    </div>
    </form>
</body>
</html>
