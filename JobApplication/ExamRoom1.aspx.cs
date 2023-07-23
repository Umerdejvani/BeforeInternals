using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class ExamRoom1 : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["CID"] = 7003;
            BindData();
        }

        private void BindData()
        {
            long _ID = long.Parse(Request.QueryString[0].ToString());
            var get = (from a in dx.tbl_Task where a.ID == _ID select a).FirstOrDefault();
            if (get != null)
            {
                lbltakquestionmarketing.Text = get.Question;
                divround3marketing.Visible = true;
                divroundfail.Visible = false;
            }
        }

        protected void btnfinish_Click(object sender, EventArgs e)
        {
            if (hfName.Value != "")
            {
                string _Value = hfName.Value.Replace("data:video/mp4;base64,", "");
                Byte[] _bytes = Convert.FromBase64String(_Value);

                long CID = long.Parse(Session["CID"].ToString());

                var update = (from a in dx.tbl_Candidate where a.ID == CID select a).FirstOrDefault();
                if (update != null)
                {
                    update.RoundNo = 3;
                    dx.SaveChanges();


                    var update3 = (from a in dx.tbl_Ex_Task_Round3 where a.CandidateID == CID select a).FirstOrDefault();
                    update3.Attachment = _bytes;
                    update3.TestExtension = ".mp4";
                    update3.EndTime = DateTime.Now;
                    double _A = update3.EndTime.Value.Subtract(update3.StartTime.Value).TotalMinutes;
                    update3.Status = _A <= 1 ? "Pass" : "Fail";

                    dx.SaveChanges();


                    divround3marketing.Visible = false;
                    divroundfail.Visible = true;

                }

            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "Kindly Record Video First");

            }
        }
    }
}