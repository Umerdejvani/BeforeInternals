<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="JobApplication.Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Dashboard
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .chart {
            position: relative;
            display: inline-block;
            width: 110px;
            height: 110px;
            margin-top: 20px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="server">
    <div class="app-main__inner">
        <div class="app-page-title">
            <div class="page-title-wrapper">
                <div class="page-title-heading">
                    <div class="page-title-icon">
                        <i class="pe-7s-stopwatch icon-gradient bg-amy-crisp"></i>
                    </div>
                    <div>
                        Dashboard
                        <div class="page-title-subheading">
                            Admin Dashboard
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="row">
            <div class="col-md-6 col-xl-6">
                <div class="card mb-3 widget-content" style="background-color : #60654e">
                    <div class="widget-content-wrapper text-white">
                        <div class="widget-content-left">
                            <div class="widget-heading">Marketing Jobs</div>
                            <div class="widget-subheading">
                                Total
                                <asp:Label ID="lbldept1name" runat="server"></asp:Label>
                                Department Job Count
                            </div>
                        </div>
                        <div class="widget-content-right">
                            <div class="widget-numbers text-white">
                                <span>
                                    <asp:Label ID="lbldept1count" runat="server"></asp:Label></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-6">
                <div class="card mb-3 widget-content "style="background-color : #60654e">
                    <div class="widget-content-wrapper text-white">
                        <div class="widget-content-left">
                            <div class="widget-heading">Graphics Jobs</div>
                            <div class="widget-subheading">
                                Total
                                <asp:Label ID="lbldept2name" runat="server"></asp:Label>
                                Department Job Count
                            </div>
                        </div>
                        <div class="widget-content-right">
                            <div class="widget-numbers text-white">
                                <span>
                                    <asp:Label ID="lbldept2count" runat="server"></asp:Label></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- <div class="col-md-6 col-xl-4">
                <div class="card mb-3 widget-content bg-grow-early">
                    <div class="widget-content-wrapper text-white">
                        <div class="widget-content-left">
                            <div class="widget-heading">Followers</div>
                            <div class="widget-subheading">People Interested</div>
                        </div>
                        <div class="widget-content-right">
                            <div class="widget-numbers text-white"><span>46%</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-xl-none d-lg-block col-md-6 col-xl-4">
                <div class="card mb-3 widget-content bg-premium-dark">
                    <div class="widget-content-wrapper text-white">
                        <div class="widget-content-left">
                            <div class="widget-heading">Products Sold</div>
                            <div class="widget-subheading">Revenue streams</div>
                        </div>
                        <div class="widget-content-right">
                            <div class="widget-numbers text-warning">
                                <span>$14M</span>

                            </div>
                        </div>
                    </div>
                </div>
            </div>--%>
        </div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="mb-3 card">
                    <div class="card-header-tab card-header-tab-animation card-header">
                        <div class="card-header-title">
                            <i class="header-icon lnr-apartment icon-gradient bg-dark"></i>
                            Position Report
                        </div>

                    </div>
                    <div class="card-body">
                        <div class="tab-content">
                            <div class="row">
                                <div class="col-sm-12">

                                    <div class="chart table-responsive" style="height: auto; width: 100%; border: 2px solid lightgray; border-radius: 5px;">

                                        <h3 class="text-center" id="lblchart1" runat="server" visible="false">No Record For Position Report</h3>

                                        <asp:Chart ID="Chart1" ClientIDMode="static" runat="server" BorderlineWidth="0" Height="400px" Width="1300px" BorderDashStyle="Solid"
                                            BackSecondaryColor="White" BackGradientStyle="Center" BorderWidth="2px" BackColor="Gray"
                                            BorderColor="#60654e" EnableViewState="true">

                                            <Series>
                                                <asp:Series Name="Series1" ChartType="Spline" Color="#60654e" BorderWidth="2"
                                                    IsValueShownAsLabel="false" ChartArea="ChartArea1"
                                                    MarkerBorderColor="#60654e">
                                                </asp:Series>

                                            </Series>
                                            <Legends>
                                                <asp:Legend Title="" />
                                            </Legends>

                                            <ChartAreas>
                                                <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid"
                                                    BackSecondaryColor="White" BackColor="white" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                                                    <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                                        WallWidth="0" IsClustered="False"></Area3DStyle>
                                                    <AxisY LineColor="64, 64, 64, 64">
                                                        <LabelStyle Font="Arial, 8.25pt, style=Bold" />
                                                        <MajorGrid LineColor="64, 64, 64, 64" />
                                                    </AxisY>
                                                    <AxisX LineColor="64, 64, 64, 64">
                                                        <LabelStyle Font="Arial, 8.25pt, style=Bold" />
                                                        <MajorGrid LineColor="64, 64, 64, 64" />
                                                    </AxisX>
                                                </asp:ChartArea>
                                            </ChartAreas>
                                        </asp:Chart>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-12 col-lg-12">
                <div class="mb-3 card">
                    <div class="card-header-tab card-header-tab-animation card-header">
                        <div class="card-header-title">
                            <i class="header-icon lnr-apartment icon-gradient bg-love-kiss"></i>
                            Interview Rounds Report
                        </div>

                    </div>
                    <div class="card-body">
                        <div class="tab-content">
                            <div class="row">
                                <div class="col-sm-12">

                                    <div class="chart table-responsive" style="height: auto; width: 100%; border: 2px solid lightgray; border-radius: 5px;">

                                        <h3 class="text-center" id="lblchart2" runat="server" visible="false">No Record For Round Report</h3>

                                        <asp:Chart ID="Chart2" ClientIDMode="static" runat="server" BorderlineWidth="0" Height="400px" Width="1000px" BorderDashStyle="Solid"
                                            BackSecondaryColor="White" BackGradientStyle="Center" BorderWidth="2px" BackColor="211, 223, 240"
                                            BorderColor="#60654e" EnableViewState="true">

                                            <Series>
                                                <asp:Series Name="Series1" ChartType="Column" Color="#60654e" BorderWidth="2"
                                                    IsValueShownAsLabel="false" ChartArea="ChartArea1"
                                                    MarkerBorderColor="#60654e">
                                                </asp:Series>

                                            </Series>
                                            <Legends>
                                                <asp:Legend Title="" />
                                            </Legends>

                                            <ChartAreas>
                                                <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid"
                                                    BackSecondaryColor="White" BackColor="white" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                                                    <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                                        WallWidth="0" IsClustered="False"></Area3DStyle>
                                                    <AxisY LineColor="64, 64, 64, 64">
                                                        <LabelStyle Font="Arial, 8.25pt, style=Bold" />
                                                        <MajorGrid LineColor="64, 64, 64, 64" />
                                                    </AxisY>
                                                    <AxisX LineColor="64, 64, 64, 64">
                                                        <LabelStyle Font="Arial, 8.25pt, style=Bold" />
                                                        <MajorGrid LineColor="64, 64, 64, 64" />
                                                    </AxisX>
                                                </asp:ChartArea>
                                            </ChartAreas>
                                        </asp:Chart>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-md-6 col-xl-4">
                <div class="card mb-3 widget-content">
                    <div class="widget-content-outer">
                        <div class="widget-content-wrapper">
                            <div class="widget-content-left">
                                <div class="widget-heading">Round 1</div>
                                <div class="widget-subheading">Candidate Participants Count</div>
                            </div>
                            <div class="widget-content-right">
                                <div class="widget-numbers text-success">
                                    <asp:Label ID="lblround1count" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="card mb-3 widget-content">
                    <div class="widget-content-outer">
                        <div class="widget-content-wrapper">
                            <div class="widget-content-left">
                                <div class="widget-heading">Round 2</div>
                                <div class="widget-subheading">Candidate Participants Count</div>
                            </div>
                            <div class="widget-content-right">
                                <div class="widget-numbers text-warning">
                                    <asp:Label ID="lblround2count" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="card mb-3 widget-content">
                    <div class="widget-content-outer">
                        <div class="widget-content-wrapper">
                            <div class="widget-content-left">
                                <div class="widget-heading">Round 3</div>
                                <div class="widget-subheading">Candidate Participants Count</div>
                            </div>
                            <div class="widget-content-right">
                                <div class="widget-numbers text-danger">
                                    <asp:Label ID="lblround3count" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-xl-none d-lg-block col-md-6 col-xl-4">
                <div class="card mb-3 widget-content">
                    <div class="widget-content-outer">
                        <div class="widget-content-wrapper">
                            <div class="widget-content-left">
                                <div class="widget-heading">Income</div>
                                <div class="widget-subheading">Expected totals</div>
                            </div>
                            <div class="widget-content-right">
                                <div class="widget-numbers text-focus">$147</div>
                            </div>
                        </div>
                        <div class="widget-progress-wrapper">
                            <div class="progress-bar-sm progress-bar-animated-alt progress">
                                <div class="progress-bar bg-info" role="progressbar" aria-valuenow="54" aria-valuemin="0" aria-valuemax="100" style="width: 54%;"></div>
                            </div>
                            <div class="progress-sub-label">
                                <div class="sub-label-left">Expenses</div>
                                <div class="sub-label-right">100%</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="main-card mb-3 card">
                    <div class="card-header">
                        Candidate Detail
                                        
                    </div>
                    <div class="table-responsive">
                        <table class="align-middle mb-0 table table-borderless table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="text-center">#</th>
                                    <th>Name</th>
                                    <th class="text-center">Contact</th>
                                    <th class="text-center">CNIC</th>
                                    <th class="text-center">Email</th>
                                    <th class="text-center">City</th>
                                    <th class="text-center">Experience</th>
                                    <th class="text-center">Round</th>

                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rp" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="text-center text-muted"><%# Container.ItemIndex + 1 %></td>
                                            <td class="text-center"><%# Eval("Name") %></td>
                                            <td class="text-center"><%# Eval("Contact") %></td>
                                            <td class="text-center"><%# Eval("CNIC") %></td>
                                            <td class="text-center"><%# Eval("Email") %></td>
                                            <td class="text-center"><%# Eval("City") %></td>
                                            <td class="text-center"><%# Eval("Experience") %></td>
                                            <td class="text-center">
                                                <div class="  <%# Eval("RoundNo").ToString()=="1" ?"badge-warning": Eval("RoundNo").ToString()=="2"? "badge-success" : "badge-danger" %> badge "><%# Eval("RoundNo") %></div>
                                            </td>

                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>

                                <%--<tr>
                                    <td class="text-center text-muted">#345</td>
                                    <td>
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="widget-content-left">
                                                        <img width="40" class="rounded-circle" src="assets/images/avatars/4.jpg" alt="">
                                                    </div>
                                                </div>
                                                <div class="widget-content-left flex2">
                                                    <div class="widget-heading">John Doe</div>
                                                    <div class="widget-subheading opacity-7">Web Developer</div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">Madrid</td>
                                    <td class="text-center">
                                        <div class="badge badge-warning">Pending</div>
                                    </td>
                                    <td class="text-center">
                                        <button type="button" id="PopoverCustomT-1" class="btn btn-primary btn-sm">Details</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center text-muted">#347</td>
                                    <td>
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="widget-content-left">
                                                        <img width="40" class="rounded-circle" src="assets/images/avatars/3.jpg" alt="">
                                                    </div>
                                                </div>
                                                <div class="widget-content-left flex2">
                                                    <div class="widget-heading">Ruben Tillman</div>
                                                    <div class="widget-subheading opacity-7">Etiam sit amet orci eget</div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">Berlin</td>
                                    <td class="text-center">
                                        <div class="badge badge-success">Completed</div>
                                    </td>
                                    <td class="text-center">
                                        <button type="button" id="PopoverCustomT-2" class="btn btn-primary btn-sm">Details</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center text-muted">#321</td>
                                    <td>
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="widget-content-left">
                                                        <img width="40" class="rounded-circle" src="assets/images/avatars/2.jpg" alt="">
                                                    </div>
                                                </div>
                                                <div class="widget-content-left flex2">
                                                    <div class="widget-heading">Elliot Huber</div>
                                                    <div class="widget-subheading opacity-7">Lorem ipsum dolor sic</div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">London</td>
                                    <td class="text-center">
                                        <div class="badge badge-danger">In Progress</div>
                                    </td>
                                    <td class="text-center">
                                        <button type="button" id="PopoverCustomT-3" class="btn btn-primary btn-sm">Details</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center text-muted">#55</td>
                                    <td>
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="widget-content-left">
                                                        <img width="40" class="rounded-circle" src="assets/images/avatars/1.jpg" alt="">
                                                    </div>
                                                </div>
                                                <div class="widget-content-left flex2">
                                                    <div class="widget-heading">Vinnie Wagstaff</div>
                                                    <div class="widget-subheading opacity-7">UI Designer</div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">Amsterdam</td>
                                    <td class="text-center">
                                        <div class="badge badge-info">On Hold</div>
                                    </td>
                                    <td class="text-center">
                                        <button type="button" id="PopoverCustomT-4" class="btn btn-primary btn-sm">Details</button>
                                    </td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>



    </div>
</asp:Content>
