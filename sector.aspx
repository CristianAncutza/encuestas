<%@ Page Language="C#" MasterPageFile="~/Site.master" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GridView1_DataBind();
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1_DataBind();
        }
        private void GridView1_AddRowFill()
        {
            SECTOR vSECTOR = new SECTOR();
            vSECTOR.New();
            
            ((DropDownList)GridView1.FooterRow.FindControl("ID_GERENCIA")).DataSource = OracleConn.GetData ("SELECT * FROM GERENCIA");
            ((DropDownList)GridView1.FooterRow.FindControl("ID_GERENCIA")).DataTextField = "DESCRIPCION";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_GERENCIA")).DataValueField = "ID_GERENCIA";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_GERENCIA")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("ID_GERENCIA")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("ID_GERENCIA")).SelectedValue = "-1";
            
            ((TextBox)GridView1.FooterRow.FindControl("DES_SECTOR")).Text = Convert.ToString(vSECTOR.DES_SECTOR);

        }
        private void GridView1_EditRowFill()
        {
            SECTOR vSECTOR = new SECTOR();
            vSECTOR.Fill(Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]));

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_GERENCIA")).DataSource = OracleConn.GetData("SELECT * FROM GERENCIA");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_GERENCIA")).DataTextField = "DESCRIPCION";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_GERENCIA")).DataValueField = "ID_GERENCIA";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_GERENCIA")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_GERENCIA")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_GERENCIA")).SelectedValue = Convert.ToString(vSECTOR.ID_GERENCIA);

            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("DES_SECTOR")).Text = Convert.ToString(vSECTOR.DES_SECTOR);
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                switch (e.CommandName)
                {
                    case "Insert":
                        GridView1_Insert();
                        break;

                    case "Update":
                        GridView1_Update();
                        break;
                }

                GridView1_DataBind();
                lbMessage.Text = "";
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                GridView1_Delete(Convert.ToString(GridView1.DataKeys[e.RowIndex].Values[0]));
                GridView1_DataBind();
                lbMessage.Text = "";
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
        }
        private string GridView1_OrderBy
        {
            get
            {
                if (ViewState["GridView1_OrderBy"] == null)
                    return "ID_SECTOR DESC";
                return (string)ViewState["GridView1_OrderBy"];
            }
            set
            {
                ViewState["GridView1_OrderBy"] = value;
            }
        }
        private void GridView1_DataBind()
        {
            DataTable dt = this.DataSource();

            if (dt.Rows.Count == 0)
                dt.Rows.Add(dt.NewRow());

            GridView1.DataSource = GridSort(dt, GridView1_OrderBy);
            GridView1.DataBind();

            GridView1_AddRowFill();
        }
        protected void GridView1_CancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1_DataBind();
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach (TableCell tc in e.Row.Cells)
            {
                tc.Attributes["style"] = "border-color: #c3cecc;";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton l = (LinkButton)e.Row.FindControl("LinkDelete");
                l.Attributes.Add("OnClick", "javascript:return confirm('Confirma Eliminar Registro ID=" + DataBinder.Eval(e.Row.DataItem, "ID_SECTOR") + "')");
            }
        }
        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridView1_OrderBy = e.SortExpression;
            GridView1_DataBind();
        }
        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GridView1_DataBind();
            GridView1_EditRowFill();
        }
        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
            }
        }
        private DataView GridSort(DataTable dt, string pOrderField)
        {
            DataView dv = new DataView(dt);
            dv.Sort = pOrderField;
            return dv;
        }
        private DataTable DataSource()
        {
            return SECTOR.GetAll();
        }
        private void GridView1_Insert()
        {
            try
            {
                SECTOR vSECTOR = new SECTOR();
                
                vSECTOR.ID_GERENCIA = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("ID_GERENCIA")).SelectedValue); 
                vSECTOR.DES_SECTOR = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("DES_SECTOR")).Text.ToString());

                vSECTOR.Create();
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        private void GridView1_Update()
        {
            try
            {
                SECTOR vSECTOR = new SECTOR();

                vSECTOR.ID_SECTOR = Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]);
                vSECTOR.ID_GERENCIA = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_GERENCIA")).SelectedValue);
                vSECTOR.DES_SECTOR = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("DES_SECTOR")).Text.ToString());
                
                vSECTOR.Update();
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }

            GridView1.EditIndex = -1;
        }
        private void GridView1_Delete(string pID)
        {
            try
            {
                SECTOR.Delete(pID);
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<table width="100%"><tr><td align="center" Width="100%">

        <table width="90%"><tr><td><h3>SECTOR</h3></td></tr><tr><td>

        <asp:GridView ID="GridView1" 
        DataKeyNames="ID_SECTOR"
        AllowPaging="True" 
        AllowSorting="True" 
        AutoGenerateColumns="False" 
        FooterStyle-BackColor="White" 
        CssClass="datagrid datagridBig" 
        GridLines="None" 
        runat="server"
        ShowFooter="True" 
        
        OnPageIndexChanging="GridView1_PageIndexChanging"
        OnRowCancelingEdit = "GridView1_CancelingEdit" 
        OnRowCommand = "GridView1_RowCommand" 
        OnRowDataBound="GridView1_RowDataBound" 
        OnRowDeleted = "GridView1_RowDeleted"
        OnRowDeleting = "GridView1_RowDeleting" 
        OnRowEditing = "GridView1_RowEditing"
        OnRowUpdated = "GridView1_RowUpdated"           
        OnRowUpdating = "GridView1_RowUpdating" 
        OnSorting = "GridView1_Sorting" BackColor="White" BorderColor="White" 
            BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" Width="100%">
            
        <RowStyle ForeColor="Black" BackColor="#DEDFDE" />
        <Columns>
            
			<asp:CommandField ShowEditButton="True" ButtonType="Link" EditText ="EDITAR" UpdateText="ACTUALIZAR" CancelText="CANCELAR" />
			
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkDelete" runat="server" CausesValidation="False" CommandName="Delete" ToolTip="Eliminar Registro" Text="ELIMINAR"></asp:LinkButton>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:LinkButton ID="Create" CommandName="Insert" runat="server" ToolTip="Agregar Registro" Text="AGREGAR" />
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="DES_GERENCIA" SortExpression="DES_GERENCIA">
                <ItemTemplate><%# Eval("DES_GERENCIA")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ID_GERENCIA" runat="server"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="ID_GERENCIA" runat="server"/>
                </FooterTemplate>
            </asp:TemplateField>
             
             <asp:TemplateField HeaderText="DES_SECTOR" SortExpression="DES_SECTOR">
                <ItemTemplate><%# Eval("DES_SECTOR")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="DES_SECTOR" Text='<%# Eval("DES_SECTOR") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="DES_SECTOR" Text='' runat="server" Width="300px"/>        
                </FooterTemplate>
            </asp:TemplateField>          
                                                                
		</Columns>
        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" 
            HorizontalAlign="Left" Font-Size="Small" />
        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />

            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#594B9C" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#33276A" />

    </asp:GridView>  
      <asp:Label runat="server" ID="lbMessage" Font-Bold="True" Font-Size="Medium" ForeColor="Red" />
                        </td></tr><tr><td></td></tr></table>
                        
        </td></tr></table>
</asp:Content>