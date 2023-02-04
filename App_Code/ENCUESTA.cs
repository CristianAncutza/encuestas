using System;
using System.Data;

public class ENCUESTA
{
    public string ID_ENC;
    public string DES_ENCUESTA;
    public string ANONIMO;
    public string USUARIO_TODOS;
    public string ESTADO;
    public string FECHA_VTO;
    public string EPIGRAFE;
    public string ID_AREA_TEMATICA;

    public void New()
    {
        ID_ENC = "-1";
        DES_ENCUESTA = "";
        ANONIMO = "";
        USUARIO_TODOS = "";
        ESTADO = "";
        FECHA_VTO = "";
        EPIGRAFE = "";
        ID_AREA_TEMATICA = "-1";
    }
    public void Create()
    {
        string vSql = "INSERT INTO ENCUESTA (ID_ENC,DESCRIPCION, ANONIMO, USUARIO_TODOS, ESTADO, FECHA_VTO, EPIGRAFE, ID_AREA_TEMATICA) VALUES (SEQ_ID_ENC.nextval,:DES_ENCUESTA, :ANONIMO, :USUARIO_TODOS, :ESTADO, :FECHA_VTO, :EPIGRAFE, :ID_AREA_TEMATICA)";

        string vParamNames = ":DES_ENCUESTA|:ANONIMO|:USUARIO_TODOS|:ESTADO|:FECHA_VTO|:EPIGRAFE|:ID_AREA_TEMATICA";
        string vParamValues = DES_ENCUESTA.Replace(" ", "_") + "|" + ANONIMO + "|" + USUARIO_TODOS + "|" + ESTADO + "|" + FECHA_VTO + "|" + EPIGRAFE + "|" + ID_AREA_TEMATICA;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM ENCUESTA WHERE ID_ENC=:ID_ENC";

        string vParamNames = ":ID_ENC";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));

    }
    public void Update()
    {
        string vSql = "UPDATE ENCUESTA SET DESCRIPCION=:DES_ENCUESTA,ANONIMO=:ANONIMO,USUARIO_TODOS=:USUARIO_TODOS,ESTADO=:ESTADO,FECHA_VTO=:FECHA_VTO,EPIGRAFE=:EPIGRAFE,ID_AREA_TEMATICA=:ID_AREA_TEMATICA WHERE ID_ENC=:ID_ENC";

        string vParamNames = ":DES_ENCUESTA|:ANONIMO|:USUARIO_TODOS|:ESTADO|:FECHA_VTO|:EPIGRAFE|:ID_AREA_TEMATICA|:ID_ENC";
        string vParamValues = DES_ENCUESTA.Replace(" ", "_") + "|" + ANONIMO + "|" + USUARIO_TODOS + "|" + ESTADO + "|" + FECHA_VTO + "|" + EPIGRAFE + "|" + ID_AREA_TEMATICA + "|" + ID_ENC;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT * FROM ENCUESTA WHERE ID_ENC=" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID_ENC = Convert.ToString(dt.Rows[0]["ID_ENC"]);
            this.DES_ENCUESTA = Convert.ToString(dt.Rows[0]["DESCRIPCION"]);
            this.ANONIMO = Convert.ToString(dt.Rows[0]["ANONIMO"]);
            this.USUARIO_TODOS = Convert.ToString(dt.Rows[0]["USUARIO_TODOS"]);
            this.ESTADO = Convert.ToString(dt.Rows[0]["ESTADO"]);
            this.FECHA_VTO = Convert.ToString(dt.Rows[0]["FECHA_VTO"]);
            this.EPIGRAFE = Convert.ToString(dt.Rows[0]["EPIGRAFE"]);
            this.ID_AREA_TEMATICA = Convert.ToString(dt.Rows[0]["ID_AREA_TEMATICA"]);
        }
    }
    public static DataTable GetAll()
    {
        return OracleConn.GetData("SELECT S.ID_ENC,S.ANONIMO,S.USUARIO_TODOS,S.ESTADO,S.FECHA_VTO,S.EPIGRAFE,S.ID_AREA_TEMATICA, S.DESCRIPCION AS DES_ENCUESTA, G.DESCRIPCION AS DES_AREA_TEMATICA FROM ENCUESTA S INNER JOIN AREA_TEMATICA G ON (S.ID_AREA_TEMATICA = G.ID_AREA_TEMATICA)");
    }
    public static int GetByTitle(string pTitle)
    {
        int vResult = -1;
        try
        {
            vResult = Convert.ToInt32(OracleConn.GetData("SELECT ID_ENC FROM ENCUESTA WHERE UPPER(DESCRIPCION)=UPPER('" + pTitle + "')").Rows[0][0]);
        }
        catch { }
        return vResult;
    }

}