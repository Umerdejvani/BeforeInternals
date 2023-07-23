using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class AddQuestions : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        HelperClass hc = new HelperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hc.GetJobCategory(ref ddljobcategory);
                hc.GetJobType(ref ddljobtype);

            }
        }



        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ddljobcategory.SelectedIndex > 0 && ddljobtype.SelectedIndex > 0 && ddlcorrectoption.SelectedIndex > 0 && txtquestion.Text != "" && txtoptiona.Text != "" && txtoptionb.Text != "" && txtoptionc.Text != "" && txtoptiond.Text != "")
            {
                tbl_questionBank tb = new tbl_questionBank();

                tb.PositionID = int.Parse(ddljobcategory.SelectedValue);
                tb.JobTypeId = int.Parse(ddljobtype.SelectedValue);
                tb.Question = txtquestion.Text;
                tb.OptionA = txtoptiona.Text;
                tb.OptionB = txtoptionb.Text;
                tb.OptionC = txtoptionc.Text;
                tb.OptionD = txtoptiond.Text;
                tb.CorrectAnswer = ddlcorrectoption.SelectedValue;
                dx.tbl_questionBank.Add(tb);
                dx.SaveChanges();

                HelperClass.DirectDisplayMessage(Page, GetType(), "Question Added Successfully");
                HelperClass.ClearAllTextBox(this);
                HelperClass.ClearAllDropDown(this);

                txtquestion.Focus();
            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "Filled Cannot Be Empty");

            }
        }
    }
}