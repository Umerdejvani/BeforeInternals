using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class displaypdf : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Context.Request.QueryString["sno"];
            string type = Context.Request.QueryString["type"];
            //int id = int.Parse((sender as LinkButton).CommandArgument);

            // string embed = "<object width='840px' height='1000px' type='application /pdf' data='{0}{1}#zoom=85&scrollbar=0&toolbar=0&navpanes=0'>";
            string embed = "<object data=\"{0}{1}\" type=\"application/pdf\" width=\"100%\" height=\"1000px\" align=\"center\">";
            embed += "If you are unable to view file, you can download from <a href = \"{0}{1}&download=1\">here</a>";
            embed += " or download <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
            embed += "</object>";
            ltEmbed.Text = string.Format(embed, ResolveUrl("~/pdfhandler.ashx?type=" + type + "&Id="), id);
        }
    }
}