using System;
using System.Data;

public class SECTOR
{
    public string ID_SECTOR;
    public string ID_GERENCIA;
    public string DES_SECTOR;

    public void New()
    {
        ID_SECTOR = "-1";
        ID_GERENCIA = "-1";
        DES_SECTOR = "";
    }
    public void Create()
    {
        string vSql = "INSERT INTO SECTOR (ID_SECTOR,ID_GERENCIA,DESCRIPCION) VALUES (SEQ_ID_SECTOR.nextval,:ID_GERENCIA,:DES_SECTOR)";

        string vParamNames = ":ID_GERENCIA|:DES_SECTOR";
        string vParamValues = ID_GERENCIA + "|" + DES_SECTOR;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM SECTOR WHERE ID_SECTOR=:ID_SECTOR";

        string vParamNames = ":ID_SECTOR";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));

    }
    public void Update()
    {
        string vSql = "UPDATE SECTOR SET ID_GERENCIA=:ID_GERENCIA, DESCRIPCION=:DES_SECTOR WHERE ID_SECTOR=:ID_SECTOR";

        string vParamNames = ":ID_SECTOR|:ID_GERENCIA|:DES_SECTOR";
        string vParamValues = ID_SECTOR + "|" + ID_GERENCIA + "|" + DES_SECTOR;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT * FROM SECTOR WHERE ID_SECTOR=" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID_SECTOR = Convert.ToString(dt.Rows[0]["ID_SECTOR"]);
            this.ID_GERENCIA = Convert.ToString(dt.Rows[0]["ID_GERENCIA"]);
            this.DES_SECTOR = Convert.ToString(dt.Rows[0]["DESCRIPCION"]);
        }
    }
    public static DataTable GetAll()
    {
        return OracleConn.GetData("SELECT S.ID_SECTOR, S.ID_GERENCIA, S.DESCRIPCION AS DES_SECTOR, G.DESCRIPCION AS DES_GERENCIA FROM SECTOR S INNER JOIN GERENCIA G ON (S.ID_GERENCIA = G.ID_GERENCIA)");
    }
}
