using System;
using System.Data;

public class GERENCIA
{
    public string ID_GERENCIA;
    public string DES_GERENCIA;

    public void New()
    {
        ID_GERENCIA = "-1";
        DES_GERENCIA = "";
    }
    public void Create()
    {
        string vSql = "INSERT INTO GERENCIA (ID_GERENCIA,DESCRIPCION) VALUES (SEQ_ID_GERENCIA.nextval,:DES_GERENCIA)";

        string vParamNames = ":DES_GERENCIA";
        string vParamValues = DES_GERENCIA;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM GERENCIA WHERE ID_GERENCIA=:ID_GERENCIA";

        string vParamNames = ":ID_GERENCIA";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Update()
    {
        string vSql = "UPDATE GERENCIA SET DESCRIPCION=:DES_GERENCIA WHERE ID_GERENCIA=:ID_GERENCIA";

        string vParamNames = ":DES_GERENCIA|:ID_GERENCIA";
        string vParamValues = DES_GERENCIA + "|" + ID_GERENCIA;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT ID_GERENCIA, DESCRIPCION AS DES_GERENCIA  FROM GERENCIA WHERE ID_GERENCIA=" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID_GERENCIA = Convert.ToString(dt.Rows[0]["ID_GERENCIA"]);
            this.DES_GERENCIA = Convert.ToString(dt.Rows[0]["DES_GERENCIA"]);
        }
    }
    public static DataTable GetAll()
    {
        return OracleConn.GetData("SELECT ID_GERENCIA,DESCRIPCION AS DES_GERENCIA FROM GERENCIA");
    }
}
