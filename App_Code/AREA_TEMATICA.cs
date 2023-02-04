using System;
using System.Data;

public class AREA_TEMATICA
{
    public string ID_AREA_TEMATICA;
    public string DES_AREA_TEMATICA;

    public void New()
    {
        ID_AREA_TEMATICA = "-1";
        DES_AREA_TEMATICA = "";
    }
    public void Create()
    {
        string vSql = "INSERT INTO AREA_TEMATICA (ID_AREA_TEMATICA,DESCRIPCION) VALUES (SEQ_ID_AREA_TEMATICA.nextval,:DES_AREA_TEMATICA)";

        string vParamNames = ":DES_AREA_TEMATICA";
        string vParamValues = DES_AREA_TEMATICA;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM AREA_TEMATICA WHERE ID_AREA_TEMATICA=:ID_AREA_TEMATICA";

        string vParamNames = ":ID_AREA_TEMATICA";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Update()
    {
        string vSql = "UPDATE AREA_TEMATICA SET DESCRIPCION=:DES_AREA_TEMATICA WHERE ID_AREA_TEMATICA=:ID_AREA_TEMATICA";

        string vParamNames = ":DES_AREA_TEMATICA|:ID_AREA_TEMATICA";
        string vParamValues = DES_AREA_TEMATICA + "|" + ID_AREA_TEMATICA;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT ID_AREA_TEMATICA, DESCRIPCION AS DES_AREA_TEMATICA  FROM AREA_TEMATICA WHERE ID_AREA_TEMATICA=" + pID);

        if (dt.Rows.Count > 0)
        {
            this.ID_AREA_TEMATICA = Convert.ToString(dt.Rows[0]["ID_AREA_TEMATICA"]);
            this.DES_AREA_TEMATICA = Convert.ToString(dt.Rows[0]["DES_AREA_TEMATICA"]);
        }
    }
    public static DataTable GetAll()
    {
        return OracleConn.GetData("SELECT ID_AREA_TEMATICA,DESCRIPCION AS DES_AREA_TEMATICA FROM AREA_TEMATICA");
    }
}