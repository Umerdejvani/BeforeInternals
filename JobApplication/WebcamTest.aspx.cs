using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class WebcamTest : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            string bs64 = hfName.Value;
        }

        protected void btnfinish_Click(object sender, EventArgs e)
        {
            string _Value = hfName.Value.Replace("data:video/mp4;base64,", "");
            Byte[] _bytes = Convert.FromBase64String(_Value);

            var update3 = (from a in dx.tbl_Ex_Task_Round3 where a.ID == 7001 select a).FirstOrDefault();
            update3.Attachment = _bytes;
            update3.TestExtension = ".mp4";
            update3.EndTime = DateTime.Now;
            double _A = update3.EndTime.Value.Subtract(update3.StartTime.Value).TotalMinutes;
            update3.Status = _A <= 1 ? "Pass" : "Fail";
            dx.SaveChanges();


        }
    }
}