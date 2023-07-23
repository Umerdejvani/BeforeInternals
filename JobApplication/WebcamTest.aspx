<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebcamTest.aspx.cs" Inherits="JobApplication.WebcamTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script>
        $(document).ready(function ()
        {


            let preview = document.getElementById("preview");
            let recording = document.getElementById("recording");
            let startButton = document.getElementById("startButton");
            let stopButton = document.getElementById("stopButton");
            let downloadButton = document.getElementById("downloadButton");
            let btnfinish = document.getElementById("btnfinish");


            let logElement = document.getElementById("log");


            let recordingTimeMS = 20000;
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
                $('#btnfinish').attr('disabled', false);

            }, false);

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="panel-body">

                <div class="col-md-1">
                </div>

                <div class="col-md-3">
                    <h2>Live Preview</h2>
                    <video id="preview" controls="controls" width="260" height="150" autoplay muted style="border: solid 2px green; background-color: black"></video>
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
                    <video id="recording" width="260" height="150" controls style="border: solid 2px green"></video>
                    <br />


                    &nbsp;&nbsp;
                                  <a id="downloadButton" disabled class="button btn btn-primary btn-sm">&nbsp; &nbsp; &nbsp;Download &nbsp; &nbsp; &nbsp;</a>
                     <asp:Button ID="btnfinish" disabled Text="Finish" runat="server" CssClass="button btn btn-primary btn-sm" OnClick="btnfinish_Click" />
                    <asp:HiddenField ID="hfName" runat="server" />
                </div>


                <div class="col-md-12">
                    <br />
                    <pre id="log"></pre>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
