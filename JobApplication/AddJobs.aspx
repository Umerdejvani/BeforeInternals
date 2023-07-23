<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddJobs.aspx.cs" Inherits="JobApplication.AddJobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Add Job
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
                        Add Job
                        <div class="page-title-subheading">
                            User Can Post Job From This Panel
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="main-card mb-3 card">
                    <div class="card-body">
                        <h5 class="card-title">Employee Information</h5>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Department</label>
                                    <asp:DropDownList ID="ddldepartment" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Job Title</label>
                                    <asp:TextBox ID="txttitle" runat="server" CssClass="form-control">
                                    </asp:TextBox>

                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Position</label>
                                    <asp:DropDownList ID="ddljobcategory" runat="server" CssClass="form-control"></asp:DropDownList>
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
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>City</label>
                                    <asp:DropDownList ID="ddlcity" runat="server" CssClass="form-control"></asp:DropDownList>

                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Experience Required</label>
                                    <asp:TextBox ID="txtexp" AutoComplete="off" TextMode="Number" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>



                        <div class="row">
                            <div class="col-sm-12">
                                <div class="pull-right">
                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn" style="background-color:#60654e;color:white;" Text="Create Job" OnClick="btnSubmit_Click" />
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
                        <h5 class="card-title">Report Jobs</h5>

                        <asp:GridView ID="GVCat" runat="server" class="mb-0 table table-striped" AutoGenerateColumns="false" Font-Size="Smaller" EmptyDataText="No Record Found">
                            <Columns>

                                <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Dept">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldept" runat="server" Text='<%# Eval("DepartmentName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Title">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltitle" runat="server" Text='<%# Eval("Job_Title") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Position">
                                    <ItemTemplate>
                                        <asp:Label ID="LbljobName" runat="server" Text='<%# Eval("PositionName") %>'></asp:Label>
                                        <asp:Label ID="LblID" runat="server" Text='<%# Eval("ID") %>' Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblposition" runat="server" Text='<%# Eval("JobType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="City">
                                    <ItemTemplate>
                                        <asp:Label ID="lblcity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Experience">
                                    <ItemTemplate>
                                        <asp:Label ID="lblexperience" runat="server" Text='<%# Eval("Experience") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Room Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblroomname" runat="server" Text='<%# Eval("RoomKey") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Apply">
                                    <ItemTemplate>
                                        <asp:UpdatePanel ID="upd" runat="server">
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="lbltotalapply" EventName="Click" />                                           
                                            </Triggers>
                                            <ContentTemplate>
                                                <asp:LinkButton ID="lbltotalapply" runat="server" Text='<%# Eval("TotalApply") %>' CommandArgument='<%# Eval("ID") %>' CommandName="cmdapply" OnCommand="lbltotalapply_Command" Enabled='<%# Eval("TotalApply").ToString()=="0" ? false : true %>'></asp:LinkButton>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
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
