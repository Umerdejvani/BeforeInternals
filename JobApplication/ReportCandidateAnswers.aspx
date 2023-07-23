<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReportCandidateAnswers.aspx.cs" Inherits="JobApplication.ReportCandidateAnswers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Report MCQs
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
                        Report Candidate MCQs
                        <div class="page-title-subheading">
                            User can view Round MCQs Report
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
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Candidate</label>
                                    <asp:DropDownList ID="ddlcandidate" runat="server" CssClass="form-control"></asp:DropDownList>
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

                        <div class="col-md-12 col-sm-12">
                            <p>
                                <b><asp:Label ID="lbldetail" runat="server"></asp:Label></b>
                            </p>
                        </div>

                        <asp:GridView ID="gv" runat="server" class="mb-0 table table-striped" AutoGenerateColumns="false" Font-Size="Smaller" EmptyDataText="No Record Found">
                            <Columns>

                                <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Question">
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="CorrectAnswer">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCorrectAnswer" runat="server" Text='<%# Eval("CorrectAnswer") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Candidate Answers">
                                    <ItemTemplate>
                                        <asp:Label ID="lblYourAnswer" runat="server" Text='<%# Eval("YourAnswer") %>'></asp:Label>
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
