using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class ReportCandidate : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        HelperClass hc = new HelperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hc.GetCity(ref ddlcity);
                hc.GetDepartment(ref ddldept);
                hc.GetJobType(ref ddljobtype);
                hc.GetJobCategory(ref ddlposition);

                Bind();
            }
        }

        private void Bind()
        {

            string Name = "", Contact = "", CNIC = "", Email = "";
            long? Experience = null;
            long? CityID = null;
            long? PositionID = null;
            long? JobTypeID = null;
            long? DeptID = null;

            if (ddldept.SelectedIndex > 0)
            {
                DeptID = long.Parse(ddldept.SelectedValue);
            }

            if (ddljobtype.SelectedIndex > 0)
            {
                JobTypeID = long.Parse(ddljobtype.SelectedValue);
            }

            if (ddlposition.SelectedIndex > 0)
            {
                PositionID = long.Parse(ddlposition.SelectedValue);
            }


            if (txtcandidate.Text != "")
            {
                Name = txtcandidate.Text;
            }
            else
            {
                Name = null;
            }

            if (ddlcity.SelectedIndex > 0)
            {
                CityID = long.Parse(ddlcity.SelectedValue);
            }

            if (txtcontactno.Text != "")
            {
                Contact = txtcontactno.Text;
            }
            else
            {
                Contact = null;
            }

            if (txtCNIC.Text != "")
            {
                CNIC = txtCNIC.Text;
            }
            else
            {
                CNIC = null;
            }

            if (txtemail.Text != "")
            {
                Email = txtemail.Text;
            }
            else
            {
                Email = null;
            }

            if (txtExperience.Text != "")
            {
                Experience = long.Parse(txtExperience.Text);
            }
            
            var query = (dx.sp_CandidateDetail(Name, Contact, CNIC, Email, Experience, CityID, PositionID, JobTypeID, DeptID)).ToList();

            if (query.ToList().Count > 0)
            {
                rp.DataSource = query;
                rp.DataBind();
            }
            else
            {
                rp.DataSource = null;
                rp.DataBind();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Bind();
        }
    }
}