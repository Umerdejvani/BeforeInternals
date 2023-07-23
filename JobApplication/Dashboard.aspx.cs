using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace JobApplication
{
    public partial class Dashboard : System.Web.UI.Page
    {
        FYP_TEST_DBEntities dx = new FYP_TEST_DBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            Bind();
            BindChart1();
            BindChart2();

        }

        private void BindChart1()
        {

            double _MinValue = 0, _MaxValue = 0;
            Color pointColor = Color.FromArgb(102, 204, 255);

            var query = (from a in dx.tbl_PostedJobs
                         join b  in dx.tbl_positions on a.PositionID equals b.ID
                         select b).ToList();


            //Get relevant columns and count fro making source of chart
            var queryLate = query.GroupBy(x => x.Name).Select(item => new
            {
                DisplayDate = item.Key,
                EmployeCount = item.Count(),


            }).ToList();

            if (queryLate.Count() > 0)
            {
                lblchart1.Visible = false;
                Chart1.Enabled = true;
                Chart1.Visible = true;
                _MinValue = 0;
                _MaxValue = queryLate.Max(x => x.EmployeCount) + 10;

                Chart1.DataSource = queryLate;
                SetChartProperties(Chart1, _MinValue, _MaxValue, "No of Positions ", "Position Wise", "", "", "", "Positions");
                Chart1.Series[0].XValueMember = "DisplayDate";
                Chart1.Series[0].YValueMembers = "EmployeCount";
                Chart1.DataBind();

                int i = 0;
                foreach (var a in queryLate)
                {
                    Chart1.Series[0].Points[i].ToolTip = "Position : " + a.DisplayDate + "\n" + "Count : " + a.EmployeCount.ToString();
                    Chart1.Series[0].LabelAngle = 45;
                    Chart1.Series[0].Points[i].MarkerStyle = MarkerStyle.Circle;
                    Chart1.Series[0].Points[i].MarkerSize = 08;
                    Chart1.Series[0].Points[i].Color = Color.Black;
                    //Chart1.Series[0].Points[i].MapAreaAttributes = "target=\"_blank\"href=\"EmployeeDashboardDetails.aspx?type=15&fromdate=" + a.DisplayDate + "&datewise=Yes\"";

                    i++;

                }

            }
            if (Chart1.Titles.Count == 0)
            {
                //Color DarkGray = Color.FromArgb(121, 121, 121);
                //Chart1.Titles.Add(new Title("Late", Docking.Top, new Font("Arial", 15), DarkGray));
                //Chart1.Legends[0].Enabled = false;
                lblchart1.Visible = true;
                Chart1.Enabled = false;
                Chart1.Visible = false;
            }


        }

        private void BindChart2()
        {

            double _MinValue = 0, _MaxValue = 0;
            Color pointColor = Color.FromArgb(96, 101, 78);

            var querydashboard = (dx.sp_DashboardCount()).Where(x=>x.ReportType !=1).ToList();


            //Get relevant columns and count fro making source of chart
            //var queryLate = querydashboard.GroupBy(x => x.Name).Select(item => new
            //{
            //    DisplayDate = item.Key,
            //    EmployeCount = item.Count(),


            //}).ToList();

            if (querydashboard.Count() > 0)
            {
                lblchart2.Visible = false;
                Chart2.Enabled = true;
                Chart2.Visible = true;
                _MinValue = 0;
                _MaxValue = 50; //double.Parse((querydashboard.Max(x => x.TotalCount) + 10).ToString());

                Chart2.DataSource = querydashboard;
                SetChartProperties(Chart2, _MinValue, _MaxValue, "No of Candidates Participate in Round ", "Rounds", "", "", "", "Interview Rounds");
                Chart2.Series[0].XValueMember = "Name";
                Chart2.Series[0].YValueMembers = "TotalCount";
                Chart2.DataBind();

                int i = 0;
                foreach (var a in querydashboard)
                {
                    Chart2.Series[0].Points[i].ToolTip = "Round : " + a.Name + "\n" + "Count : " + a.TotalCount.ToString();
                    Chart2.Series[0].LabelAngle = 45;
                    Chart2.Series[0].Points[i].MarkerStyle = MarkerStyle.Circle;
                    Chart2.Series[0].Points[i].MarkerSize = 08;
                    Chart2.Series[0].Points[i].MarkerColor = pointColor;
                    //Chart1.Series[0].Points[i].MapAreaAttributes = "target=\"_blank\"href=\"EmployeeDashboardDetails.aspx?type=15&fromdate=" + a.DisplayDate + "&datewise=Yes\"";

                    i++;

                }

            }
            if (Chart2.Titles.Count == 0)
            {
                //Color DarkGray = Color.FromArgb(121, 121, 121);
                //Chart1.Titles.Add(new Title("Late", Docking.Top, new Font("Arial", 15), DarkGray));
                //Chart1.Legends[0].Enabled = false;
                lblchart2.Visible = true;
                Chart2.Enabled = false;
                Chart2.Visible = false;
            }


        }

        private void Bind()
        {
            var query = (from a in dx.tbl_Candidate
                         join b in dx.tbl_City on a.CityID equals b.ID
                         select new
                         {
                             a.Name,
                             a.Contact,
                             a.CNIC,
                             a.Email,
                             a.Experience,
                             a.RoundNo,
                             b.City
                         }).ToList();

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


            var querydashboard = (dx.sp_DashboardCount()).ToList();
            if (querydashboard.ToList().Count > 0)
            {
                int i = 1;
                foreach (var x in querydashboard.Where(x => x.ReportType == 1))
                {
                    if (i == 1)
                    {
                        lbldept1name.Text = x.Name;
                        lbldept1count.Text = x.TotalCount.ToString();

                        //Smjh nahi aarha tha to ye kardia
                        lbldept2name.Text = x.Name;
                        lbldept2count.Text = x.TotalCount.ToString();
                    }
                    else
                    {
                        //lbldept2name.Text = x.Name;
                        //lbldept2count.Text = x.TotalCount.ToString();
                    }
                }



                lblround1count.Text = querydashboard.Where(x => x.ReportType == 2).Sum(p => p.TotalCount).ToString();
                lblround2count.Text = querydashboard.Where(x => x.ReportType == 3).Sum(p => p.TotalCount).ToString();
                lblround3count.Text = querydashboard.Where(x => x.ReportType == 4).Sum(p => p.TotalCount).ToString();
            }
            else
            {
                lblround1count.Text = "0";
                lblround2count.Text = "0";
                lblround3count.Text = "0";
                lbldept1name.Text = "Department 1";
                lbldept1count.Text = "0";
                lbldept2name.Text = "Department 2";
                lbldept2count.Text = "0";
            }
        }


        private void SetChartProperties(Chart chart, double Min, double Max, string YAxisText, string TopText, string BottomText, string Legend1, string Legend2, string XAxisText)
        {
            Color DarkGray = Color.FromArgb(121, 121, 121);

            chart.ChartAreas[0].AxisY.Minimum = Min;
            chart.ChartAreas[0].AxisY.Maximum = Max;
            chart.ChartAreas[0].AxisY.IntervalAutoMode = IntervalAutoMode.FixedCount;
            chart.ChartAreas[0].AxisY.IsStartedFromZero = true;
            chart.ChartAreas[0].AxisY.Title = YAxisText;
            chart.ChartAreas[0].AxisX.Minimum = Min;
            chart.ChartAreas[0].AxisX.IntervalAutoMode = IntervalAutoMode.FixedCount;
            chart.ChartAreas[0].AxisX.IsStartedFromZero = true;
            chart.ChartAreas[0].AxisX.Title = XAxisText;


            if (chart.Titles.Count == 0)
            {
                chart.Titles.Add(new Title(TopText, Docking.Top, new Font("Arial", 15), DarkGray));
                // chart.Titles.Add(new Title(BottomText, Docking.Bottom));
            }

            chart.Legends[0].Enabled = false;

            //chart.Series[0].LegendText = Legend1;
            //chart.Legends[0].Position.Auto = false;
            //chart.Legends[0].Position = new ElementPosition(300, 0, 10, 5);
        }

    }
}