<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamRoom.aspx.cs" Inherits="JobApplication.ExamRoom" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Exam Room</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Language" content="en" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" />
    <meta name="description" content="This is an example dashboard created using build-in elements and components." />
    <meta name="msapplication-tap-highlight" content="no" />
    <link href="./main.css" rel="stylesheet" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
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
    <script>
        $(document).ready(function () {


            let preview = document.getElementById("preview");
            let recording = document.getElementById("recording");
            let startButton = document.getElementById("startButton");
            let stopButton = document.getElementById("stopButton");
            let downloadButton = document.getElementById("downloadButton");
            let logElement = document.getElementById("log");


            let recordingTimeMS = 60000;
            function log(msg) {
                logElement.innerHTML += msg + "\n";
            }
            function wait(delayInMS) {

                return new Promise(resolve => setTimeout(resolve, delayInMS));

            }
            function startRecording(stream, lengthInMS) {
                let recorder = new MediaRecorder(stream);
                let data = [];

                recorder.ondataavailable = event => data.push(event.data);
                recorder.start();
                log(recorder.state + " for " + (lengthInMS / 1000) + " seconds...");


                $('#startButton').attr('disabled', true);
                $('#stopButton').attr('disabled', false);
                $('#downloadButton').attr('disabled', true);



                let stopped = new Promise((resolve, reject) => {
                    recorder.onstop = resolve;
                    recorder.onerror = event => reject(event.name);
                });

                let recorded = wait(lengthInMS).then(
                    () => recorder.state == "recording" && recorder.stop()

                );

                return Promise.all([
                    stopped,
                    recorded
                ])
                    .then(() => data);
            }
            function stop(stream) {
                stream.getTracks().forEach(track => track.stop());

            }
            startButton.addEventListener("click", function () {

                navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: true
                }).then(stream => {
                    preview.srcObject = stream;
                    downloadButton.href = stream;
                    preview.captureStream = preview.captureStream || preview.mozCaptureStream;
                    return new Promise(resolve => preview.onplaying = resolve);
                }).then(() => startRecording(preview.captureStream(), recordingTimeMS))
                    .then(recordedChunks => {
                        let recordedBlob = new Blob(recordedChunks, { type: "video/mp4" });
                        recording.src = URL.createObjectURL(recordedBlob);
                        downloadButton.href = recording.src;
                        downloadButton.download = "RecordedVideo.mp4";


                        $('#startButton').attr('disabled', false);
                        $('#stopButton').attr('disabled', true);
                        $('#downloadButton').attr('disabled', false);



                        var reader = new FileReader();
                        reader.readAsDataURL(recordedBlob);
                        reader.onloadend = function () {
                            var base64data = reader.result;

                            document.getElementById("<%=hfName.ClientID %>").value = base64data;

                        }


                        stop(preview.srcObject);

                        log("Successfully recorded " + recordedBlob.size + " bytes of " +
                            recordedBlob.type + " media.");


                    })
                            .catch(log);
            }, false); stopButton.addEventListener("click", function () {



                stop(preview.srcObject);



                $('#startButton').attr('disabled', false);
                $('#stopButton').attr('disabled', true);
                $('#downloadButton').attr('disabled', false);

            }, false);

        });
    </script>
