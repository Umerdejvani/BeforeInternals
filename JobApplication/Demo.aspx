<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Demo.aspx.cs" Inherits="JobApplication.Demo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
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
                        Cards
                                        <div class="page-title-subheading">
                                            Wide selection of cards with multiple styles, borders, actions and hover effects.
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
                                    <label>Employee Name</label>
                                    <asp:TextBox ID="box1" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Fathers Name</label>
                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Contact Number</label>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Employee Address</label>
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                       <%-- <div class="row">
                            <video id="rrr" runat="server" controls="controls" src="~/assets/video/RecordedVideo.mp4"></video>
                        </div>--%>

                    </div>
                </div>
            </div>
        </div>



         <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="main-card mb-3 card">
                    <div class="card-body">
                        <h5 class="card-title">Grid View</h5>

                       
                                        <table class="mb-0 table table-striped">
                                            <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>First Name</th>
                                                <th>Last Name</th>
                                                <th>Username</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <th scope="row">1</th>
                                                <td>AMNA</td>
                                                <td>MEHAK</td>
                                                <td>amnamehak</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">2</th>
                                                <td>FILZA</td>
                                                <td>ATIF</td>
                                                <td>BASHEER</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">3</th>
                                                <td>BILAL</td>
                                                <td>AHMED</td>
                                                <td>TOOR</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>

                    
                    </div>
                </div>
            </div>
     





    </div>
</asp:Content>
