<%@ WebHandler Language="C#" Class="ImageHandler" CodeBehind="ImageHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;



    public class ImageHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                byte[] bytes = null;
                int id = int.Parse(context.Request.QueryString["Id"]);
                string type = context.Request.QueryString["type"].ToString();

                //SqlConnection Conn = new SqlConnection(@"Data Source=172.16.0.178;Initial Catalog=JobPortal;User Id=sa; password= ahl");
                SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDbAMS"].ConnectionString);

                Conn.Open();


                SqlCommand cmd = new SqlCommand();
                SqlDataReader reader;


                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_GetFiles";
                cmd.Parameters.AddWithValue("@ReportType", type);
                cmd.Parameters.AddWithValue("@ID", id);
                cmd.Connection = Conn;

                reader = cmd.ExecuteReader();
                reader.Read();

                if (reader["Attachment"] != null)
                {
                    bytes = (byte[])reader["Attachment"];

                    context.Response.BinaryWrite(bytes);
                }


                Conn.Close();
                context.Response.End();

            }
            catch (Exception)
            {

            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

