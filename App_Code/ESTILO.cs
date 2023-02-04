using System;
using System.Data;

public class ESTILO
{
    public string ID_ESTILO;
    public string NOMBRE_ESTILO;
    public string HTML_PREFIX;
    public string HTML_POSTFIX;

    public void New()
    {
        ID_ESTILO = "-1";
        NOMBRE_ESTILO = "";
    }
    public void Create()
    {
        string vSql = "INSERT INTO ESTILO (ID_ESTILO,NOMBRE_ESTILO,HTML_PREFIX,HTML_POSTFIX) VALUES (SEQ_ID_ESTILO.nextval,:NOMBRE_ESTILO,:HTML_PREFIX,:HTML_POSTFIX)";

        string vParamNames = ":NOMBRE_ESTILO|:HTML_PREFIX|:HTML_POSTFIX";
        string vParamValues = NOMBRE_ESTILO + "|" + HTML_PREFIX + "|" + HTML_POSTFIX;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM ESTILO WHERE ID_ESTILO=:ID_ESTILO";

        string vParamNames = ":ID_ESTILO";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Update()
    {
        string vSql = "UPDATE ESTILO SET NOMBRE_ESTILO=:NOMBRE_ESTILO,HTML_PREFIX=:HTML_PREFIX,HTML_POSTFIX=:HTML_POSTFIX WHERE ID_ESTILO=:ID_ESTILO";

        string vParamNames = ":NOMBRE_ESTILO|:HTML_PREFIX|:HTML_POSTFIX|:ID_ESTILO";
        string vParamValues = NOMBRE_ESTILO + "|" + HTML_PREFIX + "|" + HTML_POSTFIX + "|" + ID_ESTILO;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT * FROM ESTILO WHERE ID_ESTILO=" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID_ESTILO = Convert.ToString(dt.Rows[0]["ID_ESTILO"]);
            this.NOMBRE_ESTILO = Convert.ToString(dt.Rows[0]["NOMBRE_ESTILO"]);
            this.HTML_PREFIX = Convert.ToString(dt.Rows[0]["HTML_PREFIX"]);
            this.HTML_POSTFIX = Convert.ToString(dt.Rows[0]["HTML_POSTFIX"]);
        }
    }
    public static DataTable GetAll()
    {
        return OracleConn.GetData("SELECT * FROM ESTILO");
    }
}