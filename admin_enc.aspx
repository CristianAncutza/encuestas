<%@ Page Language="C#" MasterPageFile="~/Site.master" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    public string ID_PREG
        
    {
        get
        {
            if (ViewState["ID_PREG"] != null)
                return Convert.ToString(ViewState["ID_PREG"]);
            return "-1";
        }
        set
        {
            ViewState["ID_PREG"] = value;
        }
    }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ID_ENC.DataSource = OracleConn.GetData("SELECT * FROM ENCUESTA");
                ID_ENC.DataTextField = "DESCRIPCION";
                ID_ENC.DataValueField = "ID_ENC";
                ID_ENC.DataBind();

                HyperLink1.NavigateUrl = "feedback.aspx?REP=1&id_enc=" + ID_ENC.SelectedValue;
                HyperLink2.NavigateUrl = "publicar.aspx?pub=http://ENCUESTAS/" + ID_ENC.Items.FindByValue (ID_ENC.SelectedValue).Text;
                    
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
            PREGUNTA vPREGUNTA = new PREGUNTA();
            vPREGUNTA.New(ID_ENC.SelectedValue);

          
            ((TextBox)GridView1.FooterRow.FindControl("TEXTO_PREG")).Text = Convert.ToString(vPREGUNTA.TEXTO_PREG);
            ((TextBox)GridView1.FooterRow.FindControl("TEXTO_OBS")).Text = Convert.ToString(vPREGUNTA.TEXTO_OBS);

            ((DropDownList)GridView1.FooterRow.FindControl("ID_TIPO_RESPUESTA")).Items.Add(new ListItem("TEXTO","1"));
            ((DropDownList)GridView1.FooterRow.FindControl("ID_TIPO_RESPUESTA")).Items.Add(new ListItem("LISTA","2"));
            ((DropDownList)GridView1.FooterRow.FindControl("ID_TIPO_RESPUESTA")).Items.Add(new ListItem("MULTIPLE","3"));
            ((DropDownList)GridView1.FooterRow.FindControl("ID_TIPO_RESPUESTA")).Items.Add(new ListItem("RANKING", "4"));
                                    
            ((DropDownList)GridView1.FooterRow.FindControl("ID_ESTILO")).DataSource = OracleConn.GetData("SELECT * FROM ESTILO");
            ((DropDownList)GridView1.FooterRow.FindControl("ID_ESTILO")).DataTextField = "NOMBRE_ESTILO";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_ESTILO")).DataValueField = "ID_ESTILO";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_ESTILO")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("ID_ESTILO")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("ID_ESTILO")).SelectedValue = "-1";

            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).DataSource = OracleConn.GetData("SELECT * FROM AREA_TEMATICA");
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).DataTextField = "DESCRIPCION";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).DataValueField = "ID_AREA_TEMATICA";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).SelectedValue = "-1";
            
            ((DropDownList)GridView1.FooterRow.FindControl("ID_PERFIL")).DataSource = OracleConn.GetData("SELECT * FROM PERFIL");
            ((DropDownList)GridView1.FooterRow.FindControl("ID_PERFIL")).DataTextField = "NOMBRE_PERFIL";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_PERFIL")).DataValueField = "ID_PERFIL";
            ((DropDownList)GridView1.FooterRow.FindControl("ID_PERFIL")).DataBind();
            ((DropDownList)GridView1.FooterRow.FindControl("ID_PERFIL")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.FooterRow.FindControl("ID_PERFIL")).SelectedValue = "-1";
        }
        private void GridView1_EditRowFill()
        {
            PREGUNTA vPREGUNTA = new PREGUNTA();
            vPREGUNTA.Fill(Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]));

            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_PREG")).Text = Convert.ToString(vPREGUNTA.TEXTO_PREG);
            ((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_OBS")).Text = Convert.ToString(vPREGUNTA.TEXTO_OBS);

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_TIPO_RESPUESTA")).Items.Add(new ListItem("TEXTO", "1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_TIPO_RESPUESTA")).Items.Add(new ListItem("LISTA","2"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_TIPO_RESPUESTA")).Items.Add(new ListItem("MULTIPLE","3"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_TIPO_RESPUESTA")).Items.Add(new ListItem("RANKING", "4"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_TIPO_RESPUESTA")).SelectedValue = Convert.ToString(vPREGUNTA.ID_TIPO_RESPUESTA);
            
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_ESTILO")).DataSource = OracleConn.GetData("SELECT * FROM ESTILO");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_ESTILO")).DataTextField = "NOMBRE_ESTILO";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_ESTILO")).DataValueField = "ID_ESTILO";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_ESTILO")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_ESTILO")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_ESTILO")).SelectedValue = Convert.ToString(vPREGUNTA.ID_AREA_TEMATICA);

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).DataSource = OracleConn.GetData("SELECT * FROM AREA_TEMATICA");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).DataTextField = "DESCRIPCION";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).DataValueField = "ID_AREA_TEMATICA";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).SelectedValue = Convert.ToString(vPREGUNTA.ID_AREA_TEMATICA);

            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_PERFIL")).DataSource = OracleConn.GetData("SELECT * FROM PERFIL");
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_PERFIL")).DataTextField = "NOMBRE_PERFIL";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_PERFIL")).DataValueField = "ID_PERFIL";
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_PERFIL")).DataBind();
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_PERFIL")).Items.Add(new ListItem("", "-1"));
            ((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_PERFIL")).SelectedValue = Convert.ToString(vPREGUNTA.ID_AREA_TEMATICA);
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
                        
                    case "UpRow":
                        GridView1_UpRow(Convert.ToInt32(e.CommandArgument));
                        break;

                    case "DownRow":
                        GridView1_DownRow(Convert.ToInt32(e.CommandArgument));
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
                    return "ORDEN";
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
                l.Attributes.Add("OnClick", "javascript:return confirm('Confirma Eliminar Registro ID=" + DataBinder.Eval(e.Row.DataItem, "ID_PREG") + "')");
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
            return PREGUNTA.GetByPREGUNTAID(ID_ENC.SelectedValue);
        }
        private void GridView1_Insert()
        {
            try
            {
                PREGUNTA vPREGUNTA = new PREGUNTA();
                
                vPREGUNTA.ID_ENC = ID_ENC.SelectedValue;

                vPREGUNTA.TEXTO_PREG = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("TEXTO_PREG")).Text.ToString());
                vPREGUNTA.TEXTO_OBS = Convert.ToString(((TextBox)GridView1.FooterRow.FindControl("TEXTO_OBS")).Text.ToString());

                vPREGUNTA.ID_TIPO_RESPUESTA = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("ID_TIPO_RESPUESTA")).SelectedValue); 
                vPREGUNTA.ID_ESTILO = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("ID_ESTILO")).SelectedValue);                
                vPREGUNTA.ID_AREA_TEMATICA = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("ID_AREA_TEMATICA")).SelectedValue);
                vPREGUNTA.ID_PERFIL = Convert.ToString(((DropDownList)GridView1.FooterRow.FindControl("ID_PERFIL")).SelectedValue); 
                
                vPREGUNTA.Create();
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
                PREGUNTA vPREGUNTA = new PREGUNTA();

                vPREGUNTA.ID_PREG = Convert.ToString(GridView1.DataKeys[GridView1.EditIndex].Values[0]);
                vPREGUNTA.ID_ENC = ID_ENC.SelectedValue;

                vPREGUNTA.TEXTO_PREG = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_PREG")).Text.ToString());
                vPREGUNTA.TEXTO_OBS = Convert.ToString(((TextBox)GridView1.Rows[GridView1.EditIndex].FindControl("TEXTO_OBS")).Text.ToString());
                
                vPREGUNTA.ID_TIPO_RESPUESTA = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_TIPO_RESPUESTA")).SelectedValue);
                vPREGUNTA.ID_ESTILO = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_ESTILO")).SelectedValue);
                vPREGUNTA.ID_AREA_TEMATICA = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_AREA_TEMATICA")).SelectedValue);
                vPREGUNTA.ID_PERFIL = Convert.ToString(((DropDownList)GridView1.Rows[GridView1.EditIndex].FindControl("ID_PERFIL")).SelectedValue); 
                                
                vPREGUNTA.Update();
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }

            GridView1.EditIndex = -1;
        }
        private void GridView1_UpRow(int pGridIndex)
        {
            try
            {
                if (pGridIndex > 0)
                {
                    string vIdRequerido = Convert.ToString(GridView1.DataKeys[pGridIndex - 1].Values[0]);
                    string vIdActual = Convert.ToString(GridView1.DataKeys[pGridIndex].Values[0]);

                    string vOrdenRequerido = Convert.ToString(OracleConn.GetData("SELECT ORDEN FROM PREGUNTA WHERE ID_PREG=" + vIdRequerido).Rows[0][0]);
                    string vOrdenActual = Convert.ToString(OracleConn.GetData("SELECT ORDEN FROM PREGUNTA WHERE ID_PREG=" + vIdActual).Rows[0][0]);

                    OracleConn.Execute("UPDATE PREGUNTA SET ORDEN=" + vOrdenRequerido + " WHERE ID_PREG=" + vIdActual);
                    OracleConn.Execute("UPDATE PREGUNTA SET ORDEN=" + vOrdenActual + " WHERE ID_PREG=" + vIdRequerido);

                    GridView1_DataBind();
                }
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }

        private void GridView1_DownRow(int pGridIndex)
        {
            try
            {
                if (pGridIndex < GridView1.Rows.Count)
                {
                    string vIdRequerido = Convert.ToString(GridView1.DataKeys[pGridIndex + 1].Values[0]);
                    string vIdActual = Convert.ToString(GridView1.DataKeys[pGridIndex].Values[0]);

                    string vOrdenRequerido = Convert.ToString(OracleConn.GetData("SELECT ORDEN FROM PREGUNTA WHERE ID_PREG=" + vIdRequerido).Rows[0][0]);
                    string vOrdenActual = Convert.ToString(OracleConn.GetData("SELECT ORDEN FROM PREGUNTA WHERE ID_PREG=" + vIdActual).Rows[0][0]);

                    OracleConn.Execute("UPDATE PREGUNTA SET ORDEN=" + vOrdenRequerido + " WHERE ID_PREG=" + vIdActual);
                    OracleConn.Execute("UPDATE PREGUNTA SET ORDEN=" + vOrdenActual + " WHERE ID_PREG=" + vIdRequerido);

                    GridView1_DataBind();
                }
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        private void GridView1_Delete(string pID)
        {
            try
            {
                PREGUNTA.Delete(pID);
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        protected void ID_ENC_SelectedIndexChanged(object sender, EventArgs e)
        {
            HyperLink1.NavigateUrl = "feedback.aspx?REP=1&id_enc=" + ID_ENC.SelectedValue;
            HyperLink2.NavigateUrl = "publicar.aspx?pub=http://encuentas/" + ID_ENC.Items.FindByValue(ID_ENC.SelectedValue).Text;
            
            GridView1_DataBind();
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.ID_PREG = GridView1.DataKeys[GridView1.SelectedIndex].Value.ToString();
            GridView2_DataBind();
            PanelRespuestas.Visible = true;
        }
                
        /// <summary>
        /// /RESPUESTAS
        /// </summary>
        /// 

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            GridView2_DataBind();
        }
        private void GridView2_AddRowFill()
        {
            RESPUESTA vRESPUESTA = new RESPUESTA();
            vRESPUESTA.New(ID_PREG);
            
            ((TextBox)GridView2.FooterRow.FindControl("TEXTO_RESP")).Text = Convert.ToString(vRESPUESTA.TEXTO_RESP);
            ((TextBox)GridView2.FooterRow.FindControl("TEXTO_AUX1")).Text = Convert.ToString(vRESPUESTA.TEXTO_AUX1);
            ((TextBox)GridView2.FooterRow.FindControl("TEXTO_AUX2")).Text = Convert.ToString(vRESPUESTA.TEXTO_AUX2);

        }
        private void GridView2_EditRowFill()
        {
            RESPUESTA vRESPUESTA = new RESPUESTA();
            vRESPUESTA.Fill(Convert.ToString(GridView2.DataKeys[GridView2.EditIndex].Values[0]));

            ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("TEXTO_RESP")).Text = Convert.ToString(vRESPUESTA.TEXTO_RESP);
            ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("TEXTO_AUX1")).Text = Convert.ToString(vRESPUESTA.TEXTO_AUX1);
            ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("TEXTO_AUX2")).Text = Convert.ToString(vRESPUESTA.TEXTO_AUX2);
        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                switch (e.CommandName)
                {
                    case "Insert":
                        GridView2_Insert();
                        break;

                    case "Update":
                        GridView2_Update();
                        break;

                    case "UpRow":
                        GridView2_UpRow(Convert.ToInt32 (e.CommandArgument));
                        break;

                    case "DownRow":
                        GridView2_DownRow(Convert.ToInt32 (e.CommandArgument));
                        break;                        
                        
                }

                GridView2_DataBind();
                lbMessage.Text = "";
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                GridView2_Delete(Convert.ToString(GridView2.DataKeys[e.RowIndex].Values[0]));
                GridView2_DataBind();
                lbMessage.Text = "";
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
        }
        private string GridView2_OrderBy
        {
            get
            {
                if (ViewState["GridView2_OrderBy"] == null)
                    return "ORDEN";
                return (string)ViewState["GridView2_OrderBy"];
            }
            set
            {
                ViewState["GridView2_OrderBy"] = value;
            }
        }
        private void GridView2_DataBind()
        {
            DataTable dt = this.DataSource2();

            if (dt.Rows.Count == 0)
                dt.Rows.Add(dt.NewRow());

            GridView2.DataSource = GridSort2(dt, GridView2_OrderBy);
            GridView2.DataBind();

            GridView2_AddRowFill();
        }
        protected void GridView2_CancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView2.EditIndex = -1;
            GridView2_DataBind();
        }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach (TableCell tc in e.Row.Cells)
            {
                tc.Attributes["style"] = "border-color: #c3cecc;";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton l = (LinkButton)e.Row.FindControl("LinkDelete");
                l.Attributes.Add("OnClick", "javascript:return confirm('Confirma Eliminar Registro ID=" + DataBinder.Eval(e.Row.DataItem, "ID_RESP") + "')");
            }
        }
        protected void GridView2_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridView2_OrderBy = e.SortExpression;
            GridView2_DataBind();
        }
        protected void GridView2_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
            }
        }
        protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView2.EditIndex = e.NewEditIndex;
            GridView2_DataBind();
            GridView2_EditRowFill();
        }
        protected void GridView2_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
            }
        }
        private DataView GridSort2(DataTable dt, string pOrderField)
        {
            DataView dv = new DataView(dt);
            dv.Sort = pOrderField;
            return dv;
        }
        private DataTable DataSource2()
        {
            return RESPUESTA.GetByID_PREG(this.ID_PREG);
        }
        private void GridView2_Insert()
        {
            try
            {
                RESPUESTA vRESPUESTA = new RESPUESTA();

                vRESPUESTA.ID_PREG = this.ID_PREG;
                vRESPUESTA.TEXTO_RESP = Convert.ToString(((TextBox)GridView2.FooterRow.FindControl("TEXTO_RESP")).Text.ToString());
                vRESPUESTA.TEXTO_AUX1 = Convert.ToString(((TextBox)GridView2.FooterRow.FindControl("TEXTO_AUX1")).Text.ToString());
                vRESPUESTA.TEXTO_AUX2 = Convert.ToString(((TextBox)GridView2.FooterRow.FindControl("TEXTO_AUX2")).Text.ToString());

                vRESPUESTA.Create();
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }
        private void GridView2_Update()
        {
            try
            {
                RESPUESTA vRESPUESTA = new RESPUESTA();

                vRESPUESTA.ID_RESP = Convert.ToString(GridView2.DataKeys[GridView2.EditIndex].Values[0]);
                vRESPUESTA.TEXTO_RESP = Convert.ToString(((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("TEXTO_RESP")).Text.ToString());
                vRESPUESTA.TEXTO_AUX1 = Convert.ToString(((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("TEXTO_AUX1")).Text.ToString());
                vRESPUESTA.TEXTO_AUX2 = Convert.ToString(((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("TEXTO_AUX2")).Text.ToString());

                vRESPUESTA.Update();
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }

            GridView2.EditIndex = -1;
        }
        private void GridView2_UpRow(int pGridIndex)
        {
            try
            {
                if (pGridIndex > 0)
                {
                    string vIdRequerido = Convert.ToString(GridView2.DataKeys[pGridIndex - 1].Values[0]);
                    string vIdActual = Convert.ToString(GridView2.DataKeys[pGridIndex].Values[0]);

                    string vOrdenRequerido = Convert.ToString(OracleConn.GetData("SELECT ORDEN FROM RESPUESTA WHERE ID_RESP=" + vIdRequerido).Rows[0][0]);
                    string vOrdenActual = Convert.ToString(OracleConn.GetData("SELECT ORDEN FROM RESPUESTA WHERE ID_RESP=" + vIdActual).Rows[0][0]);

                    OracleConn.Execute("UPDATE RESPUESTA SET ORDEN=" + vOrdenRequerido + " WHERE ID_RESP=" + vIdActual);
                    OracleConn.Execute("UPDATE RESPUESTA SET ORDEN=" + vOrdenActual + " WHERE ID_RESP=" + vIdRequerido);

                    GridView2_DataBind();
                }
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }

        private void GridView2_DownRow(int pGridIndex)
        {
            try
            {
                if (pGridIndex < GridView2.Rows.Count)
                {
                    string vIdRequerido = Convert.ToString(GridView2.DataKeys[pGridIndex + 1].Values[0]);
                    string vIdActual = Convert.ToString(GridView2.DataKeys[pGridIndex].Values[0]);

                    string vOrdenRequerido = Convert.ToString (OracleConn.GetData ("SELECT ORDEN FROM RESPUESTA WHERE ID_RESP=" + vIdRequerido).Rows[0][0]);
                    string vOrdenActual = Convert.ToString(OracleConn.GetData("SELECT ORDEN FROM RESPUESTA WHERE ID_RESP=" + vIdActual).Rows[0][0]);

                    OracleConn.Execute("UPDATE RESPUESTA SET ORDEN=" + vOrdenRequerido + " WHERE ID_RESP=" + vIdActual);
                    OracleConn.Execute("UPDATE RESPUESTA SET ORDEN=" + vOrdenActual + " WHERE ID_RESP=" + vIdRequerido);

                    GridView2_DataBind();
                }
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }

        private void GridView2_Delete(string pID)
        {
            try
            {
                RESPUESTA.Delete(pID);
            }
            catch (Exception ex)
            {
                lbMessage.Text = ex.Message;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            PanelRespuestas.Visible = false;
        }


</script>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<table width="100%"><tr><td align="center" Width="100%">
 
        <table width="90%"><tr><td><h3>ADMINISTRACION DE PREGUNTA Y RESPUESTAS</h3></td></tr>
        
        <tr><td>
            
            <table border="1"><tr><td>ENCUESTA:</td><td><asp:DropDownList ID="ID_ENC" runat="server" 
                onselectedindexchanged="ID_ENC_SelectedIndexChanged" AutoPostBack="True"/></td><td> 
                    
                    <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank">VER ENCUESTA</asp:HyperLink>

                </td><td> <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank">PUBLICAR ENCUESTA</asp:HyperLink></td></tr>

            </table>

            </td></tr>
        
        <tr><td>

        <asp:GridView ID="GridView1" 
        DataKeyNames="ID_PREG"
        AllowPaging="True" 
        AllowSorting="False" 
        AutoGenerateColumns="False" 
        FooterStyle-BackColor="White" 
        CssClass="datagrid datagridBig" 
        GridLines="None" 
        runat="server"
        ShowFooter="True"
        PageSize="50" 
        
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
        BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" Width="100%" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            
        <RowStyle ForeColor="Black" BackColor="#DEDFDE" />
        <Columns>

            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="LinkUpRow" CommandName="UpRow" runat="server" ToolTip="Subir orden" ImageUrl="~/Styles/up.png" Width="30px" CommandArgument="<%#((GridViewRow)Container).RowIndex %>" />
                    <asp:ImageButton ID="LinkDownRow" CommandName="DownRow" runat="server" ToolTip="Bajar orden" ImageUrl="~/Styles/down.png" Width="30px" CommandArgument="<%#((GridViewRow)Container).RowIndex %>" />
                </ItemTemplate>
                <FooterTemplate>
                </FooterTemplate>
            </asp:TemplateField>
                        
			<asp:CommandField ShowEditButton="True" ButtonType="Link" EditText ="EDITAR" UpdateText="ACTUALIZAR" CancelText="CANCELAR" />
			
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkDelete" runat="server" CausesValidation="False" CommandName="Delete" ToolTip="Eliminar Registro" Text="ELIMINAR"></asp:LinkButton>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:LinkButton ID="Create" CommandName="Insert" runat="server" ToolTip="Agregar Registro" Text="AGREGAR" />
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center"  SortExpression="">
                <ItemTemplate>
                    <asp:Button ID="Select" runat="server" CommandName="Select" Text="RESPUESTAS" />
                </ItemTemplate>
                <EditItemTemplate>
                </EditItemTemplate>
                <FooterTemplate>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="TEXTO_PREG" SortExpression="TEXTO_PREG">
                <ItemTemplate><%# Eval("TEXTO_PREG")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_PREG" Text='<%# Eval("TEXTO_PREG") %>' runat="server" TextMode="MultiLine"  Width="300px" Height="50px"/>
                </EditItemTemplate>
                <FooterTemplate>    
                    <asp:TextBox ID="TEXTO_PREG" Text='<%# Eval("TEXTO_PREG") %>' runat="server" TextMode="MultiLine" Width="300px" Height="50px"/>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="TEXTO_OBS" SortExpression="TEXTO_OBS" >
                <ItemTemplate><%# Eval("TEXTO_OBS")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_OBS" Text='<%# Eval("TEXTO_OBS") %>' runat="server" TextMode="MultiLine" Width="300px" Height="50px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_OBS" Text='<%# Eval("TEXTO_OBS") %>' runat="server" TextMode="MultiLine" Width="300px" Height="50px"/>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="TIPO_RESP" SortExpression="DES_TIPO_RESPUESTA">
                <ItemTemplate><%# Eval("DES_TIPO_RESPUESTA")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ID_TIPO_RESPUESTA" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="ID_TIPO_RESPUESTA" runat="server" Width="150px"/>
                </FooterTemplate>
            </asp:TemplateField>


            <asp:TemplateField HeaderText="DES_ESTILO" SortExpression="DES_ESTILO">
                <ItemTemplate><%# Eval("DES_ESTILO")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ID_ESTILO" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="ID_ESTILO" runat="server" Width="150px"/>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="DES_AREA_TEMATICA" SortExpression="DES_AREA_TEMATICA">
                <ItemTemplate><%# Eval("DES_AREA_TEMATICA")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ID_AREA_TEMATICA" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="ID_AREA_TEMATICA" runat="server" Width="150px"/>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="DES_PERFIL" SortExpression="DES_PERFIL">
                <ItemTemplate><%# Eval("DES_PERFIL")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ID_PERFIL" runat="server" Width="150px"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:DropDownList ID="ID_PERFIL" runat="server" Width="150px"/>
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
    
    <hr/>
    <asp:Panel ID="PanelRespuestas" runat="server" Visible="false" Style="position:absolute; left: 20%; top: 20%; height: 100%; text-align: center;">
        
        <table style="background: silver" border="1">
            <tr>
                <td><B>RESPUESTAS</B></td><td width="1"><asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Cerrar" /></td>
            </tr>
            <tr>
            <td colspan="2">

            <asp:GridView ID="GridView2" 

        DataKeyNames="ID_RESP"
        AllowPaging="true" 
        AllowSorting="false" 
        AutoGenerateColumns="False" 
        FooterStyle-BackColor="White" 
        CssClass="datagrid datagridBig" 
        GridLines="None" 
        runat="server"
        ShowFooter="True" 

        OnPageIndexChanging="GridView2_PageIndexChanging"
        OnRowCancelingEdit = "GridView2_CancelingEdit" 
        OnRowCommand = "GridView2_RowCommand" 
        OnRowDataBound="GridView2_RowDataBound" 
        OnRowDeleted = "GridView2_RowDeleted"
        OnRowDeleting = "GridView2_RowDeleting" 
        OnRowEditing = "GridView2_RowEditing"
        OnRowUpdated = "GridView2_RowUpdated"           
        OnRowUpdating = "GridView2_RowUpdating" 

        OnSorting = "GridView2_Sorting" BackColor="White" BorderColor="White" 
        BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1">
            
        <RowStyle ForeColor="Black" BackColor="#DEDFDE" />
        <Columns>
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="LinkUpRow" CommandName="UpRow" runat="server" ToolTip="Subir orden" ImageUrl="~/Styles/up.png" Width="30px" CommandArgument="<%#((GridViewRow)Container).RowIndex %>" />
                    <asp:ImageButton ID="LinkDownRow" CommandName="DownRow" runat="server" ToolTip="Bajar orden" ImageUrl="~/Styles/down.png" Width="30px" CommandArgument="<%#((GridViewRow)Container).RowIndex %>" />
                </ItemTemplate>
                <FooterTemplate>
                </FooterTemplate>
            </asp:TemplateField>

			<asp:CommandField ShowEditButton="True" ButtonType="Link" EditText ="EDITAR" UpdateText="ACTUALIZAR" CancelText="CANCELAR" />
			
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkDelete" runat="server" CausesValidation="False" CommandName="Delete" ToolTip="Eliminar Registro" Text="ELIMINAR"></asp:LinkButton>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:LinkButton ID="Create" CommandName="Insert" runat="server" ToolTip="Agregar Registro" Text="AGREGAR" />
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="ID_RESP" SortExpression="ID_RESP" Visible="false">
                <ItemTemplate><%# Eval("ID_RESP")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="ID_RESP" Text='<%# Eval("ID_RESP") %>' runat="server" Width="100%"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="ID_RESP" Text='' runat="server" Width="100%"/>        
                </FooterTemplate>
            </asp:TemplateField>          

            <asp:TemplateField HeaderText="TEXTO_RESP" SortExpression="TEXTO_RESP">
                <ItemTemplate><%# Eval("TEXTO_RESP")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_RESP" Text='<%# Eval("TEXTO_RESP") %>' runat="server" Width="400px" Height="50px" TextMode="MultiLine"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_RESP" Text='' runat="server" Width="400px" Height="50px" TextMode="MultiLine"/>
                </FooterTemplate>
            </asp:TemplateField>          


            <asp:TemplateField HeaderText="TEXTO_AUX1" SortExpression="TEXTO_AUX1">
                <ItemTemplate><%# Eval("TEXTO_AUX1")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_AUX1" Text='<%# Eval("TEXTO_AUX1") %>' runat="server" Width="400px" Height="50px" TextMode="MultiLine"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_AUX1" Text='' runat="server" Width="400px" Height="50px" TextMode="MultiLine"/>
                </FooterTemplate>
            </asp:TemplateField> 

            <asp:TemplateField HeaderText="TEXTO_AUX2" SortExpression="TEXTO_AUX2">
                <ItemTemplate><%# Eval("TEXTO_AUX2")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TEXTO_AUX2" Text='<%# Eval("TEXTO_AUX2") %>' runat="server" Width="400px" Height="50px" TextMode="MultiLine"/>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="TEXTO_AUX2" Text='' runat="server" Width="400px" Height="50px" TextMode="MultiLine"/>
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

            </td></tr>
            </table>
                <asp:Label runat="server" ID="Label1" Font-Bold="True" Font-Size="Medium" ForeColor="Red" />
   <br/>
     </asp:Panel>                   
                        
        </td></tr></table>


</asp:Content>
