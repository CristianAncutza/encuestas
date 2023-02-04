using System;
using System.Data;

public class TABLA_RESP
{
    public string ID_RESP_COM;
    public string TEXTO_RESP1;
    public string TEXTO_RESP2;
    public string TEXTO_RESP3;
    public string TEXTO_RESP4;
    public string TEXTO_RESP5;
    public string TEXTO_RESP6;

    public void New()
    {

        ID_RESP_COM = "-1";
        TEXTO_RESP1 = "";
        TEXTO_RESP2 = "";
        TEXTO_RESP3 = "";
        TEXTO_RESP4 = "";
        TEXTO_RESP5 = "";
        TEXTO_RESP6 = "";
    }
    public void Create()
    {
        string vSql = "INSERT INTO TABLA_RESP (ID_RESP_COM,TEXTO_RESP1, TEXTO_RESP2,TEXTO_RESP3, TEXTO_RESP4, TEXTO_RESP5, TEXTO_RESP6 ) VALUES (SEQ_ID_RESP_COM.nextval,:TEXTO_RESP1, :TEXTO_RESP2,:TEXTO_RESP3, :TEXTO_RESP4, :TEXTO_RESP5, :TEXTO_RESP6 )";

        string vParamNames = "TEXTO_RESP1|:TEXTO_RESP2|:TEXTO_RESP3|:TEXTO_RESP4|:TEXTO_RESP5|:TEXTO_RESP6";
        string vParamValues = TEXTO_RESP1 + "|" + TEXTO_RESP2 + "|" + TEXTO_RESP3 + "|" + TEXTO_RESP4 + "|" + TEXTO_RESP5 + "|" + TEXTO_RESP6;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM TABLA_RESP WHERE ID_RESP_COM=:ID_RESP_COM";

        string vParamNames = ":ID_RESP_COM";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Update()
    {
        string vSql = @"UPDATE TABLA_RESP 
                                SET TEXTO_RESP1=:TEXTO_RESP1, 
                                    TEXTO_RESP2=:TEXTO_RESP2, 
                                    TEXTO_RESP3=:TEXTO_RESP3,
                                    TEXTO_RESP4=:TEXTO_RESP4,
                                    TEXTO_RESP5=:TEXTO_RESP5, 
                                    TEXTO_RESP6=:TEXTO_RESP6 
                                    WHERE ID_RESP_COM=:ID_RESP_COM";

        string vParamNames = ":TEXTO_RESP1|:TEXTO_RESP2|:TEXTO_RESP3|:TEXTO_RESP4|:TEXTO_RESP5|:TEXTO_RESP6|:ID_RESP_COM";
        string vParamValues = TEXTO_RESP1 + "|" + TEXTO_RESP2 + "|" + TEXTO_RESP3 + "|" + TEXTO_RESP4 + "|" + TEXTO_RESP5 + "|" + TEXTO_RESP6 + "|" + ID_RESP_COM;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT * FROM TABLA_RESP WHERE ID_RESP_COM=" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID_RESP_COM = Convert.ToString(dt.Rows[0]["ID_RESP_COM"]);
            this.TEXTO_RESP1 = Convert.ToString(dt.Rows[0]["TEXTO_RESP1"]);
            this.TEXTO_RESP2 = Convert.ToString(dt.Rows[0]["TEXTO_RESP2"]);
            this.TEXTO_RESP3 = Convert.ToString(dt.Rows[0]["TEXTO_RESP3"]);
            this.TEXTO_RESP4 = Convert.ToString(dt.Rows[0]["TEXTO_RESP4"]);
            this.TEXTO_RESP5 = Convert.ToString(dt.Rows[0]["TEXTO_RESP5"]);
            this.TEXTO_RESP6 = Convert.ToString(dt.Rows[0]["TEXTO_RESP6"]);
        }
    }
    public static DataTable GetAll()
    {
        return OracleConn.GetData("SELECT * FROM TABLA_RESP");
    }
}