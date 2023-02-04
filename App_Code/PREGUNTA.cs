using System;
using System.Data;

public class PREGUNTA
{
    public string ID_ENC;
    public string ID_PREG;
    public string TEXTO_PREG;
    public string TEXTO_OBS;
    public string ID_TIPO_RESPUESTA;
    public string ID_ESTILO;
    public string ID_AREA_TEMATICA;
    public string ID_PERFIL;

    public string GetNextOrden(string pID_ENC)
    {
        return Convert.ToString(OracleConn.GetData("SELECT MAX(orden)+1 FROM PREGUNTA WHERE ID_ENC=" + pID_ENC).Rows[0][0]);
    }

    public void New(string pID_ENC)
    {
        ID_PREG = "-1";
        TEXTO_PREG = "";
        TEXTO_OBS = "";
        ID_TIPO_RESPUESTA = "1";
        ID_ESTILO = "-1";
        ID_AREA_TEMATICA = "-1";
        ID_PERFIL = "-1";
    }
    public void Create()
    {
        string vSql = @"INSERT INTO PREGUNTA (ID_PREG,ID_ENC,TEXTO_PREG,TEXTO_OBS,ID_TIPO_RESPUESTA,ID_PERFIL,ID_ESTILO,ID_AREA_TEMATICA,ORDEN) 
                                VALUES (SEQ_ID_PREGUNTA.nextval,:ID_ENC,:TEXTO_PREG,:TEXTO_OBS,:ID_TIPO_RESPUESTA,:ID_PERFIL,:ID_ESTILO,:ID_AREA_TEMATICA,:ORDEN)";

        string vParamNames = ":ID_ENC|:TEXTO_PREG|:TEXTO_OBS|:ID_TIPO_RESPUESTA|:ID_PERFIL|:ID_ESTILO|:ID_AREA_TEMATICA|:ORDEN";
        string vParamValues = ID_ENC + "|" + TEXTO_PREG + "|" + TEXTO_OBS + "|" + ID_TIPO_RESPUESTA + "|" + ID_PERFIL + "|" + ID_ESTILO + "|" + ID_AREA_TEMATICA + "|" + GetNextOrden(ID_ENC);

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM PREGUNTA WHERE ID_PREG=:ID_PREG";

        string vParamNames = ":ID_PREG";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Update()
    {
        string vSql = @"UPDATE PREGUNTA SET 
                                TEXTO_PREG=:TEXTO_PREG,
                                TEXTO_OBS=:TEXTO_OBS,
                                ID_TIPO_RESPUESTA=:ID_TIPO_RESPUESTA,
                                ID_PERFIL=:ID_PERFIL,
                                ID_ESTILO=:ID_ESTILO,
                                ID_AREA_TEMATICA=:ID_AREA_TEMATICA
                                WHERE ID_PREG=:ID_PREG";

        string vParamNames = ":TEXTO_PREG|:TEXTO_OBS|:ID_TIPO_RESPUESTA|:ID_PERFIL|:ID_ESTILO|:ID_AREA_TEMATICA|:ORDEN|:ID_PREG";
        string vParamValues = TEXTO_PREG + "|" + TEXTO_OBS + "|" + ID_TIPO_RESPUESTA + "|" + ID_PERFIL + "|" + ID_ESTILO + "|" + ID_AREA_TEMATICA + "|" + ID_PREG;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT * FROM PREGUNTA WHERE ID_PREG=" + pID);
        if (dt.Rows.Count > 0)
        {
            ID_PREG = Convert.ToString(dt.Rows[0]["ID_PREG"]);
            ID_ENC = Convert.ToString(dt.Rows[0]["ID_ENC"]);
            TEXTO_PREG = Convert.ToString(dt.Rows[0]["TEXTO_PREG"]);
            TEXTO_OBS = Convert.ToString(dt.Rows[0]["TEXTO_OBS"]);
            ID_TIPO_RESPUESTA = Convert.ToString(dt.Rows[0]["ID_TIPO_RESPUESTA"]);
            ID_ESTILO = Convert.ToString(dt.Rows[0]["ID_ESTILO"]);
            ID_AREA_TEMATICA = Convert.ToString(dt.Rows[0]["ID_AREA_TEMATICA"]);
            ID_PERFIL = Convert.ToString(dt.Rows[0]["ID_PERFIL"]);
        }
    }
    public static DataTable GetByPREGUNTAID(string pEncID)
    {
        string vSql = @"SELECT A.*, B.DESCRIPCION AS DES_AREA_TEMATICA, C.NOMBRE_ESTILO AS DES_ESTILO, D.NOMBRE_PERFIL AS DES_PERFIL, DECODE(A.ID_TIPO_RESPUESTA,1,'TEXTO',2,'LISTA',3,'MULTIPLE',4,'RANKING') AS DES_TIPO_RESPUESTA
                                FROM PREGUNTA A
                                LEFT JOIN AREA_TEMATICA B ON (A.ID_AREA_TEMATICA = B.ID_AREA_TEMATICA)
                                LEFT JOIN ESTILO C ON (A.ID_ESTILO = C.ID_ESTILO)
                                LEFT JOIN PERFIL D ON (A.ID_PERFIL = D.ID_PERFIL)
                                WHERE A.ID_ENC=" + pEncID;

        return OracleConn.GetData(vSql);
    }
}