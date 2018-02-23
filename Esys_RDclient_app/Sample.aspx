<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="Sample.aspx.cs" Inherits="Esys_RDclient_app.Sample" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ERDS WEB</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link runat="server" rel="shortcut icon" href="OnlyEsmallwhite.ico" type="image/x-icon" />
    <link runat="server" rel="icon" href="OnlyEsmallwhite.ico" type="image/ico" />

    <!-- Bootstrap 3-->
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <%-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.0.3.min.js"></script>

    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-theme.css" />
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-theme.min.css" />
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />

    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <%--<script src="bootstrap/js/npm.js"></script>--%>


    <!-- Bootstrap 4-->
    <%-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>--%>


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
    </style>

    <script>

        var osname;
        var template
        var connection;
        var bluetoothname;
        var bluetoothmac;
        var btconval;
        var ekyc_wadh;
        var auth_encoded;
        var jsonResponse;

        /*Browser Detection*/
        function browserdetection() {
            var unknown = '-';

            // screen
            var screenSize = '';
            if (screen.width) {
                width = (screen.width) ? screen.width : '';
                height = (screen.height) ? screen.height : '';
                screenSize += '' + width + " x " + height;
            }

            // browser
            var nVer = navigator.appVersion;
            var nAgt = navigator.userAgent;
            var browser = navigator.appName;
            var version = '' + parseFloat(navigator.appVersion);
            var majorVersion = parseInt(navigator.appVersion, 10);
            var nameOffset, verOffset, ix;

            // Opera
            if ((verOffset = nAgt.indexOf('Opera')) != -1) {
                browser = 'Opera';
                version = nAgt.substring(verOffset + 6);
                if ((verOffset = nAgt.indexOf('Version')) != -1) {
                    version = nAgt.substring(verOffset + 8);
                }
            }
            // Opera Next
            if ((verOffset = nAgt.indexOf('OPR')) != -1) {
                browser = 'Opera';
                version = nAgt.substring(verOffset + 4);
            }
                // Edge
            else if ((verOffset = nAgt.indexOf('Edge')) != -1) {
                browser = 'Microsoft Edge';
                version = nAgt.substring(verOffset + 5);
            }
                // MSIE
            else if ((verOffset = nAgt.indexOf('MSIE')) != -1) {
                browser = 'Microsoft Internet Explorer';
                version = nAgt.substring(verOffset + 5);
            }
                // Chrome
            else if ((verOffset = nAgt.indexOf('Chrome')) != -1) {
                browser = 'Chrome';
                version = nAgt.substring(verOffset + 7);
            }
                // Safari
            else if ((verOffset = nAgt.indexOf('Safari')) != -1) {
                browser = 'Safari';
                version = nAgt.substring(verOffset + 7);
                if ((verOffset = nAgt.indexOf('Version')) != -1) {
                    version = nAgt.substring(verOffset + 8);
                }
            }
                // Firefox
            else if ((verOffset = nAgt.indexOf('Firefox')) != -1) {
                browser = 'Firefox';
                version = nAgt.substring(verOffset + 8);
            }
                // MSIE 11+
            else if (nAgt.indexOf('Trident/') != -1) {
                browser = 'Microsoft Internet Explorer';
                version = nAgt.substring(nAgt.indexOf('rv:') + 3);
            }
                // Other browsers
            else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) < (verOffset = nAgt.lastIndexOf('/'))) {
                browser = nAgt.substring(nameOffset, verOffset);
                version = nAgt.substring(verOffset + 1);
                if (browser.toLowerCase() == browser.toUpperCase()) {
                    browser = navigator.appName;
                }
            }
            // trim the version string
            if ((ix = version.indexOf(';')) != -1) version = version.substring(0, ix);
            if ((ix = version.indexOf(' ')) != -1) version = version.substring(0, ix);
            if ((ix = version.indexOf(')')) != -1) version = version.substring(0, ix);

            majorVersion = parseInt('' + version, 10);
            if (isNaN(majorVersion)) {
                version = '' + parseFloat(navigator.appVersion);
                majorVersion = parseInt(navigator.appVersion, 10);
            }

            // mobile version
            var mobile = /Mobile|mini|Fennec|Android|iP(ad|od|hone)/.test(nVer);

            // cookie
            var cookieEnabled = (navigator.cookieEnabled) ? true : false;

            if (typeof navigator.cookieEnabled == 'undefined' && !cookieEnabled) {
                document.cookie = 'testcookie';
                cookieEnabled = (document.cookie.indexOf('testcookie') != -1) ? true : false;
            }

            // system
            var os = unknown;
            var clientStrings = [
                { s: 'Windows 10', r: /(Windows 10.0|Windows NT 10.0)/ },
                { s: 'Windows 8.1', r: /(Windows 8.1|Windows NT 6.3)/ },
                { s: 'Windows 8', r: /(Windows 8|Windows NT 6.2)/ },
                { s: 'Windows 7', r: /(Windows 7|Windows NT 6.1)/ },
                { s: 'Windows Vista', r: /Windows NT 6.0/ },
                { s: 'Windows Server 2003', r: /Windows NT 5.2/ },
                { s: 'Windows XP', r: /(Windows NT 5.1|Windows XP)/ },
                { s: 'Windows 2000', r: /(Windows NT 5.0|Windows 2000)/ },
                { s: 'Windows ME', r: /(Win 9x 4.90|Windows ME)/ },
                { s: 'Windows 98', r: /(Windows 98|Win98)/ },
                { s: 'Windows 95', r: /(Windows 95|Win95|Windows_95)/ },
                { s: 'Windows NT 4.0', r: /(Windows NT 4.0|WinNT4.0|WinNT|Windows NT)/ },
                { s: 'Windows CE', r: /Windows CE/ },
                { s: 'Windows 3.11', r: /Win16/ },
                { s: 'Android', r: /Android/ },
                { s: 'Open BSD', r: /OpenBSD/ },
                { s: 'Sun OS', r: /SunOS/ },
                { s: 'Linux', r: /(Linux|X11)/ },
                { s: 'iOS', r: /(iPhone|iPad|iPod)/ },
                { s: 'Mac OS X', r: /Mac OS X/ },
                { s: 'Mac OS', r: /(MacPPC|MacIntel|Mac_PowerPC|Macintosh)/ },
                { s: 'QNX', r: /QNX/ },
                { s: 'UNIX', r: /UNIX/ },
                { s: 'BeOS', r: /BeOS/ },
                { s: 'OS/2', r: /OS\/2/ },
                { s: 'Search Bot', r: /(nuhk|Googlebot|Yammybot|Openbot|Slurp|MSNBot|Ask Jeeves\/Teoma|ia_archiver)/ }
            ];
            for (var id in clientStrings) {
                var cs = clientStrings[id];
                if (cs.r.test(nAgt)) {
                    os = cs.s;
                    break;
                }
            }

            var osVersion = unknown;

            if (/Windows/.test(os)) {
                osVersion = /Windows (.*)/.exec(os)[1];
                os = 'Windows';
            }

            switch (os) {
                case 'Mac OS X':
                    osVersion = /Mac OS X (10[\.\_\d]+)/.exec(nAgt)[1];
                    break;

                case 'Android':
                    osVersion = /Android ([\.\_\d]+)/.exec(nAgt)[1];
                    break;

                case 'iOS':
                    osVersion = /OS (\d+)_(\d+)_?(\d+)?/.exec(nVer);
                    osVersion = osVersion[1] + '.' + osVersion[2] + '.' + (osVersion[3] | 0);
                    break;
            }

            // flash (you'll need to include swfobject)
            /* script src="//ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js" */
            var flashVersion = 'no check';
            if (typeof swfobject != 'undefined') {
                var fv = swfobject.getFlashPlayerVersion();
                if (fv.major > 0) {
                    flashVersion = fv.major + '.' + fv.minor + ' r' + fv.release;
                }
                else {
                    flashVersion = unknown;
                }
            }


            window.jscd = {
                screen: screenSize,
                browser: browser,
                browserVersion: version,
                browserMajorVersion: majorVersion,
                mobile: mobile,
                os: os,
                osVersion: osVersion,
                cookies: cookieEnabled,
                flashVersion: flashVersion
            };

            //alert(
            //    'OS: ' + jscd.os + ' ' + jscd.osVersion + '\n' +
            //    'Browser: ' + jscd.browser + ' ' + jscd.browserMajorVersion +
            //      ' (' + jscd.browserVersion + ')\n' +
            //    'Mobile: ' + jscd.mobile + '\n' +
            //    'Flash: ' + jscd.flashVersion + '\n' +
            //    'Cookies: ' + jscd.cookies + '\n' +
            //    'Screen Size: ' + jscd.screen + '\n\n' +
            //    'Full User Agent: ' + navigator.userAgent
            //);
            osname = jscd.os;
            //alert("inside browserdetection()  os is:" + jscd.os);
            return osname;

        }

        /*Token registration*/
        function Otpreg() {
            document.getElementById("errorMessage").innerHTML = "";
            document.getElementById("successMessage").innerHTML = "";
            var url = "http://127.0.0.1:11100/rd/otp";
            var enteredOtp = document.getElementById('Otp').value;
            //alert(enteredOtp);

            var xhr;
            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");

            if (enteredOtp !== '') {
                document.getElementById('errfn').innerHTML = '';

                if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                {
                    //IE browser
                    xhr = new ActiveXObject("Microsoft.XMLHTTP");
                } else {
                    //other browser
                    xhr = new XMLHttpRequest();
                }

                //xhr.withCredentials = true;
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        if (xhr.responseText.indexOf("200") >= 0) {
                            document.getElementById("successMessage").innerHTML = xhr.responseText;
                            document.getElementById("errorMessage").innerHTML = "";
                            console.log(xhr.responseText);
                        } else {
                            document.getElementById("errorMessage").innerHTML = xhr.responseText;
                            document.getElementById("successMessage").innerHTML = "";
                            console.log(xhr.responseText);
                        }
                    }
                };
                xhr.open('POST', url, true);
                xhr.send('otp=' + enteredOtp);
            } else {
                document.getElementById('errfn').innerHTML = "Please Enter Token";
            }
        }

        /*pidoptions validation*/
        function pidvalidate(ekyc_wadh) {

            /*Error handling for null values in the form*/
            /*env*/
            if (document.getElementById('env').value == '' || document.getElementById('env').value == null) {
                var env = document.getElementById('env').defaultValue = 'S';
            } else {
                var env = document.getElementById('env').value;
            }
            /*fcount*/
            if (document.getElementById('fcount').value == '' || document.getElementById('fcount').value == null) {
                var fcount = document.getElementById('fcount').defaultValue = '1';
            } else {
                var fcount = document.getElementById('fcount').value;
            }
            /*ftype*/
            if (document.getElementById('ftype').value == '' || document.getElementById('ftype').value == null) {
                var ftype = document.getElementById('ftype').defaultValue = '0';
            } else {
                var ftype = document.getElementById('ftype').value;
            }
            /*format*/
            if (document.getElementById('format').value == '' || document.getElementById('format').value == null) {
                var format = document.getElementById('format').defaultValue = '0';
            } else {
                var format = document.getElementById('format').value;
            }
            /*wadh*/
            //if (document.getElementById('wadh').value == '' || document.getElementById('wadh').value == null) {
            //    wadh = document.getElementById('wadh').defaultValue = '';
            //} else {
            //    wadh = document.getElementById('wadh').value;
            //}

            /*wadh ekyc*/
            if (document.getElementById('wadh').value == '' || document.getElementById('wadh').value == null) {
                var wadh = document.getElementById('wadh').defaultValue = '';
            } else {
                var wadh = document.getElementById('wadh').value;
            }

            /*pid version*/
            if (document.getElementById('pidver').value == '' || document.getElementById('pidver').value == null) {
                var pidver = document.getElementById('pidver').defaultValue = '2.0';
            } else {
                var pidver = document.getElementById('pidver').value;
            }
            /*otp*/
            if (document.getElementById('otp').value == '' || document.getElementById('otp').value == null) {
                var otp = document.getElementById('otp').defaultValue = '';
            } else {
                var otp = document.getElementById('otp').value;
            }
            /*timeout*/
            if (document.getElementById('timeout').value == '' || document.getElementById('timeout').value == null) {
                var timeout = document.getElementById('timeout').defaultValue = '10000';
            } else {
                var timeout = document.getElementById('timeout').value;
            }

            /*bluetooth*/
            var txn = Math.round((new Date()).getTime() / 1000);


            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Value";
                //return;
            } else {
                btconval = document.getElementById('btconvalue').value;
                btname = document.getElementById("btnametxt").value;
                btmac = document.getElementById("btmactxt").value;
            }

            /*pid options input*/
            var PIDOPTS = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                          + '<PidOptions ver="1.0">'
                          + '<CustOpts>'
                          + '<Param name="' + btname + '" value="' + btmac + '"/>'
                          + '<Param name="Connection" value="' + btconval + '"/>'
                          + '</CustOpts>'
                          + '<Opts '
                          + 'env="' + env + '" '
                          + 'fCount="' + fcount + '" '
                          + 'fType="' + ftype + '" '
                          + 'iCount="" '
                          + 'iType="" '
                          + 'pCount="" '
                          + 'pType="" '
                          + 'format="' + format + '" '
                          + 'pidVer="' + pidver + '" '
                          + 'timeout="' + timeout + '" '
                          + 'otp="' + otp + '" '
                          + 'wadh="' + wadh + '" '
                          + 'posh="UNKNOWN"/>'
                          + '</PidOptions>';
            console.log('PIDOPTS: -->' + PIDOPTS);
            return PIDOPTS;
        }

        /*pidoptions capture*/
        function Capture() {
            //debugger;
            browserdetection();
            var os = osname.toString();

            //document.getElementById('btconvalueerr').innerHTML = "";
            var PIDOPTS = pidvalidate("");
            //if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
            //document.getElementById('btconvalueerr').innerHTML = "Select Connection Type";
            //alert("Select Mandatory field! Bluetooth connection value");
            //return;
            //}
            //else {
            //    alert(PIDOPTS);
            //}

            if (os == 'Android') {
                //// alert("inside if loop Android postauth"+inXMl);
                //var androidhref = "intent:#Intent;action=evolute.custom.CAPTURE;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PID_OPTIONS=" + PIDOPTS + "";
                ////var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + PIDOPTS + ";end";
                //var finalhref = androidhref.replace(/ /g, "%20")
                //var hrefLink = finalhref;
                //document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                ////alert(androidpostauthcall);
                //var response = androidpostauthcall.click();
                ////alert(response);

                /*Sachin code test*/
                var toast = 'this is toast method';
                AndroidFunction.showToast(toast);
                alert(PIDOPTS);

                function showNextActivity(txt) {
                    alert(txt);

                    //AndroidFunction.showNextActivity();
                    var testtxt = txt;

                    PageMethods.test(testtxt, onSucess, onError);

                    function onSucess(txtreturn) {
                        alert("txt Return -->>> " + txtreturn);
                        console.log("txt Return-->>> " + txtreturn);
                    }
                    function onError(result) {
                        console.log('Something wrong. Refresh Page and Try Again');
                        alert('Something wrong. Refresh Page and Try Again');
                    }

                }

                function showAndroidToast(toast) {
                    AndroidFunction.showToast(toast);
                    var pidopts = pidvalidate('');
                    alert(pidopts);
                }


            }
            else if (os == 'Windows') {
                alert(PIDOPTS);
                var url = "http://127.0.0.1:11100/rd/capture";
                var xhr;
                var ua = window.navigator.userAgent;
                var msie = ua.indexOf("MSIE ");

                if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                {
                    //IE browser
                    xhr = new ActiveXObject("Microsoft.XMLHTTP");
                } else {
                    //other browser
                    xhr = new XMLHttpRequest();
                }

                xhr.open('CAPTURE', url, true);
                xhr.setRequestHeader("Content-Type", "text/xml");
                xhr.setRequestHeader("Accept", "text/xml");

                xhr.onreadystatechange = function () {

                    if (xhr.readyState == 4) {
                        var status = xhr.status;

                        if (status == 200) {
                            alert('PID DATA: ' + xhr.responseText);
                            console.log(xhr.responseText);

                        } else {
                            console.log(xhr.response);
                        }
                    }
                };
                xhr.send(PIDOPTS);
            }
        } /*pidoptions capture End*/

        /*Sleep*/
        function sleep(milliseconds) {
            var start = new Date().getTime();
            for (var i = 0; i < 1e7; i++) {
                if ((new Date().getTime() - start) > milliseconds) {
                    break;
                }
            }
        }

        /*uid Validation */
        function authvalidate() {
            document.getElementById("authsucMessage").innerHTML = "";
            document.getElementById("autherrMessage").innerHTML = "";
            document.getElementById("btconvalueerr").innerHTML = "";

            /*aadhar no validation*/
            if (document.getElementById('aadharno').value == '' || document.getElementById('aadharno').value == null) {
                document.getElementById('uidnoerr').innerHTML = "Enter Aadhar Number";
                return;
            }
            if (document.getElementById('aadharno').value.length < 12 || document.getElementById('aadharno').value.length > 12) {
                document.getElementById('uidnoerr').innerHTML = "Enter Valid Aadhar Number";
                return;
            }
            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Type";
                alert("Select Mandatory field! Bluetooth connection value");
                return;
            }
            if (document.getElementById('aadharno').value.length == 12) {
                //var Usraadharno = document.getElementById('aadharno').value;
                document.getElementById('uidnoerr').innerHTML = '';
                var Usraadharno = document.getElementById('aadharno').value;
                //alert("Uid no:    "+aadharno);
            }

        } /*Authenticate End*/

        /*Otp Request*/
        function getotp() {
            if (document.getElementById('aadharno').value.length == 12) {
                document.getElementById('uidnoerr').innerHTML = '';
                var uidno = document.getElementById('aadharno').value;
            } else {
                document.getElementById('uidnoerr').innerHTML = 'Enter Valid Aadhar No';
                return
            }
            var Usraadharno = document.getElementById('<%=aadharno.ClientID %>').value;
            PageMethods.otpgenxml(Usraadharno, onSucess, onError);
            function onSucess(otpresult) {
                if (otpresult == "OTP Successfull Sent") {
                    document.getElementById("otpsucMessage").innerHTML = otpresult;
                } else {
                    document.getElementById("otperrMessage").innerHTML = otpresult;
                }
                console.log(otpresult);
            }
            function onError(result) {
                alert('Something wrong. Refresh Page and Try Again');
            }
        }

        /* capture + auth function Start */
        function authenticate() {
            document.getElementById("authsucMessage").innerHTML = "";
            document.getElementById("autherrMessage").innerHTML = "";
            document.getElementById("btconvalueerr").innerHTML = "";

            var uidno = authvalidate(); //calling authvalidate function

            var PIDOPTS = pidvalidate();
            alert(PIDOPTS);

            var url = "http://127.0.0.1:11100/rd/capture";
            var xhr;
            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");

            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
            {
                //IE browser
                xhr = new ActiveXObject("Microsoft.XMLHTTP");
            } else {
                //other browser
                xhr = new XMLHttpRequest();
            }

            xhr.open('CAPTURE', url, true);
            xhr.setRequestHeader("Content-Type", "application/xml");
            xhr.setRequestHeader("Accept", "application/xml");

            xhr.onreadystatechange = function () {

                if (xhr.readyState == 4) {
                    var status = xhr.status;

                    if (status == 200) {
                        var piddata1 = document.getElementById("piddatahiddenfield").value = xhr.responseText;
                        console.log('PID DATA: -->' + xhr.responseText);

                        var Usraadharno = document.getElementById('<%=aadharno.ClientID %>').value;
                        var piddata = document.getElementById('<%=piddatahiddenfield.ClientID %>').value;

                        PageMethods.auth(Usraadharno, piddata, onSucess, onError);
                        function onSucess(authresult) {
                            if (authresult == "Authentication Successfull") {
                                document.getElementById("authsucMessage").innerHTML = authresult;
                            } else {
                                document.getElementById("autherrMessage").innerHTML = authresult;
                            }
                            //alert(authresult);
                            console.log(authresult);
                        }
                        function onError(result) {
                            alert('Something wrong. Refresh Page and Try Again');
                        }
                    } else {
                        console.log(xhr.response);
                    }
                }
            };
            xhr.send(PIDOPTS);

        }

        /* ekyc */
        function ekyc() {
            //document.getElementById("ekycsubbtn").disabled = true;
            //debugger;
            document.getElementById("ekycsucMessage").innerHTML = "";
            document.getElementById("ekycerrMessage").innerHTML = "";
            document.getElementById('btconvalueerr').innerHTML = "";
            /*bluetooth*/
            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                alert("Select Mandatory field! Bluetooth connection value");
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Type";
                return;
            }
            /*aadhar no validation*/
            if (document.getElementById('ekycuidno').value == '' || document.getElementById('ekycuidno').value == null) {
                document.getElementById('ekycuidnoerr').innerHTML = "Enter Aadhar Number";
                return;
            }
            if (document.getElementById('ekycuidno').value.length < 12 || document.getElementById('ekycuidno').value.length > 12) {
                document.getElementById('ekycuidnoerr').innerHTML = "Enter Valid Aadhar Number";
                return;
            }

            if (document.getElementById('ekycuidno').value.length == 12) {
                //var Usraadharno = document.getElementById('aadharno').value;
                document.getElementById('ekycuidnoerr').innerHTML = '';
                var Usraadharno = document.getElementById('ekycuidno').value;
                //alert("Auth validate:    "+Usraadharno);
            }

            /*version*/
            if (document.getElementById('ver').value == '' || document.getElementById('ver').value == null) {
                var ver = document.getElementById('ver').defaultValue = '2.1';
            } else {
                var ver = document.getElementById('ver').value;
            }
            /*ra*/
            if (document.getElementById('ra').value == '' || document.getElementById('ra').value == null) {
                var ra = document.getElementById('ra').defaultValue = 'F';
            } else {
                var ra = document.getElementById('ra').value;
            }
            /*rc*/
            if (document.getElementById('rc').value == '' || document.getElementById('rc').value == null) {
                var rc = document.getElementById('rc').defaultValue = 'Y';
            } else {
                var rc = document.getElementById('rc').value;
            }
            /*lr*/
            if (document.getElementById('lr').value == '' || document.getElementById('lr').value == null) {
                var lr = document.getElementById('lr').defaultValue = 'N';
            } else {
                var lr = document.getElementById('lr').value;
            }
            /*de*/
            if (document.getElementById('de').value == '' || document.getElementById('de').value == null) {
                var de = document.getElementById('de').defaultValue = 'Y';
            } else {
                var de = document.getElementById('de').value;
            }
            /*pfr*/
            if (document.getElementById('pfr').value == '' || document.getElementById('pfr').value == null) {
                var pfr = document.getElementById('pfr').defaultValue = 'N';
            } else {
                var pfr = document.getElementById('pfr').value;
            }

            var s = ver + ra + rc + lr + de + pfr;
            //alert(s);

            var sha256value = SHA256(s);
            //alert(sha256value);

            ekyc_wadh = btoa(sha256value);
            document.getElementById('wadh').value = ekyc_wadh;
            //alert(ekyc_wadh);
            console.log('SHA256: -->' + sha256value);
            console.log('base64 encode: -->' + ekyc_wadh);

            var PIDOPTS = pidvalidate(ekyc_wadh);
            alert(PIDOPTS);

            //capture function

            var url = "http://127.0.0.1:11100/rd/capture";
            var xhr;
            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");

            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
            {
                //IE browser
                xhr = new ActiveXObject("Microsoft.XMLHTTP");
            } else {
                //other browser
                xhr = new XMLHttpRequest();
            }

            xhr.open('CAPTURE', url, true);
            xhr.setRequestHeader("Content-Type", "application/xml");
            xhr.setRequestHeader("Accept", "application/xml");

            xhr.onreadystatechange = function () {

                if (xhr.readyState == 4) {
                    var status = xhr.status;

                    if (status == 200) {

                        var piddata1 = document.getElementById("piddatahiddenfield").value = xhr.responseText;
                        console.log('PID DATA: -->' + xhr.responseText);

                        var Usraadharno = document.getElementById('<%=ekycuidno.ClientID %>').value;
                        var piddata = document.getElementById('<%=piddatahiddenfield.ClientID %>').value;

                        PageMethods.ekycauthcreate(Usraadharno, piddata, onSucess, onError);

                        function onSucess(auth_encoded) {
                            //alert(auth_encoded);
                            console.log("Auth encoded in Base64: --> " + auth_encoded);
                            /*ekyc xml formation*/
                            var Kyc_xml = '<Kyc '
                                          + 'ver="' + ver + '" '
                                          + 'ra="' + ra + '" '
                                          + 'rc="' + rc + '" '
                                          + 'lr="' + lr + '" '
                                          + 'de="' + de + '" '
                                          + 'pfr="' + pfr + '">'
                                          + '<Rad>' + auth_encoded + '</Rad>'
                                          + '</Kyc>';
                            console.log('Kyc_xml: -->' + Kyc_xml);
                            alert('Kyc_xml: -->' + Kyc_xml);

                            PageMethods.ekycsend(Kyc_xml, onSucess, onError);

                            function onSucess(eKyc_result) {
                                if (auth_encoded == "e-KYC Successfull") {
                                    document.getElementById("ekycsucMessage").innerHTML = eKyc_result;
                                    $("#ekycmodal").click();
                                } else {
                                    document.getElementById("ekycerrMessage").innerHTML = eKyc_result;
                                }
                            }

                        }
                        function onError(result) {
                            alert('Something wrong. Refresh Page and Try Again');
                        }
                    } else {
                        console.log(xhr.response);
                    }
                }
            };
            xhr.send(PIDOPTS);

        }

        /*bt pair list search*/
        function BtpairList() {
            browserdetection();
            var os = osname.toString();

            if (os == 'Android') {
                //ANDROID CODE HERE
            }
            else if (os == 'Windows') {
                document.getElementById('CustomValidatorradbtn').innerHTML = "";
                var url = "http://localhost:9116/BT/pairedlist";
                var xhr;
                var ua = window.navigator.userAgent;
                var msie = ua.indexOf("MSIE ");

                if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                {
                    //IE browser
                    xhr = new ActiveXObject("Microsoft.XMLHTTP");
                } else {
                    //other browser
                    xhr = new XMLHttpRequest();
                }

                xhr.open('POST', url, true);
                xhr.setRequestHeader("Content-Type", "application/json");
                xhr.setRequestHeader("Accept", "application/json");

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4) {
                        var status = xhr.status;

                        if (status == 200) {
                            var json = xhr.responseText;
                            if (json == "\"No Paired Devices\"") {
                                alert("No Paired Devices");
                            }
                            jsonResponse = JSON.parse(json);
                            jsonResponse1 = JSON.parse(jsonResponse);

                            var dev = jsonResponse1.PairedDevicesCount;
                            var btname = [];
                            var btmac = [];
                            for (var i = 0; i < dev; i++) {
                                var Btname = jsonResponse1.Devices[i].BtName;
                                var Btmac = jsonResponse1.Devices[i].BtMac;
                                btname.push(Btname);
                                btmac.push(Btmac);
                            }
                            console.log("btname_array:" + btname);
                            console.log("btmac_array:" + btmac);

                            $(function () {
                                $("#Btnamelistdrop option").remove();
                            });
                            var opt = new Option("BT Pair List", "BT Pair List");
                            document.forms[0]["Btnamelistdrop"].options.add(opt);
                            for (var i = 0; i < btname.length; i++) {
                                var item = new Option(btname[i], btmac[i]);
                                document.forms[0]["Btnamelistdrop"].options.add(item);
                            }

                        } else {
                            console.log(xhr.response);
                            alert("No Response from Service");
                        }
                    }

                };
                xhr.send();
            }
        }

        function btdetails() {
            <%--var btdetails = document.getElementById("<%=Btnamelistdrop.ClientID %>");
            document.getElementById("btnametxt").innerHTML = btdetails.valueOf(btname);
            document.getElementById("btmactxt").innerHTML = btdetails.valueOf(btmac);--%>

            var dropdown1 = document.getElementById("Btnamelistdrop");
            var a = dropdown1.options[dropdown1.selectedIndex].text; //options[dropdown1.title];
            var b = dropdown1.options[dropdown1.selectedIndex].value;
            var textbox = document.getElementById('btnametxt');
            var textbox1 = document.getElementById('btmactxt');
            textbox.value = a;
            textbox1.value = b;
        }

        /*Bluetooth connection*/
        function btcon() {
            document.getElementById('btnameerr').innerHTML = "";
            document.getElementById('btmacerr').innerHTML = "";
            document.getElementById('btconvalueerr').innerHTML = "";

            if (document.getElementById('btconvalue').value == '') {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Type";
                return;
            } else {
                btconval = document.getElementById('btconvalue').value;
            }

            if (document.getElementById("btnametxt").value == '' || document.getElementById("btnametxt").value == null) {
                btname = document.getElementById("btnametxt").defaultvalue = '';
            } else {
                btname = document.getElementById("btnametxt").value;
            }
            if (document.getElementById("btmactxt").value == '' || document.getElementById("btmactxt").value == null) {
                btmac = document.getElementById("btmactxt").defaultvalue = '';
            } else {
                btmac = document.getElementById("btmactxt").value;
            }
            <%--var btnameui = document.getElementById('<%=btnametxt.ClientID %>').value;
            var btmacui = document.getElementById('<%=btmactxt.ClientID %>').value;
            var btconvalui = document.getElementById('<%=btconvalue.ClientID %>').value;--%>

            PageMethods.btdetails(btname, btmac, btconval);
        }

        /*rd service*/
        function rdservice() {
            browserdetection();
            var os = osname.toString();

            if (os == 'Android') {
                // alert("inside if loop Android postauth"+inXMl);
                var androidhref = "intent:#Intent;action=evolute.custom.RD_SERVICE_INFO;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE";
                var finalhref = androidhref.replace(/ /g, "%20")
                var hrefLink = finalhref;
                document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                //alert(androidpostauthcall);
                androidpostauthcall.click();

                sleep(20000);
                $.post('http://192.168.1.101:1100/', { xml: yourXMLString });

            }
            else if (os == 'Windows') {

                var url = "http://127.0.0.1:11100/";
                var xhr;
                var ua = window.navigator.userAgent;
                var msie = ua.indexOf("MSIE ");

                if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                {
                    //IE browser
                    xhr = new ActiveXObject("Microsoft.XMLHTTP");
                } else {
                    //other browser
                    xhr = new XMLHttpRequest();
                }

                xhr.open('RDSERVICE', url, true);
                xhr.setRequestHeader("Content-Type", "text/xml");
                xhr.setRequestHeader("Accept", "text/xml");

                xhr.onreadystatechange = function () {

                    if (xhr.readyState == 4) {
                        var status = xhr.status;

                        if (status == 200) {
                            console.log(xhr.responseText);
                            alert(xhr.responseText);
                            //template = xhr.responseText;
                        } else {
                            console.log(xhr.response);
                            //alert(xhr.response);
                        }
                    } else {
                        //alert("Error Occurred");
                    }
                };
                xhr.send();
            }
        } /*rd service End*/

        /*DeviceInfo*/
        function deviceinfo() {
            browserdetection();
            var os = osname.toString();

            if (os == 'Android') {
                // alert("inside if loop Android postauth"+inXMl);
                var androidhref = "intent:#Intent;action=evolute.custom.DEVICE_INFO;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE";
                var finalhref = androidhref.replace(/ /g, "%20")
                var hrefLink = finalhref;
                document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                //alert(androidpostauthcall);
                androidpostauthcall.click();
            }
            else if (os == 'Windows') {

                var url = "http://127.0.0.1:11100/rd/info";

                var xhr;
                var ua = window.navigator.userAgent;
                var msie = ua.indexOf("MSIE ");

                if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                {
                    //IE browser
                    xhr = new ActiveXObject("Msxml2.XMLHTTP");
                } else {
                    //other browser
                    xhr = new XMLHttpRequest();
                }

                xhr.open("DEVICEINFO", url, true);
                // xhr.withCredentials = true;
                //xhr.setRequestHeader("SOAPAction", "http://schemas.microsoft.com/crm/2007/WebServices/Retrieve");
                xhr.setRequestHeader("Content-Type", "text/xml; charset=utf8");
                xhr.setRequestHeader("Accept", "text/xml");
                xhr.setRequestHeader("Method", "CUSTOM");
                // xhr.send(timeout);
                xhr.onreadystatechange = function () {

                    if (xhr.readyState == 4) {
                        var status = xhr.status;

                        if (status == 200) {
                            alert(xhr.responseText);
                            console.log(xhr.response);
                        } else {
                            console.log(xhr.response);
                        }
                    } else {
                        //alert("Error Occurred");
                    }
                };
                xhr.send();
            }
        } /*DeviceInfo End*/

        /*Printer Postauth function*/
        function postauthcall(inXMl) {
            browserdetection();
            var os = osname.toString();

            if (os == 'Android') {
                // alert("inside if loop Android postauth"+inXMl);
                var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + inXMl + ";end"; "S.ReturnURL=http://192.168.1.101:1100/server/;end";
                var finalhref = androidhref.replace(/ /g, "%20")
                var hrefLink = finalhref;
                document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                //alert(androidpostauthcall);
                androidpostauthcall.click();
            }
            else if (os == 'Windows') {
                //alert("inside if loop windows postauth" + inXMl);
                var url = "http://127.0.0.1:11100/rd/postauth";

                var xml = inXMl;
                var xhr;
                var ua = window.navigator.userAgent;
                var msie = ua.indexOf("MSIE ");

                if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                {
                    //IE browser
                    xhr = new ActiveXObject("Msxml2.XMLHTTP");
                } else {
                    //other browser
                    xhr = new XMLHttpRequest();
                }

                xhr.open("POSTAUTH", url, true);
                // xhr.withCredentials = true;
                //xhr.setRequestHeader("SOAPAction", "http://schemas.microsoft.com/crm/2007/WebServices/Retrieve");
                xhr.setRequestHeader("Content-Type", "text/xml; charset=utf8");
                xhr.setRequestHeader("Accept", "text/xml");
                xhr.setRequestHeader("Method", "CUSTOM");
                // xhr.send(timeout);
                xhr.onreadystatechange = function () {

                    if (xhr.readyState == 4) {
                        var status = xhr.status;

                        if (status == 200) {
                            alert(xhr.responseText);
                            console.log(xhr.response);
                        } else {
                            console.log(xhr.response);
                            alert("Check if RDService is running");
                        }
                    } else {
                        //alert("Error Occurred");
                    }
                };
                xhr.send(xml);
            }
        } /*Printer Postauth function End*/

        /*BatteryStatus postauth*/
        function Batterystatus() {
            browserdetection();
            var os = osname.toString();

            //timestamp
            var txn = Math.round((new Date()).getTime() / 1000);


            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Value";
                return;
            } else {
                btconval = document.getElementById('btconvalue').value;
                btname = document.getElementById("btnametxt").value;
                btmac = document.getElementById("btmactxt").value;

                var url = "http://127.0.0.1:11100/rd/postauth";
                //var textprintinput = document.getElementById('txtprintip').value;
                //var txtprintipencoded = window.btoa(textprintinput);
                //alert(txtprintipencoded);
                var Batterystatusxml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                      + '<PostAuth txn="' + txn + '"  err="0">'
                                      + '<CustOpts>'
                                      + '<Param name="' + btname + '" value="' + btmac + '"/>'
                                      + '<Param name="Connection" value="' + btconval + '"/>'
                                      + '<Param name="Module" value="BATTERY_STATUS"/>'
                                      + '</CustOpts>'
                                      + '</PostAuth>';
                alert(Batterystatusxml);
                //Android
                if (os == "Android") {
                    // alert("inside if loop Android postauth"+inXMl);
                    var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + Batterystatusxml + ";end"; "S.ReturnURL=http://192.168.1.101:1100/server/;end";
                    var finalhref = androidhref.replace(/ /g, "%20")
                    var hrefLink = finalhref;
                    document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                    //alert(androidpostauthcall);
                    androidpostauthcall.click();
                } else { //windows

                    var xhr;
                    var ua = window.navigator.userAgent;
                    var msie = ua.indexOf("MSIE ");

                    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                    {
                        //IE browser
                        xhr = new ActiveXObject("Microsoft.XMLHTTP");
                    } else {
                        //other browser
                        //test();
                        xhr = new XMLHttpRequest();
                    }

                    xhr.open('POSTAUTH', url, true);
                    xhr.setRequestHeader("Content-Type", "text/xml");
                    xhr.setRequestHeader("Accept", "text/xml");

                    xhr.onreadystatechange = function () {
                        //if(xhr.readyState == 1 && count == 0){
                        //	fakeCall();
                        //}
                        if (xhr.readyState == 4) {
                            var status = xhr.status;

                            if (status == 200) {
                                alert(xhr.responseText);
                            } else {
                                console.log(xhr.response);
                            }
                        } else {
                            //alert("Error Occurred");
                        }
                    };
                    xhr.send(Batterystatusxml);
                }


            }
        } /*BatteryStatus postauth End*/

        /*diagnostics print postauth*/
        function DiagnosticS() {
            browserdetection();
            var os = osname.toString();

            //timestamp
            var txn = Math.round((new Date()).getTime() / 1000);


            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Value";
                return;
            } else {
                btconval = document.getElementById('btconvalue').value;
                btname = document.getElementById("btnametxt").value;
                btmac = document.getElementById("btmactxt").value;

                var url = "http://127.0.0.1:11100/rd/postauth";
                //var textprintinput = document.getElementById('txtprintip').value;
                //var txtprintipencoded = window.btoa(textprintinput);
                //alert(txtprintipencoded);
                var diagnostics = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                   + '<PostAuth txn="' + txn + '"  err="0">'
                                   + '<CustOpts>'
                                    + '<Param name="' + btname + '" value="' + btmac + '"/>'
                                    + '<Param name="Connection" value="' + btconval + '"/>'
                                   + '<Param name="Module" value="DIAGNOSTICS"/>'
                                   + '</CustOpts>'
                                   + '</PostAuth>';
                alert(diagnostics);
                if (os == "Android") {
                    // alert("inside if loop Android postauth"+inXMl);
                    var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + diagnostics + ";end"; "S.ReturnURL=http://192.168.1.101:1100/server/;end";
                    var finalhref = androidhref.replace(/ /g, "%20")
                    var hrefLink = finalhref;
                    document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                    //alert(androidpostauthcall);
                    androidpostauthcall.click();
                } else {
                    var xhr;
                    var ua = window.navigator.userAgent;
                    var msie = ua.indexOf("MSIE ");

                    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                    {
                        //IE browser
                        xhr = new ActiveXObject("Microsoft.XMLHTTP");
                    } else {
                        //other browser
                        //test();
                        xhr = new XMLHttpRequest();
                    }

                    xhr.open('POSTAUTH', url, true);
                    xhr.setRequestHeader("Content-Type", "text/xml");
                    xhr.setRequestHeader("Accept", "text/xml");

                    xhr.onreadystatechange = function () {
                        //if(xhr.readyState == 1 && count == 0){
                        //	fakeCall();
                        //}
                        if (xhr.readyState == 4) {
                            var status = xhr.status;

                            if (status == 200) {
                                alert(xhr.responseText);
                            } else {
                                console.log(xhr.response);
                            }
                        } else {
                            //alert("Error Occurred");
                        }
                    };
                    xhr.send(diagnostics);
                }
            }
        } /*diagnostics  postauth End*/

        /*FirmwareVersion postauth*/
        function Firmwareversion() {
            browserdetection();
            var os = osname.toString();

            //timestamp
            var txn = Math.round((new Date()).getTime() / 1000);


            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Value";
                return;
            } else {
                btconval = document.getElementById('btconvalue').value;
                btname = document.getElementById("btnametxt").value;
                btmac = document.getElementById("btmactxt").value;

                var url = "http://127.0.0.1:11100/rd/postauth";

                var Firmwareversion = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                 + '<PostAuth txn="' + txn + '"  err="0">'
                                 + '<CustOpts>'
                                 + '<Param name="' + btname + '" value="' + btmac + '"/>'
                                 + '<Param name="Connection" value="' + btconval + '"/>'
                                 + '<Param name="Module" value="FIRM_WARE_VERSION"/>'
                                 + '</CustOpts>'
                                 + '</PostAuth>';
                alert(Firmwareversion);

                if (os == "Android") {
                    // alert("inside if loop Android postauth"+inXMl);
                    var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + Firmwareversion + ";end"; "S.ReturnURL=http://192.168.1.101:1100/server/;end";
                    var finalhref = androidhref.replace(/ /g, "%20")
                    var hrefLink = finalhref;
                    document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                    //alert(androidpostauthcall);
                    androidpostauthcall.click();
                } else {
                    var xhr;
                    var ua = window.navigator.userAgent;
                    var msie = ua.indexOf("MSIE ");

                    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                    {
                        //IE browser
                        xhr = new ActiveXObject("Microsoft.XMLHTTP");
                    } else {
                        //other browser
                        //test();
                        xhr = new XMLHttpRequest();
                    }

                    xhr.open('POSTAUTH', url, true);
                    xhr.setRequestHeader("Content-Type", "text/xml");
                    xhr.setRequestHeader("Accept", "text/xml");

                    xhr.onreadystatechange = function () {
                        //if(xhr.readyState == 1 && count == 0){
                        //	fakeCall();
                        //}
                        if (xhr.readyState == 4) {
                            var status = xhr.status;

                            if (status == 200) {
                                console.log(xhr.responseText);
                                alert(xhr.responseText);
                            } else {
                                console.log(xhr.response);
                            }
                        } else {
                            //alert("Error Occurred");
                        }
                    };
                    xhr.send(Firmwareversion);
                }

            }

        } /*FirmwareVersion  postauth End*/

        /*Identifyperipherals postauth*/
        function IdentifyPeripherals() {
            browserdetection();
            var os = osname.toString();

            //timestamp
            var txn = Math.round((new Date()).getTime() / 1000);


            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Value";
                return;
            } else {
                btconval = document.getElementById('btconvalue').value;
                btname = document.getElementById("btnametxt").value;
                btmac = document.getElementById("btmactxt").value;

                var url = "http://127.0.0.1:11100/rd/postauth";
                //var textprintinput = document.getElementById('txtprintip').value;
                //var txtprintipencoded = window.btoa(textprintinput);
                //alert(txtprintipencoded);
                var Identifyperipheral = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                          + '<PostAuth txn="' + txn + '"  err="0">'
                                          + '<CustOpts>'
                                          + '<Param name="' + btname + '" value="' + btmac + '"/>'
                                          + '<Param name="Connection" value="' + btconval + '"/>'
                                          + '<Param name="Module" value="IDENTIFY_PERIPHERALS"/>'
                                          + '</CustOpts>'
                                          + '</PostAuth>';
                alert(Identifyperipheral);

                if (os == "Android") {
                    // alert("inside if loop Android postauth"+inXMl);
                    var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + Identifyperipheral + ";end"; "S.ReturnURL=http://192.168.1.101:1100/server/;end";
                    var finalhref = androidhref.replace(/ /g, "%20")
                    var hrefLink = finalhref;
                    document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                    //alert(androidpostauthcall);
                    androidpostauthcall.click();
                } else {
                    var xhr;
                    var ua = window.navigator.userAgent;
                    var msie = ua.indexOf("MSIE ");

                    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                    {
                        //IE browser
                        xhr = new ActiveXObject("Microsoft.XMLHTTP");
                    } else {
                        //other browser
                        //test();
                        xhr = new XMLHttpRequest();
                    }

                    xhr.open('POSTAUTH', url, true);
                    xhr.setRequestHeader("Content-Type", "text/xml");
                    xhr.setRequestHeader("Accept", "text/xml");

                    xhr.onreadystatechange = function () {
                        //if(xhr.readyState == 1 && count == 0){
                        //	fakeCall();
                        //}
                        if (xhr.readyState == 4) {
                            var status = xhr.status;

                            if (status == 200) {
                                console.log(xhr.responseText);
                                alert(xhr.responseText);
                            } else {
                                console.log(xhr.response);
                            }
                        } else {
                            //alert("Error Occurred");
                        }
                    };
                    xhr.send(Identifyperipheral);
                }

            }
        } /*Identifyperipherals postauth End*/

        /*magcard postauth*/
        function Magcard() {
            browserdetection();
            var os = osname.toString();

            //timestamp
            var txn = Math.round((new Date()).getTime() / 1000);


            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Value";
                return;
            } else {
                btconval = document.getElementById('btconvalue').value;
                btname = document.getElementById("btnametxt").value;
                btmac = document.getElementById("btmactxt").value;

                var url = "http://127.0.0.1:11100/rd/postauth";
                //var textprintinput = document.getElementById('txtprintip').value;
                //var txtprintipencoded = window.btoa(textprintinput);
                //alert(txtprintipencoded);
                var magcardxml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                  + '<PostAuth txn="' + txn + '"  err="0">'
                                  + '<CustOpts>'
                                  + '<Param name="' + btname + '" value="' + btmac + '"/>'
                                  + '<Param name="Connection" value="' + btconval + '"/>'
                                  + '<Param name="Module" value="MAGCARD"/>'
                                  + '<Param name="Timeout" value="10000"/>'
                                  + '</CustOpts>'
                                  + '</PostAuth>';
                alert(magcardxml);

                if (os == "Android") {
                    // alert("inside if loop Android postauth"+inXMl);
                    var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + magcardxml + ";end"; "S.ReturnURL=http://192.168.1.101:1100/server/;end";
                    var finalhref = androidhref.replace(/ /g, "%20")
                    var hrefLink = finalhref;
                    document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                    //alert(androidpostauthcall);
                    androidpostauthcall.click();
                } else {
                    var xhr;
                    var ua = window.navigator.userAgent;
                    var msie = ua.indexOf("MSIE ");

                    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                    {
                        //IE browser
                        xhr = new ActiveXObject("Microsoft.XMLHTTP");
                    } else {
                        //other browser
                        //test();
                        xhr = new XMLHttpRequest();
                    }

                    xhr.open('POSTAUTH', url, true);
                    xhr.setRequestHeader("Content-Type", "text/xml");
                    xhr.setRequestHeader("Accept", "text/xml");

                    xhr.onreadystatechange = function () {
                        //if(xhr.readyState == 1 && count == 0){
                        //	fakeCall();
                        //}
                        if (xhr.readyState == 4) {
                            var status = xhr.status;

                            if (status == 200) {
                                console.log(xhr.responseText);
                                alert(xhr.responseText);
                            } else {
                                console.log(xhr.response);
                            }
                        } else {
                            //alert("Error Occurred");
                        }
                    };
                    xhr.send(magcardxml);
                }

            }
        } /*magcard postauth End*/

        /*paperfeed postauth*/
        function Paperfeed() {
            browserdetection();
            var os = osname.toString();

            //timestamp
            var txn = Math.round((new Date()).getTime() / 1000);


            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Value";
                return;
            } else {
                btconval = document.getElementById('btconvalue').value;
                btname = document.getElementById("btnametxt").value;
                btmac = document.getElementById("btmactxt").value;
                var url = "http://127.0.0.1:11100/rd/postauth";
                //var textprintinput = document.getElementById('txtprintip').value;
                //var txtprintipencoded = window.btoa(textprintinput);
                //alert(txtprintipencoded);
                var paperfeedxml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                  + '<PostAuth txn="' + txn + '"  err="0">'
                                  + '<CustOpts>'
                                  + '<Param name="' + btname + '" value="' + btmac + '"/>'
                                  + '<Param name="Connection" value="' + btconval + '"/>'
                                  + '<Param name="Module" value="PAPERFEED"/>'
                                  + '</CustOpts>'
                                  + '</PostAuth>';
                alert(paperfeedxml);

                if (os == "Android") {
                    // alert("inside if loop Android postauth"+inXMl);
                    var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + paperfeedxml + ";end"; "S.ReturnURL=http://192.168.1.101:1100/server/;end";
                    var finalhref = androidhref.replace(/ /g, "%20")
                    var hrefLink = finalhref;
                    document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                    //alert(androidpostauthcall);
                    androidpostauthcall.click();
                } else {
                    var xhr;
                    var ua = window.navigator.userAgent;
                    var msie = ua.indexOf("MSIE ");

                    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                    {
                        //IE browser
                        xhr = new ActiveXObject("Microsoft.XMLHTTP");
                    } else {
                        //other browser
                        //test();
                        xhr = new XMLHttpRequest();
                    }

                    xhr.open('POSTAUTH', url, true);
                    xhr.setRequestHeader("Content-Type", "text/xml");
                    xhr.setRequestHeader("Accept", "text/xml");

                    xhr.onreadystatechange = function () {
                        //if(xhr.readyState == 1 && count == 0){
                        //	fakeCall();
                        //}
                        if (xhr.readyState == 4) {
                            var status = xhr.status;

                            if (status == 200) {
                                console.log(xhr.responseText);
                                alert(xhr.responseText);
                            } else {
                                console.log(xhr.response);
                            }
                        } else {
                            //alert("Error Occurred");
                        }
                    };
                    xhr.send(paperfeedxml);
                }
            }
        } /*paperfeed postauth End*/

        /*DISCONNECT postauth*/
        function Disconect() {
            browserdetection();
            var os = osname.toString();

            //timestamp
            var txn = Math.round((new Date()).getTime() / 1000);


            if (document.getElementById('btconvalue').value == "" || document.getElementById('btconvalue').value == null) {
                document.getElementById('btconvalueerr').innerHTML = "Select Connection Value";
                return;
            } else {
                btconval = document.getElementById('btconvalue').value;
                btname = document.getElementById("btnametxt").value;
                btmac = document.getElementById("btmactxt").value;

                var url = "http://127.0.0.1:11100/rd/postauth";
                //var textprintinput = document.getElementById('txtprintip').value;
                //var txtprintipencoded = window.btoa(textprintinput);
                //alert(txtprintipencoded);
                var DisconnectXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                      + '<PostAuth txn="' + txn + '"  err="0">'
                                      + '<CustOpts>'
                                      + '<Param name="' + btname + '" value="' + btmac + '"/>'
                                      + '<Param name="Connection" value="' + btconval + '"/>'
                                      + '<Param name="Module" value="DISCONNECTED"/>'
                                      + '</CustOpts>'
                                      + '</PostAuth>';
                alert(DisconnectXML);

                if (os == "Android") {
                    // alert("inside if loop Android postauth"+inXMl);
                    var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + DisconnectXML + ";end"; "S.ReturnURL=http://192.168.1.101:1100/server/;end";
                    var finalhref = androidhref.replace(/ /g, "%20")
                    var hrefLink = finalhref;
                    document.getElementById("androidpostauthcall").setAttribute("href", hrefLink);
                    //alert(androidpostauthcall);
                    androidpostauthcall.click();
                } else {
                    var xhr;
                    var ua = window.navigator.userAgent;
                    var msie = ua.indexOf("MSIE ");

                    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
                    {
                        //IE browser
                        xhr = new ActiveXObject("Microsoft.XMLHTTP");
                    } else {
                        //other browser
                        //test();
                        xhr = new XMLHttpRequest();
                    }

                    xhr.open('POSTAUTH', url, true);
                    xhr.setRequestHeader("Content-Type", "text/xml");
                    xhr.setRequestHeader("Accept", "text/xml");

                    xhr.onreadystatechange = function () {
                        //if(xhr.readyState == 1 && count == 0){
                        //	fakeCall();
                        //}
                        if (xhr.readyState == 4) {
                            var status = xhr.status;

                            if (status == 200) {
                                console.log(xhr.responseText);
                                alert(xhr.responseText);
                            } else {
                                console.log(xhr.response);
                            }
                        } else {
                            //alert("Error Occurred");
                        }
                    };
                    xhr.send(DisconnectXML);
                }

            }
        } /*DISCONNECT postauth End*/

        /*SHA256 ENCODING*/
        function SHA256(s) {
            var chrsz = 8;
            var hexcase = 0;
            function safe_add(x, y) {
                var lsw = (x & 0xFFFF) + (y & 0xFFFF);
                var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
                return (msw << 16) | (lsw & 0xFFFF);
            }
            function S(X, n) { return (X >>> n) | (X << (32 - n)); }
            function R(X, n) { return (X >>> n); }
            function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }
            function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }
            function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }
            function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }
            function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }
            function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }
            function core_sha256(m, l) {
                var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3, 0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786, 0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA, 0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147, 0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13, 0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070, 0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208, 0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);
                var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);
                var W = new Array(64);
                var a, b, c, d, e, f, g, h, i, j;
                var T1, T2;
                m[l >> 5] |= 0x80 << (24 - l % 32);
                m[((l + 64 >> 9) << 4) + 15] = l;
                for (var i = 0; i < m.length; i += 16) {
                    a = HASH[0];
                    b = HASH[1];
                    c = HASH[2];
                    d = HASH[3];
                    e = HASH[4];
                    f = HASH[5];
                    g = HASH[6];
                    h = HASH[7];
                    for (var j = 0; j < 64; j++) {
                        if (j < 16) W[j] = m[j + i];
                        else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);
                        T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);
                        T2 = safe_add(Sigma0256(a), Maj(a, b, c));
                        h = g;
                        g = f;
                        f = e;
                        e = safe_add(d, T1);
                        d = c;
                        c = b;
                        b = a;
                        a = safe_add(T1, T2);
                    }
                    HASH[0] = safe_add(a, HASH[0]);
                    HASH[1] = safe_add(b, HASH[1]);
                    HASH[2] = safe_add(c, HASH[2]);
                    HASH[3] = safe_add(d, HASH[3]);
                    HASH[4] = safe_add(e, HASH[4]);
                    HASH[5] = safe_add(f, HASH[5]);
                    HASH[6] = safe_add(g, HASH[6]);
                    HASH[7] = safe_add(h, HASH[7]);
                }
                return HASH;
            }
            function str2binb(str) {
                var bin = Array();
                var mask = (1 << chrsz) - 1;
                for (var i = 0; i < str.length * chrsz; i += chrsz) {
                    bin[i >> 5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i % 32);
                }
                return bin;
            }
            function Utf8Encode(string) {
                string = string.replace(/\r\n/g, "\n");
                var utftext = "";
                for (var n = 0; n < string.length; n++) {
                    var c = string.charCodeAt(n);
                    if (c < 128) {
                        utftext += String.fromCharCode(c);
                    }
                    else if ((c > 127) && (c < 2048)) {
                        utftext += String.fromCharCode((c >> 6) | 192);
                        utftext += String.fromCharCode((c & 63) | 128);
                    }
                    else {
                        utftext += String.fromCharCode((c >> 12) | 224);
                        utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                        utftext += String.fromCharCode((c & 63) | 128);
                    }
                }
                return utftext;
            }
            function binb2hex(binarray) {
                var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
                var str = "";
                for (var i = 0; i < binarray.length * 4; i++) {
                    str += hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8 + 4)) & 0xF) +
                    hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8)) & 0xF);
                }
                return str;
            }
            s = Utf8Encode(s);
            return binb2hex(core_sha256(str2binb(s), s.length * chrsz));
        }

        /*Print radio btn validation*/
        function ValidateRadioButtons(sender, args) {
            args.IsValid = $("input[name=Print]:checked").length > 0;
        }

    </script>
