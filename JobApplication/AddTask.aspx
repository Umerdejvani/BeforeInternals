<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddTask.aspx.cs" Inherits="JobApplication.AddTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Add Task
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
                        Add Task
                                        <div class="page-title-subheading">
                                            Add Task for Round 3
                                        </div>
                    </div>
                </div>

            </div>
        </div>



        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="main-card mb-3 card">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label><b>Position</b></label>
                                    <asp:DropDownList ID="ddlposition" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>Job Type</label>
                                    <asp:DropDownList ID="ddljobtype" runat="server" CssClass="form-control">
                                    </asp:DropDownList>

                                </div>
                            </div>

                            <hr />

                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label><b>Add Task</b></label>
                                    <asp:TextBox ID="txtquestion" TextMode="MultiLine" Height="150px" AutoComplete="off" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-sm-12">
                                <div class="pull-right">
                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn" style="background-color:#60654e;color:white;" Text="Submit" OnClick="btnSubmit_Click" />
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
                        <h5 class="card-title">Task List</h5>
                        <asp:gridview id="gv" runat="server" class="mb-0 table table-striped" autogeneratecolumns="false" Font-Size="Smaller" EmptyDataText="No Record Found">
                            <Columns>

                                 <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Position">
                                    <ItemTemplate>
                                        <asp:Label ID="lblposition" runat="server" Text='<%# Eval("PositionName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Job Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lbljobtype" runat="server" Text='<%# Eval("JobType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Question">
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                               
                            </Columns>
                        </asp:gridview>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
