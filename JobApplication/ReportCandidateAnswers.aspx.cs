using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class ReportCandidateAnswers : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        HelperClass hc = new HelperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hc.GetCandidate(ref ddlcandidate);


                Bind();
            }
        }

        private void Bind()
        {
            long? _CandidateID = null;

            if (ddlcandidate.SelectedIndex > 0)
            {
                _CandidateID = long.Parse(ddlcandidate.SelectedValue);
            }



            
            var query = dx.sp_ViewQuestionBank(_CandidateID).ToList();
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Bind();
        }
    }
}