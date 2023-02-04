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
            TABLA_RESP vTABLA_RESP = new TABLA_RESP();
            vTABLA_RESP.New();
            ((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP1")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP1);
            ((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP2")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP2);
            ((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP3")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP3);
            ((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP4")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP4);
            ((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP5")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP5);
            ((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP6")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP6);

        }
        private void GridView1_EditRowFill()
        {
            TABLA_RESP vTABLA_RESP = new TABLA_RESP();
            vTABLA_RESP.Fill(Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]));

            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP1")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP1);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP2")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP2);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP3")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP3);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP4")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP4);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP5")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP5);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP6")).Text = Convert.ToString(vTABLA_RESP.TEXTO_RESP6);
            
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
                    return "ID_RESP_COM DESC";
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
                l.Attributes.Add("OnClick", "javascript:return confirm('Confirma Eliminar Registro ID=" + DataBinder.Eval(e.Row.DataItem, "ID_RESP_COM") + "')");
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
            return TABLA_RESP.GetAll();
        }
        private void GridView1_Insert()
        {
            try
            {
                TABLA_RESP vTABLA_RESP = new TABLA_RESP();
                vTABLA_RESP.TEXTO_RESP1 = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP1")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP2 = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP2")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP3 = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP3")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP4 = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP4")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP5 = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP5")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP6 = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("TEXTO_RESP6")).Text.ToString());

                vTABLA_RESP.Create();
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
                TABLA_RESP vTABLA_RESP = new TABLA_RESP();
                
                vTABLA_RESP.ID_RESP_COM = Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]);
                
                vTABLA_RESP.TEXTO_RESP1 = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP1")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP2 = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP2")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP3 = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP3")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP4 = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP4")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP5 = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP5")).Text.ToString());
                vTABLA_RESP.TEXTO_RESP6 = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_RESP6")).Text.ToString());
                
                vTABLA_RESP.Update();
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
                TABLA_RESP.Delete(pID);
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<table width="100%"><tr><td align="center" Width="100%">

        <table width="90%"><tr><td><h3>TABLA_RESP COMUNES</h3></td></tr><tr><td>

        <asp:GridView ID="GridView1" 
        DataKeyNames="ID_RESP_COM"
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

             <asp:TemplateField HeaderText="TEXTO_RESP1" SortExpression="TEXTO_RESP1">
                <ItemTemplate><%# Eval("TEXTO_RESP1")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_RESP1" Text='<%# Eval("TEXTO_RESP1") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_RESP1" Text='' runat="server" Width="300px"/>        
                </FooterTemplate>
            </asp:TemplateField>       
            
             <asp:TemplateField HeaderText="TEXTO_RESP2" SortExpression="TEXTO_RESP2">
                <ItemTemplate><%# Eval("TEXTO_RESP2")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_RESP2" Text='<%# Eval("TEXTO_RESP2") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_RESP2" Text='' runat="server" Width="300px"/>        
                </FooterTemplate>
            </asp:TemplateField>        
            
             <asp:TemplateField HeaderText="TEXTO_RESP3" SortExpression="TEXTO_RESP3">
                <ItemTemplate><%# Eval("TEXTO_RESP3")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_RESP3" Text='<%# Eval("TEXTO_RESP3") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_RESP3" Text='' runat="server" Width="300px"/>        
                </FooterTemplate>
            </asp:TemplateField>        
            
             <asp:TemplateField HeaderText="TEXTO_RESP4" SortExpression="TEXTO_RESP4">
                <ItemTemplate><%# Eval("TEXTO_RESP4")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_RESP4" Text='<%# Eval("TEXTO_RESP4") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_RESP4" Text='' runat="server" Width="300px"/>        
                </FooterTemplate>
            </asp:TemplateField>        
            
             <asp:TemplateField HeaderText="TEXTO_RESP5" SortExpression="TEXTO_RESP5">
                <ItemTemplate><%# Eval("TEXTO_RESP5")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_RESP5" Text='<%# Eval("TEXTO_RESP5") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_RESP5" Text='' runat="server" Width="300px"/>        
                </FooterTemplate>
            </asp:TemplateField>        
            
             <asp:TemplateField HeaderText="TEXTO_RESP6" SortExpression="TEXTO_RESP6">
                <ItemTemplate><%# Eval("TEXTO_RESP6")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_RESP6" Text='<%# Eval("TEXTO_RESP6") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_RESP6" Text='' runat="server" Width="300px"/>        
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