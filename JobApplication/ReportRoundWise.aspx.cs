using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class ReportRoundWise : System.Web.UI.Page
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
            long? _CandidateID = null, _Round=null;
            string  Status = "";

            if(ddlcandidate.SelectedIndex>0)
            {
                _CandidateID = long.Parse(ddlcandidate.SelectedValue);
            }

            if (ddlstatus.SelectedIndex > 0)
            {
                Status = ddlstatus.SelectedValue;
            }
            else
            {
                Status = null;
            }

            if (ddlroundno.SelectedIndex > 0)
            {
                _Round = long.Parse(ddlroundno.SelectedValue);
            }


            var query = dx.sp_ReportRoundWise(_CandidateID, Status, _Round, null, null).ToList();
            if(query.ToList().Count > 0)
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