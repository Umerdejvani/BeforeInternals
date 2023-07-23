using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class AddJobs : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        HelperClass hc = new HelperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hc.GetJobCategory(ref ddljobcategory);
                hc.GetJobType(ref ddljobtype);
                hc.GetDepartment(ref ddldepartment);


                hc.GetCity(ref ddlcity);
                Bind();
            }
        }

        private void Bind()
        {
            var query = (dx.sp_GetJobPostDetail()).ToList();

            if(query.ToList().Count>0)
            {
                GVCat.DataSource = query;
                GVCat.DataBind();
            }
            else
            {
                GVCat.DataSource = null;
                GVCat.DataBind();
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ddldepartment.SelectedIndex>0 && txttitle.Text !="" && ddljobcategory.SelectedIndex > 0 && ddlcity.SelectedIndex > 0 && ddljobtype.SelectedIndex >0  && txtexp.Text != "")
            {
                tbl_PostedJobs tb = new tbl_PostedJobs();

                tb.PositionID = int.Parse(ddljobcategory.SelectedValue);
                tb.JobTypeID = int.Parse(ddljobtype.SelectedValue);
                tb.Job_Title = txttitle.Text;
                tb.DeptID = int.Parse(ddldepartment.SelectedValue);
                tb.CityID = int.Parse(ddlcity.SelectedValue);
                tb.Experience = int.Parse(txtexp.Text);
                tb.RoomKey= CreateRoomKey(DateTime.Now.Ticks.ToString());
                tb.Created_date = DateTime.Now;
                tb.Posted_date = DateTime.Now;
                dx.tbl_PostedJobs.Add(tb);
                dx.SaveChanges();

                HelperClass.DirectDisplayMessage(Page, GetType(), "Job Posted Successfully");
                HelperClass.ClearAllTextBox(this);
                HelperClass.ClearAllDropDown(this);

                Bind();
            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "Filled Cannot Be Empty");

            }
        }


        public string CreateRoomKey(string data)
        {

            string passPhrase = "Fin@lYe@rProjecT";
            string saltValue = "itsmylife";                     // can be any string
            string hashAlgorithm = "SHA1";                      // can be "MD5"
            int passwordIterations = 14;                        // can be any number
            string initVector = "~1B2c3D4e5F6g7H8";             // must be 16 bytes
            int keySize = 256;                                  // can be 192 or 128

            byte[] bytes = Encoding.ASCII.GetBytes(initVector);
            byte[] rgbSalt = Encoding.ASCII.GetBytes(saltValue);
            byte[] buffer = Encoding.UTF8.GetBytes(data);
            byte[] rgbKey = new PasswordDeriveBytes(passPhrase, rgbSalt, hashAlgorithm, passwordIterations).GetBytes(keySize / 8);
            RijndaelManaged managed = new RijndaelManaged();
            managed.Mode = CipherMode.CBC;
            ICryptoTransform transform = managed.CreateEncryptor(rgbKey, bytes);
            MemoryStream stream = new MemoryStream();
            CryptoStream stream2 = new CryptoStream(stream, transform, CryptoStreamMode.Write);
            stream2.Write(buffer, 0, buffer.Length);
            stream2.FlushFinalBlock();
            byte[] inArray = stream.ToArray();
            stream.Close();
            stream2.Close();
            return Convert.ToBase64String(inArray);
        }

        protected void lbltotalapply_Command(object sender, CommandEventArgs e)
        {
            if(e.CommandName=="cmdapply")
            {
                long JID = long.Parse(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('JobApply.aspx?ID=" + JID + "');", true);
            }
        }
    }
}