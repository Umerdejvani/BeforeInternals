<%@ WebHandler Language="C#" Class="pdfhandler" CodeBehind="pdfhandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
public class pdfhandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        int id = int.Parse(context.Request.QueryString["Id"]);
        string type = context.Request.QueryString["type"].ToString();
        byte[] bytes = null;
        string fileName = "", contentType = "";


        //SqlConnection Conn = new SqlConnection(@"Data Source=172.16.0.178;Initial Catalog=JobPortal;User Id=sa; password= ahl");
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbAMS"].ConnectionString);
        Conn.Open();

        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_GetFiles";
            cmd.Parameters.AddWithValue("@ReportType", type);
            cmd.Parameters.AddWithValue("@ID", id);

            cmd.Connection = Conn;

            using (SqlDataReader sdr = cmd.ExecuteReader())
            {
                sdr.Read();
                if (sdr["Attachment"] != null)
                {

                    bytes = (byte[])sdr["Attachment"];
                    contentType = ".pdf";
                    fileName = sdr["ID"].ToString();
                }
            }

        }


        context.Response.Buffer = true;
        context.Response.Charset = "";
        if (context.Request.QueryString["download"] == "1")
        {
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
        }
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        context.Response.ContentType = "application/pdf";
        context.Response.BinaryWrite(bytes);
        context.Response.Flush();
        context.Response.End();

        Conn.Close();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
