using System;
using System.Data;

public class PERFIL
{
    public string ID_PERFIL;
    public string DES_PERFIL;

    public void New()
    {
        ID_PERFIL = "-1";
        DES_PERFIL = "";
    }
    public void Create()
    {
        string vSql = "INSERT INTO PERFIL (ID_PERFIL,NOMBRE_PERFIL) VALUES (SEQ_ID_PERFIL.nextval,:DES_PERFIL)";

        string vParamNames = ":DES_PERFIL";
        string vParamValues = DES_PERFIL;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM PERFIL WHERE ID_PERFIL=:ID_PERFIL";

        string vParamNames = ":ID_PERFIL";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Update()
    {
        string vSql = "UPDATE PERFIL SET NOMBRE_PERFIL=:DES_PERFIL WHERE ID_PERFIL=:ID_PERFIL";

        string vParamNames = ":DES_PERFIL|:ID_PERFIL";
        string vParamValues = DES_PERFIL + "|" + ID_PERFIL;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT ID_PERFIL, NOMBRE_PERFIL  AS DES_PERFIL FROM PERFIL WHERE ID_PERFIL=" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID_PERFIL = Convert.ToString(dt.Rows[0]["ID_PERFIL"]);
            this.DES_PERFIL = Convert.ToString(dt.Rows[0]["DES_PERFIL"]);
        }
    }
    public static DataTable GetAll()
    {
        return OracleConn.GetData("SELECT ID_PERFIL,NOMBRE_PERFIL AS DES_PERFIL FROM PERFIL");
    }
}
