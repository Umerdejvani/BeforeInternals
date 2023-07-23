using ASPSnippets.LinkedInAPI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class LinkedIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LinkedInConnect.APIKey = "77unr0p44qisgs";
            LinkedInConnect.APISecret = "s7gtYcPgqi9eleNH";

            LinkedInConnect.RedirectUrl = Request.Url.AbsoluteUri.Split('?')[0];
            if (LinkedInConnect.IsAuthorized)
            {
                pnlDetails.Visible = true;
                DataSet ds = LinkedInConnect.Fetch();
                imgPicture.ImageUrl = ds.Tables["person"].Rows[0]["picture-url"].ToString();
                lblName.Text = ds.Tables["person"].Rows[0]["first-name"].ToString();
                lblName.Text += " " + ds.Tables["person"].Rows[0]["last-name"].ToString();
                lblEmailAddress.Text = ds.Tables["person"].Rows[0]["email-address"].ToString();
                lblHeadline.Text = ds.Tables["person"].Rows[0]["headline"].ToString();
                lblIndustry.Text = ds.Tables["person"].Rows[0]["industry"].ToString();
                lblLinkedInId.Text = ds.Tables["person"].Rows[0]["id"].ToString();
                lblLocation.Text = ds.Tables["location"].Rows[0]["name"].ToString();
                imgPicture.ImageUrl = ds.Tables["person"].Rows[0]["picture-url"].ToString();
            }
        }

        protected void Authorize(object sender, EventArgs e)
        {
            LinkedInConnect.Authorize();
        }
    }
}