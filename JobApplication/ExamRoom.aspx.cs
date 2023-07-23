using iTextSharp.text.pdf;
using iTextSharp.text.pdf.parser;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class ExamRoom : System.Web.UI.Page
    {

        // Round 123 = 0 = Not Attempt 1= Failed 2=Pass
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        HelperClass hc = new HelperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ModalPopupExtender2.Show();
            }
        }
        #region round1

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lbljid.Text = "";
            lbljobcid.Text = "";
            lbljobtid.Text = "";
            txtname.Text = "";
            txtemail.Text = "";
            txtexp.Text = "";
            txtmobileno.Text = "";
            txtnic.Text = "";
            ddlcity.Items.Clear();
            ddlcity.DataSource = null;
            ddlcity.DataBind();

            txtname.Enabled = true;
            txtemail.Enabled = true;
            txtexp.Enabled = true;
            txtmobileno.Enabled = true;
            txtnic.Enabled = true;
            ddlcity.Enabled = true;

            if (txtroom.Text != "")
            {
                var chk = (from a in dx.tbl_PostedJobs where a.RoomKey == txtroom.Text select a).FirstOrDefault();
                if (chk != null)
                {
                    lbltitle.Text = chk.Job_Title;

                    if (attachmentfile.HasFile)
                    {
                        string Extension = System.IO.Path.GetExtension(attachmentfile.PostedFile.FileName);
                        if (Extension.ToLower() == ".pdf")
                        {
                            string FileName = System.IO.Path.GetFileName(attachmentfile.PostedFile.FileName);

                            string FilePath = Server.MapPath("~/" + FileName);
                            attachmentfile.SaveAs(FilePath);

                            string _EmailAddress = HelperClass.pdfText(FilePath);
                            string City = HelperClass.GetCity(FilePath);
                            string NIC = HelperClass.GetNIC(FilePath);
                            string MobileNo = HelperClass.GetMobileNo(FilePath);

                            if (_EmailAddress != "")
                            {
                                long? _CID = AddCandidate(_EmailAddress, Extension, chk.ID);

                                if (_CID != null)
                                {
                                    Session["CID"] = _CID;

                                    lbljobcid.Text = chk.PositionID.ToString();
                                    lbljobtid.Text = chk.JobTypeID.Value.ToString();
                                    lbljid.Text = chk.ID.ToString();

                                    txtemail.Text = _EmailAddress;
                                    txtnic.Text = HelperClass.REmoveSpecialCharacter(NIC).Replace("-", "");
                                    txtmobileno.Text = MobileNo;


                                    txtemail.Enabled = false;
                                    txtmobileno.Enabled = txtmobileno.Text == "" ? true : false;
                                    txtnic.Enabled = txtnic.Text == "" ? true : false;


                                    Dictionary<long, string> dic = new Dictionary<long, string>();
                                    if (City != "")
                                    {

                                        foreach (var x in City.Split(','))
                                        {
                                            dic.Add(hc.GETCityID(x.ToUpper()), x.ToUpper());
                                        }
                                        if (dic.ToList().Count == 1)
                                        {
                                            ddlcity.DataSource = dic;
                                            ddlcity.DataTextField = "Value";
                                            ddlcity.DataValueField = "Key";
                                            ddlcity.DataBind();
                                            ddlcity.Enabled = false;
                                        }
                                        else
                                        {
                                            ddlcity.DataSource = dic;
                                            ddlcity.DataTextField = "Value";
                                            ddlcity.DataValueField = "Key";
                                            ddlcity.DataBind();
                                            ddlcity.Items.Insert(0, "- Select City -");

                                        }

                                    }
                                    else
                                    {

                                        hc.GetCity(ref ddlcity);

                                    }


                                    ModalPopupExtender1.Show();


                                }
                                else
                                {
                                    //HelperClass.DirectDisplayMessage(Page, GetType(), "User Already Applied For This Job");
                                    divround1.Visible = false;
                                    divround2.Visible = false;
                                    divround3.Visible = false;
                                    divroundfail.Visible = true;
                                }
                            }
                            else
                            {
                                HelperClass.DirectDisplayMessage(Page, GetType(), "Kindly Upload Resume In PDF Format");
                            }
                        }
                        else
                        {
                            HelperClass.DirectDisplayMessage(Page, GetType(), "Kindly Upload PDF Format");
                        }
                    }
                    else
                    {
                        HelperClass.DirectDisplayMessage(Page, GetType(), "Kindly Upload Resume");

                    }
                }
                else
                {
                    HelperClass.DirectDisplayMessage(Page, GetType(), "Invalid Room Number");

                }
            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "Kindly Enter Room No");
            }

        }

        private long? AddCandidate(string _Email, string _Extension, long _JID)
        {

            long? _CID = null;

            var chk = (from a in dx.tbl_Candidate
                       join b in dx.tbl_Ex_Interview_Round1 on a.ID equals b.CandidateID
                       where a.Email.ToLower() == _Email.ToLower() && b.JobID == _JID
                       select a).FirstOrDefault();

            if (chk == null)
            {

                tbl_Candidate tb = new tbl_Candidate();

                Stream fs = attachmentfile.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);
                Byte[] bytes = br.ReadBytes((Int32)fs.Length);

                tb.Email = _Email;
                tb.RoundNo = 1;
                tb.Attachment = bytes;
                tb.Extension = _Extension;
                dx.tbl_Candidate.Add(tb);
                dx.SaveChanges();

                _CID = tb.ID;

                tbl_Ex_Interview_Round1 tbl = new tbl_Ex_Interview_Round1();
                tbl.CandidateID = int.Parse(_CID.ToString());
                tbl.JobID = int.Parse(_JID.ToString());
                tbl.SubmittedDate = DateTime.Now;
                dx.tbl_Ex_Interview_Round1.Add(tbl);
                dx.SaveChanges();

            }

            return _CID;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (txtname.Text != "" && txtemail.Text != "" && txtexp.Text != "" && txtmobileno.Text != "" && txtnic.Text != "" && ddlcity.SelectedItem.Text != "- Select City -")
            {
                long CID = long.Parse(Session["CID"].ToString());
                long JID = long.Parse(lbljid.Text);

                if (hc.IsValidEmail(txtemail.Text) == true)
                {
                    if (txtnic.Text.Length == 13)
                    {
                        if (txtmobileno.Text.Length == 11)
                        {
                            var update = (from a in dx.tbl_Candidate where a.ID == CID select a).FirstOrDefault();
                            if (update != null)
                            {
                                update.Name = txtname.Text;
                                update.Email = txtemail.Text;
                                update.Experience = int.Parse(txtexp.Text);
                                update.Contact = txtmobileno.Text;
                                update.CNIC = txtnic.Text;
                                update.CityID = long.Parse(ddlcity.SelectedValue);
                                dx.SaveChanges();

                                txtname.Text = "";
                                txtemail.Text = "";
                                txtexp.Text = "";
                                txtmobileno.Text = "";
                                txtnic.Text = "";
                                ddlcity.Items.Clear();
                                ddlcity.DataSource = null;
                                ddlcity.DataBind();
                            }

                            var chkexp = (from a in dx.tbl_PostedJobs where a.ID == JID select a).FirstOrDefault();
                            if (chkexp != null)
                            {
                                if (update.Experience >= chkexp.Experience)
                                {
                                    List<QuestionClass> lst = new List<QuestionClass>();
                                    var getquestion = (dx.sp_GetInterviewQuestions(long.Parse(lbljobcid.Text), long.Parse(lbljobtid.Text))).OrderBy(x => x.ID).ToList();
                                    if (getquestion.ToList().Count > 0)
                                    {
                                        var update1 = (from a in dx.tbl_Ex_Interview_Round1 where a.CandidateID == CID select a).FirstOrDefault();
                                        if (update1 != null)
                                        {
                                            update1.Status = "Pass";
                                            update1.Remarks = "";
                                            dx.SaveChanges();
                                        }


                                        foreach (var x in getquestion)
                                        {
                                            lst.Add(new QuestionClass { ID = x.ID, Question = x.Question, OPtionA = x.OptionA, OPtionB = x.OptionB, OPtionC = x.OptionC, OPtionD = x.OptionD, CorrectOption = x.CorrectAnswer, Answer = "" });
                                        }

                                        var question = (from a in lst where a.Answer == "" select a).FirstOrDefault();
                                        if (question != null)
                                        {
                                            lblquestion.Text = question.Question;
                                            lblquestionid.Text = question.ID.ToString();

                                            rd.Items.Insert(0, new ListItem(question.OPtionA, "A"));
                                            rd.Items.Insert(1, new ListItem(question.OPtionB, "B"));
                                            rd.Items.Insert(2, new ListItem(question.OPtionC, "C"));
                                            rd.Items.Insert(3, new ListItem(question.OPtionD, "D"));

                                            ViewState["QuestionState"] = lst;
                                        }

                                        lblround.Text = "( Round 2)";


                                        divround2.Visible = true;
                                        divround1.Visible = false;
                                        divround3.Visible = false;
                                        divroundfail.Visible = false;

                                        TimeSpan time = TimeSpan.FromSeconds(2 * 60);
                                        string str = time.ToString(@"hh\:mm\:ss");
                                        lblround2timer.Text = str;
                                    }
                                    else
                                    {
                                        HelperClass.DirectDisplayMessage(Page, GetType(), "No Question Found");
                                    }
                                }
                                else
                                {
                                    //HelperClass.DirectDisplayMessage(Page, GetType(), "Experience Should Be More Than " + chkexp.Experience);
                                    //ModalPopupExtender1.Show();

                                    var update1 = (from a in dx.tbl_Ex_Interview_Round1 where a.CandidateID == CID select a).FirstOrDefault();
                                    if (update1 != null)
                                    {
                                        update1.Status = "Fail";
                                        update1.Remarks = "Experience Issue";
                                        dx.SaveChanges();
                                    }


                                    divround1.Visible = false;
                                    divround2.Visible = false;
                                    divround3.Visible = false;
                                    divroundfail.Visible = true;

                                }
                            }
                        }
                        else
                        {
                            HelperClass.DirectDisplayMessage(Page, GetType(), "Mobile# is Incorrect.");
                            ModalPopupExtender1.Show();

                        }
                    }
                    else
                    {
                        HelperClass.DirectDisplayMessage(Page, GetType(), "NIC is Invalid.");
                        ModalPopupExtender1.Show();

                    }
                }
                else
                {
                    HelperClass.DirectDisplayMessage(Page, GetType(), "Email Format is Invalid.");
                    ModalPopupExtender1.Show();

                }
            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "Kindly Select All Fields To Continue");
                ModalPopupExtender1.Show();
            }
        }

        #endregion

        #region round2

        protected void Timer1_Tick(object sender, EventArgs e)
        {

            TimeSpan result = TimeSpan.FromSeconds(TimeSpan.Parse(lblround2timer.Text).TotalSeconds - 1);
            string fromTimeString = result.ToString(@"hh\:mm\:ss");
            lblround2timer.Text = fromTimeString;

            if (lblround2timer.Text == "00:00:00")
            {
                List<QuestionClass> lst = new List<QuestionClass>();
                lst = (List<QuestionClass>)ViewState["QuestionState"];


                lblround2timer.Text = "Time's Up 0:00";

                ////
                Round2(lst);

            }

        }

        protected void btnnext_Click(object sender, EventArgs e)
        {
            if (rd.SelectedIndex >= 0)
            {
                int _ID = int.Parse(lblquestionid.Text);

                List<QuestionClass> lst = new List<QuestionClass>();
                lst = (List<QuestionClass>)ViewState["QuestionState"];

                lst.Where(w => w.ID == _ID).ToList().ForEach(s => s.Answer = rd.SelectedValue);
                int _CID = int.Parse(Session["CID"].ToString());
                int? round2id = null;
                var getjid = (from a in dx.tbl_Ex_Interview_Round1 where a.CandidateID == _CID select a).FirstOrDefault();
                var chk = (from a in dx.tbl_Ex_Quiz_Round2 where a.CandidateID == _CID select a).FirstOrDefault();
                if (chk == null)
                {
                    tbl_Ex_Quiz_Round2 tbl = new tbl_Ex_Quiz_Round2();
                    tbl.CandidateID = _CID;
                    tbl.JobID = getjid.JobID;
                    dx.tbl_Ex_Quiz_Round2.Add(tbl);
                    dx.SaveChanges();
                    round2id = tbl.ID;
                }
                else
                {
                    round2id = chk.ID;
                }

                tbl_results_round2 tb = new tbl_results_round2();

                tb.CandidateID = _CID;
                tb.Round2RecordID = round2id;
                tb.CorrectAnswer = rd.SelectedValue;
                tb.QuestionID = _ID;
                dx.tbl_results_round2.Add(tb);
                dx.SaveChanges();


                var question = (from a in lst where a.Answer == "" select a).FirstOrDefault();
                if (question != null)
                {
                    rd.Items.Clear();
                    rd.DataSource = null;

                    lblquestion.Text = question.Question;
                    lblquestionid.Text = question.ID.ToString();

                    rd.Items.Insert(0, new ListItem(question.OPtionA, "A"));
                    rd.Items.Insert(1, new ListItem(question.OPtionB, "B"));
                    rd.Items.Insert(2, new ListItem(question.OPtionC, "C"));
                    rd.Items.Insert(3, new ListItem(question.OPtionD, "D"));

                    ViewState["QuestionState"] = lst;
                }
                else
                {
                    Round2(lst);
                }

            }

        }

        public void Round2(List<QuestionClass> lst)
        {
            Timer1.Enabled = false;
            btnnext.Visible = false;

            decimal _Total = 0;
            foreach (var x in lst)
            {
                if (x.CorrectOption.ToLower() == x.Answer.ToLower())
                {
                    _Total++;
                }
            }

            decimal _Per = (_Total / lst.Count) * 100;

            if (_Per >= 70)
            {
                int CID = int.Parse(Session["CID"].ToString());

                var update = (from a in dx.tbl_Candidate
                              where a.ID == CID
                              select a).FirstOrDefault();
                if (update != null)
                {

                    var get = (from a in dx.tbl_Ex_Quiz_Round2
                               join b in dx.tbl_PostedJobs on a.JobID equals b.ID
                               where a.CandidateID == update.ID
                               select b).FirstOrDefault();

                    var gettask = dx.sp_GetTask(get.PositionID, get.JobTypeID).FirstOrDefault();

                    update.RoundNo = 2;
                    dx.SaveChanges();

                    var update1 = (from a in dx.tbl_Ex_Quiz_Round2 where a.CandidateID == CID select a).FirstOrDefault();
                    if (update1 != null)
                    {
                        update1.Status = "Pass";
                        update1.Remarks = "Total Percentage :" + _Per;
                        dx.SaveChanges();
                    }

                    var chk = (from a in dx.tbl_Ex_Task_Round3 where a.CandidateID == CID select a).FirstOrDefault();
                    if (chk == null)
                    {
                        tbl_Ex_Task_Round3 tb = new tbl_Ex_Task_Round3();

                        tb.CandidateID = CID;
                        tb.JobID = get.ID;
                        tb.TaskQID = gettask.ID;
                        tb.StartTime = DateTime.Now;
                        dx.tbl_Ex_Task_Round3.Add(tb);
                        dx.SaveChanges();
                    }

                    lblround.Text = "( Round 3)";

                    divround1.Visible = false;
                    divround2.Visible = false;
                    divroundfail.Visible = false;

                    if (get.DeptID != 2001)
                    {
                        lbltakquestion.Text = gettask.Question;
                        divround3.Visible = true;
                        TimeSpan time = TimeSpan.FromSeconds(2 * 60);
                        string str = time.ToString(@"hh\:mm\:ss");
                        lblround3timer.Text = str;
                        btnround3stop.Visible = true;
                    }
                    else
                    {

                        Response.Redirect("~/ExamRoom1.aspx?TaskID="+ gettask.ID, false);
                        //lbltakquestionmarketing.Text = gettask.Question;
                        //divround3marketing.Visible = true;
                    }
                }
            }
            else
            {
                long CID = long.Parse(Session["CID"].ToString());

                var update = (from a in dx.tbl_Candidate where a.ID == CID select a).FirstOrDefault();
                if (update != null)
                {
                    update.RoundNo = 2;
                    dx.SaveChanges();
                }

                var update1 = (from a in dx.tbl_Ex_Quiz_Round2 where a.CandidateID == CID select a).FirstOrDefault();
                if (update1 != null)
                {
                    update1.Status = "Fail";
                    update1.Remarks = "Total Percentage :" + _Per;
                    dx.SaveChanges();
                }

                //fail

                divround1.Visible = false;
                divround2.Visible = false;
                divround3.Visible = false;
                divroundfail.Visible = true;
            }
        }

        [Serializable]
        public class QuestionClass
        {
            public long? ID { get; set; }
            public string Question { get; set; }
            public string Answer { get; set; }
            public string OPtionA { get; set; }
            public string OPtionB { get; set; }
            public string OPtionC { get; set; }
            public string OPtionD { get; set; }
            public string CorrectOption { get; set; }

        }



        #endregion

        #region round3

        protected void Timer2_Tick(object sender, EventArgs e)
        {
            TimeSpan result = TimeSpan.FromSeconds(TimeSpan.Parse(lblround3timer.Text).TotalSeconds - 1);
            string fromTimeString = result.ToString(@"hh\:mm\:ss");
            lblround3timer.Text = fromTimeString;

            if (lblround3timer.Text == "00:00:00")
            {
                lblround3timer.Text = "Time's Up 0:00";
                Timer2.Enabled = false;

                btnuploadtask.Visible = true;
                btnround3stop.Visible = false;
            }
        }

        protected void btnuploadtask_Click(object sender, EventArgs e)
        {
            if (FileUploadTask.HasFile)
            {
                string Extension = System.IO.Path.GetExtension(FileUploadTask.PostedFile.FileName);
                if (Extension.ToLower() == ".jpg" || Extension.ToLower() == ".png" || Extension.ToLower() == ".jpeg" || Extension.ToLower() == ".pdf")
                {

                    long CID = long.Parse(Session["CID"].ToString());

                    var update = (from a in dx.tbl_Candidate where a.ID == CID select a).FirstOrDefault();
                    if (update != null)
                    {
                        Stream fs = FileUploadTask.PostedFile.InputStream;
                        BinaryReader br = new BinaryReader(fs);
                        Byte[] bytes = br.ReadBytes((Int32)fs.Length);


                        update.RoundNo = 3;
                        dx.SaveChanges();


                        var update3 = (from a in dx.tbl_Ex_Task_Round3 where a.CandidateID == CID select a).FirstOrDefault();


                        update3.Attachment = bytes;
                        update3.TestExtension = Extension;
                        update3.EndTime = DateTime.Now;


                        double _A = update3.EndTime.Value.Subtract(update3.StartTime.Value).TotalMinutes;
                        update3.Status = _A <= 3 ? "Pass" : "Fail";

                        dx.SaveChanges();

                        //fail
                        divround1.Visible = false;
                        divround2.Visible = false;
                        divround3.Visible = false;
                        divroundfail.Visible = true;

                    }
                }
                else
                {
                    HelperClass.DirectDisplayMessage(Page, GetType(), "Upload Only Image File");
                }
            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "Kindly Attach File");

            }
        }

        protected void btnround3stop_Click(object sender, EventArgs e)
        {
            lblround3timer.Text = "Time Stop Kindly Upload Your Task";
            Timer2.Enabled = false;

            btnuploadtask.Visible = true;
            btnround3stop.Visible = false;
        }

        #endregion


    }
}