<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamRoom1.aspx.cs" Inherits="JobApplication.ExamRoom1" %>


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
    


    <script>
        $(document).ready(function () {


            let preview = document.getElementById("preview");
            let recording = document.getElementById("recording");
            let startButton = document.getElementById("startButton");
            let stopButton = document.getElementById("stopButton");
            let downloadButton = document.getElementById("downloadButton");
            let btnfinish = document.getElementById("btnfinish");

            let logElement = document.getElementById("log");


            let recordingTimeMS = 30000;
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
                $('#btnfinish').attr('disabled', true);




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
                stream.getTracks().forEach(
                    track => track.stop()
                );

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
                        $('#btnfinish').attr('disabled', false);



                        var reader = new FileReader();
                        reader.readAsDataURL(recordedBlob);
                        reader.onloadend = function () {
                            var base64data = reader.result;

                            document.getElementById("<%=hfName.ClientID %>").value = base64data;
                            document.getElementById('<%= btnfinish.ClientID %>').click();
                                    }


                                    stop(preview.srcObject);
                                    log("Successfully recorded " + recordedBlob.size + " bytes of " +
                                        recordedBlob.type + " media.");


                                })
                            .catch(log);
            }, false);
            stopButton.addEventListener("click", function () {



                            stop(preview.srcObject);



                            $('#startButton').attr('disabled', false);
                            $('#stopButton').attr('disabled', true);
                            $('#downloadButton').attr('disabled', false);
                            $('#btnfinish').attr('disabled', false);

                        }, false);

                    });
    </script>

</head>
<body>

    <form id="form2" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


        <div class="app-container app-theme-white body-tabs-shadow fixed-sidebar fixed-header">
            <div class="app-header header-shadow">
                <h3>&nbsp;&nbsp;Welcome To <b>TRIENTA SOL 3D</b> Job Portal.</h3>

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
                                                        <h4><b>
                                                            <asp:Label ID="lbltitle" runat="server"></asp:Label>
                                                            <asp:Label ID="lblround" runat="server" Text=" (Round 3)"></asp:Label></b></h4>
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
                                            <div class="col-md-12 col-lg-12">
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

                                                                <div class="col-md-12 text-center">
                                                                    <h2>Live Preview</h2>
                                                                    <video id="preview" controls="controls" width="340" height="230" autoplay muted style="border: solid 2px green; background-color: black"></video>
                                                                    <br />
                                                                    &nbsp;&nbsp;   &nbsp;&nbsp;
                                    <div id="startButton" class="button btn btn-success btn-sm">&nbsp; &nbsp; &nbsp;Start Recording  &nbsp; &nbsp; &nbsp; </div>

                                                                                &nbsp;&nbsp;
    
                                    <div id="stopButton" disabled class="button btn btn-warning btn-sm" style="display:none">&nbsp; &nbsp; &nbsp;Stop &nbsp; &nbsp; &nbsp;  </div>
                                                                    <br />




                                                                </div>
                                                                <div class="col-md-2">
                                                                    <br />
                                                                    <br />
                                                                    <br />
                                                                    <br />

                                                                </div>
                                                                <div class="col-md-5" style="display:none;">
                                                                    <h2>Recorded Video</h2>
                                                                    <video id="recording" width="340" height="230" controls style="border: solid 2px green"></video>
                                                                    <br />


                                                                    &nbsp;&nbsp;
                                  <a id="downloadButton" disabled class="button btn btn-primary btn-sm" style="display:none">&nbsp; &nbsp; &nbsp;Download &nbsp; &nbsp; &nbsp;</a>
                                                                    <asp:Button ID="btnfinish" disabled Text="Finish" ClientIDMode="Static" runat="server" CssClass="button btn btn-primary btn-sm" OnClick="btnfinish_Click" />
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

                                            <%--<div class="col-md-3 col-lg-3">
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
                                                    </div>--%>
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

       
    </form>



</body>
</html>
