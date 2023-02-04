<%@ Page Language="C#" MasterPageFile="~/Site.master" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GridView1.DataSource = OracleConn.GetData("SELECT * from resultado"); ;
            GridView1.DataBind();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Button2.Visible = true;
        Button3.Visible = true;
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        OracleConn.Execute("delete from resultado");
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        Button2.Visible = false;
        Button3.Visible = false;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:Button ID="Button1" runat="server" Text="VACIAR RESPUESTAS" OnClick="Button1_Click" />
    <asp:Button ID="Button2" runat="server" Text="SEGURO?" Visible="false" OnClick="Button2_Click" />
    <asp:Button ID="Button3" runat="server" Text="CANCELAR VACIAR RESPUESTAS" Visible="false" OnClick="Button3_Click" />
    <asp:GridView ID="GridView1" runat="server">
    </asp:GridView>
    
</asp:Content>

