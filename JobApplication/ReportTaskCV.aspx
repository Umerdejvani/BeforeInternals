<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReportTaskCV.aspx.cs" Inherits="JobApplication.ReportTaskCV" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

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
                        <h5 class="card-title">Jobs Request</h5>

                        <asp:GridView ID="gv" runat="server" class="mb-0 table table-striped" AutoGenerateColumns="false" Font-Size="Smaller" EmptyDataText="No Record Found">
                            <Columns>

                                <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="DepartmentName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartmentName" runat="server" Text='<%# Eval("DepartmentName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="PositionName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPositionName" runat="server" Text='<%# Eval("PositionName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Contact">
                                    <ItemTemplate>
                                        <asp:Label ID="lblContact" runat="server" Text='<%# Eval("Contact") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="CNIC">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCNIC" runat="server" Text='<%# Eval("CNIC") %>'></asp:Label>
                                      
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Resume">
                                    <ItemTemplate>
                                        <asp:UpdatePanel ID="upd" runat="server">
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="lnkview" EventName="Click" />
                                            </Triggers>
                                            <ContentTemplate>
                                                <asp:LinkButton ID="lnkview" runat="server" Text="View" CommandArgument='<%# Eval("CID") %>' OnCommand="lnkview_Command" CommandName="viewresume"></asp:LinkButton>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Task">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkviewtest" runat="server" Text="View" CommandArgument='<%# Eval("CID") %>' OnCommand="lnkview_Command" CommandName="viewtest"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>

                        <%--View Remarks Start--%>
                        <asp:Button ID="btnvideopopup" runat="server" Style="display: none" />
                        <asp:ModalPopupExtender ID="ModalPopupExtenderVideo" runat="server" TargetControlID="btnvideopopup" PopupControlID="pnlvideo" CancelControlID="btnvideoc" BackgroundCssClass="modalBackground"></asp:ModalPopupExtender>
                        <asp:Panel ID="pnlvideo" runat="server" Style="display: none; width: 50%;">

                            <div class="row">
                                <div class="col-md-12 col-sm-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <div class="modal-header" style="padding: 5px !important;">
                                                <h5 class="modal-title" style="color: #f05050;">Playing:
                                            <asp:Label ID="lblvideoname" runat="server" Font-Bold="true"></asp:Label>
                                                </h5>
                                            </div>
                                            <div class="row">

                                                <div class="col-sm-12">

                                                    <video id="vid" clientidmode="Static" controls="controls" controlslist="nodownload noplaybackrate" runat="server" style="width: 80%;"></video>
                                                </div>

                                                <div class="col-sm-12">
                                                    <div class="pull-right" style="margin-top: 30px;">
                                                        <asp:Button ID="btnvideoc" runat="server" Text="Close" CssClass="btn btn-warning" />


                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>


                        </asp:Panel>

                        <%--View Remarks END--%>
                    </div>


                </div>
            </div>
        </div>

    </div>
</asp:Content>
