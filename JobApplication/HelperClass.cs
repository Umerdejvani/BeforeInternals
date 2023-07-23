using iTextSharp.text.pdf;
using iTextSharp.text.pdf.parser;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public class HelperClass
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        public static void DirectDisplayMessage(Page page, Type type, string _Message)
        {
            ScriptManager.RegisterClientScriptBlock(page, type, "alert", "alert('" + _Message + "');", true);
        }

        public static void ClearAllTextBox(Control con)
        {
            try
            {
                foreach (Control c in con.Controls)
                {
                    if (c is TextBox)
                        ((TextBox)c).Text = "";
                    else
                        ClearAllTextBox(c);
                }
            }
            catch (Exception ex)
            {

            }
        }

        public static void ClearAllDropDown(Control con)
        {
            try
            {
                foreach (Control c in con.Controls)
                {
                    if (c is DropDownList)
                        ((DropDownList)c).SelectedIndex = 0;
                    else
                        ClearAllDropDown(c);
                }
            }
            catch (Exception ex)
            {

            }
        }

        public bool IsValidEmail(string email)
        {
            try
            {
                string[] _E = email.Split(',');
                foreach (var x in _E)
                {
                    var addr = new System.Net.Mail.MailAddress(x);
                }
                return true;


            }
            catch (Exception)
            {

                return false;

            }
        }

        #region ReadingPDF
        public static string REmoveSpecialCharacter(string text)
        {
            string myString = Regex.Replace(text, "[^0-9A-Za-z _-]", "");
            return Regex.Replace(myString, @"\s+", " ");
        }

        public static string pdfText(string path)
        {
            PdfReader reader = new PdfReader(path);
            string text = string.Empty;
            for (int page = 1; page <= reader.NumberOfPages; page++)
            {
                text += PdfTextExtractor.GetTextFromPage(reader, page);
            }
            reader.Close();



            const string MatchEmailPattern =
              @"(([\w-]+\.)+[\w-]+|([a-zA-Z]{1}|[\w-]{2,}))@"
              + @"((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\."
              + @"([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])){1}|"
              + @"([a-zA-Z]+[\w-]+\.)+[a-zA-Z]{2,4})";

            Regex rx = new Regex(MatchEmailPattern, RegexOptions.Compiled | RegexOptions.IgnoreCase);

            // Find matches.
            MatchCollection matches = rx.Matches(text);

            // Report the number of matches found.
            int noOfMatches = matches.Count;

            string _Email = "";
            // Report on each match.
            foreach (Match match in matches)
            {
                // if (!_Email.Contains(match.Value.ToString()))
                // {
                //_Email += match.Value.ToString() + ",";
                //}
                _Email += match.Value.ToString();
                break;
            }

            //_Email = _Email.TrimEnd(',');

            return _Email;
        }

        public static string GetCity(string path)
        {
            PdfReader reader = new PdfReader(path);
            string text = string.Empty;
            for (int page = 1; page <= reader.NumberOfPages; page++)
            {
                text += PdfTextExtractor.GetTextFromPage(reader, page);
            }
            reader.Close();

            string pattern = @"\b(karachi|lahore|islamabad|rawalpindi|peshawar|faisalabad|multan)\b";


            Regex rg = new Regex(pattern);

            string _City = "";
            MatchCollection matchedAuthors = rg.Matches(text.ToLower());
            // Print all matched authors
            for (int count = 0; count < matchedAuthors.Count; count++)
            {
                if (!_City.Contains(matchedAuthors[count].Value))
                {
                    _City += matchedAuthors[count].Value + ",";
                }
            }

            _City = _City.TrimEnd(',');

            return _City;
        }

        public static string GetNIC(string path)
        {
            PdfReader reader = new PdfReader(path);
            string text = string.Empty;
            for (int page = 1; page <= reader.NumberOfPages; page++)
            {
                text += PdfTextExtractor.GetTextFromPage(reader, page);
            }
            reader.Close();

            string _NIC = "";
            text = REmoveSpecialCharacter(text);
            string[] t = text.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var x in t)
            {
                if (x.StartsWith("4") && (x.Length == 15 || x.Length == 13))
                {
                    _NIC = x;
                    if (_NIC.Replace("-", "").Length == 13)
                    {
                        break;
                    }
                }
            }



            return _NIC;
        }

        public static string GetMobileNo(string path)
        {
            PdfReader reader = new PdfReader(path);
            string text = string.Empty;
            for (int page = 1; page <= reader.NumberOfPages; page++)
            {
                text += PdfTextExtractor.GetTextFromPage(reader, page);
            }
            reader.Close();

            string _MObileNo = "";
            text = REmoveSpecialCharacter(text).Replace("-", "");
            string[] t = text.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);

            string pattern = @"^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$";



            Regex rg = new Regex(pattern);

            foreach (var x in t)
            {
                MatchCollection matchedAuthors = rg.Matches(x.ToLower());

                for (int count = 0; count < matchedAuthors.Count; count++)
                {
                    _MObileNo = matchedAuthors[count].Value;
                }
            }


            // Print all matched authors




            return _MObileNo;
        }

        #endregion


        #region BindDropDownList

        public void GetDepartment(ref DropDownList dll)
        {
            var query = (from a in dx.tbl_department select a).OrderBy(x => x.Name).ToList();
            if (query.ToList().Count > 0)
            {
                dll.DataTextField = "Name";
                dll.DataValueField = "ID";
                dll.DataSource = query;
                dll.DataBind();
                dll.Items.Insert(0, "- Select -");
            }

        }

        public void GetJobType(ref DropDownList dll)
        {
            var query = (from a in dx.tbl_jobtype select a).OrderBy(x => x.Name).ToList();
            if (query.ToList().Count > 0)
            {
                dll.DataTextField = "Name";
                dll.DataValueField = "ID";
                dll.DataSource = query;
                dll.DataBind();
                dll.Items.Insert(0, "- Select -");
            }

        }
        public void GetJobCategory(ref DropDownList dll)
        {
            var query = (from a in dx.tbl_positions select a).OrderBy(x => x.Name).ToList();
            if (query.ToList().Count > 0)
            {
                dll.DataTextField = "Name";
                dll.DataValueField = "ID";
                dll.DataSource = query;
                dll.DataBind();
                dll.Items.Insert(0, "- Select -");
            }

        }

        public void GetCandidate(ref DropDownList dll)
        {
            var query = (from a in dx.tbl_Candidate select a).OrderBy(x => x.Name).ToList();
            if (query.ToList().Count > 0)
            {
                dll.DataTextField = "Name";
                dll.DataValueField = "ID";
                dll.DataSource = query;
                dll.DataBind();
                dll.Items.Insert(0, "- Select -");
            }

        }

        public void GetCity(ref DropDownList dll)
        {
            var querycity = (from a in dx.tbl_City
                             select a).OrderBy(x => x.City).ToList();
            if (querycity.ToList().Count > 0)
            {
                dll.DataTextField = "City";
                dll.DataValueField = "ID";
                dll.DataSource = querycity;
                dll.DataBind();
                dll.Items.Insert(0, "- Select -");
            }

        }

        public long GETCityID(string CityName)
        {
            var querycity = (from a in dx.tbl_City where a.City == CityName select a).FirstOrDefault();
            return querycity.ID;
        }
        #endregion
    }
}