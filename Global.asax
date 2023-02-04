<%@ Application Language="C#" %>

<script runat="server">

    void Application_BeginRequest(Object source, EventArgs e)
    {
        try
        {
            HttpApplication app = (HttpApplication)source;
            HttpContext context = app.Context;
            string vTitle = Convert.ToString(app.Context.Request.RawUrl.ToString().Split('/')[1]);
            int vID_ENC = ENCUESTA.GetByTitle(vTitle);
            if (vID_ENC>-1)
                Response.Redirect("feedback.aspx?ID_ENC=" + Convert.ToString(vID_ENC));
        }
        catch { }
    }
    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
