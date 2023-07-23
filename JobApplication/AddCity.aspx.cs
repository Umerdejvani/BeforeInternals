using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class AddCity : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            var get = (from a in dx.tbl_City select a).OrderBy(x => x.City).ToList();
            if(get.ToList().Count>0)
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
            if(txtcity.Text !="")
            {
                var get = (from a in dx.tbl_City where a.City.ToLower()==txtcity.Text.ToLower() select a).FirstOrDefault();
                if (get ==null)
                {
                    tbl_City tb = new tbl_City();
                    tb.City = txtcity.Text.ToUpper();
                    tb.ActiveStatus = true;
                    dx.tbl_City.Add(tb);
                    dx.SaveChanges();

                    HelperClass.DirectDisplayMessage(Page, GetType(), "City Added Successfully");
                    HelperClass.ClearAllTextBox(this);
                    txtcity.Focus();

                    BindData();
                }
                else
                {
                    HelperClass.DirectDisplayMessage(Page, GetType(), "City Name Already Exists");

                }
            }
            else
            {
                HelperClass.DirectDisplayMessage(Page, GetType(), "Insert City Name");
            }
        }
    }
}