</head>

<body>
    <%-- Bootstrap page start --%>
    <!-- navbar -->
    <nav class="navbar navbar-inverse">
        <%--style="background-color: #428bca;">--%>
        <div style="color: white; text-align: center">
            <h2><b>EVOLUTE RD SERVICE WEB</b></h2>
        </div>
    </nav>
    <!-- navbar End -->

    <div class="container">
        <!-- Container start -->
        <form id="form" runat="server">
            <%--<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true"></asp:ScriptManager>--%>
            <asp:ScriptManager ID="ScriptManager2" runat="server" EnablePageMethods="true"></asp:ScriptManager>

            <div class="col-sm-3" id="btcon">
                <div class="panel-group">
                    <!--Port Selection-->
                    <%--<div class="panel panel-default" id="portsel">
                        <div class="panel-heading" style="text-align: center;"><b>Port Selection</b></div>
                        <div class="panel-body">
                            <%--<span id="custoptmandatory" style="color: #f44336; font-size: 12px;">*Mandatory Select "YES" or "NO" </span>&nbsp;--%>
                    <%-- <asp:DropDownList ID="portselList" runat="server" class="form-control">
                            </asp:DropDownList>
                            &nbsp;
                    <asp:Button ID="portselRefreshbtn" runat="server" class="btn-primary form-control" Text="Refresh" />
                        </div>
                    </div>--%>

                    <!--Bluetooth Connection-->
                    <div class="panel panel-default" id="bluetooth">
                        <div class="panel-heading" style="text-align: center;"><b>Custom Options</b></div>
                        <div class="panel-body">

                            <%-- Sachin test code --%>
                            <%--<asp:Button ID="Button2" runat="server" Text="showNextActivity" OnClientClick="showNextActivity();" class="btn-primary form-control" />--%>
                            <%--<asp:Button ID="Button1" runat="server" Text="showAndroidToast" OnClientClick="showAndroidToast('Android toast message!!');" class="btn-primary form-control" />--%>
                            <%-- Sachin test code End --%>

                            <asp:Button ID="btpairlist" class="btn-primary form-control" runat="server" Text="GET BT PAIR LIST" OnClientClick="BtpairList()" />&nbsp;
                             <asp:DropDownList ID="Btnamelistdrop" onchange="btdetails()" runat="server" class="form-control">
                             </asp:DropDownList>
                            <%--<select id="btnamelistdrop"></select>--%>
                            <span id="custoptmandatory" style="color: #f44336; font-size: 12px;">*Mandatory Select "YES" or "NO" </span>&nbsp;
                            <asp:DropDownList ID="btconvalue" runat="server" class="form-control">
                                <asp:ListItem Enabled="true" Text="Connection Value *" Value=""></asp:ListItem>
                                <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;
                            <span id="btconvalueerr" style="color: #f44336; font-size: 12px;"></span>&nbsp;
                            <asp:TextBox ID="btnametxt" runat="server" class="form-control" placeholder="Enter Bluetooth Name" MaxLength="20" value=""></asp:TextBox>
                            <span id="btnameerr" style="color: #f44336; font-size: 12px;"></span>&nbsp;
                            <asp:TextBox ID="btmactxt" runat="server" class="form-control" placeholder="Enter Bluetooth MAC Address" MaxLength="32" value=""></asp:TextBox>
                            <span id="btmacerr" style="color: #f44336; font-size: 12px;"></span>
                            <%--<asp:Button ID="btconbtn" class="btn-primary form-control" runat="server" Text="CONNECT" OnClientClick="btcon(); return false;" />&nbsp;
                            <p id="btresp" style="color: #f44336; font-size: 12px;" value=""></p>--%>
                        </div>
                    </div>

                    <!-- eKYC -->
                    <div class="panel panel-default" id="ekyc">
                        <div class="panel-heading" style="text-align: center;"><b>e - KYC</b></div>
                        <div class="panel-body">
                            <asp:HiddenField ID="ekycpidoptshidden" runat="server" Value="" />
                            <asp:TextBox ID="ekycuidno" runat="server" class="form-control" placeholder="Enter Aadhar No" MaxLength="12" value=""></asp:TextBox>&nbsp;
                        <span id="ekycuidnoerr" style="color: #f44336; font-size: 12px;"></span>
                            <asp:TextBox ID="ver" runat="server" class="form-control" placeholder="Version" value=""></asp:TextBox>&nbsp;
                        <asp:TextBox ID="ra" runat="server" class="form-control" placeholder="Authentication type" value=""></asp:TextBox>&nbsp;
                        <asp:TextBox ID="rc" runat="server" class="form-control" placeholder="Explicit consent" value=""></asp:TextBox>&nbsp;
                        <asp:TextBox ID="lr" runat="server" class="form-control" placeholder="Local language" value=""></asp:TextBox>&nbsp;
                        <asp:TextBox ID="de" runat="server" class="form-control" placeholder="Delegating Decryption" value=""></asp:TextBox>&nbsp;
                        <asp:TextBox ID="pfr" runat="server" class="form-control" placeholder="Print format request" value=""></asp:TextBox>&nbsp;
                        <asp:Button ID="ekycsubbtn" runat="server" class="btn-primary form-control" Text="e - KYC" OnClientClick="ekyc(); return false;" />&nbsp;
                        <p id="ekycerrMessage" style="color: #f44336; font-size: 12px;" value=""></p>
                            <p id="ekycsucMessage" style="color: #4CAF50; font-size: 12px;" value=""></p>
                            <!-- Trigger the modal with a button      -->
                            <button type="button" class="btn btn-info btn-lg" id="ekycmodal" data-toggle="modal" data-target="#myModal" style="display: none;">Open Modal</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- modal e-KYC output -->

            <!-- Modal -->
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog modal-lg col-lg-9">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Aadhaar e-KYC</h4>
                        </div>
                        <div class="modal-body">
                            <p>UID No : <span id="uidno" class="form-control"></span></p>

                            <fieldset>
                                <legend>Photo:</legend>
                                <%--<img id="pic" src="sample.bmp" />--%>
                            </fieldset>
                            <%--<label class="control-label" for="phote">Image:</label><img id="photo" src="sample.bmp" />--%>
                            <label class="control-label" for="name">Name:</label><input type="text" class="form-control" id="name" />
                            <label class="control-label" for="dob">DOB:</label><input type="text" class="form-control" id="dob" />
                            <label class="control-label" for="gender">Gender:</label><input type="text" class="form-control" id="gender" />
                            <label class="control-label" for="co">CO:</label><input type="text" class="form-control" id="co" />
                            <label class="control-label" for="house">House:</label><input type="text" class="form-control" id="house" />
                            <label class="control-label" for="street">Street:</label><input type="text" class="form-control" id="street" />
                            <label class="control-label" for="landmark">Land Mark:</label><input type="text" class="form-control" id="landmark" />
                            <label class="control-label" for="loc">LOC:</label><input type="text" class="form-control" id="loc" />
                            <label class="control-label" for="vtc">VTC:</label><input type="text" class="form-control" id="vtc" />
                            <label class="control-label" for="subdist">Sub-District:</label><input type="text" class="form-control" id="subdist" />
                            <label class="control-label" for="dist">District:</label><input type="text" class="form-control" id="dist" />
                            <label class="control-label" for="state">State:</label><input type="text" class="form-control" id="state" />
                            <label class="control-label" for="country">Country:</label><input type="text" class="form-control" id="country" />
                            <label class="control-label" for="pincode">Pincode:</label><input type="text" class="form-control" id="pincode" />
                            <label class="control-label" for="po">PO:</label><input type="text" class="form-control" id="po" />

                            <button class="btn-primary  form-control" id="ekycprintbtn">Print</button>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div>

            <!-- modal e-KYC output End -->

            <!-- pid options -->
            <div class="pidopts">
                <div class="panel-group col-md-3">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="text-align: center;"><b>PID Options</b></div>
                        <div class="panel-body">
                            <div class="panel-body">
                                <!--<select class="form-control" id="rdslist">
                                    <option value="" disabled selected>RD Service</option>
                                    <option id="erds" value="erds"></option>
                                </select>&nbsp;-->
                                <input type="text" class="form-control" id="env" placeholder="ENV" value="" maxlength="2" />&nbsp;
                                <input type="text" class="form-control" id="fcount" placeholder="FCOUNT" value="" maxlength="2" />&nbsp;
                                <select class="form-control" id="ftype">
                                    <!--<option value="" disabled selected>FTYPE</option>-->
                                    <option value="0">FMR</option>
                                    <!--<option value="1">FIR</option>-->
                                </select>&nbsp;
                                <select class="form-control" id="format">
                                    <option value="" disabled selected>FORMAT</option>
                                    <option value="0">XML</option>
                                    <option value="1">PROTOBUF</option>
                                </select>&nbsp;
                                <input type="text" class="form-control" id="wadh" placeholder="WADH" value="" />
                                &nbsp;
                                <input type="text" class="form-control" id="pidver" placeholder="PID VERSION" value="" />
                                &nbsp;
                                <input type="text" class="form-control" id="otp" placeholder="OTP" value="" />
                                &nbsp;
                                <input type="text" class="form-control" id="timeout" placeholder="TIMEOUT" value="" />
                                &nbsp;
                                <button type="button" class="btn-primary form-control" id="capture" onclick="Capture();">CAPTURE</button>

                            </div>

                        </div>
                    </div>
                </div>
            </div>



            <div class="col-sm-3" id="rdauth">

                <!-- Token entry-->
                <div class="panel-group" id="tokenentry">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="text-align: center;"><b>Device Register OTP</b></div>
                        <div class="panel-body">
                            <input type="text" class="form-control" id="Otp" placeholder="Enter OTP" maxlength="18" value="" />
                            <span id="errfn" style="color: #f44336; font-size: 12px;"></span>
                            &nbsp;
                        <button type="button" class="btn-primary form-control" id="otpsubmit" onclick="Otpreg();">SUBMIT</button>&nbsp;
                        <p id="errorMessage" style="color: #f44336; font-size: 12px;"></p>
                            <p id="successMessage" style="color: #4CAF50; font-size: 12px;"></p>
                        </div>
                    </div>
                </div>

                <!-- Authenticate otp ekyc-->
                <div class="panel panel-default" id="auth">
                    <div class="panel-heading" style="text-align: center;"><b>Authenticate | OTP</b></div>
                    <div class="panel-body">
                        <asp:HiddenField ID="piddatahiddenfield" runat="server" Value="" />
                        <asp:TextBox ID="aadharno" runat="server" class="form-control" placeholder="Enter Aadhar No" MaxLength="12" value=""></asp:TextBox>&nbsp;
                        <span id="uidnoerr" style="color: #f44336; font-size: 12px;"></span>
                        <asp:Button ID="aadnosub" runat="server" class="btn-primary form-control" Text="AUTHENTICATE" OnClientClick="authenticate(); return false;" />&nbsp;
                        <asp:Button ID="getotpsubmit" runat="server" class="btn-primary form-control" Text="GET OTP" OnClientClick="getotp(); return false;" />&nbsp;
                        <span id="autherrMessage" style="color: #f44336; font-size: 12px;" value=""></span>
                        <span id="authsucMessage" style="color: #4CAF50; font-size: 12px;" value=""></span>
                        <span id="otpsucMessage" style="color: #f44336; font-size: 12px;" value=""></span>
                        <span id="otperrMessage" style="color: #4CAF50; font-size: 12px;" value=""></span>
                    </div>
                </div>

                <!-- RDService -->
                <div class="panel-group" id="rdservice">
                    <div class="panel panel-default ">
                        <div class="panel-heading" style="text-align: center;"><b>RD Service</b></div>
                        <div class="panel-body">
                            <button type="button" class="btn-primary  form-control" id="rdsbtn" onclick="rdservice();">RD SERVICE STATUS</button>
                            &nbsp;
                        <button type="button" class="btn-primary  form-control" id="info" onclick="deviceinfo();">DEVICE INFO</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-3" id="print">
                <div class="panel-group">
                    <%-- Logout --%>
                    <%--<div class="panel panel-default ">
                        <div class="panel-heading" style="text-align: center;"><b>User</b></div>
                        <div class="panel-body">
                            <div>
                            <asp:Label ID="usrnmedisp" runat="server" class="form-control"></asp:Label>&nbsp;
                            <asp:Button ID="LogoutBtn" runat="server" class="btn-primary form-control" Text="Logout" OnClick="LogoutBtn_Click" />&nbsp;
                            </div>
                        </div>
                    </div>--%>

                    <%-- Printer --%>
                    <div class="panel panel-default ">
                        <div class="panel-heading" style="text-align: center;"><b>Printer</b></div>
                        <div class="panel-body">
                            <asp:RadioButton ID="Radiotxtprint" class="radio radio-inline" runat="server" GroupName="Print" Text="Text Print" /><br />
                            <asp:DropDownList ID="fonttype" runat="server" class="form-control">
                                <asp:ListItem Text="Large Normal" Value="PR_FONTLARGENORMAL"></asp:ListItem>
                                <asp:ListItem Text="Large Bold" Value="PR_FONTLARGEBOLD"></asp:ListItem>
                                <asp:ListItem Text="Small Normal" Value="PR_FONTSMALLNORMAL"></asp:ListItem>
                                <asp:ListItem Text="Small Bold" Value="PR_FONTSMALLBOLD"></asp:ListItem>
                                <asp:ListItem Text="UL Large Normal" Value="PR_FONTULLARGENORMAL"></asp:ListItem>
                                <asp:ListItem Text="UL Large Bold" Value="PR_FONTULLARGEBOLD"></asp:ListItem>
                                <asp:ListItem Text="UL Small Normal" Value="PR_FONTULSMALLNORMAL"></asp:ListItem>
                                <asp:ListItem Text="UL Small Bold" Value="PR_FONTULSMALLBOLD"></asp:ListItem>
                                <asp:ListItem Text="Reverse Large Normal" Value="PR_FONT180LARGENORMAL"></asp:ListItem>
                                <asp:ListItem Text="Reverse Large Bold" Value="PR_FONT180LARGEBOLD"></asp:ListItem>
                                <asp:ListItem Text="Reverse Small Normal" Value="PR_FONT180SMALLNORMAL"></asp:ListItem>
                                <asp:ListItem Text="Reverse Small Bold" Value="PR_FONT180SMALLBOLD"></asp:ListItem>
                                <asp:ListItem Text="Reverse UL Large Normal" Value="PR_FONT180ULLARGENORMAL"></asp:ListItem>
                                <asp:ListItem Text="Reverse UL Large Bold" Value="PR_FONT180ULLARGEBOLD"></asp:ListItem>
                                <asp:ListItem Text="Reverse UL Small Normal" Value="PR_FONT180ULSMALLNORMAL"></asp:ListItem>
                                <asp:ListItem Text="Reverse UL Small Bold" Value="PR_FONT180ULSMALLBOLD"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="textprintdata" runat="server" class="form-control" placeholder="Text Here..." value=""></asp:TextBox>&nbsp;
                            
                        <asp:RadioButton ID="Radiotstprint" class="radio radio-inline" runat="server" GroupName="Print" Text="Test Print" /><br />
                            &nbsp;

                        <asp:RadioButton ID="Radiobmpprint" class="radio radio-inline" runat="server" GroupName="Print" Text="BMP Print" /><br />
                            <asp:FileUpload ID="bmpimageip" class="form-control" accept=".bmp" runat="server" />&nbsp;

                            <asp:RadioButton ID="Radiobarcodeprint" class="radio radio-inline" runat="server" GroupName="Print" Text="Barcode Print" /><br />
                            <asp:DropDownList ID="barcodetype" runat="server" class="form-control">
                                <asp:ListItem Text="2of5 Compressed" Value="BARCODE2OF5COMPRESSED"></asp:ListItem>
                                <asp:ListItem Text="2of5 UnCompressed" Value="BARCODE2OF5UNCOMPRESSED"></asp:ListItem>
                                <asp:ListItem Text="3of9 Compressed" Value="BARCODE3OF9COMPRESSED"></asp:ListItem>
                                <asp:ListItem Text="3of9 UnCompressed" Value="BARCODE3OF9UNCOMPRESSED"></asp:ListItem>
                                <asp:ListItem Text="EAN 13 Standard" Value="BARCODEEAN13STANDARD"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="barcodedata" runat="server" class="form-control" placeholder="Barcode Value" value=""></asp:TextBox>&nbsp;
                            <asp:Button ID="printbtn" runat="server" Text="Print" class="btn-primary form-control" OnClick="btn_Print_Click" />
                            <asp:CustomValidator ID="CustomValidatorradbtn" runat="server" ErrorMessage="Must Select Type of Print" ClientValidationFunction="ValidateRadioButtons"></asp:CustomValidator>
                            <hr style="border-top: 3px double #8c8b8b" />

                            <button type="button" class="btn-primary form-control" id="paperfeed" onclick="Paperfeed();">PAPER FEED</button>&nbsp;

                        <button type="button" class="btn-primary form-control" id="BatteryStatus" onclick="Batterystatus();">BATTERY STATUS</button>
                            &nbsp;
                        <button type="button" class="btn-primary form-control" id="Diagnostics" onclick="DiagnosticS();">DIAGNOSTICS</button>
                            &nbsp;
                        <button type="button" class="btn-primary form-control" id="FirmwareVersion" onclick="Firmwareversion();">FIRMWARE VERSION</button>
                            &nbsp;
                        <button type="button" class="btn-primary form-control" id="Identifyperipherals" onclick="IdentifyPeripherals();">IDENTIFY PERIPHERALS</button>
                            &nbsp;
                        <button type="button" class="btn-primary form-control" id="magcard" onclick="Magcard();">MAG CARD</button>
                            &nbsp;
                        <button type="button" class="btn-primary form-control" id="Disconnect" onclick="Disconect();">DISCONNECT</button>
                            <%-- android intent call anchor tag --%> <a id="androidpostauthcall"></a>

                        </div>
                    </div>
                </div>
            </div>
            <%-- Printer End --%>
        </form>
    </div>
    <!-- Container End -->
    <!-- footer -->
    <footer class="navbar navbar-inverse">
        <%--style="background-color: #428bca;">--%>
        <!--class="page-footer blue center-on-small-only">-->
        <div class="footer-copyright" style="text-align: center; color: white">
            <div class="container-fluid">

                <h4 style="text-align: left">© 2018 Copyright: <a style="color: white" href="https://www.evolute.in"><span style="color: white">evolute</span></a>
                    <span style="float: right; color: white">V1.1</span>
                </h4>


            </div>
        </div>
    </footer>
    <!-- footer End-->

</body>
</html>
