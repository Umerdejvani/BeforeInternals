<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReportCandidate.aspx.cs" Inherits="JobApplication.ReportCandidate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Report Candidate
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
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
                        Report Candidate 
                        <div class="page-title-subheading">
                            User can view Candidates who have applied for jobs
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="main-card mb-3 card">
                    <div class="card-body">
                        <h5 class="card-title">Search Panel</h5>

                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Candidate</label>
                                    <asp:TextBox ID="txtcandidate" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>City</label>
                                    <asp:DropDownList ID="ddlcity" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Email</label>
                                    <asp:TextBox ID="txtemail" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>CNIC</label>
                                    <asp:TextBox ID="txtCNIC" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Custom, Numbers" TargetControlID="txtCNIC" ValidChars="1234567890" />

                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Contact</label>
                                    <asp:TextBox ID="txtcontactno" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Custom, Numbers" TargetControlID="txtcontactno" ValidChars="1234567890" />

                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Experience</label>
                                    <asp:TextBox ID="txtExperience" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Custom, Numbers" TargetControlID="txtExperience" ValidChars="1234567890" />

                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Position</label>
                                    <asp:DropDownList ID="ddlposition" runat="server" CssClass="form-control"></asp:DropDownList>

                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Job Type</label>
                                    <asp:DropDownList ID="ddljobtype" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Department</label>
                                    <asp:DropDownList ID="ddldept" runat="server" CssClass="form-control"></asp:DropDownList>

                                </div>
                            </div>

                        </div>


                        <div class="row">
                            <div class="col-sm-12">
                                <div class="pull-right">
                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn" style="background-color:#60654e;color:white;" Text="Search" OnClick="btnSubmit_Click" />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>



        <div class="row">



            <div class="col-md-12 col-sm-12">
                <div class="main-card mb-3 card">
                    <div class="card-body">
                        <h5 class="card-title">Report</h5>

                        <div class="table-responsive">
                            <table class="align-middle mb-0 table table-borderless table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th>Name</th>
                                        <th>Dept</th>
                                        <th>JobType</th>
                                        <th>Position</th>
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
                                                <td class="text-center"><%# Eval("DepartmentName") %></td>
                                                <td class="text-center"><%# Eval("JobType") %></td>
                                                <td class="text-center"><%# Eval("PositionName") %></td>

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

                                </tbody>
                            </table>
                        </div>
                    </div>


                </div>
            </div>
        </div>

    </div>
</asp:Content>
