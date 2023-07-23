using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class JobApply : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDetail(long.Parse(Request.QueryString[0].ToString()));


                //Stream fs = fuuploadprofile.PostedFile.InputStream;
                //BinaryReader br = new BinaryReader(fs);
                //Byte[] bytes = br.ReadBytes((Int32)fs.Length);

                //var query = (from a in ams.tbl_Employee where a.ID == _EID select a).FirstOrDefault();
                //if (query != null)
                //{
                //    query.ProfileImage = bytes;
                //    query.Extenstion = ext;
                //    ams.SaveChanges();

                //    string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                //    imgprofile.ImageUrl = "data:image/jpeg;base64," + base64String;
                //}

            }

        }

        private void BindDetail(long _JID)
        {

            var query1 = (dx.sp_GetJobPostDetail()).Where(x => x.ID == _JID).FirstOrDefault();
            if (query1 != null)
            {
                lbljobdetail.Text = query1.DepartmentName + " (" + query1.PositionName + ") Detail:";
            }


            var query = (dx.sp_GetCandidateDetail(_JID)).ToList();
            if (query.ToList().Count > 0)
            {
                GV.DataSource = query;
                GV.DataBind();
            }
            else
            {
                GV.DataSource = null;
                GV.DataBind();

            }
        }

        protected void lbltotalapply_Command(object sender, CommandEventArgs e)
        {
            //if (query.Extension.ToLower() == ".pdf")
            //{
            //    ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('displaypdf.aspx?type=viewresume&sno=" + query.sno + "');", true);
            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('displayallimage.aspx?type=viewtest&sno=" + query.sno + "');", true);
            //}
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
            else if (e.CommandName == "viewquestion")
            {
                long _ID = long.Parse(e.CommandArgument.ToString());

                var query = (dx.sp_ViewQuestionBank(_ID).ToList());
                if(query.ToList().Count>0)
                {
                    gvdetail.DataSource = query;
                    gvdetail.DataBind();
                    ModalPopupExtender1.Show();
                }
                else
                {
                    gvdetail.DataSource = null;
                    gvdetail.DataBind();
                    HelperClass.DirectDisplayMessage(Page, GetType(), "No Record Found");

                }

            }

        }
    }
}