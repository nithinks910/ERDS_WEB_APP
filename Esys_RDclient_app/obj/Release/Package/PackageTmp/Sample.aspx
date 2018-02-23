<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="Sample.aspx.cs" Inherits="Esys_RDclient_app.Sample" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RD Service WEB</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.0.3.min.js"></script>
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
    </style>

    <script>

        var osname;
        var template;
        var connection;
        var bluetoothname;
        var bluetoothmac;


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

        //Textfield enable and disable on radiobutton click
        //function rad() {
        //    if (document.getElementById('RadioButton1').checked == true) {
        //        document.getElementById('textprintdata').disabled = false;
        //        document.getElementById('bmpimage').disabled = true;
        //        document.getElementById('barcodeinput').disabled = true;
        //    }
        //    else if (document.getElementById('RadioButton2').checked == true) {
        //        document.getElementById('textprintdata').disabled = true;
        //        document.getElementById('bmpimage').disabled = true;
        //        document.getElementById('barcodeinput').disabled = true;
        //    }
        //    else if (document.getElementById('RadioButton3').checked == true) {
        //        document.getElementById('textprintdata').disabled = true;
        //        document.getElementById('bmpimage').disabled = false;
        //        document.getElementById('barcodeinput').disabled = true;
        //    }
        //    else if (document.getElementById('RadioButton4').checked == true) {
        //        document.getElementById('textprintdata').disabled = true;
        //        document.getElementById('bmpimage').disabled = true;
        //        document.getElementById('barcodeinput').disabled = false;
        //    } else {
        //        document.getElementById('textprintdata').disabled = true;
        //        document.getElementById('bmpimage').disabled = true;
        //        document.getElementById('barcodeinput').disabled = true;
        //    }
        //}

        /*Otp registration*/
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

        /*pidoptions capture*/
        function Capture() {
            var url = "http://127.0.0.1:11100/rd/capture";

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
            /*Bluetooth connection validation*/
            if (document.getElementById("btnametxt").value == '' || document.getElementById("btnametxt").value == null ||
                document.getElementById("btmactxt").value == '' || document.getElementById("btmactxt").value == null) {
                var connection = "N";
                var bluetoothname = document.getElementById("btnametxt").defaultvalue = '';
                var bluetoothmac = document.getElementById("btmactxt").defaultvalue = '';
            } else {
                var connection = 'Y';
                var bluetoothname = document.getElementById("btnametxt").value;
                var bluetoothmac = document.getElementById("btmactxt").value;
            }
           
            
            /*pid options input*/
            var PIDOPTS = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                          + '<PidOptions ver="1.0">'
                          + '<CustOpts>'
                          + '<Param name="' + bluetoothname + '" value="' + bluetoothmac + '"/>'
                          + '<Param name="Connection" value="' + connection + '"/>'
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
            alert(PIDOPTS);

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
        } /*pidoptions capture End*/

        function sleep(milliseconds) {
            var start = new Date().getTime();
            for (var i = 0; i < 1e7; i++) {
                if ((new Date().getTime() - start) > milliseconds) {
                    break;
                }
            }
        }

        /*Authenticate */
        function authvalidate() {

            /*aadhar no validation*/
            if (document.getElementById('aadharno').value == '' || document.getElementById('aadharno').value == null) {
                document.getElementById('uidnoerr').innerHTML = "Enter Aadhar Number";
                return;
            }
            if (document.getElementById('aadharno').value.length < 12 || document.getElementById('aadharno').value.length > 12) {
                document.getElementById('uidnoerr').innerHTML = "Enter Valid Aadhar Number";
                return;
            }
            if (document.getElementById('aadharno').value.length == 12) {
                //var Usraadharno = document.getElementById('aadharno').value;
                document.getElementById('uidnoerr').innerHTML = '';
                var Usraadharno = document.getElementById('aadharno').value;
                //alert("Auth validate:    "+Usraadharno);
            } /*aadhar no validation END*/

            //var xmlns = "http://www.uidai.gov.in/authentication/uid-auth-request/2.0"
            //var uid = Usraadharno;
            //var rc = "Y"
            //var tid = "registered"
            //var ac = "public"
            //var sa = "public"
            //var ver = "2.0"
            //var txn = ""
            //var lk = "MEaMX8fkRa6PqsqK6wGMrEXcXFl_oXHA-YuknI2uf0gKgZ80HaZgG3A"

            //var AUTHXML = '<Auth uid="' + uid + '" rc="' + rc + '" tid="' + tid + '" ac="' + ac + '" sa="' + sa + '" ver="' + ver + '" txn="' + txn + '" lk="' + lk + '">'
            //              + '<Uses pi="" pa="" pfa="" bio="" bt="" pin="" otp=""/>'
            //              + '<Meta udc="" rdsId="" rdsVer="" dpId="" dc="" mi="" mc="" />'
            //              + '<Skey ci=""></Skey>'
            //              + '<Hmac>SHA-256 Hash of Pid block, encrypted and then encoded</Hmac>'
            //              + '<Data type="X|P">encrypted PID block</Data>'
            //              + '<Signature>Digital signature of AUA</Signature>'
            //              + '</Auth>';
            // alert(AUTHXML);

        } /*Authenticate End*/

        /* capture + auth function Start */
        function authenticate() {
            document.getElementById("authsucMessage").innerHTML = "";
            document.getElementById("autherrMessage").innerHTML = "";

            authvalidate(); //calling authvalidate function
            
            //capture function start
            var url = "http://127.0.0.1:11100/rd/capture";

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

            /*Bluetooth connection validation*/
            if (document.getElementById("btnametxt").value == '' || document.getElementById("btnametxt").value == null ||
                document.getElementById("btmactxt").value == '' || document.getElementById("btmactxt").value == null) {
                var connection = "N";
                var bluetoothname = document.getElementById("btnametxt").defaultvalue = '';
                var bluetoothmac = document.getElementById("btmactxt").defaultvalue = '';
            } else {
                var connection = 'Y';
                var bluetoothname = document.getElementById("btnametxt").value;
                var bluetoothmac = document.getElementById("btmactxt").value;
            }
            
            /*pid options input*/
            var PIDOPTS = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                          + '<PidOptions ver="1.0">'
                          + '<CustOpts>'
                          + '<Param name="' + bluetoothname + '" value="' + bluetoothmac + '"/>'
                          + '<Param name="Connection" value="' + connection + '"/>'
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
            alert(PIDOPTS);

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
                        //alert('PID DATA: ' + xhr.responseText);
                        //alert('PID DATA 1: ' + piddata1);
                        console.log(xhr.responseText);

                        //alert('sending values to aspx.cs file');
                        var Usraadharno = document.getElementById('<%=aadharno.ClientID %>').value;
                        var piddata = document.getElementById('<%=piddatahiddenfield.ClientID %>').value;

                        PageMethods.auth(Usraadharno, piddata, onSucess, onError);
                        //alert('sent values to aspx.cs file');
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
            //capture function End
        } /* capture + auth function End */

        /*Bluetooth connection*/
        function btcon() {
            
            document.getElementById('btnameerr').innerHTML = "";
            document.getElementById('btmacerr').innerHTML = "";
            var btname = document.getElementById("btnametxt").value;
            var btmac = document.getElementById("btmactxt").value;

            if (document.getElementById("btnametxt").value == '' || document.getElementById("btnametxt").value == null) {
                document.getElementById('btnameerr').innerHTML = "Enter Bluetooth Name";
                return;
            }
            if (document.getElementById("btmactxt").value == '' || document.getElementById("btmactxt").value == null) {
                document.getElementById('btmacerr').innerHTML = "Enter Bluetooth Mac Address";
                return;
            }
           
            var btnameui = document.getElementById('<%=btnametxt.ClientID %>').value;
            var btmacui = document.getElementById('<%=btmactxt.ClientID %>').value;

            PageMethods.btdetails(btnameui, btmacui, response);
            function connresp(response) {
                alert(response);
                document.getElementById("btresp").innerHTML = response;
            }
            //alert(btname + btmac);
        } /*Bluetooth connection*/


        /*rd service*/
        function rdservice() {
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
                        template = xhr.responseText;
                    } else {
                        console.log(xhr.response);
                        alert(xhr.response);

                    }
                }
            };
            xhr.send();
        } /*rd service End*/

        /*DeviceInfo*/
        function deviceinfo() {
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
                }
            };
            xhr.send();
        } /*DeviceInfo End*/

        /*Printer Postauth function*/
        function postauthcall(inXMl) {

            //alert("inside postauthcall()");
            //alert(inXMl);
            browserdetection();
            //alert("out of browserdetection()");
            var os = osname.toString();
            //alert("osname is copied to a var os");

            if (os == 'Android') {
                // alert("inside if loop Android postauth"+inXMl);
                var androidhref = "intent:#Intent;action=in.gov.uidai.rdservice.POSTAUTH;category=android.intent.category.DEFAULT;category=android.intent.category.BROWSABLE;S.PrinterText=" + inXMl + ";end";
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
                        }
                    }
                };
                xhr.send(xml);
            }
        } /*Printer Postauth function End*/

        /*BatteryStatus postauth*/
        function Batterystatus() {
            var url = "http://127.0.0.1:11100/rd/postauth";
            //var textprintinput = document.getElementById('txtprintip').value;
            //var txtprintipencoded = window.btoa(textprintinput);
            //alert(txtprintipencoded);
            var Batterystatusxml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                  + '<PostAuth txn="abc"  err="0">'
                                  + '<CustOpts>'
                                  + '<Param name="ESYS04650" value="00:04:3E:97:B9:08"/>'
                                  + '<Param name="Connection" value="N"/>'
                                  + '<Param name="Module" value="BATTERY_STATUS"/>'
                                  + '</CustOpts>'
                                  + '</PostAuth>';
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
                }
            };
            xhr.send(Batterystatusxml);
        } /*BatteryStatus postauth End*/

        /*diagnostics print postauth*/
        function DiagnosticS() {
            var url = "http://127.0.0.1:11100/rd/postauth";
            //var textprintinput = document.getElementById('txtprintip').value;
            //var txtprintipencoded = window.btoa(textprintinput);
            //alert(txtprintipencoded);
            var diagnostics = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                               + '<PostAuth txn="abc"  err="0">'
                               + '<CustOpts>'
                               + '<Param name="ESYS04650" value="00:04:3E:97:B9:08"/>'
                               + '<Param name="Connection" value="N"/>'
                               + '<Param name="Module" value="DIAGNOSTICS"/>'
                               + '</CustOpts>'
                               + '</PostAuth>';

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
                }
            };
            xhr.send(diagnostics);
        } /*diagnostics  postauth End*/

        /*FirmwareVersion postauth*/
        function Firmwareversion() {
            var url = "http://127.0.0.1:11100/rd/postauth";

            var Firmwareversion = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                             + '<PostAuth txn="abc"  err="0">'
                             + '<CustOpts>'
                             + '<Param name="ESYS04650" value="00:04:3E:97:B9:08"/>'
                             + '<Param name="Connection" value="N"/>'
                             + '<Param name="Module" value="FIRM_WARE_VERSION"/>'
                             + '</CustOpts>'
                             + '</PostAuth>';
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
                }
            };
            xhr.send(Firmwareversion);
        } /*FirmwareVersion  postauth End*/

        /*Identifyperipherals postauth*/
        function IdentifyPeripherals() {
            var url = "http://127.0.0.1:11100/rd/postauth";
            //var textprintinput = document.getElementById('txtprintip').value;
            //var txtprintipencoded = window.btoa(textprintinput);
            //alert(txtprintipencoded);
            var Identifyperipheral = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                      + '<PostAuth txn="abc"  err="0">'
                                      + '<CustOpts>'
                                      + '<Param name="ESYS04650" value="00:04:3E:97:B9:08"/>'
                                      + '<Param name="Connection" value="N"/>'
                                      + '<Param name="Module" value="IDENTIFY_PERIPHERALS"/>'
                                      + '</CustOpts>'
                                      + '</PostAuth>';
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
                }
            };
            xhr.send(Identifyperipheral);
        } /*Identifyperipherals postauth End*/

        /*magcard postauth*/
        function Magcard() {
            var url = "http://127.0.0.1:11100/rd/postauth";
            //var textprintinput = document.getElementById('txtprintip').value;
            //var txtprintipencoded = window.btoa(textprintinput);
            //alert(txtprintipencoded);
            var magcardxml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                              + '<PostAuth txn="abc"  err="0">'
                              + '<CustOpts>'
                              + '<Param name="ESYS04650" value="00:04:3E:97:B9:08"/>'
                              + '<Param name="Connection" value="N"/>'
                              + '<Param name="Module" value="MAGCARD"/>'
                              + '<Param name="Timeout" value="10000"/>'
                              + '</CustOpts>'
                              + '</PostAuth>';
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
                }
            };
            xhr.send(magcardxml);
        } /*magcard postauth End*/

        /*paperfeed postauth*/
        function Paperfeed() {
            var url = "http://127.0.0.1:11100/rd/postauth";
            //var textprintinput = document.getElementById('txtprintip').value;
            //var txtprintipencoded = window.btoa(textprintinput);
            //alert(txtprintipencoded);
            var paperfeedxml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                              + '<PostAuth txn="abc"  err="0">'
                              + '<CustOpts>'
                              + '<Param name="ESYS04650" value="00:04:3E:97:B9:08"/>'
                              + '<Param name="Connection" value="N"/>'
                              + '<Param name="Module" value="PAPERFEED"/>'
                              + '</CustOpts>'
                              + '</PostAuth>';
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
                }
            };
            xhr.send(paperfeedxml);
        } /*paperfeed postauth End*/

        /*DISCONNECT postauth*/
        function Disconect() {
            var url = "http://127.0.0.1:11100/rd/postauth";
            //var textprintinput = document.getElementById('txtprintip').value;
            //var txtprintipencoded = window.btoa(textprintinput);
            //alert(txtprintipencoded);
            var DisconnectXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                                  + '<PostAuth txn="abc"  err="0">'
                                  + '<CustOpts>'
                                  + '<Param name="ESYS04650" value="00:04:3E:97:B9:08"/>'
                                  + '<Param name="Connection" value="N"/>'
                                  + '<Param name="Module" value="DISCONNECTED"/>'
                                  + '</CustOpts>'
                                  + '</PostAuth>';
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
                }
            };
            xhr.send(DisconnectXML);
        } /*DISCONNECT postauth End*/
    </script>
