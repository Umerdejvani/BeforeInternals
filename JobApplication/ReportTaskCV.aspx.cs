using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class ReportTaskCV : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        HelperClass hc = new HelperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hc.GetCandidate(ref ddlcandidate);

            }
        }

        private void Bind()
        {





            var query = (dx.sp_CandidateDetail(null, null, null, null, null, null, null, null, null)).ToList();

            if (query.ToList().Count > 0)
            {
                if (ddlcandidate.SelectedIndex > 0)
                {
                    long _CandidateID = long.Parse(ddlcandidate.SelectedValue);
                    query = query.Where(x => x.CID == _CandidateID).ToList();
                }

                if (query.ToList().Count > 0)
                {
                    gv.DataSource = query;
                    gv.DataBind();
                }
                else
                {
                    gv.DataSource = null;
                    gv.DataBind();
                }
            }
            else
            {
                gv.DataSource = null;
                gv.DataBind();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Bind();
        }

        protected void lnkview_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "viewresume")
            {
                long _ID = long.Parse(e.CommandArgument.ToString());

                var query = (from a in dx.tbl_Candidate where a.ID == _ID select a).FirstOrDefault();
                if (query != null)
                {
                    if (query.Extension != null)
                    {
                        if (query.Extension.ToLower() == ".pdf")
                        {
                            ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('displaypdf.aspx?type=viewresume&sno=" + _ID + "');", true);
                        }

                    }
                    else
                    {
                        HelperClass.DirectDisplayMessage(Page, GetType(), "No File Found");
                    }
                }


            }
            else if (e.CommandName == "viewtest")
            {

                long _CID = long.Parse(e.CommandArgument.ToString());

                var query = (from a in dx.tbl_Ex_Task_Round3 where a.CandidateID == _CID select a).FirstOrDefault();
                if (query != null)
                {
                    if (query.TestExtension != null)
                    {
                        if (query.TestExtension.ToLower() == ".mp4")
                        {
                            string base64String = "data:video/mp4;base64," + Convert.ToBase64String(query.Attachment, 0, query.Attachment.Length);

                            lblvideoname.Text = "Round 3 Task";
                            vid.Attributes["src"] = base64String;
                            ModalPopupExtenderVideo.Show();
                        }
                        else if (query.TestExtension.ToLower() == ".pdf")
                        {
                            ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('displaypdf.aspx?type=viewresume&sno=" + query.ID + "');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('displayallimage.aspx?type=viewtest&sno=" + query.ID + "');", true);
                        }
                    }
                    else
                    {
                        HelperClass.DirectDisplayMessage(Page, GetType(), "No File Found");
                    }
                }
            }
           

        }
    }
}