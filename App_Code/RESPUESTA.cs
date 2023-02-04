using System;
using System.Data;

public class RESPUESTA
{
    public string ID_RESP;
    public string ID_PREG;
    public string TEXTO_RESP;
    public string TEXTO_AUX1;
    public string TEXTO_AUX2;

    public string GetNextOrden(string pID_PREG)
    {
        return Convert.ToString(OracleConn.GetData("SELECT MAX(orden)+1 FROM RESPUESTA WHERE ID_PREG=" + pID_PREG).Rows[0][0]);
    }

    public void New(string pID_PREG)
    {
        ID_RESP = "-1";
        TEXTO_RESP = "";
        TEXTO_AUX1 = "";
        TEXTO_AUX2 = "";
    }
    public void Create()
    {
        string vSql = "INSERT INTO RESPUESTA (ID_RESP,ID_PREG,ORDEN,TEXTO_RESP,TEXTO_AUX1, TEXTO_AUX2) VALUES (SEQ_ID_RESPUESTA.nextval,:ID_PREG,:ORDEN,:TEXTO_RESP,:TEXTO_AUX1,:TEXTO_AUX2)";

        string vParamNames = ":ID_PREG|:ORDEN|:TEXTO_RESP|:TEXTO_AUX1|:TEXTO_AUX2";
        string vParamValues = ID_PREG + "|" + GetNextOrden(ID_PREG) + "|" + TEXTO_RESP + "|" + TEXTO_AUX1 + "|" + TEXTO_AUX2;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM RESPUESTA WHERE ID_RESP=:ID_RESP";

        string vParamNames = ":ID_RESP";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Update()
    {
        string vSql = "UPDATE RESPUESTA SET TEXTO_RESP=:TEXTO_RESP,TEXTO_AUX1=:TEXTO_AUX1,TEXTO_AUX2=:TEXTO_AUX2 WHERE ID_RESP=:ID_RESP";

        string vParamNames = ":TEXTO_RESP|:TEXTO_AUX1|:TEXTO_AUX2|:ID_RESP";
        string vParamValues = TEXTO_RESP + "|" + TEXTO_AUX1 + "|" + TEXTO_AUX2 + "|" + ID_RESP;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT * FROM RESPUESTA WHERE ID_RESP=" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID_RESP = Convert.ToString(dt.Rows[0]["ID_RESP"]);
            this.ID_PREG = Convert.ToString(dt.Rows[0]["ID_PREG"]);
            this.TEXTO_RESP = Convert.ToString(dt.Rows[0]["TEXTO_RESP"]);
            this.TEXTO_AUX1 = Convert.ToString(dt.Rows[0]["TEXTO_AUX1"]);
            this.TEXTO_AUX2 = Convert.ToString(dt.Rows[0]["TEXTO_AUX2"]);
        }
    }
    public static DataTable GetByID_PREG(string pID_PREG)
    {
        return OracleConn.GetData("SELECT * FROM RESPUESTA WHERE ID_PREG=" + pID_PREG);
    }
}