</head>

<body>
    <%-- Bootstrap page start --%>
    <!-- navbar -->
    <nav class="navbar navbar-light" style="background-color: #428bca;">
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
            <!-- pid options -->
            <div class="pidopts">
                <div class="panel-group col-md-3">
                    <div class="panel panel-primary">
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
                                &nbsp;
                            </div>

                        </div>
                    </div>
                </div>
            </div>



            <div class="col-sm-3" id="rdauth">

                <!-- Token entry-->
                <div class="panel-group" id="tokenentry">
                    <div class="panel panel-primary">
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

                <!-- Authenticate -->
                <div class="panel panel-primary" id="auth">
                    <div class="panel-heading" style="text-align: center;"><b>Authenticate</b></div>
                    <div class="panel-body">
                        <asp:HiddenField ID="piddatahiddenfield" runat="server" Value="" />
                        <asp:TextBox ID="aadharno" runat="server" class="form-control" placeholder="Enter Aadhar No" MaxLength="12" value=""></asp:TextBox>&nbsp;
                        <span id="uidnoerr" style="color: #f44336; font-size: 12px;"></span>
                        <asp:Button ID="aadnosub" runat="server" class="btn-primary form-control" Text="AUTHENTICATE" OnClientClick="authenticate(); return false;" />&nbsp;
                        <p id="autherrMessage" style="color: #f44336; font-size: 12px;" value=""></p>
                        <p id="authsucMessage" style="color: #4CAF50; font-size: 12px;" value=""></p>
                        <%--<input type="number" class="form-control" id="aadharno" placeholder="Enter Aadhar No" maxlength="12" value="" />
                    &nbsp;
                    <button type="button" class="btn-primary form-control" id="aadnosub" onclick="authenticate();">AUTHENTICATE</button>
                    &nbsp;--%>
                    </div>
                </div>

                <!-- RDService -->
                <div class="panel-group" id="rdservice">
                    <div class="panel panel-primary ">
                        <div class="panel-heading" style="text-align: center;"><b>RD Service</b></div>
                        <div class="panel-body">
                            <button type="button" class="btn-primary  form-control" id="rdsbtn" onclick="rdservice();">RD Service</button>
                            &nbsp;
                        <button type="button" class="btn-primary  form-control" id="info" onclick="deviceinfo();">DEVICE INFO</button>
                        </div>
                    </div>
                </div>

            </div>

            <%-- Printer --%>
            <div class="col-sm-3" id="print">
                <div class="panel-group">
                    <div class="panel panel-primary ">
                        <div class="panel-heading" style="text-align: center;"><b>Printer</b></div>
                        <div class="panel-body">

                            <asp:RadioButton ID="Radiotxtprint" class="radio radio-inline" runat="server" GroupName="Print" Text="Text Print" /><br />
                            <asp:TextBox ID="textprintdata" runat="server" class="form-control" placeholder="Text Here..." value=""></asp:TextBox>&nbsp;

                        <asp:RadioButton ID="Radiotstprint" class="radio radio-inline" runat="server" GroupName="Print" Text="Test Print" /><br />
                            &nbsp;

                        <asp:RadioButton ID="Radiobmpprint" class="radio radio-inline" runat="server" GroupName="Print" Text="BMP Print" /><br />
                            <asp:FileUpload ID="bmpimageip" class="form-control" accept=".bmp" runat="server" />&nbsp;

                            <asp:RadioButton ID="Radiobarcodeprint" class="radio radio-inline" runat="server" GroupName="Print" Text="Barcode Print" /><br />
                            <asp:TextBox ID="barcodedata" runat="server" class="form-control" placeholder="Barcode Value" value=""></asp:TextBox>&nbsp;

                        <asp:Button ID="printbtn" runat="server" Text="Print" class="btn-primary form-control" OnClick="btn_Print_Click" />&nbsp;
                       
                        <%--<asp:Button ID="paperfeed" runat="server" Text="PAPER FEED" class="btn-primary form-control" OnClientClick="paperfeed()" />&nbsp;--%>

                            <button type="button" class="btn-primary form-control" id="paperfeed" onclick="Paperfeed();">PAPER FEED</button>&nbsp;
                       <%-- <button type="button" class="btn-primary form-control" id="greyscal" onclick="greyscal();">GREY SCALE PRINT</button>
                        &nbsp;--%>
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

            <!--Bluetooth Connection-->
            <div class="col-sm-3" id="btcon">
                <div class="panel-group">
                    <div class="panel panel-primary" id="getotp">
                        <div class="panel-heading" style="text-align: center;"><b>Bluetooth Connection</b></div>
                        <div class="panel-body">
                            <asp:TextBox ID="btnametxt" runat="server" class="form-control" placeholder="Enter Bluetooth Name" MaxLength="20" value=""></asp:TextBox>
                            <span id="btnameerr" style="color: #f44336; font-size: 12px;"></span>&nbsp;
                            <asp:TextBox ID="btmactxt" runat="server" class="form-control" placeholder="Enter Bluetooth MAC Address" MaxLength="32" value=""></asp:TextBox>
                            <span id="btmacerr" style="color: #f44336; font-size: 12px;"></span>&nbsp;
                            <asp:Button ID="btconbtn" class="btn-primary form-control" runat="server" Text="CONNECT" OnClientClick="btcon(); return false;" />&nbsp;
                            <p id="btresp" style="color: #f44336; font-size: 12px;" value=""></p>
                        </div>
                    </div>

                    <!--Get OTP-->
                    <%--<div class="panel panel-primary" id="getotp">
                        <div class="panel-heading" style="text-align:center;"><b>Generate OTP</b></div>
                        <div class="panel-body">
                            <input type="text" class="form-control" id="otpuidno" placeholder="Enter Aadhar No" maxlength="18" value="" />
                            <span id="errfn" style="color:#f44336;font-size: 12px;"></span>
                            &nbsp;
                            <button type="button" class="btn-primary form-control" id="getotpsubmit" onclick="getotp();">GET OTP</button>&nbsp;
                            <p id="errmsggetotp" style="color:#f44336;font-size: 12px;"></p>
                            <p id="succmsggetotp" style="color: #4CAF50; font-size: 12px;"></p>
                        </div>
                    </div>--%>
                </div>
            </div>

        </form>
    </div>
    <!-- Container End -->
    <!-- footer -->
    <footer class="navbar navbar-light" style="background-color: #428bca;">
        <!--class="page-footer blue center-on-small-only">-->
        <div class="footer-copyright" style="text-align: center; color: white">
            <div class="container-fluid">
                <h4>© 2017 Copyright: <a style="color: white" href="https://www.evolute.in"><span style="color: white">evolute </span></a>
                </h4>
            </div>
        </div>
    </footer>
    <!-- footer End-->

</body>
</html>