</head>
<body>

    <form id="form2" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <%--<asp:UpdatePanel ID="UpdatePanel1"
            runat="server">
            <ContentTemplate>--%>
        <div class="app-container app-theme-white body-tabs-shadow fixed-sidebar fixed-header">
            <div class="app-header header-shadow">
                <marquee><h3>Welcome To <b>TRIENTA SOL 3D</b> Job Portal.</h3></marquee>

            </div>

            <div class="app-main">

                <div class="app-main__outer" style="margin-right: 116px; padding-left: 130px !important;">

                    <div>

                        <div class="app-main__inner">

                            <div class="row">

                                <div class="col-md-12 col-sm-12 text-center">
                                    <asp:Image ID="Image1" Width="30%" runat="server" ImageUrl="~/assets/images/Logo.png" /><br />

                                </div>

                                <div class="col-md-12 col-sm-12">
                                    <div class="col-md-12 col-xl-12">
                                        <div class="card mb-3 widget-content bg-arielle-smile">
                                            <div class="widget-content-wrapper text-white">
                                                <div class="widget-content-left">
                                                    <div class="widget-heading">
                                                        <h4><b>Exam Room
                                                            <asp:Label ID="lblround" runat="server" Text="( Round 1)"></asp:Label></b></h4>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12 col-sm-12">



                                    <div>
                                        <div id="divround1" runat="server" visible="true">
                                            <div class="col-md-12 col-lg-12">
                                                <div class="mb-3 card">
                                                    <div class="card-header-tab card-header" style="margin-top: 15px;">
                                                        <div class="card-header-title">
                                                            <i class="header-icon lnr-rocket icon-gradient bg-tempting-azure"></i>
                                                            <h4><b>Upload Resume</b></h4>
                                                            <hr />
                                                        </div>

                                                    </div>
                                                    <div class="tab-content">
                                                        <div class="row" style="text-align: center;">
                                                            <div class="col-sm-12">
                                                                <%--<h3 class="text-center">Enter Job Room Number (Round 1)</h3>--%>
                                                                <br />
                                                            </div>
                                                        </div>

                                                        <div class="row" style="margin-left: 30px; margin-right: 30px;">
                                                            <div class="col-sm-12">
                                                                <asp:TextBox ID="txtroom" AutoComplete="off" runat="server" CssClass="form-control" placeholder="Room Number"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="row" style="margin-left: 30px; margin-right: 30px;">
                                                            <div class="col-sm-12">
                                                                <div class="col-sm-2" style="float: left;">
                                                                    <label><b>Upload Resume</b></label>
                                                                </div>
                                                                <div class="col-sm-6" style="max-width: 0%;">
                                                                    <asp:FileUpload ID="attachmentfile" class="filestyle" data-buttonname="btn-primlightary" runat="server" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="row" style="margin-left: 30px; margin-right: 30px;">
                                                            <div class="col-sm-12">
                                                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-light" Text="Submit" Width="100%" OnClick="btnSubmit_Click" Style="width: 100%; margin-bottom: 20px;" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <%-- <div class="col-md-3 col-lg-3">
                                                <div class="mb-3 card">
                                                    <div class="card-header-tab card-header" style="margin-top: 15px;">
                                                        <div class="card-header-title">
                                                            <i class="header-icon lnr-rocket icon-gradient bg-tempting-azure"></i>
                                                            <h4><b>Timer</b></h4>
                                                            <hr />
                                                        </div>

                                                    </div>
                                                    <div class="tab-content">
                                                    </div>
                                                </div>
                                            </div>--%>








                                            <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
                                            <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopup" BackgroundCssClass="modalBackground"></asp:ModalPopupExtender>
                                            <asp:Panel ID="pnlpopup" runat="server" Style="display: none; width: 50%;">

                                                <div class="row">
                                                    <div class="col-md-12 col-sm-12">
                                                        <div class="main-card mb-3 card">
                                                            <div class="card-body">
                                                                <div class="modal-header" style="padding: 5px !important;">
                                                                    <h5 class="modal-title" style="color: #f05050;">Kindly Confirm Your Information
                                                                    </h5>
                                                                </div>
                                                                <div class="row">
                                                                    <asp:Label Visible="false" ID="lbljobcid" runat="server"></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbljobtid" runat="server"></asp:Label>
                                                                    <asp:Label Visible="false" ID="lbljid" runat="server"></asp:Label>


                                                                    <div class="col-sm-6">
                                                                        <div class="form-group">
                                                                            <label>Name:</label>
                                                                            <asp:TextBox ID="txtname" AutoComplete="off" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-sm-6">
                                                                        <div class="form-group">
                                                                            <label>Email:</label>
                                                                            <asp:TextBox ID="txtemail" AutoComplete="off" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-sm-6">
                                                                        <div class="form-group">
                                                                            <label>CNIC:</label>
                                                                            <asp:TextBox ID="txtnic" AutoComplete="off" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                                            <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Custom, Numbers" TargetControlID="txtnic" ValidChars="1234567890" />

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-sm-6">
                                                                        <div class="form-group">
                                                                            <label>MObile (i.e:03451234567):</label>
                                                                            <asp:TextBox ID="txtmobileno" AutoComplete="off" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                                            <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Custom, Numbers" TargetControlID="txtmobileno" ValidChars="1234567890" />

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-sm-6">
                                                                        <div class="form-group">
                                                                            <label>City:</label>
                                                                            <asp:DropDownList ID="ddlcity" AutoComplete="off" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-sm-6">
                                                                        <div class="form-group">
                                                                            <label>No Of Experience:</label>
                                                                            <asp:TextBox ID="txtexp" AutoComplete="off" runat="server" CssClass="form-control input-sm"></asp:TextBox>

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-sm-12">
                                                                        <div class="pull-right" style="margin-top: 30px;">
                                                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger" />
                                                                            <asp:Button ID="btnUpdate" runat="server" Text="Update Information" CssClass="btn btn-success" OnClick="btnUpdate_Click" />


                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>

                                        </div>


                                        <div id="divround2" runat="server" visible="false">
                                            <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick">
                                            </asp:Timer>
                                            <div class="col-md-9 col-lg-9">
                                                <div class="mb-3 card">
                                                    <div class="card-header-tab card-header" style="margin-top: 15px;">
                                                        <div class="card-header-title">
                                                            <i class="header-icon lnr-rocket icon-gradient bg-tempting-azure"></i>
                                                            <h4><b>Choose Correct Answer</b></h4>
                                                            <hr />
                                                        </div>

                                                    </div>
                                                    <div class="tab-content">
                                                        <div class="row" style="margin-left: 30px; margin-right: 30px;">
                                                            <div class="col-sm-12">
                                                                <h4>
                                                                    <asp:Label ID="lblquestion" runat="server"></asp:Label>
                                                                    <asp:Label ID="lblquestionid" Visible="false" runat="server"></asp:Label>
                                                                </h4>
                                                            </div>
                                                        </div>
                                                        <br />

                                                        <div class="row" style="margin-left: 30px; margin-right: 30px;">
                                                            <div class="col-sm-12">
                                                                <asp:RadioButtonList ID="rd" runat="server">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </div>

                                                        <br />
                                                        <div class="row" style="margin-left: 30px; margin-right: 30px;">
                                                            <div class="col-sm-12">
                                                                <asp:Button ID="btnnext" runat="server" CssClass="btn btn-success" Text="Next" OnClick="btnnext_Click" Style="margin-bottom: 20px;" />

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3 col-lg-3">
                                                <div class="mb-3 card">
                                                    <div class="card-header-tab card-header" style="margin-top: 15px;">
                                                        <div class="card-header-title">
                                                            <i class="header-icon lnr-rocket icon-gradient bg-tempting-azure"></i>
                                                            <h4><b>Timer</b></h4>
                                                            <hr />
                                                        </div>

                                                    </div>
                                                    <div class="tab-content">
                                                        <h2 class="text-center" style="color: #03254c;">
                                                            <asp:Label ID="lblround2timer" runat="server" Text="2"></asp:Label></h2>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div id="divround3" runat="server" visible="false">
                                            <asp:Timer ID="Timer2" runat="server" Interval="1000" OnTick="Timer2_Tick">
                                            </asp:Timer>
                                            <div class="col-md-9 col-lg-9">
                                                <div class="mb-3 card">
                                                    <div class="card-header-tab card-header" style="margin-top: 15px;">
                                                        <div class="card-header-title">
                                                            <i class="header-icon lnr-rocket icon-gradient bg-tempting-azure"></i>
                                                            <h4><b>Task</b></h4>
                                                            <hr />
                                                        </div>

                                                    </div>
                                                    <div class="tab-content">
                                                        <div class="row" style="margin-left: 30px; margin-right: 30px; text-align: center;">
                                                            <div class="col-sm-12">
                                                                <br />
                                                                <table>
                                                                    <tr>
                                                                        <td colspan="3" align="left"><b>Task:<asp:Label ID="lbltakquestion" runat="server" Text="asdasd"></asp:Label></b></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Upload Task</td>
                                                                        <td>
                                                                            <asp:FileUpload ID="FileUploadTask" class="filestyle" data-buttonname="btn-primlightary" runat="server" Style="margin-bottom: 20px;" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:Button ID="btnuploadtask" runat="server" Visible="false" CssClass="btn btn-success" Text="Upload Task" OnClick="btnuploadtask_Click" />
                                                                            <asp:Button ID="btnround3stop" runat="server" Visible="false" CssClass="btn btn-danger" Text="Stop Timer" OnClick="btnround3stop_Click" OnClientClick="return confirm('Do you want stop timer and upload your task now?');" />
                                                                        </td>

                                                                    </tr>
                                                                </table>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3 col-lg-3">
                                                <div class="mb-3 card">
                                                    <div class="card-header-tab card-header">
                                                        <div class="card-header-title">
                                                            <i class="header-icon lnr-rocket icon-gradient bg-tempting-azure"></i>
                                                            <h4><b>Timer</b></h4>
                                                            <hr />
                                                        </div>

                                                    </div>
                                                    <div class="tab-content">
                                                        <h2 class="text-center" style="color: #03254c;">
                                                            <asp:Label ID="lblround3timer" runat="server" Text="2"></asp:Label></h2>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div id="divroundfail" runat="server" visible="false">
                                            <div class="col-md-12 col-lg-12">
                                                <div class="mb-3 card">
                                                    <div class="card-header-tab card-header" style="margin-top: 15px;">
                                                        <div class="card-header-title">
                                                            <i class="header-icon lnr-rocket icon-gradient bg-tempting-azure"></i>
                                                            <h4><b>Message</b></h4>
                                                            <hr />
                                                        </div>

                                                    </div>
                                                    <div class="tab-content">
                                                        <h3 class="text-center">
                                                            <asp:Image ID="img" Width="30%" runat="server" ImageUrl="~/assets/images/ThankYou.png" /><br />
                                                            <asp:Label ID="lblfailmsg1" runat="server" Font-Bold="true" ForeColor=" #03254c" Text="Thank You For Your Active Participation"></asp:Label><br />
                                                            <asp:Label ID="lblfailmsg2" runat="server" Font-Bold="true" ForeColor=" #03254c" Text="Our HR will contact you."></asp:Label>

                                                        </h3>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>



                                        <div id="divround3marketing" runat="server" visible="false">
                                            <div class="col-md-9 col-lg-9">
                                                <div class="mb-3 card">
                                                    <div class="card-header-tab card-header" style="margin-top: 15px;">
                                                        <div class="card-header-title">
                                                            <i class="header-icon lnr-rocket icon-gradient bg-tempting-azure"></i>
                                                            <h4><b>Task</b></h4>
                                                            <hr />
                                                        </div>

                                                    </div>
                                                    <div class="tab-content">
                                                        <div class="row" style="margin-left: 30px; margin-right: 30px; text-align: center;">

                                                            <div class="col-sm-12">
                                                                <h4>
                                                                    <b>Task Question:</b>
                                                                    <asp:Label ID="lbltakquestionmarketing" runat="server" Text=""></asp:Label>
                                                                </h4>
                                                            </div>
                                                            <div class="col-sm-12">

                                                                <div class="panel-body">

                                                                    <div class="col-md-1">
                                                                    </div>

                                                                    <div class="col-md-3">
                                                                        <h2>Live Preview</h2>
                                                                        <video id="preview" controls="controls" width="360" height="250" autoplay muted style="border: solid 2px green; background-color: black"></video>
                                                                        <br />
                                                                        &nbsp;&nbsp;   &nbsp;&nbsp;
                                    <div id="startButton" class="button btn btn-success btn-sm">&nbsp; &nbsp; &nbsp;Start  &nbsp; &nbsp; &nbsp; </div>
                                                                        &nbsp;&nbsp;
    
                                    <div id="stopButton" disabled class="button btn btn-warning btn-sm">&nbsp; &nbsp; &nbsp;Stop &nbsp; &nbsp; &nbsp;  </div>
                                                                        <br />




                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        <br />
                                                                        <br />
                                                                        <br />
                                                                        <br />

                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <h2>Recorded Video</h2>
                                                                        <video id="recording" width="360" height="250" controls style="border: solid 2px green"></video>
                                                                        <br />


                                                                        &nbsp;&nbsp;
                                  <a id="downloadButton" disabled class="button btn btn-primary btn-sm">&nbsp; &nbsp; &nbsp;Download &nbsp; &nbsp; &nbsp;</a>
                                                                        <asp:HiddenField ID="hfName" runat="server" />
                                                                    </div>


                                                                    <div class="col-md-12">
                                                                        <br />
                                                                        <pre id="log"></pre>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3 col-lg-3">
                                                <div class="mb-3 card">
                                                    <div class="card-header-tab card-header">
                                                        <div class="card-header-title">
                                                            <i class="header-icon lnr-rocket icon-gradient bg-tempting-azure"></i>
                                                            <h4><b>Timer</b></h4>
                                                            <hr />
                                                        </div>

                                                    </div>
                                                    <div class="tab-content">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>




                                        <br />
                                        <div class="row" style="margin-left: 30px; margin-right: 30px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>





                    </div>

                    <div class="app-wrapper-footer">
                        <div class="app-footer">
                            <div class="app-footer__inner">

                                <div class="app-footer-right">
                                    <ul class="nav">
                                        <li class="nav-item">© 2023. All rights reserved TRIENTA SOL.
                                        </li>

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
                </div>
            </div>
            <script type="text/javascript" src="./assets/scripts/main.js"></script>
            <%-- khtm --%>
        </div>

        <%--</ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick"></asp:AsyncPostBackTrigger>
                <asp:AsyncPostBackTrigger ControlID="Timer2" EventName="Tick"></asp:AsyncPostBackTrigger>

                <asp:AsyncPostBackTrigger ControlID="btnnext" EventName="Click"></asp:AsyncPostBackTrigger>
                <asp:PostBackTrigger ControlID="btnSubmit" />
                <asp:PostBackTrigger ControlID="btnuploadtask" />
     
            </Triggers>
        </asp:UpdatePanel>--%>
    </form>



</body>
</html>
