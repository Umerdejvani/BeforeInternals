using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class displayallimage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string sno = Context.Request.QueryString["sno"];
            string type = Context.Request.QueryString["type"];
            Image1.ImageUrl = "ImageHandler.ashx?type=" + type + "&Id=" + sno;
        }
    }
}