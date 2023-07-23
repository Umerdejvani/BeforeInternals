using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class AddTask : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        HelperClass hc = new HelperClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hc.GetJobCategory(ref ddlposition);
                hc.GetJobType(ref ddljobtype);

                BindData();

            }
        }

        private void BindData()
        {
            var get = (from a in dx.tbl_Task
                       join b in dx.tbl_positions on a.PositionID equals b.ID
                       join c in dx.tbl_jobtype on a.JTypeID equals c.ID
                       select new { a.ID, a.Question, JobType = c.Name, PositionName = b.Name }).OrderBy(x => x.Question).ToList();
            if (get.ToList().Count > 0)
            {
                gv.DataSource = get;
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
            if (ddlposition.SelectedIndex > 0 && ddljobtype.SelectedIndex > 0 && txtquestion.Text != "")
            {
                tbl_Task tb = new tbl_Task();

                tb.PositionID = int.Parse(ddlposition.SelectedValue);
                tb.JTypeID = int.Parse(ddljobtype.SelectedValue);
                tb.Question = txtquestion.Text;
                tb.InsertedDateTime = DateTime.Now;
                dx.tbl_Task.Add(tb);
                dx.SaveChanges();

                HelperClass.DirectDisplayMessage(Page, GetType(), "Task Added Successfully");
                HelperClass.ClearAllTextBox(this);
                HelperClass.ClearAllDropDown(this);

                txtquestion.Focus();
                BindData();
            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "Filled Cannot Be Empty");

            }
        }
    }
}