<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string vPublish = Convert.ToString (Request.QueryString["pub"]);
        Label1.Text = "<b>LA ENCUESTA FUE PUBLICADA COMO: <a href='" + vPublish + "' >" + vPublish + "</b>";
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </div>
    </form>
</body>
</html>
