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
            ENCUESTA vENCUESTA = new ENCUESTA();
            vENCUESTA.New();
            
            ((TextBox)GridView1.FooterRow.FindControl("ID_ENC")).Text = Convert.ToString(vENCUESTA.ID_ENC);

            ((TextBox)GridView1.FooterRow.FindControl("DES_ENCUESTA")).Text = Convert.ToString(vENCUESTA.DES_ENCUESTA);
            ((TextBox)GridView1.FooterRow.FindControl("ANONIMO")).Text = Convert.ToString(vENCUESTA.ANONIMO);
            ((TextBox)GridView1.FooterRow.FindControl("USUARIO_TODOS")).Text = Convert.ToString(vENCUESTA.USUARIO_TODOS);
            ((TextBox)GridView1.FooterRow.FindControl("ESTADO")).Text = Convert.ToString(vENCUESTA.ESTADO);
            ((TextBox)GridView1.FooterRow.FindControl("FECHA_VTO")).Text = Convert.ToString(vENCUESTA.FECHA_VTO);
            ((TextBox)GridView1.FooterRow.FindControl("EPIGRAFE")).Text = Convert.ToString(vENCUESTA.EPIGRAFE);
            
            
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).DataSource = OracleConn.GetData("SELECT * FROM AREA_TEMATICA");
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).DataTextField = "DESCRIPCION";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).DataValueField = "ID_AREA_TEMATICA";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).SelectedValue = "-1";
        }
        private void GridView1_EditRowFill()
        {
            ENCUESTA vENCUESTA = new ENCUESTA();
            vENCUESTA.Fill(Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]));

            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("ID_ENC")).Text = Convert.ToString(vENCUESTA.ID_ENC);

            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("DES_ENCUESTA")).Text = Convert.ToString(vENCUESTA.DES_ENCUESTA);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("ANONIMO")).Text = Convert.ToString(vENCUESTA.ANONIMO);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("USUARIO_TODOS")).Text = Convert.ToString(vENCUESTA.USUARIO_TODOS);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("ESTADO")).Text = Convert.ToString(vENCUESTA.ESTADO);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_VTO")).Text = Convert.ToString(vENCUESTA.FECHA_VTO);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("EPIGRAFE")).Text = Convert.ToString(vENCUESTA.EPIGRAFE);

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).DataSource = OracleConn.GetData("SELECT * FROM AREA_TEMATICA");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).DataTextField = "DESCRIPCION";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).DataValueField = "ID_AREA_TEMATICA";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).SelectedValue = Convert.ToString(vENCUESTA.ID_AREA_TEMATICA);
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
                    return "ID_ENC DESC";
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
                l.Attributes.Add("OnClick", "javascript:return confirm('Confirma Eliminar Registro ID=" + DataBinder.Eval(e.Row.DataItem, "ID_ENC") + "')");
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
            return ENCUESTA.GetAll();
        }
        private void GridView1_Insert()
        {
            try
            {
                ENCUESTA vENCUESTA = new ENCUESTA();

                vENCUESTA.DES_ENCUESTA = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("DES_ENCUESTA")).Text.ToString());
                vENCUESTA.ANONIMO = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("ANONIMO")).Text.ToString());
                vENCUESTA.USUARIO_TODOS = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("USUARIO_TODOS")).Text.ToString());
                vENCUESTA.ESTADO = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("ESTADO")).Text.ToString());
                vENCUESTA.FECHA_VTO = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("FECHA_VTO")).Text.ToString());
                vENCUESTA.EPIGRAFE = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("EPIGRAFE")).Text.ToString());
                
                vENCUESTA.ID_AREA_TEMATICA = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).SelectedValue); 
                
                vENCUESTA.Create();
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
                ENCUESTA vENCUESTA = new ENCUESTA();

                vENCUESTA.ID_ENC = Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]);

                vENCUESTA.DES_ENCUESTA = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("DES_ENCUESTA")).Text.ToString());
                vENCUESTA.ANONIMO = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("ANONIMO")).Text.ToString());
                vENCUESTA.USUARIO_TODOS = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("USUARIO_TODOS")).Text.ToString());
                vENCUESTA.ESTADO = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("ESTADO")).Text.ToString());
                vENCUESTA.FECHA_VTO = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("FECHA_VTO")).Text.ToString());
                vENCUESTA.EPIGRAFE = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("EPIGRAFE")).Text.ToString());
                
                vENCUESTA.ID_AREA_TEMATICA = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).SelectedValue);
                
                vENCUESTA.Update();
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
                ENCUESTA.Delete(pID);
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }


