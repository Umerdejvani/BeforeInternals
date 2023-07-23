<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReportQuestionBank.aspx.cs" Inherits="JobApplication.ReportQuestionBank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Question Bank
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
                       Question Bank
                        <div class="page-title-subheading">
                            User Can view questions from here
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
                                    <label>Position</label>
                                    <asp:DropDownList ID="ddlposition" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Job Type</label>
                                    <asp:DropDownList ID="ddljobtype" runat="server" CssClass="form-control">
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

                                 <asp:TemplateField HeaderText="PositionName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPositionName" runat="server" Text='<%# Eval("PositionName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="JobType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblJobType" runat="server" Text='<%# Eval("JobType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Question">
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Option A">
                                    <ItemTemplate>
                                        <asp:Label ID="lblbOptionA" runat="server" Text='<%# Eval("OptionA") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Option B">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOptionB" runat="server" Text='<%# Eval("OptionB") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Option C">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOptionC" runat="server" Text='<%# Eval("OptionC") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Option D">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOptionD" runat="server" Text='<%# Eval("OptionD") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Answer">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCorrectAnswer" runat="server" Text='<%# Eval("CorrectAnswer") %>'></asp:Label>
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