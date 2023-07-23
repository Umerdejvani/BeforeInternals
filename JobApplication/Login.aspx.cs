using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class Login : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
          
        }



        protected void btnlogin_Click(object sender, EventArgs e)
        {
            if (txtlogin.Text != "" && txtpassword.Text != "")
            {
                string _Username = txtlogin.Text.ToLower();
                string password = txtpassword.Text.ToLower();
                var chk = (from a in dx.tbl_Users where a.Username == _Username && a.UserPassword == password select a).FirstOrDefault();
                if (chk != null)
                {
                    Session["userid"] = chk.ID.ToString();
                    Response.Redirect("~/Dashboard.aspx", false);
                    //Response.Redirect("~/ExamRoom1.aspx?TaskID=" + 2, false);
                }
                else
                {
                    HelperClass.DirectDisplayMessage(Page, GetType(), "Invalid User");
                }
            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "User name and Password Cannot Be Empty");

            }
        }
    }
}