using System;
using System.Data;

public class USUARIO
{
    public string NOMBRE;
    public string LOGIN;
    public string MAIL;
    public string ID_GERENCIA;
    public string ID_SECTOR;
    public string ID_PERFIL;
    public string ID_USU;

    public void New()
    {
        NOMBRE = "";
        LOGIN = "";
        MAIL = "";
        ID_SECTOR = "-1";
        ID_GERENCIA = "-1";
        ID_PERFIL = "-1";
    }
    public void Create()
    {
        string vSql = "INSERT INTO USUARIO (ID_USU, NOMBRE, LOGIN, MAIL, ID_GERENCIA, ID_SECTOR, ID_PERFIL) VALUES (SEQ_ID_USU.nextval,:NOMBRE, :LOGIN, :MAIL, :ID_GERENCIA, :ID_SECTOR, :ID_PERFIL)";


        string vParamNames = ":NOMBRE|:LOGIN|:MAIL|:ID_GERENCIA|:ID_SECTOR|:ID_PERFIL";
        string vParamValues = NOMBRE + "|" + LOGIN + "|" + MAIL + "|" + ID_GERENCIA + "|" + ID_SECTOR + "|" + ID_PERFIL;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public static void Delete(string pID)
    {
        string vSql = "DELETE FROM USUARIO WHERE ID_USU=:ID_USU";

        string vParamNames = ":ID_USU";
        string vParamValues = pID;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));

    }
    public void Update()
    {
        string vSql = @"UPDATE USUARIO SET NOMBRE= :NOMBRE, 
                                                  LOGIN= :LOGIN, 
                                                  MAIL= :MAIL, 
                                                  ID_GERENCIA = :ID_GERENCIA, 
                                                  ID_SECTOR = :ID_SECTOR, 
                                                  ID_PERFIL = :ID_PERFIL 
                                                  WHERE ID_USU= :ID_USU";

        string vParamNames = ":NOMBRE|:LOGIN|:MAIL|:ID_GERENCIA|:ID_SECTOR|:ID_PERFIL|:ID_USU";
        string vParamValues = NOMBRE + "|" + LOGIN + "|" + MAIL + "|" + ID_GERENCIA + "|" + ID_SECTOR + "|" + ID_PERFIL + "|" + ID_USU;

        OracleConn.Execute(vSql, vParamNames.Split('|'), vParamValues.Split('|'));
    }
    public void Fill(string pID)
    {
        DataTable dt = OracleConn.GetData("SELECT * FROM USUARIO WHERE ID_USU=" + pID);
        if (dt.Rows.Count > 0)
        {
            this.ID_USU = Convert.ToString(dt.Rows[0]["ID_USU"]);
            this.NOMBRE = Convert.ToString(dt.Rows[0]["NOMBRE"]);
            this.LOGIN = Convert.ToString(dt.Rows[0]["LOGIN"]);
            this.MAIL = Convert.ToString(dt.Rows[0]["MAIL"]);
            this.ID_GERENCIA = Convert.ToString(dt.Rows[0]["ID_GERENCIA"]);
            this.ID_SECTOR = Convert.ToString(dt.Rows[0]["ID_SECTOR"]);
            this.ID_PERFIL = Convert.ToString(dt.Rows[0]["ID_PERFIL"]);
        }
    }
    public static DataTable GetAll()
    {
        //"SELECT S.ID_SECTOR, S.ID_GERENCIA, S.DESCRIPCION AS DES_USUARIO, G.DESCRIPCION AS DES_GERENCIA FROM USUARIO S INNER JOIN GERENCIA G ON (S.ID_GERENCIA = G.ID_GERENCIA
        return OracleConn.GetData("SELECT U.*, G.DESCRIPCION AS DES_GERENCIA, S.DESCRIPCION AS DES_SECTOR, P.NOMBRE_PERFIL AS DES_PERFIL FROM USUARIO U INNER JOIN GERENCIA G ON (U.ID_GERENCIA = G.ID_GERENCIA) INNER JOIN SECTOR S ON (U.ID_SECTOR = S.ID_SECTOR) INNER JOIN PERFIL P ON (U.ID_PERFIL = P.ID_PERFIL)");
    }
}
