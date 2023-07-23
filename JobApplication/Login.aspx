<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="JobApplication.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <%--    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Language" content="en" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" />
    <meta name="description" content="This is an example dashboard created using build-in elements and components." />
    <meta name="msapplication-tap-highlight" content="no" />--%>
    <link href="./main.css" rel="stylesheet" />
    <style>
        body {
            background: #ebeff2;
            font-family: 'Noto Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;
            margin: 0;
            overflow-x: hidden;
            color: #797979;
        }

        .account-pages {
            background: url(assets/images/agsquare.png);
            position: absolute;
            height: 100%;
            width: 100%;
        }

        .wrapper-page {
            margin: 5% auto;
            position: relative;
            width: 420px;
        }

        .card-box {
            padding: 20px;
            border: 1px solid rgba(54, 64, 74, 0.05);
            -webkit-border-radius: 5px;
            border-radius: 5px;
            -moz-border-radius: 5px;
            background-clip: padding-box;
            margin-bottom: 20px;
            background-color: #ffffff;
        }

        .wrapper-page .card-box {
            border: 1px solid rgba(54, 64, 74, 0.1);
        }

        .panel-heading {
            border: none !important;
            padding: 10px 20px;
        }

        .panel-body {
            padding: 15px;
        }

        .btn-pink {
            background-color: #81c868 !important;
            border: 1px solid #81c868 !important;
            color: #ffffff;
        }

        .row {
            margin-right: -10px;
            margin-left: -10px;
        }
    </style>
</head>
<body class="widescreen">
    <form runat="server">
        <div class="account-pages">
            <div class="clearfix"></div>
            <div class="wrapper-page">
                <div class=" card-box">
                    <div class="panel-heading">
                        <h3 class="text-center">Login as <strong class="text-custom">Admin</strong> </h3>
                    </div>


                    <div class="panel-body">

                            <div class="form-group ">
                                <div class="col-xs-12">
                                    <asp:TextBox ID="txtlogin" runat="server" AutoComplete="off" class="form-control" required="" placeholder="Username"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group" style="margin-top: 2rem;">
                                <div class="col-xs-12">
                                    <asp:TextBox ID="txtpassword" TextMode="Password" AutoComplete="off" runat="server" class="form-control" required="" placeholder="Password"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group text-center m-t-40">
                                <div class="col-xs-12">
                                    <asp:Button ID="btnlogin" runat="server" class="btn btn-pink btn-block text-uppercase waves-effect waves-light" OnClick="btnlogin_Click" Text="Login"></asp:Button>
                                </div>
                            </div>

                           <%-- <div class="form-group m-t-30 m-b-0">
                                <div class="col-sm-12">
                                    <a href="page-recoverpw.html" class="text-dark"><i class="fa fa-lock m-r-5"></i>Forgot your password?</a>
                                </div>
                            </div>--%>

                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 text-center">
                        <%--<p>Back To  <a href="page-register.html" class="text-primary m-l-5"><b>Home Page?</b></a></p>--%>
                        <p>Go To <a href="ExamRoom.aspx" class="text-primary m-l-5" target="_blank"><b>Candidate Panel</b></a></p>

                    </div>
                </div>

            </div>
        </div>
    </form>





    <%--<script src="assets/scripts/main.js"></script>--%>
</body>
</html>
