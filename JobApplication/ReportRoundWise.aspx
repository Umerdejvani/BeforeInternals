<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReportRoundWise.aspx.cs" Inherits="JobApplication.ReportRoundWise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Rounds Report
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
                       Round Wise Report
                        <div class="page-title-subheading">
                            User Can view Status of All Rounds
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
                                    <asp:DropDownList ID="ddlcandidate" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Status</label>
                                    <asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control">
                                         <asp:ListItem Value="- Select -" Text="- Select -"></asp:ListItem>
                                        <asp:ListItem Value="Not Attempt" Text="Not Attempt"></asp:ListItem>
                                        <asp:ListItem Value="Pass" Text="Pass"></asp:ListItem>
                                        <asp:ListItem Value="Fail" Text="Fail"></asp:ListItem>
                                    </asp:DropDownList>

                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label>Round</label>
                                    <asp:DropDownList ID="ddlroundno" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="- Select -" Text="- Select -"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Round 1"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Round 2"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="Round 3"></asp:ListItem>
                                    </asp:DropDownList>

                                </div>
                            </div>
                        </div>

                   
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="pull-right">
                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn" style="background-color:#60654e;color:white;" Text="Search" OnClick="btnSubmit_Click"  />
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

                        <asp:GridView ID="gv" runat="server" class="mb-0 table table-striped" AutoGenerateColumns="false" Font-Size="Smaller" EmptyDataText="No Record Found">
                            <Columns>

                                <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="RoundNo">
                                    <ItemTemplate>
                                        <asp:Label ID="lblroundno" runat="server" Text='<%# "RoundNo " + Eval("RoundNo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Department Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartmentName" runat="server" Text='<%# Eval("DepartmentName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Position">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPosition" runat="server" Text='<%# Eval("Position") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Candidate Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCandidateName" runat="server" Text='<%# Eval("CandidateName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRound" runat="server" Text='<%# Eval("RoundStatus") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </div>


                </div>
            </div>
        </div>

    </div>
</asp:Content>