</script>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<table width="100%"><tr><td align="center" Width="100%">

        <table width="90%"><tr><td><h3>ENCUESTA</h3></td></tr><tr><td>

        <asp:GridView ID="GridView1" 
        DataKeyNames="ID_ENC"
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

            <asp:TemplateField HeaderText="ID_ENC" SortExpression="ID_ENC" Visible="false">
                <ItemTemplate><%# Eval("ID_ENC")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="ID_ENC" Text='<%# Eval("ID_ENC") %>' runat="server" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="ID_ENC" Text='<%# Eval("ID_ENC") %>' runat="server" />
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="DES_ENCUESTA" SortExpression="DES_ENCUESTA">
                <ItemTemplate><%# Eval("DES_ENCUESTA")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="DES_ENCUESTA" Text='<%# Eval("DES_ENCUESTA") %>' runat="server" Width="300px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="DES_ENCUESTA" Text='' runat="server" Width="300px"/>        
                </FooterTemplate>
            </asp:TemplateField>  


            <asp:TemplateField HeaderText="ANONIMO" SortExpression="ANONIMO">
                <ItemTemplate><%# Eval("ANONIMO")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="ANONIMO" Text='<%# Eval("ANONIMO") %>' runat="server" Width="20px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="ANONIMO" Text='' runat="server" Width="20px"/>        
                </FooterTemplate>
            </asp:TemplateField>  

                <asp:TemplateField HeaderText="TODOS" SortExpression="USUARIO_TODOS">
                <ItemTemplate><%# Eval("USUARIO_TODOS")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="USUARIO_TODOS" Text='<%# Eval("USUARIO_TODOS") %>' runat="server" Width="20px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="USUARIO_TODOS" Text='' runat="server" Width="20px"/>        
                </FooterTemplate>
            </asp:TemplateField>  


            <asp:TemplateField HeaderText="ESTADO" SortExpression="ESTADO">
                <ItemTemplate><%# Eval("ESTADO")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="ESTADO" Text='<%# Eval("ESTADO") %>' runat="server" Width="20px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="ESTADO" Text='' runat="server" Width="20px"/>
                </FooterTemplate>
            </asp:TemplateField>  


            <asp:TemplateField HeaderText="VTO" SortExpression="FECHA_VTO" >
                <ItemTemplate><%# Eval("FECHA_VTO")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="FECHA_VTO" Text='<%# Eval("FECHA_VTO") %>' runat="server"  Width="70px" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="FECHA_VTO" Text='' runat="server" Width="70px"/>        
                </FooterTemplate>
            </asp:TemplateField>  

            
            <asp:TemplateField HeaderText="EPIGRAFE" SortExpression="EPIGRAFE">
                <ItemTemplate><%# Eval("EPIGRAFE")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="EPIGRAFE" Text='<%# Eval("EPIGRAFE") %>' TextMode="MultiLine" runat="server" Width="300px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="EPIGRAFE" Text='' TextMode="MultiLine" runat="server" Width="300px"/>        
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="DES_AREA_TEMATICA" SortExpression="DES_AREA_TEMATICA">
                <ItemTemplate><%# Eval("DES_AREA_TEMATICA")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ID_AREA_TEMATICA" runat="server"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="ID_AREA_TEMATICA" runat="server"/>
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