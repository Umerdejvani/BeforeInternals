<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="JobApply.aspx.cs" Inherits="JobApplication.JobApply" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Job Apply
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-box-AR {
            padding: 5px !important;
        }

        .modalBackground {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
            position: fixed;
            left: 0px;
            top: 0px;
            z-index: 10001;
            width: 1903px;
            height: 1365px;
        }
    </style>
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
                        Jobs Detail
                        <div class="page-title-subheading">
                            <b>
                                <asp:Label ID="lbljobdetail" runat="server"></asp:Label></b>
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

                        <asp:GridView ID="GV" runat="server" class="mb-0 table table-striped" AutoGenerateColumns="false" Font-Size="Smaller" EmptyDataText="No Record Found">
                            <Columns>

                                <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("CName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="CNIC">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCNIC" runat="server" Text='<%# Eval("CNIC") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="CMobileNo">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCMobileNo" runat="server" Text='<%# Eval("CMobileNo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="City">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblemail" runat="server" Text='<%# Eval("EmailAddress") %>'></asp:Label>
                                        <asp:Label ID="lblcid" runat="server" Text='<%# Eval("CID") %>' Visible="false"></asp:Label>
                                        <asp:Label ID="lbljid" runat="server" Text='<%# Eval("JID") %>' Visible="false"></asp:Label>

                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Experience">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExperience" runat="server" Text='<%# Eval("Experience") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Round 1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRound1" runat="server" Text='<%# Eval("Round1") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Round 2">
                                    <ItemTemplate>
                                        
                                        <asp:LinkButton ID="lblRound2" runat="server" Text='<%# Eval("Round2") %>' CommandArgument='<%# Eval("CID") %>' OnCommand="lnkview_Command" CommandName="viewquestion"></asp:LinkButton>
                                                
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Round 3">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRound3" runat="server" Text='<%# Eval("Round3") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRound" runat="server" Text='<%# "Round " + Eval("Round") %>'></asp:Label>
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


                        <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
                        <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopup" BackgroundCssClass="modalBackground"></asp:ModalPopupExtender>
                        <asp:Panel ID="pnlpopup" runat="server" Style="display: none; width: 50%;">

                            <div class="row">
                                <div class="col-md-12 col-sm-12">
                                    <div class="main-card mb-3 card">
                                        <div class="card-body">
                                            <div class="modal-header" style="padding: 5px !important;">
                                                <h5 class="modal-title" style="color: #f05050;">Candidate MCQs Answer
                                                </h5>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="table-responsive">
                                                        <asp:GridView ID="gvdetail" runat="server" class="mb-0 table table-striped" AutoGenerateColumns="false" Font-Size="Smaller" EmptyDataText="No Record Found">
                                                            <Columns>

                                                                <asp:TemplateField HeaderText="#">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>

                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Question">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="LblName" runat="server" Text='<%# Eval("Question") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="CorrectAnswer">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCorrectAnswer" runat="server" Text='<%# Eval("CorrectAnswer") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                 <asp:TemplateField HeaderText="YourAnswer">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblYourAnswer" runat="server" Text='<%# Eval("YourAnswer") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>

                                                <div class="col-sm-12">
                                                    <div class="pull-right" style="margin-top: 30px;">
                                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger" />


                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>


                </div>
            </div>
        </div>

    </div>
</asp:Content>
