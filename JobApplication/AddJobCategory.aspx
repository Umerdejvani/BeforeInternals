<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddJobCategory.aspx.cs" Inherits="JobApplication.AddJobCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Add Job Category
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
                        Add Position
                                        <div class="page-title-subheading">
                                            Add Position for drop down selection
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
                            <div class="col-sm-10">
                                <div class="form-group">
                                    <label>Job Position</label>
                                    <asp:textbox id="txtjobcategory" autocomplete="off" runat="server" cssclass="form-control"></asp:textbox>
                                </div>
                            </div>

                            <div class="col-sm-2">
                                <div class="pull-right" style="margin-top: 30px;">
                                    <asp:button id="btnSubmit" runat="server" CssClass="btn" style="background-color:#60654e;color:white;" text="Submit" onclick="btnSubmit_Click" />
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
                        <h5 class="card-title">Job Position List</h5>
                        <asp:gridview id="GVCat" runat="server" class="mb-0 table table-striped" autogeneratecolumns="false" Font-Size="Smaller" EmptyDataText="No Record Found">
                            <Columns>

                                 <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Job Position">
                                    <ItemTemplate>
                                        <asp:Label ID="LblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                        <asp:Label ID="LblID" runat="server" Text='<%# Eval("ID") %>' Visible="false"></asp:Label>
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
