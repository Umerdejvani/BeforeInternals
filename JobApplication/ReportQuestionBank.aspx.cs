using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class ReportQuestionBank : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        HelperClass hc = new HelperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hc.GetJobCategory(ref ddlposition);
                hc.GetJobType(ref ddljobtype);


                Bind();
            }
        }

        private void Bind()
        {
            long? _PositionID = null, _JobTypeID = null;

            if (ddlposition.SelectedIndex > 0)
            {
                _PositionID = long.Parse(ddlposition.SelectedValue);
            }



            if (ddljobtype.SelectedIndex > 0)
            {
                _JobTypeID = long.Parse(ddljobtype.SelectedValue);
            }


            var query = dx.sp_ReportQuestionBank(_PositionID, _JobTypeID).ToList();
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