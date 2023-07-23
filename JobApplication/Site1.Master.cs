using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] != null)
            {
                long _ID = long.Parse(Session["userid"].ToString());
                var chk = (from a in dx.tbl_Users where a.ID == _ID select a).FirstOrDefault();
                if (chk != null)
                {
                    lblfirstname.Text = chk.FirstName;
                    lbllastname.Text = chk.LastName;
                }
            }
        }

        protected void lnklogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Login.aspx", false);
            Session.Abandon();
            Session.Clear();
        }
    }
}