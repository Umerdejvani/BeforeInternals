<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddQuestions.aspx.cs" Inherits="JobApplication.AddQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Add Question
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
                        Add Question
                                        <div class="page-title-subheading">
                                            Add Question for job selection
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
                                    <asp:DropDownList ID="ddljobcategory" runat="server" CssClass="form-control"></asp:DropDownList>
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
                                    <label><b>Add Question</b></label>
                                    <asp:TextBox ID="txtquestion" AutoComplete="off" TextMode="MultiLine" Height="150px" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label><b>Option A</b></label>
                                    <asp:TextBox ID="txtoptiona" AutoComplete="off" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label><b>Option B</b></label>
                                    <asp:TextBox ID="txtoptionb" AutoComplete="off" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label><b>Option C</b></label>
                                    <asp:TextBox ID="txtoptionc" AutoComplete="off" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label><b>Option D</b></label>
                                    <asp:TextBox ID="txtoptiond" AutoComplete="off" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                            </div>

                             <div class="col-sm-12">
                                <div class="form-group">
                                    <label><b>Correct Answer</b></label>
                                    <asp:DropDownList ID="ddlcorrectoption" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="- Select -" Text="- Select -"></asp:ListItem>
                                        <asp:ListItem Value="A" Text="A"></asp:ListItem>
                                        <asp:ListItem Value="B" Text="B"></asp:ListItem>
                                        <asp:ListItem Value="C" Text="C"></asp:ListItem>
                                        <asp:ListItem Value="D" Text="D"></asp:ListItem>

                                    </asp:DropDownList>
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

    </div>
</asp:Content>
