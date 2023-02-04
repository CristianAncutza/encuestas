using System;
using System.Data;
using System.Data.OracleClient;
using System.Configuration;

/// <summary>
/// Summary description for OracleConn
/// </summary>
public class OracleConn
{
    public static void Execute(string pSql)
    {

        string vConnectionString = ConfigurationSettings.AppSettings["OracleConnectionString"];
        OracleConnection _Conn = new OracleConnection();
        _Conn.ConnectionString = vConnectionString;
        _Conn.Open();
        OracleCommand vCmd = new OracleCommand(pSql, _Conn);
        try
        {
            vCmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        finally
        {
            _Conn.Close();
            _Conn.Dispose();
        }
    }
    public static void Execute(string pSql, string[] pParamNames, string[] pParamValues)
    {

        string vConnectionString = ConfigurationSettings.AppSettings["OracleConnectionString"];
        OracleConnection _Conn = new OracleConnection();
        _Conn.ConnectionString = vConnectionString;
        _Conn.Open();
        OracleCommand vCmd = new OracleCommand(pSql, _Conn);
        for (int i = 0; i < pParamNames.Length; i++)
        {
            OracleParameter vOraPar = new OracleParameter(pParamNames[i], pParamValues[i].Replace("\"", "'"));
            vCmd.Parameters.Add(vOraPar);
        }
        try
        {
            vCmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        finally
        {
            _Conn.Close();
            _Conn.Dispose();
        }
    }
    public static DataTable GetData(string pSql)
    {
        string vConnectionString = ConfigurationSettings.AppSettings["OracleConnectionString"];
        OracleConnection _Conn = new OracleConnection();
        _Conn.ConnectionString = vConnectionString;
        _Conn.Open();
        OracleDataAdapter vAdap = new OracleDataAdapter(pSql, vConnectionString);
        DataTable dt = new DataTable();
        vAdap.Fill(dt);
        _Conn.Close();
        return dt;
    }
}