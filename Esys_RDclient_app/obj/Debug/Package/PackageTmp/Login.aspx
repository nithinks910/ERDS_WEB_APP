<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Esys_RDclient_app.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ERDS LOGIN</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link runat="server" rel="shortcut icon" href="OnlyEsmallwhite.ico" type="image/x-icon" />
    <link runat="server" rel="icon" href="OnlyEsmallwhite.ico" type="image/ico" />

    <!-- Bootstrap 3-->
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <%-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.0.3.min.js"></script>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-theme.css" />
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-theme.min.css" />
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />

    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>

    <style>
        fieldset {
            border: 1px solid #999;
            padding: 10px;
        }

        .divider {
            width: 1px;
            height: auto;
            display: inline-block;
        }

        footer {
            position: fixed;
            bottom: 0;
            left: 0;
        }

        .btn-primary, .btn-primary:active, .btn-primary:visited, .btn-primary:focus, .btn-primary:active:focus {
            background-color: #212121;
            border-color: #212121;
        }

            .btn-primary:hover, .btn-primary:focus, .btn-primary:active:focus {
                background-color: #2E2E2E;
                border-color: #2E2E2E;
            }

        @import url(http://fonts.googleapis.com/css?family=Roboto:400);

        body {
            background-color: #fff;
            -webkit-font-smoothing: antialiased;
            font: normal 14px Roboto,arial,sans-serif;
        }

        .container {
            padding: 25px;
            position: fixed;
        }

        .form-login {
            background-color: #EDEDED;
            padding-top: 10px;
            padding-bottom: 20px;
            padding-left: 20px;
            padding-right: 20px;
            border-radius: 15px;
            border-color: #d2d2d2;
            border-width: 5px;
            box-shadow: 0 1px 0 #cfcfcf;
        }

        h4 {
            border: 0 solid #fff;
            border-bottom-width: 1px;
            padding-bottom: 10px;
            text-align: center;
        }

        .form-control {
            border-radius: 10px;
        }

        .wrapper {
            text-align: center;
        }
    </style>


</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-offset-5 col-md-3">
                    <div class="form-login">
                        <h4>Welcome</h4>
                        <asp:TextBox ID="userName" runat="server" class="form-control input-sm chat-input" placeholder="username"></asp:TextBox>
                        <br />
                        <asp:TextBox ID="password" runat="server" class="form-control input-sm chat-input" placeholder="password"></asp:TextBox>
                            <span class="group-btn">
                                <asp:Label ID="Label" runat="server" Text=""></asp:Label>
                            </span>
                        <br />
                        <div class="wrapper">
                            <span class="group-btn">
                                <asp:Button ID="loginbtn" runat="server" Text="LOGIN" class="btn btn-primary btn-md" OnClick="loginbtn_Click" />
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
