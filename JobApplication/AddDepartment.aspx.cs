using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class AddDepartment : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            var get = (from a in dx.tbl_department select a).OrderBy(x => x.Name).ToList();
            if (get.ToList().Count > 0)
            {
                GVCat.DataSource = get;
                GVCat.DataBind();
            }
            else
            {
                GVCat.DataSource = null;
                GVCat.DataBind();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txtdepartment.Text != "")
            {
                var get = (from a in dx.tbl_department where a.Name.ToLower() == txtdepartment.Text.ToLower() select a).FirstOrDefault();
                if (get == null)
                {
                    tbl_department tb = new tbl_department();
                    tb.Name = txtdepartment.Text;
                    dx.tbl_department.Add(tb);
                    dx.SaveChanges();

                    HelperClass.DirectDisplayMessage(Page, GetType(), "Department Added Successfully");
                    HelperClass.ClearAllTextBox(this);
                    txtdepartment.Focus();

                    BindData();
                }
                else
                {
                    HelperClass.DirectDisplayMessage(Page, GetType(), "Department Name Already Exists");

                }
            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "Insert Department Name");
            }
        }
    }
}