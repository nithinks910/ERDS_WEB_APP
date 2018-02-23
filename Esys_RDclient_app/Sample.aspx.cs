using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.IO;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Xml;
using System.Net;
using System.Security.Cryptography.Xml;
using Org.BouncyCastle.Asn1;
using Org.BouncyCastle.Asn1.X509;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Generators;
using Org.BouncyCastle.Crypto.Prng;
using Org.BouncyCastle.Math;
using Org.BouncyCastle.Security;
using Org.BouncyCastle.X509;
using Org.BouncyCastle.Utilities;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Pkcs;
using System.Reflection;
using Security.Cryptography;
using Org.BouncyCastle.Crypto.Modes;
using Org.BouncyCastle.Crypto.Engines;
using System.Xml.Linq;
using System.Diagnostics;
using System.Threading;
using Printer;


namespace Esys_RDclient_app
{
    public partial class Sample : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:functionname(); ", true);
            //try
            //{
            //    usrnmedisp.Text = Session["id"].ToString();
            //}
            //catch
            //{
            //    Session.RemoveAll();
            //    Response.Redirect("Login.aspx");
            //}
        }

        static string txn = DateTime.Now.ToString("yyyyMMddHHmmssfff");
        static string btname = string.Empty;
        static string dmac = string.Empty;
        static string btconnection = string.Empty;

        static string Otpuidno = string.Empty;

        static string Errorinfo = string.Empty;
        static string OtpErr = string.Empty;
        static string Err = string.Empty;
        static string Ret = string.Empty;
        static string Info = string.Empty;
        static int uid1st = 0;
        static int uid2nd = 0;
        static string uidfromuser = string.Empty;
        static string Final_PID_Data = string.Empty;
        static string Skey = string.Empty;
        static string Hmac = string.Empty;
        static string Data = string.Empty;
        static string DPID = string.Empty;
        static string RDSID = string.Empty;
        static string RDSVER = string.Empty;
        static string DC = string.Empty;
        static string MI = string.Empty;
        static string CI = string.Empty;
        static string MC = string.Empty;
        static string TYPE = string.Empty;
        static string lk = "MEaMX8fkRa6PqsqK6wGMrEXcXFl_oXHA-YuknI2uf0gKgZ80HaZgG3A";
        static string asalk = "MG41KIrkk5moCkcO8w-2fc01-P7I5S-6X2-X7luVcDgZyOa2LXs3ELI";
        static string format = string.Empty;
        static bool result = false;
        string Auth_Data;
        string XML = "";

        private const int RAD_TEST_PRINT = -90;
        private const int RAD_BARCODE_PRINT = -91;
        private const int RAD_TEXT_PRINT = -92;
        private const int RAD_BMP_PRINT = -93;
        private const int RAD_GREYSCALE_PRINT = -94;
        private const int RAD_MAGCARD = -95;
        private const int RAD_PAPERFEED = -96;
        private const int RAD_DIAGNOSTICS = -97;
        private const int RAD_IDENTIFY_PERIPHERALS = -98;
        private const int RAD_BATTERY = -99;
        private const int RAD_FIRMWARE = -100;
        private const int RAD_DEVICE_NOTCONNECTED = -102;

        //Text font constants
        private const byte PR_FONTLARGENORMAL = (byte)0x01;
        private const byte PR_FONTLARGEBOLD = (byte)0x02;
        private const byte PR_FONTSMALLNORMAL = (byte)0x03;
        private const byte PR_FONTSMALLBOLD = (byte)0x04;
        private const byte PR_FONTULLARGENORMAL = (byte)0x05;
        private const byte PR_FONTULLARGEBOLD = (byte)0x06;
        private const byte PR_FONTULSMALLNORMAL = (byte)0x07;
        private const byte PR_FONTULSMALLBOLD = (byte)0x08;
        private const byte PR_FONT180LARGENORMAL = (byte)0x09;
        private const byte PR_FONT180LARGEBOLD = (byte)0x0A;
        private const byte PR_FONT180SMALLNORMAL = (byte)0x0B;
        private const byte PR_FONT180SMALLBOLD = (byte)0x0C;
        private const byte PR_FONT180ULLARGENORMAL = (byte)0x0D;
        private const byte PR_FONT180ULLARGEBOLD = (byte)0x0E;
        private const byte PR_FONT180ULSMALLNORMAL = (byte)0x0F;
        private const byte PR_FONT180ULSMALLBOLD = (byte)0x10;

        //barcode constants
        private const byte BARCODE2OF5COMPRESSED = (byte)0x01;
        private const byte BARCODE2OF5UNCOMPRESSED = (byte)0x02;
        private const byte BARCODE3OF9COMPRESSED = (byte)0x03;
        private const byte BARCODE3OF9UNCOMPRESSED = (byte)0x04;
        private const byte BARCODEEAN13STANDARD = (byte)0x05;

        //Authentication error codes constants
        private const int pi_demographic_data_did_not_match = 100;
        private const int Pa_demographic_data_did_not_match = 200;
        private const int Biometric_data_did_not_match = 300;
        private const int Duplicate_fingers_used = 310;
        private const int Duplicate_Irises_used = 311;
        private const int FMR_and_FIR_cannot_be_used_in_same_transaction = 312;
        private const int Single_FIR_record_contains_more_than_one_finger = 313;
        private const int Number_of_FMR_FIR_should_not_exceed_10 = 314;
        private const int Number_of_IIR_should_not_exceed_2 = 315;
        private const int Number_of_FID_should_not_exceed_1 = 316;
        private const int Biometrics_locked_by_Aadhaar_holder = 330;
        private const int Invalid_OTP_value = 400;
        private const int txn_value_did_not_match_with_txn_value_used_in_Request_OTP_API = 402;
        private const int Invalid_encryption_of_session_key = 500;
        private const int Invalid_certificate_identifier_in_ci_attribute_of_Skey = 501;
        private const int Invalid_encryption_of_PID = 502;
        private const int Invalid_encryption_of_Hmac = 503;
        private const int Session_key_re_initiation_required_due_to_expiry_or_key_out_of_sync = 504;
        private const int Synchronized_Key_usage_not_allowed_for_the_AUA = 505;
        private const int Invalid_Auth_XML_format = 510;
        private const int Invalid_PID_XML_format = 511;
        private const int Invalid_Aadhaar_holder_consent_in_rc_attribute_of_Auth = 512;
        private const int Invalid_tid_value = 520;
        private const int Invalid_dc_code_under_Meta_tag = 521;
        private const int Invalid_mi_code_under_Meta_tag = 524;
        private const int Invalid_mc_code_under_Meta_tag = 527;
        private const int Invalid_authenticator_code = 530;
        private const int Invalid_Auth_XML_version = 540;
        private const int Invalid_PID_XML_version = 541;
        private const int AUA_not_authorized_for_ASA_This_error_will_be_returned_if_AUA_and_ASA_do_not_have_linking_in_the_portal = 542;
        private const int Sub_AUA_not_associated_with_AUA_This_error_will_be_returned_if_Sub_AUA_specified_in_sa_attribute_is_not_added_as_Sub_AUA_in_portal = 543;
        private const int Invalid_Uses_element_attributes = 550;
        private const int Invalid_tid_valuee = 551;
        private const int Registered_devices_currently_not_supported_This_feature_is_being_implemented_in_a_phased_manner = 553;
        private const int Public_devices_are_not_allowed_to_be_used = 554;
        private const int rdsId_is_invalid_and_not_part_of_certification_registry = 555;
        private const int rdsVer_is_invalid_and_not_part_of_certification_registry = 556;
        private const int dpId_is_invalid_and_not_part_of_certification_registry = 557;
        private const int Invalid_dih = 558;
        private const int Device_Certificat_has_expired = 559;
        private const int DP_Master_Certificate_has_expired = 560;
        private const int Request_expired_Pid_ts_value_is_older_than_N_hours_where_N_is_a_configured_threshold_in_authentication_server = 561;
        private const int Timestamp_value_is_future_time_value_specified_Pidts_is_ahead_of_authentication_server_time_beyond_acceptable_threshold = 562;
        private const int Duplicate_request_this_error_occurs_when_exactly_same_authentication_request_was_reprivate_sent_by_AUA = 563;
        private const int HMAC_Validation_failed = 564;
        private const int AUA_license_has_expired = 565;
        private const int Invalid_nonprivate_decryptable_license_key = 566;
        private const int Invalid_input_this_error_occurs_when_unsupported_characters_were_found_in_Indian_language_values_lname_or_lav = 567;
        private const int Unsupported_Language = 568;
        private const int Digital_signature_verification_failed_means_that_authentication_request_XML_was_modified_after_it_was_signed = 569;
        private const int Invalid_key_info_in_digital_signature_this_means_that_certificate_used_for_signing_the_authentication_request_is_not_valid_it_is_either_expired_or_does_not_belong_to_the_AUA_or_is_not_created_by_a_wellknown_Certification_Authority = 570;
        private const int PIN_requires_reset = 571;
        private const int Invalid_biometric_position = 572;
        private const int Pi_usage_not_allowed_as_per_license = 573;
        private const int Pa_usage_not_allowed_as_per_license = 574;
        private const int Pfa_usage_not_allowed_as_per_license = 575;
        private const int FMR_usage_not_allowed_as_per_license = 576;
        private const int FIR_usage_not_allowed_as_per_license = 577;
        private const int IIR_usage_not_allowed_as_per_license = 578;
        private const int OTP_usage_not_allowed_as_per_license = 579;
        private const int PIN_usage_not_allowed_as_per_license = 580;
        private const int Fuzzy_matching_usage_not_allowed_as_per_license = 581;
        private const int Local_language_usage_not_allowed_as_per_license = 582;
        private const int FID_usage_not_allowed_as_per_license_This_feature_is_being_implemented_in_a_phased_manner = 586;
        private const int Name_space_not_allowed = 587;
        private const int Registered_device_not_allowed_as_per_license = 588;
        private const int Public_device_not_allowed_as_per_license = 590;
        private const int Missing_Pi_data_as_specified_in_Uses = 710;
        private const int Missing_Pa_data_as_specified_in_Uses = 720;
        private const int Missing_Pfa_data_as_specified_in_Uses = 721;
        private const int Missing_PIN_data_as_specified_in_Uses = 730;
        private const int Missing_OTP_data_as_specified_in_Uses = 740;
        private const int Invalid_biometric_data = 800;
        private const int Missing_biometric_data_as_specified_in_Uses = 810;
        private const int Missing_biometric_data_in_CIDR_for_the_given_Aadhaar_number = 811;
        private const int Aadhaar_holder_has_not_done_Best_Finger_Detection_Application_should_initiate_BFD_to_help_Aadhaar_holder_identify_their_best_fingers = 812;
        private const int Missing_or_empty_value_for_bt_attribute_in_Uses_element = 820;
        private const int Invalid_value_in_the_bt_attribute_of_Uses_element = 821;
        private const int Invalid_value_in_the_bs_attribute_of_Bio_element_within_Pid = 822;
        private const int No_authentication_data_found_in_the_request_this_corresponds_to_a_scenario_wherein_none_of_the_auth_data_Demo_Pv_or_Bios_is_present = 901;
        private const int Invalid_dob_value_in_the_Pi_element_this_corresponds_to_a_scenarios_wherein_dob_attribute_is_not_of_the_format_YYYY_or_YYYYMMDD_or_the_age_is_not_in_valid_range = 902;
        private const int Invalid_mv_value_in_the_Pi_element = 910;
        private const int Invalid_mv_value_in_the_Pfa_element = 911;
        private const int Invalid_ms_value = 912;
        private const int Both_Pa_and_Pfa_are_present_in_the_authentication_request_Pa_and_Pfa_are_mutually_exclusive = 913;
        private const int Technical_error_that_are_internal_to_authentication_server_930 = 930;
        private const int Technical_error_that_are_internal_to_authentication_server_931 = 931;
        private const int Technical_error_that_are_internal_to_authentication_server_932 = 932;
        private const int Technical_error_that_are_internal_to_authentication_server_933 = 933;
        private const int Technical_error_that_are_internal_to_authentication_server_934 = 934;
        private const int Technical_error_that_are_internal_to_authentication_server_935 = 935;
        private const int Technical_error_that_are_internal_to_authentication_server_936 = 936;
        private const int Technical_error_that_are_internal_to_authentication_server_937 = 937;
        private const int Technical_error_that_are_internal_to_authentication_server_938 = 938;
        private const int Technical_error_that_are_internal_to_authentication_server_939 = 939;
        private const int Unauthorized_ASA_channel = 940;
        private const int Unspecified_ASA_channel = 941;
        private const int OTP_store_related_technical_error = 950;
        private const int Biometric_lock_related_technical_error = 951;
        private const int Unsupported_option = 980;
        private const int Aadhaar_suspended_by_competent_authority = 995;
        private const int Aadhaar_cancelled_Aadhaar_is_no_in_authenticable_status = 996;
        private const int Aadhaar_suspended_Aadhaar_is_not_in_authenticatable_status = 997;
        private const int Invalid_Aadhaar_Number = 998;
        private const int Unknown_error = 999;

        //Otp error codes
        private const int Aadhaar_number_does_not_have_verified_mobile_email = 110;
        private const int Aadhaar_number_does_not_have_verified_mobile = 111;
        private const int Aadhaar_number_does_not_have_both_email_and_mobile = 112;
        private const int Invalid_Otp_XML_format = 510;
        private const int Invalid_device = 520;
        private const int Invalid_mobile_number = 521;
        private const int Invalid_type_attribute = 522;
        private const int Invalid_AUA_code = 530;
        private const int Invalid_OTP_XML_version = 540;
        private const int AUA_not_authorized_for_ASA_This_error_will_be_returned_if_AUA_and_ASA_do_not_have_linking_in_the_portal_otp = 542;
        private const int Sub_AUA_not_associated_with_AUA_This_error_will_be_returned_if_Sub_AUA_specified_in_sa_attribute_is_not_added_as_Sub_AUA_in_portal_otp = 543;
        private const int AUA_License_key_has_expired_or_is_invalid = 565;
        private const int ASA_license_key_has_expired_or_is_invalid = 566;
        private const int Digital_signature_verification_failed = 569;
        private const int Invalid_key_info_in_digital_signature_this_means_that_certificate_used_for_signing_the_OTP_request_is_not_validprivate_const_int_it_is_either_expired_or_does_not_belong_to_the_AUA_or_is_not_created_by_CA = 570;
        private const int Unauthorized_ASA_channel_otp = 940;
        private const int Unspecified_ASA_channel_otp = 941;
        private const int Could_not_generate_and_or_send_OTP = 950;
        private const int Unknown_error_otp = 999;

        //eKyc error codes
        private const string Resident_authentication_failed_ekyc = "K-100";
        private const string Resident_data_currently_not_available_ekyc = "K-200";
        private const string Invalid_KYC_XML_ekyc = "K-540";
        private const string Invalid_eKYC_API_version_ekyc = "K-541";
        private const string Invalid_resident_consent_rc_attribute_in_Kyc_element_ekyc = "K-542";
        private const string Invalid_resident_auth_type_ra_attribute_in_Kyc_element_does_not_match_what_is_in_PID_block_ekyc = "K-544";
        private const string Resident_has_optedout_of_this_service_This_feature_is_not_implemented_currently_ekyc = "K-545";
        private const string Invalid_value_for_pfr_attribute_ekyc = "K-546";
        private const string Invalid_value_for_wadh_attribute_within_PID_block_ekyc = "K-547";
        private const string Invalid_Uses_Attribute_ekyc = "K-550";
        private const string Invalid_Txn_namespace_ekyc = "K-551";
        private const string Invalid_License_key_ekyc = "K-552";
        private const string Digital_signature_verification_failed_for_eKYC_XML_ekyc = "K-569";
        private const string Invalid_key_info_in_digital_signature_for_eKYC_XML_it_is_either_expired_or_does_not_belong_to_the_AUA_or_is_not_created_by_a_wellknown_Certification_Authority_ekyc = "K-570";
        private const string AUA_is_invalid_or_not_an_authorized_KUA_ekyc = "K-600";
        private const string ASA_is_invalid_or_not_an_authorized_ASA_ekyc = "K-601";
        private const string KUA_encryption_key_not_available_ekyc = "K-602";
        private const string ASA_encryption_key_not_available_ekyc = "K-603";
        private const string ASA_Signature_not_allowed_ekyc = "K-604";
        private const string Neither_KUA_key_nor_ASA_encryption_key_are_available_ekyc = "K-605";
        private const string Technical_Failure_ekyc = "K-955";
        private const string Unknown_error_ekyc = "K-999";



        private static void GetSelectedNodeXML()
        {
            try
            {
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.LoadXml(Final_PID_Data);

                XmlNodeList xnList = xmlDoc.SelectNodes("/PidData");
                foreach (XmlNode xn in xnList)
                {
                    Skey = xn["Skey"].InnerText;
                    Hmac = xn["Hmac"].InnerText;
                    Data = xn["Data"].InnerText;
                }

                XmlNodeList xnList1 = xmlDoc.SelectNodes("/PidData/DeviceInfo");
                foreach (XmlNode xn1 in xnList1)
                {
                    DPID = xn1.Attributes["dpId"].Value;
                    RDSID = xn1.Attributes["rdsId"].Value;
                    RDSVER = xn1.Attributes["rdsVer"].Value;
                    DC = xn1.Attributes["dc"].Value;
                    MI = xn1.Attributes["mi"].Value;
                    MC = xn1.Attributes["mc"].Value;
                }

                XmlNodeList xnList2 = xmlDoc.SelectNodes("/PidData/Skey");
                foreach (XmlNode xn1 in xnList2)
                {
                    CI = xn1.Attributes["ci"].Value;
                }

                XmlNodeList xnList3 = xmlDoc.SelectNodes("/PidData/Data");
                foreach (XmlNode xn1 in xnList3)
                {
                    TYPE = xn1.Attributes["type"].Value;
                }
                result = true;
                return;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                //return ex.Message;
            }
        }

        private static String GenerateAuthXML()
        {
            XmlDocument XDoc = new XmlDocument();
            XmlElement XElemRoot = XDoc.CreateElement("Auth");
            XElemRoot.SetAttribute("xmlns", "http://www.uidai.gov.in/authentication/uid-auth-request/2.0");
            XElemRoot.SetAttribute("uid", uidfromuser);
            XElemRoot.SetAttribute("rc", "Y");
            XElemRoot.SetAttribute("tid", "registered");
            XElemRoot.SetAttribute("ac", "public");
            XElemRoot.SetAttribute("sa", "public");
            XElemRoot.SetAttribute("ver", "2.0");
            XElemRoot.SetAttribute("txn", DateTime.Now.ToString("yyyyMMddHHmmssfff"));//"UKC:NA:" + DateTime.Now.ToString("yyyyMMddHHmmssfff"));
            XElemRoot.SetAttribute("lk", lk);
            XDoc.AppendChild(XElemRoot);

            XmlElement Xsource = XDoc.CreateElement("Uses");

            Xsource.SetAttribute("pi", "n");
            Xsource.SetAttribute("pa", "n");
            Xsource.SetAttribute("pfa", "n");
            Xsource.SetAttribute("bio", "y");
            Xsource.SetAttribute("bt", "FMR");
            Xsource.SetAttribute("pin", "n");
            Xsource.SetAttribute("otp", "n");
            XElemRoot.AppendChild(Xsource);

            XmlElement Xsource1 = XDoc.CreateElement("Meta");

            Xsource1.SetAttribute("udc", "200");//"11evolutesys22");
            Xsource1.SetAttribute("rdsId", RDSID);
            Xsource1.SetAttribute("rdsVer", RDSVER);
            Xsource1.SetAttribute("dpId", DPID);
            Xsource1.SetAttribute("dc", DC);
            Xsource1.SetAttribute("mi", MI);
            Xsource1.SetAttribute("mc", MC);

            XElemRoot.AppendChild(Xsource1);

            XmlElement Xsource2 = XDoc.CreateElement("Skey");

            Xsource2.SetAttribute("ci", CI);
            Xsource2.InnerText = Skey;
            XElemRoot.AppendChild(Xsource2);

            string EncryptedPIDData = Data;

            XmlElement Xsource3 = XDoc.CreateElement("Data");
            Xsource3.SetAttribute("type", TYPE);
            Xsource3.InnerText = EncryptedPIDData;
            XElemRoot.AppendChild(Xsource3);

            XmlElement Xsource4 = XDoc.CreateElement("Hmac");
            Xsource4.InnerText = Hmac;
            XElemRoot.AppendChild(Xsource4);

            MemoryStream ms = new MemoryStream();
            XDoc.Save(ms);
            byte[] Fpid = ms.ToArray();
            string AUTH_XML = Encoding.UTF8.GetString(Fpid);
            return AUTH_XML;
        }

        private static void SignXml(XmlDocument xmlDoc, X509Certificate2 uidCert)
        {
            RSACryptoServiceProvider rsaKey = (RSACryptoServiceProvider)uidCert.PrivateKey;

            if (xmlDoc == null)
                throw new ArgumentException("xmlDoc");
            if (rsaKey == null)
                throw new ArgumentException("Key");

            SignedXml signedXml = new SignedXml(xmlDoc);
            signedXml.SigningKey = rsaKey;
            System.Security.Cryptography.Xml.Reference reference = new System.Security.Cryptography.Xml.Reference();
            reference.Uri = "";
            XmlDsigEnvelopedSignatureTransform env = new XmlDsigEnvelopedSignatureTransform();
            reference.AddTransform(env);
            signedXml.AddReference(reference);
            KeyInfo keyInfo = new KeyInfo();
            KeyInfoX509Data clause = new KeyInfoX509Data();
            clause.AddSubjectName(uidCert.Subject);
            clause.AddCertificate(uidCert);
            keyInfo.AddClause(clause);
            signedXml.KeyInfo = keyInfo;
            signedXml.ComputeSignature();
            XmlElement xmlDigitalSignature = signedXml.GetXml();
            System.Console.WriteLine(signedXml.GetXml().InnerXml);
            xmlDoc.DocumentElement.AppendChild(xmlDoc.ImportNode(xmlDigitalSignature, true));
        }

        private static string ForSignAuthXML(string AUTH_XML)
        {
            try
            {
                XmlDocument xmlDoc = new XmlDocument();
                var outPutDirectory = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                var _Path = System.IO.Path.Combine(outPutDirectory, "Staging_Signature_PrivateKey.p12");
                string Cert_path = new Uri(_Path).LocalPath;
                X509Certificate2 uidCert = new X509Certificate2(Cert_path, "public", X509KeyStorageFlags.DefaultKeySet);
                xmlDoc.LoadXml(AUTH_XML);
                xmlDoc.PreserveWhitespace = true;
                SignXml(xmlDoc, uidCert);
                //xmlDoc.Save(@"D:\VISHU\RD_CPP_SERVICE\WebAppAPI_AUTH_SUCCESS\Signed.xml");
                MemoryStream ms = new MemoryStream();
                xmlDoc.Save(ms);
                byte[] Fpid = ms.ToArray();
                string Auth_XML = Encoding.UTF8.GetString(Fpid);
                //xmlDoc = null;
                return Auth_XML;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return e.Message;
            }
        }

        private static string SendForAuthentication(string Au_th_sig_fin)
        {
            try
            {

                //string Signed_Auth = ForSignAuthXML(Au_th_sig_fin);

                string lk = "MG41KIrkk5moCkcO8w-2fc01-P7I5S-6X2-X7luVcDgZyOa2LXs3ELI";

                File.AppendAllText(@"D:\AADHAAR_Related\AADHAAR_Logs\Signed_AuthXML.txt", Au_th_sig_fin);

                string authurlstring = "http://developer.uidai.gov.in/auth/public/" + uid1st + "/" + uid2nd + "/" + lk;
                Uri authURL = new Uri(authurlstring);

                HttpWebRequest authRequest = (HttpWebRequest)WebRequest.Create(authURL);
                authRequest.Method = "POST";
                authRequest.ContentType = "application/xml";

                StreamWriter stOut = new StreamWriter(authRequest.GetRequestStream());
                stOut.WriteLine(Au_th_sig_fin);
                stOut.Close();
                StreamReader stIn = new StreamReader(authRequest.GetResponse().GetResponseStream());
                string strResponse = stIn.ReadToEnd();

                File.AppendAllText(@"D:\AADHAAR_Related\AADHAAR_Logs\Auth_Response.txt", strResponse);
                return strResponse;
            }
            catch (Exception e)
            {
                return e.Message;
            }

        }

        //private string GeneratePIDOptions()
        //{
        //    XmlDocument XDoc = new XmlDocument();
        //    XmlElement XElemRoot = XDoc.CreateElement("PidOptions");
        //    XElemRoot.SetAttribute("ver", "1.0");
        //    XDoc.AppendChild(XElemRoot);

        //    XmlElement Xsource1 = XDoc.CreateElement("Opts");
        //    Xsource1.SetAttribute("fCount", "1");
        //    Xsource1.SetAttribute("fType", "");
        //    Xsource1.SetAttribute("iCount", "");
        //    Xsource1.SetAttribute("iType", "");
        //    Xsource1.SetAttribute("pCount", "");
        //    Xsource1.SetAttribute("pType", "");
        //    Xsource1.SetAttribute("format", "1");
        //    Xsource1.SetAttribute("pidVer", "2.0");
        //    Xsource1.SetAttribute("timeout", "0");
        //    Xsource1.SetAttribute("env", "s");
        //    Xsource1.SetAttribute("otp", "");
        //    Xsource1.SetAttribute("wadh", "");
        //    Xsource1.SetAttribute("posh", "");
        //    XElemRoot.AppendChild(Xsource1);

        //    XmlElement Xsource2 = XDoc.CreateElement("Demo");
        //    XElemRoot.AppendChild(Xsource2);

        //    XmlElement Xsource3 = XDoc.CreateElement("CustOpts");
        //    XElemRoot.AppendChild(Xsource3);

        //    XmlElement Xsource4 = XDoc.CreateElement("Param", "");
        //    Xsource4.SetAttribute("name", "");
        //    Xsource4.SetAttribute("value", "");

        //    Xsource3.AppendChild(Xsource4);
        //    MemoryStream ms = new MemoryStream();
        //    XDoc.Save(ms);
        //    byte[] pid = ms.ToArray();
        //    string rpid = Encoding.UTF8.GetString(pid);
        //    return rpid;
        //}

        //protected void btn_Capture_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string PID_Options = GeneratePIDOptions();
        //        var Pid_OptData = Encoding.UTF8.GetBytes(PID_Options);

        //        string Get_pid_data = "http://localhost:11100/rd/capture";
        //        Uri authURL = new Uri(Get_pid_data);

        //        HttpWebRequest authRequest = (HttpWebRequest)WebRequest.Create(authURL);
        //        authRequest.Method = "CAPTURE";
        //        authRequest.ContentType = "application/xml; charset=utf8";
        //        authRequest.ContentLength = Pid_OptData.Length;
        //        var newStream = authRequest.GetRequestStream();
        //        newStream.Write(Pid_OptData, 0, Pid_OptData.Length);
        //        newStream.Close();
        //        StreamReader stIn = new StreamReader(authRequest.GetResponse().GetResponseStream());
        //        string strResponse = stIn.ReadToEnd();
        //        string ReplacedRes = strResponse.Replace("\\r\\n", "");
        //        Final_PID_Data = (ReplacedRes.Replace("\\\"", @"""")).Trim('"');
        //        //GetSelectedNodeXML();
        //        //Auth_Data = GenerateAuthXML();

        //        //if (result == true)
        //        MsgBox("success" + Final_PID_Data,this.Page,this);

        //    }
        //    catch (WebException webex)
        //    {
        //        WebResponse errResp = webex.Response;
        //        using (Stream respStream = errResp.GetResponseStream())
        //        {
        //            StreamReader reader = new StreamReader(respStream);
        //            string text = reader.ReadToEnd();
        //        }
        //    }
        //}

        public void Message(String msg)
        {
            string script = "window.onload = function(){ alert('";
            script += msg;
            script += "');";
            script += "window.location = '";
            script += "'; }";
            ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script, true);
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

        //protected void btn_info_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        //deviceinfo();
        //        string authurlstring = "http://localhost:11100/rd/info";
        //         Uri authURL = new Uri(authurlstring);

        //        HttpWebRequest authRequest = (HttpWebRequest)WebRequest.Create(authURL);
        //        authRequest.Method = "DEVICEINFO";
        //        authRequest.ContentType = "application/xml";

        //        StreamWriter stOut = new StreamWriter(authRequest.GetRequestStream());
        //        stOut.WriteLine();
        //        stOut.Close();

        //        StreamReader stIn = new StreamReader(authRequest.GetResponse().GetResponseStream());
        //        string strResponse = stIn.ReadToEnd();
        //        Message(strResponse);
        //    }
        //    catch (WebException webex)
        //    {
        //        WebResponse errResp = webex.Response;
        //        using (Stream respStream = errResp.GetResponseStream())
        //        {
        //            StreamReader reader = new StreamReader(respStream);
        //            string text = reader.ReadToEnd();
        //        }
        //    }
        //}

        //private string deviceinfo()
        //{
        //    string authurlstring = "http://localhost:11100/rd/info";
        //    Uri authURL = new Uri(authurlstring);

        //    HttpWebRequest authRequest = (HttpWebRequest)WebRequest.Create(authURL);
        //    authRequest.Method = "DEVICEINFO";
        //    authRequest.ContentType = "application/xml";

        //    StreamWriter stOut = new StreamWriter(authRequest.GetRequestStream());
        //    stOut.WriteLine();
        //    stOut.Close();

        //    StreamReader stIn = new StreamReader(authRequest.GetResponse().GetResponseStream());
        //    string strResponse = stIn.ReadToEnd();
        //    Message(strResponse);
        //    return strResponse;
        //}

        string textprintinput = string.Empty;
        string textfonttype = string.Empty;
        string barcodeinput = string.Empty;
        string barcodetypeinput = string.Empty;
        string HiddenFieldcs = string.Empty;
        protected void btn_Print_Click(object sender, EventArgs e)
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "btn_Print_Click", "btcon()", true);
            try
            {


                btconnection = btconvalue.Text;
                btname = btnametxt.Text;
                dmac = btmactxt.Text;

                byte[] m = null;
                string inXMl = string.Empty;

                if (Radiotxtprint.Checked == true)
                {
                    textprintinput = textprintdata.Text;
                    textfonttype = fonttype.Text;

                    if (textprintinput == "" || textprintinput == null)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert Meassage", "alert('Text print Input is Empty')", true);
                        return;
                    }
                    else
                    {
                        inXMl = operations(RAD_TEXT_PRINT);
                        var bytes = Encoding.UTF8.GetBytes(inXMl);
                        m = bytes;
                    }
                }
                else if (Radiotstprint.Checked == true)
                {
                    inXMl = operations(RAD_TEST_PRINT);
                    var bytes = Encoding.UTF8.GetBytes(inXMl);
                    m = bytes;
                }
                else if (Radiobmpprint.Checked == true)
                {
                    string bmpfile = bmpimageip.FileName;
                    if (bmpfile == "" || bmpfile == null)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert Meassage", "alert('BMP File Input is Empty')", true);
                        return;
                    }

                    inXMl = operations(RAD_BMP_PRINT);
                    var bytes = Encoding.UTF8.GetBytes(XML);
                    m = bytes;
                }
                else if (Radiobarcodeprint.Checked == true)
                {
                    barcodeinput = barcodedata.Text;
                    barcodetypeinput = barcodetype.Text;
                    if (barcodeinput == "" || barcodeinput == null)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert Meassage", "alert('Barcode Input is Empty')", true);
                        return;
                    }
                    else
                    {
                        inXMl = operations(RAD_BARCODE_PRINT);
                        //var bytes = Encoding.UTF8.GetBytes(inXMl);
                        //m = bytes;
                    }
                }
                //else if (Prn_Diagnostic.IsChecked == true)
                //{
                //    string inXMl = operations(RAD_DIAGNOSTICS);
                //    var bytes = Encoding.UTF8.GetBytes(inXMl);
                //    m = bytes;
                //}
                //else if (Firmware_version.IsChecked == true)
                //{
                //    string inXMl = operations(RAD_FIRMWARE);
                //    var bytes = Encoding.UTF8.GetBytes(inXMl);
                //    m = bytes;
                //}
                //else if (Barcode_print.IsChecked == true)
                //{
                //    string inXMl = operations(RAD_BARCODE_PRINT);
                //    var bytes = Encoding.UTF8.GetBytes(inXMl);
                //    m = bytes;
                //}

                //   //call to rd service from cs file
                //string Get_pid_data = "http://localhost:11100/rd/postauth";
                //Uri authURL = new Uri(Get_pid_data);
                //HttpWebRequest authRequest = (HttpWebRequest)WebRequest.Create(authURL);
                //authRequest.Method = "POSTAUTH";
                //authRequest.ContentType = "application/xml; charset=utf8";
                //// authRequest.ContentLength = Pid_OptData.Length;
                //var newStream = authRequest.GetRequestStream();
                //newStream.Write(m, 0, m.Length);
                //newStream.Close();
                //StreamReader stIn = new StreamReader(authRequest.GetResponse().GetResponseStream());
                //string strResponse = stIn.ReadToEnd();

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "btn_Print_Click", "postauthcall('" + inXMl + "')", true);
                //ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "btn_Print_Click", "postauthcall('" + inXMl + "')", true);
            }
            catch (Exception)
            {
                return;
            }
        }

        private string operations(int type)
        {
            int err = 0;
            Debug.WriteLine("Inside operation " + type);
            Printer.Print prn = new Printer.Print();
            try
            {
                Debug.WriteLine("Printer is Initialized");
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            byte bcode = 0x00;
            switch (type)
            {
                case RAD_TEXT_PRINT:
                    String dat = textprintinput;
                    String font = textfonttype;
                    String printer = "Printer." + font;
                    if (fonttype.SelectedIndex == 0)
                    {
                        bcode = PR_FONTLARGENORMAL;
                    }
                    else if (fonttype.SelectedIndex == 1)
                    {
                        bcode = PR_FONTLARGEBOLD;
                    }
                    else if (fonttype.SelectedIndex == 2)
                    {
                        bcode = PR_FONTSMALLNORMAL;
                    }
                    else if (fonttype.SelectedIndex == 3)
                    {
                        bcode = PR_FONTSMALLBOLD;
                    }
                    else if (fonttype.SelectedIndex == 4)
                    {
                        bcode = PR_FONTULLARGENORMAL;
                    }
                    else if (fonttype.SelectedIndex == 5)
                    {
                        bcode = PR_FONTULLARGEBOLD;
                    }
                    else if (fonttype.SelectedIndex == 6)
                    {
                        bcode = PR_FONTULSMALLNORMAL;
                    }
                    else if (fonttype.SelectedIndex == 7)
                    {
                        bcode = PR_FONTULSMALLBOLD;
                    }
                    else if (fonttype.SelectedIndex == 8)
                    {
                        bcode = PR_FONT180LARGENORMAL;
                    }
                    else if (fonttype.SelectedIndex == 9)
                    {
                        bcode = PR_FONT180LARGEBOLD;
                    }
                    else if (fonttype.SelectedIndex == 10)
                    {
                        bcode = PR_FONT180SMALLNORMAL;
                    }
                    else if (fonttype.SelectedIndex == 11)
                    {
                        bcode = PR_FONT180SMALLBOLD;
                    }
                    else if (fonttype.SelectedIndex == 12)
                    {
                        bcode = PR_FONT180ULLARGENORMAL;
                    }
                    else if (fonttype.SelectedIndex == 13)
                    {
                        bcode = PR_FONT180ULLARGEBOLD;
                    }
                    else if (fonttype.SelectedIndex == 14)
                    {
                        bcode = PR_FONT180ULSMALLNORMAL;
                    }
                    else if (fonttype.SelectedIndex == 15)
                    {
                        bcode = PR_FONT180ULSMALLBOLD;
                    }


                    prn.iFlushBuf();
                    //prn.iPrinterAddData(Printer.PR_FONTLARGENORMAL, dat);
                    prn.iPrinterAddData(bcode, dat);
                    // prn.iPrinterAddData(printer.PR_FONTLARGENORMAL, "   1\n" + dataTest);
                    XML = prn.sStartPrinting(txn, btname, dmac, btconnection);
                    break;

                case RAD_BARCODE_PRINT:
                    if (barcodetype.SelectedIndex == 0)
                    {
                        bcode = BARCODE2OF5COMPRESSED;
                    }
                    else if (barcodetype.SelectedIndex == 1)
                    {
                        bcode = BARCODE2OF5UNCOMPRESSED;
                    }
                    else if (barcodetype.SelectedIndex == 2)
                    {
                        bcode = BARCODE3OF9COMPRESSED;
                    }
                    else if (barcodetype.SelectedIndex == 3)
                    {
                        bcode = BARCODE3OF9UNCOMPRESSED;
                    }
                    else if (barcodetype.SelectedIndex == 4)
                    {
                        bcode = BARCODEEAN13STANDARD;
                    }
                    String bar = barcodeinput;
                    String bartype = barcodetypeinput;
                    //String barcode = "Printer." + bartype;
                    //byte[] barcode1 = Encoding.ASCII.GetBytes(bartype);
                    //String bar = 'ABCDEFGHIJ';
                    XML = prn.sPrintBarcode(bcode, bar, txn, btname, dmac, btconnection);
                    break;

                case RAD_TEST_PRINT:
                    XML = prn.sTestPrint(txn, btname, dmac, btconnection);
                    break;

                case RAD_BMP_PRINT:
                    //Read the uploaded File as Byte Array from FileUpload control.
                    Stream fs = bmpimageip.PostedFile.InputStream;
                    BinaryReader br = new BinaryReader(fs);
                    byte[] bytes = br.ReadBytes((Int32)fs.Length);
                    ////Save the Byte Array as File.
                    //string filePath = "~/Files/" + Path.GetFileName(bmpimageip.FileName);
                    //File.WriteAllBytes(Server.MapPath(filePath), bytes);
                    XML = prn.sGetBmpPackets(bytes, txn, btname, dmac, btconnection);
                    break;

                //case RAD_GREYSCALE_PRINT :
                //    inXML = prn.sGreyscalePrint(NewAuthenticationActivity.this,R.drawable.anji,"abc",glbDevname,glbDevmac);
                //    break;
                //case RAD_MAGCARD:
                //    XML = prn.sGetMagneticData(txn, btname, dmac, 10000);
                //    break;
                //case RAD_TEST_PRINT:
                //    XML = prn.sTestPrint(txn, btname, dmac);
                //    break;
                //case RAD_DIAGNOSTICS:
                //    XML = prn.sPrinterDiagnostics(txn, btname, dmac);
                //    break;
                //case RAD_IDENTIFY_PERIPHERALS:
                //    XML = prn.sIdentifyPeripherals(txn, btname, dmac);
                //    break;
                //case RAD_PAPERFEED:
                //    XML = prn.sPaperFeed(txn, btname, dmac);
                //    break;
                //case RAD_FIRMWARE:
                //    XML = prn.sGetFirmwareVersion(txn, btname, dmac);
                //    break;
                //case RAD_BATTERY:
                //    XML = prn.sGetBatteryStatus(txn, btname, dmac);
                //    break;
                default:
                    break;
            }

            return XML;

        }

        [System.Web.Services.WebMethod]
        public static String auth(string Usraadharno, string piddata)
        {
            uidfromuser = Usraadharno;

            string uidfull = Usraadharno;

            int[] digits = Usraadharno.ToString().ToCharArray().Select(x => (int)Char.GetNumericValue(x)).ToArray();

            uid1st = digits[0];
            uid2nd = digits[1];

            Final_PID_Data = piddata;
            GetSelectedNodeXML();
            string Au_th_XML = GenerateAuthXML();
            string auth_final_signed = ForSignAuthXML(Au_th_XML);
            string Auth_Response = SendForAuthentication(auth_final_signed);
            System.Diagnostics.Debug.WriteLine(Au_th_XML);
            System.Diagnostics.Debug.WriteLine(Auth_Response);

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(Auth_Response);
            XmlNodeList xnList = xmlDoc.SelectNodes("/AuthRes");
            foreach (XmlNode xn in xnList)
            {
                Ret = xn.Attributes["ret"].Value;
                try
                {
                    if (Ret == "n")
                    {
                        Err = xn.Attributes["err"].Value;
                    }

                }
                catch
                {

                }

                //Info = xn.Attributes["info"].Value;   
            }
            string Authresult = error(Ret, Err);
            //return Au_th_sig_fin + Auth_Response;
            string authresult = Authresult; // +Au_th_sig_fin + Auth_Response;
            return authresult;
        }


        [System.Web.Services.WebMethod]
        public static String test(string testtxt)
        {
            string txtreturn = "PidData from c# file "+ testtxt;

            //File.AppendAllText(@"D:\AADHAAR_Related\AADHAAR_Logs\Android_Test.txt", "\nPIDOPTS --->> " + Piddata);
            File.AppendAllText(@"D:\AADHAAR_Related\AADHAAR_Logs\Android_Test.txt", "\nPIDDATA --->> " + txtreturn);

            return txtreturn;
        }

        public static string error(string Ret, string sErr)
        {
            if (Ret == "n")
            {
                //return "Authentication Error";
                int Err = Convert.ToInt32(sErr);
                if (Err == pi_demographic_data_did_not_match)
                    return "Error “100” – “Pi” (basic) attributes of demographic data did not match.";
                else if (Err == Pa_demographic_data_did_not_match)
                    return "Error “200” – “Pa” (address) attributes of demographic data did not match.";
                else if (Err == Biometric_data_did_not_match)
                    return "Error “300” – Biometric data did not match.";
                else if (Err == Duplicate_fingers_used)
                    return "Error “310” – Duplicate fingers used.";
                else if (Err == Duplicate_Irises_used)
                    return "Error “311” – Duplicate Irises used.";
                else if (Err == FMR_and_FIR_cannot_be_used_in_same_transaction)
                    return "Error “312” – FMR and FIR cannot be used in same transaction.";
                else if (Err == Single_FIR_record_contains_more_than_one_finger)
                    return "Error “313” – Single FIR record contains more than one finger.";
                else if (Err == Number_of_FMR_FIR_should_not_exceed_10)
                    return "Error “314” – Number of FMR/FIR should not exceed 10.";
                else if (Err == Number_of_IIR_should_not_exceed_2)
                    return "Error “315” – Number of IIR should not exceed 2.";
                else if (Err == Number_of_FID_should_not_exceed_1)
                    return "Error “316” – Number of FID should not exceed 1.";
                else if (Err == Biometrics_locked_by_Aadhaar_holder)
                    return "Error “330” – Biometrics locked by Aadhaar holder.";
                else if (Err == Invalid_OTP_value)
                    return "Error “400” – Invalid OTP value.";
                else if (Err == txn_value_did_not_match_with_txn_value_used_in_Request_OTP_API)
                    return "Error “402” – “txn” value did not match with “txn” value used in Request OTP API.";
                else if (Err == Invalid_encryption_of_session_key)
                    return "Error “500” – Invalid encryption of session key.";
                else if (Err == Invalid_certificate_identifier_in_ci_attribute_of_Skey)
                    return "Error “501” – Invalid certificate identifier in “ci” attribute of “Skey”.";
                else if (Err == Invalid_encryption_of_PID)
                    return "Error “502” – Invalid encryption of PID.";
                else if (Err == Invalid_encryption_of_Hmac)
                    return "Error “503” – Invalid encryption of Hmac.";
                else if (Err == Session_key_re_initiation_required_due_to_expiry_or_key_out_of_sync)
                    return "Error “504” – Session key re-initiation required due to expiry or key out of sync.";
                else if (Err == Synchronized_Key_usage_not_allowed_for_the_AUA)
                    return "Error “505” – Synchronized Key usage not allowed for the AUA.";
                else if (Err == Invalid_Auth_XML_format)
                    return "Error “510” – Invalid Auth XML format.";
                else if (Err == Invalid_PID_XML_format)
                    return "Error “511” – Invalid PID XML format.";
                else if (Err == Invalid_Aadhaar_holder_consent_in_rc_attribute_of_Auth)
                    return "Error “512” – Invalid Aadhaar holder consent in “rc” attribute of “Auth”.";
                else if (Err == Invalid_tid_value)
                    return "Error “520” – Invalid “tid” value.";
                else if (Err == Invalid_dc_code_under_Meta_tag)
                    return "Error “521” – Invalid “dc” code under Meta tag.";
                else if (Err == Invalid_mi_code_under_Meta_tag)
                    return "Error “524” – Invalid “mi” code under Meta tag.";
                else if (Err == Invalid_mc_code_under_Meta_tag)
                    return "Error “527” – Invalid “mc” code under Meta tag.";
                else if (Err == Invalid_authenticator_code)
                    return "Error “530” – Invalid authenticator code.";
                else if (Err == Invalid_Auth_XML_version)
                    return "Error “540” – Invalid Auth XML version.";
                else if (Err == Invalid_PID_XML_version)
                    return "Error “541” – Invalid PID XML version.";
                else if (Err == AUA_not_authorized_for_ASA_This_error_will_be_returned_if_AUA_and_ASA_do_not_have_linking_in_the_portal)
                    return "Error “542” – AUA not authorized for ASA. This error will be returned if AUA and ASA do not have linking in the portal.";
                else if (Err == Sub_AUA_not_associated_with_AUA_This_error_will_be_returned_if_Sub_AUA_specified_in_sa_attribute_is_not_added_as_Sub_AUA_in_portal)
                    return "Error “543” – Sub-AUA not associated with “AUA”. This error will be returned if Sub-AUA specified in “sa” attribute is not added as “Sub-AUA” in portal.";
                else if (Err == Invalid_Uses_element_attributes)
                    return "Error “550” – Invalid “Uses” element attributes.";
                else if (Err == Invalid_tid_valuee)
                    return "Error “551” – Invalid “tid” value.";
                else if (Err == Registered_devices_currently_not_supported_This_feature_is_being_implemented_in_a_phased_manner)
                    return "Error “553” – Registered devices currently not supported. This feature is being implemented in a phased manner.";
                else if (Err == Public_devices_are_not_allowed_to_be_used)
                    return "Error “554” – Public devices are not allowed to be used.";
                else if (Err == rdsId_is_invalid_and_not_part_of_certification_registry)
                    return "Error “555” – rdsId is invalid and not part of certification registry.";
                else if (Err == rdsVer_is_invalid_and_not_part_of_certification_registry)
                    return "Error “556” – rdsVer is invalid and not part of certification registry.";
                else if (Err == dpId_is_invalid_and_not_part_of_certification_registry)
                    return "Error “557” – dpId is invalid and not part of certification registry.";
                else if (Err == Invalid_dih)
                    return "Error “558” – Invalid dih";
                else if (Err == Device_Certificat_has_expired)
                    return "Error “559” – Device Certificate has expired";
                else if (Err == DP_Master_Certificate_has_expired)
                    return "Error “560” – DP Master Certificate has expired";
                else if (Err == Request_expired_Pid_ts_value_is_older_than_N_hours_where_N_is_a_configured_threshold_in_authentication_server)
                    return "Error “561” – Request expired (“Pid->ts” value is older than N hours where N is a configured threshold in authentication server).";
                else if (Err == Timestamp_value_is_future_time_value_specified_Pidts_is_ahead_of_authentication_server_time_beyond_acceptable_threshold)
                    return "Error “562” – Timestamp value is future time (value specified “Pid->ts” is ahead of authentication server time beyond acceptable threshold).";
                else if (Err == Duplicate_request_this_error_occurs_when_exactly_same_authentication_request_was_reprivate_sent_by_AUA)
                    return "Error “563” – Duplicate request (this error occurs when exactly same authentication request was re-sent by AUA).";
                else if (Err == HMAC_Validation_failed)
                    return "Error “564” – HMAC Validation failed.";
                else if (Err == AUA_license_has_expired)
                    return "Error “565” – AUA license has expired.";
                else if (Err == Invalid_nonprivate_decryptable_license_key)
                    return "Error “566” – Invalid non-decryptable license key.";
                else if (Err == Invalid_input_this_error_occurs_when_unsupported_characters_were_found_in_Indian_language_values_lname_or_lav)
                    return "Error “567” – Invalid input (this error occurs when unsupported characters were found in Indian language values, “lname” or “lav”).";
                else if (Err == Unsupported_Language)
                    return "Error “568” – Unsupported Language.";
                else if (Err == Digital_signature_verification_failed_means_that_authentication_request_XML_was_modified_after_it_was_signed)
                    return "Error “569” – Digital signature verification failed (means that authentication request XML was modified after it was signed).";
                else if (Err == Invalid_key_info_in_digital_signature_this_means_that_certificate_used_for_signing_the_authentication_request_is_not_valid_it_is_either_expired_or_does_not_belong_to_the_AUA_or_is_not_created_by_a_wellknown_Certification_Authority)
                    return "Error “570” – Invalid key info in digital signature (this means that certificate used for signing the authentication request is not valid – it is either expired, or does not belong to the AUA or is not created by a well-known Certification Authority).";
                else if (Err == PIN_requires_reset)
                    return "Error “571” – PIN requires reset.";
                else if (Err == Invalid_biometric_position)
                    return "Error “572” – Invalid biometric position.";
                else if (Err == Pi_usage_not_allowed_as_per_license)
                    return "Error “573” – Pi usage not allowed as per license.";
                else if (Err == Pa_usage_not_allowed_as_per_license)
                    return "Error “574”– Pa usage not allowed as per license.";
                else if (Err == Pfa_usage_not_allowed_as_per_license)
                    return "Error “575”– Pfa usage not allowed as per license.";
                else if (Err == FMR_usage_not_allowed_as_per_license)
                    return "Error “576” - FMR usage not allowed as per license.";
                else if (Err == FIR_usage_not_allowed_as_per_license)
                    return "Error “577” – FIR usage not allowed as per license.";
                else if (Err == IIR_usage_not_allowed_as_per_license)
                    return "Error “578” – IIR usage not allowed as per license.";
                else if (Err == OTP_usage_not_allowed_as_per_license)
                    return "Error “579” – OTP usage not allowed as per license.";
                else if (Err == PIN_usage_not_allowed_as_per_license)
                    return "Error “580” – PIN usage not allowed as per license.";
                else if (Err == Fuzzy_matching_usage_not_allowed_as_per_license)
                    return "Error “581” – Fuzzy matching usage not allowed as per license.";
                else if (Err == Local_language_usage_not_allowed_as_per_license)
                    return "Error “582” – Local language usage not allowed as per license.";
                else if (Err == FID_usage_not_allowed_as_per_license_This_feature_is_being_implemented_in_a_phased_manner)
                    return "Error “586” – FID usage not allowed as per license. This feature is being implemented in a phased manner.";
                else if (Err == Name_space_not_allowed)
                    return "Error “587” – Name space not allowed.";
                else if (Err == Registered_device_not_allowed_as_per_license)
                    return "Error “588” – Registered device not allowed as per license.";
                else if (Err == Public_device_not_allowed_as_per_license)
                    return "Error “590” – Public device not allowed as per license.";
                else if (Err == Missing_Pi_data_as_specified_in_Uses)
                    return "Error “710” – Missing “Pi” data as specified in “Uses”.";
                else if (Err == Missing_Pa_data_as_specified_in_Uses)
                    return "Error “720” – Missing “Pa” data as specified in “Uses”.";
                else if (Err == Missing_Pfa_data_as_specified_in_Uses)
                    return "Error “721” – Missing “Pfa” data as specified in “Uses”.";
                else if (Err == Missing_PIN_data_as_specified_in_Uses)
                    return "Error “730” – Missing PIN data as specified in “Uses”.";
                else if (Err == Missing_OTP_data_as_specified_in_Uses)
                    return "Error “740” – Missing OTP data as specified in “Uses”.";
                else if (Err == Invalid_biometric_data)
                    return "Error “800” – Invalid biometric data.";
                else if (Err == Missing_biometric_data_as_specified_in_Uses)
                    return "Error “810” – Missing biometric data as specified in “Uses”.";
                else if (Err == Missing_biometric_data_in_CIDR_for_the_given_Aadhaar_number)
                    return "Error “811” – Missing biometric data in CIDR for the given Aadhaar number.";
                else if (Err == Aadhaar_holder_has_not_done_Best_Finger_Detection_Application_should_initiate_BFD_to_help_Aadhaar_holder_identify_their_best_fingers)
                    return "Error “812” – Aadhaar holder has not done “Best Finger Detection”. Application should initiate BFD to help Aadhaar holder identify their best fingers.";
                else if (Err == Missing_or_empty_value_for_bt_attribute_in_Uses_element)
                    return "Error “820” – Missing or empty value for “bt” attribute in “Uses” element.";
                else if (Err == Invalid_value_in_the_bt_attribute_of_Uses_element)
                    return "Error “821” – Invalid value in the “bt” attribute of “Uses” element.";
                else if (Err == Invalid_value_in_the_bs_attribute_of_Bio_element_within_Pid)
                    return "Error “822” – Invalid value in the “bs” attribute of “Bio” element within “Pid”.";
                else if (Err == No_authentication_data_found_in_the_request_this_corresponds_to_a_scenario_wherein_none_of_the_auth_data_Demo_Pv_or_Bios_is_present)
                    return "Error “901” – No authentication data found in the request (this corresponds to a scenario wherein none of the auth data – Demo, Pv, or Bios – is present).";
                else if (Err == Invalid_dob_value_in_the_Pi_element_this_corresponds_to_a_scenarios_wherein_dob_attribute_is_not_of_the_format_YYYY_or_YYYYMMDD_or_the_age_is_not_in_valid_range)
                    return "Error “902” – Invalid “dob” value in the “Pi” element (this corresponds to a scenarios wherein “dob” attribute is not of the format “YYYY” or “YYYY-MM-DD”, or the age is not in valid range).";
                else if (Err == Invalid_mv_value_in_the_Pi_element)
                    return "Error “910” – Invalid “mv” value in the “Pi” element.";
                else if (Err == Invalid_mv_value_in_the_Pfa_element)
                    return "Error “911” – Invalid “mv” value in the “Pfa” element.";
                else if (Err == Invalid_ms_value)
                    return "Error “912” – Invalid “ms” value.";
                else if (Err == Both_Pa_and_Pfa_are_present_in_the_authentication_request_Pa_and_Pfa_are_mutually_exclusive)
                    return "Error “913” – Both “Pa” and “Pfa” are present in the authentication request (Pa and Pfa are mutually exclusive).";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_930)
                    return "Error “930” – Technical error that are internal to authentication server.";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_931)
                    return "Error “931” – Technical error that are internal to authentication server.";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_932)
                    return "Error “932” – Technical error that are internal to authentication server.";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_933)
                    return "Error “933” – Technical error that are internal to authentication server.";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_934)
                    return "Error “934” – Technical error that are internal to authentication server.";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_935)
                    return "Error “935” – Technical error that are internal to authentication server.";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_936)
                    return "Error “936” – Technical error that are internal to authentication server.";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_937)
                    return "Error “937” – Technical error that are internal to authentication server.";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_938)
                    return "Error “938” – Technical error that are internal to authentication server.";
                else if (Err == Technical_error_that_are_internal_to_authentication_server_939)
                    return "Error “939” – Technical error that are internal to authentication server.";
                else if (Err == Unauthorized_ASA_channel)
                    return "Error “940” – Unauthorized ASA channel.";
                else if (Err == Unspecified_ASA_channel)
                    return "Error “941” – Unspecified ASA channel.";
                else if (Err == OTP_store_related_technical_error)
                    return "Error “950” – OTP store related technical error.";
                else if (Err == Biometric_lock_related_technical_error)
                    return "Error “951” – Biometric lock related technical error.";
                else if (Err == Unsupported_option)
                    return "Error “980” – Unsupported option.";
                else if (Err == Aadhaar_suspended_by_competent_authority)
                    return "Error “995” – Aadhaar suspended by competent authority.";
                else if (Err == Aadhaar_cancelled_Aadhaar_is_no_in_authenticable_status)
                    return "Error “996” – Aadhaar cancelled (Aadhaar is no in authenticable status).";
                else if (Err == Aadhaar_suspended_Aadhaar_is_not_in_authenticatable_status)
                    return "Error “997” – Aadhaar suspended (Aadhaar is not in authenticatable status).";
                else if (Err == Invalid_Aadhaar_Number)
                    return "Error “998” – Invalid Aadhaar Number.";
                else if (Err == Unknown_error)
                    return "Error “999” – Unknown error.";
                return Convert.ToString(Err);
            }
            else
            {
                return "Authentication Successfull";
            }

        }

        private String gotError(int err)
        {
            if (err == Printer.Print.PR_FAIL)
                return "FAIL";
            else if (err == Printer.Print.PR_PARAM_ERROR)
                return "Passed invalid parameter";
            else if (err == Printer.Print.PR_NO_DATA)
                return "NO DATA";
            else if (err == Printer.Print.PR_BMP_FILE_NOT_FOUND)
                return "BMP File Not Found";
            else if (err == Printer.Print.PR_FONT_ORIENTATION_MISMATCH)
                return "Font Orientation Mismatch";
            else if (err == Printer.Print.PR_LIMIT_EXCEEDED)
                return "Data Limit Exceeded";
            else if (err == Printer.Print.PR_CHARACTER_NOT_SUPPORTED)
                return "Character Not Supported";
            return "";
        }

        protected void aadnosub_Click(object sender, EventArgs e)
        {
            Response.Redirect("Sample.aspx");
            btconnection = btconvalue.Text;
            btname = btnametxt.Text;
            dmac = btmactxt.Text;

        }

        protected void Otp_Req_Click(object sender, EventArgs e)
        {
            Response.Redirect("Sample.aspx");
            string Otpuidno = aadharno.Text;
            otpgenxml(Otpuidno);
        }

        [System.Web.Services.WebMethod]
        public static String otpgenxml(string Usraadharno)
        {
            string OtpURL = "http://developer.uidai.gov.in/otp/1.5";
            string auaCode = "public";

            //uid no from ui
            string Otp_Uid = Usraadharno;

            //uid no split
            string uid = Otp_Uid;
            int[] digits = uid.ToString().ToCharArray().Select(x => (int)Char.GetNumericValue(x)).ToArray();
            int uid1 = digits[0];
            int uid2 = digits[1];

            //otp xml generation
            XmlDocument XDoc = new XmlDocument();
            XmlElement XElemRoot = XDoc.CreateElement("Otp");
            XElemRoot.SetAttribute("xmlns", OtpURL);
            XElemRoot.SetAttribute("uid", uid);
            XElemRoot.SetAttribute("tid", "public");
            XElemRoot.SetAttribute("ac", "public");
            XElemRoot.SetAttribute("sa", "public");
            XElemRoot.SetAttribute("ver", "1.5");
            XElemRoot.SetAttribute("txn", "asdf1234567890");
            //XElemRoot.SetAttribute("txn", DateTime.Now.ToString("yyyyMMddHHmmssfff"));//"UKC:NA:" + DateTime.Now.ToString("yyyyMMddHHmmssfff"));
            XElemRoot.SetAttribute("lk", lk);
            XDoc.AppendChild(XElemRoot);

            XmlElement Xsource = XDoc.CreateElement("Opts");
            Xsource.SetAttribute("ch", "00");
            XElemRoot.AppendChild(Xsource);

            MemoryStream msotp = new MemoryStream();
            XDoc.Save(msotp);
            byte[] Fotp = msotp.ToArray();
            string OTP_XML = Encoding.UTF8.GetString(Fotp);
            string Otp_final_signed = ForSignAuthXML(OTP_XML);

            try
            {
                //otp request to server
                File.AppendAllText(@"D:\AADHAAR_Related\AADHAAR_Logs\Signed_OtpXML.txt", Otp_final_signed);

                //url string
                String otpURL = "" + OtpURL + "/" + auaCode + "/" + uid1 + "/" + uid2 + "/" + asalk;

                Uri OtpreqURL = new Uri(otpURL);

                HttpWebRequest authRequest = (HttpWebRequest)WebRequest.Create(OtpreqURL);
                authRequest.Method = "POST";
                authRequest.ContentType = "application/xml";

                StreamWriter stOut = new StreamWriter(authRequest.GetRequestStream());
                stOut.WriteLine(Otp_final_signed);
                stOut.Close();
                StreamReader stIn = new StreamReader(authRequest.GetResponse().GetResponseStream());
                string strResponse = stIn.ReadToEnd();

                File.AppendAllText(@"D:\AADHAAR_Related\AADHAAR_Logs\OTP_Response.txt", strResponse);
                string Otprespxml = strResponse;

                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.LoadXml(Otprespxml);
                XmlNodeList xnList = xmlDoc.SelectNodes("/OtpRes");
                foreach (XmlNode xn in xnList)
                {
                    Ret = xn.Attributes["ret"].Value;
                    try
                    {
                        if (Ret == "n")
                        {
                            OtpErr = xn.Attributes["err"].Value;
                        }

                    }
                    catch
                    {

                    }
                }
                string otpresult = otperror(Ret, OtpErr);
                return otpresult;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        public static string otperror(string Ret, string sErr)
        {
            if (Ret == "n")
            {
                //return "Authentication Error";
                int Err = Convert.ToInt32(sErr);
                if (Err == Aadhaar_number_does_not_have_verified_mobile_email)
                    return "Error “110” – Aadhaar number does not have verified mobile/email";
                else if (Err == Aadhaar_number_does_not_have_verified_mobile)
                    return "Error “111” – Aadhaar number does not have verified mobile";
                else if (Err == Aadhaar_number_does_not_have_both_email_and_mobile)
                    return "Error “112” – Aadhaar number does not have both email and mobile.";
                else if (Err == Invalid_Otp_XML_format)
                    return "Error “510” – Invalid “Otp” XML format";
                else if (Err == Invalid_device)
                    return "Error “520” – Invalid device";
                else if (Err == Invalid_mobile_number)
                    return "Error “521” – Invalid mobile number";
                else if (Err == Invalid_type_attribute)
                    return "Error “522” – Invalid “type” attribute";
                else if (Err == Invalid_AUA_code)
                    return "Error “530” – Invalid AUA code";
                else if (Err == Invalid_OTP_XML_version)
                    return "Error “540” – Invalid OTP XML version";
                else if (Err == AUA_not_authorized_for_ASA_This_error_will_be_returned_if_AUA_and_ASA_do_not_have_linking_in_the_portal_otp)
                    return "Error “542” – AUA not authorized for ASA. This error will be returned if AUA and ASA do not have linking in the portal";
                else if (Err == Sub_AUA_not_associated_with_AUA_This_error_will_be_returned_if_Sub_AUA_specified_in_sa_attribute_is_not_added_as_Sub_AUA_in_portal_otp)
                    return "Error “543” – Sub-AUA not associated with “AUA”. This error will be returned if Sub-AUA specified in “sa” attribute is not added as “Sub-AUA” in portal";
                else if (Err == AUA_License_key_has_expired_or_is_invalid)
                    return "Error “565” – AUA License key has expired or is invalid";
                else if (Err == ASA_license_key_has_expired_or_is_invalid)
                    return "Error “566” – ASA license key has expired or is invalid";
                else if (Err == Digital_signature_verification_failed)
                    return "Error “569” – Digital signature verification failed";
                else if (Err == Invalid_key_info_in_digital_signature_this_means_that_certificate_used_for_signing_the_OTP_request_is_not_validprivate_const_int_it_is_either_expired_or_does_not_belong_to_the_AUA_or_is_not_created_by_CA)
                    return "Error “570” – Invalid key info in digital signature (this means that certificate used for signing the OTP request is not valid – it is either expired, or does not belong to the AUA or is not created by a CA)";
                else if (Err == Unauthorized_ASA_channel_otp)
                    return "Error “940” – Unauthorized ASA channel";
                else if (Err == Unspecified_ASA_channel_otp)
                    return "Error “941” – Unspecified ASA channel";
                else if (Err == Could_not_generate_and_or_send_OTP)
                    return "Error “950” – Could not generate and/or send OTP";
                else if (Err == Unknown_error_otp)
                    return "Error “999” – Unknown error";
                return Convert.ToString(Err);
            }
            else
            {
                return "OTP Successfully Sent";
            }

        }

        [System.Web.Services.WebMethod]
        public static String ekycauthcreate(string Usraadharno, string piddata)
        {
            string uidfull = Usraadharno;

            int[] digits = Usraadharno.ToString().ToCharArray().Select(x => (int)Char.GetNumericValue(x)).ToArray();

            uid1st = digits[0];
            uid2nd = digits[1];

            Final_PID_Data = piddata;
            GetSelectedNodeXML();
            //string Au_th_XML = GenerateAuthXML();

            XmlDocument XDoc = new XmlDocument();
            XmlElement XElemRoot = XDoc.CreateElement("Auth");
            XElemRoot.SetAttribute("xmlns", "http://www.uidai.gov.in/authentication/uid-auth-request/2.0");
            XElemRoot.SetAttribute("uid", uidfromuser);
            XElemRoot.SetAttribute("rc", "Y");
            XElemRoot.SetAttribute("tid", "registered");
            XElemRoot.SetAttribute("ac", "public");
            XElemRoot.SetAttribute("sa", "public");
            XElemRoot.SetAttribute("ver", "2.0");
            XElemRoot.SetAttribute("txn", "UKC:NA:" + DateTime.Now.ToString("yyyyMMddHHmmssfff")); //DateTime.Now.ToString("yyyyMMddHHmmssfff"));
            XElemRoot.SetAttribute("lk", lk);
            XDoc.AppendChild(XElemRoot);

            XmlElement Xsource = XDoc.CreateElement("Uses");

            Xsource.SetAttribute("pi", "n");
            Xsource.SetAttribute("pa", "n");
            Xsource.SetAttribute("pfa", "n");
            Xsource.SetAttribute("bio", "y");
            Xsource.SetAttribute("bt", "FMR");
            Xsource.SetAttribute("pin", "n");
            Xsource.SetAttribute("otp", "n");
            XElemRoot.AppendChild(Xsource);

            XmlElement Xsource1 = XDoc.CreateElement("Meta");

            Xsource1.SetAttribute("udc", "200");//"11evolutesys22");
            Xsource1.SetAttribute("rdsId", RDSID);
            Xsource1.SetAttribute("rdsVer", RDSVER);
            Xsource1.SetAttribute("dpId", DPID);
            Xsource1.SetAttribute("dc", DC);
            Xsource1.SetAttribute("mi", MI);
            Xsource1.SetAttribute("mc", MC);

            XElemRoot.AppendChild(Xsource1);

            XmlElement Xsource2 = XDoc.CreateElement("Skey");

            Xsource2.SetAttribute("ci", CI);
            Xsource2.InnerText = Skey;
            XElemRoot.AppendChild(Xsource2);

            string EncryptedPIDData = Data;

            XmlElement Xsource3 = XDoc.CreateElement("Data");
            Xsource3.SetAttribute("type", TYPE);
            Xsource3.InnerText = EncryptedPIDData;
            XElemRoot.AppendChild(Xsource3);

            XmlElement Xsource4 = XDoc.CreateElement("Hmac");
            Xsource4.InnerText = Hmac;
            XElemRoot.AppendChild(Xsource4);

            MemoryStream ms = new MemoryStream();
            XDoc.Save(ms);
            byte[] Fpid = ms.ToArray();
            string AUTH_XML = Encoding.UTF8.GetString(Fpid);

            string Au_th_XML = AUTH_XML;

            byte[] toEncodeAsBytes = System.Text.ASCIIEncoding.ASCII.GetBytes(Au_th_XML);
            string auth_encoded = System.Convert.ToBase64String(toEncodeAsBytes);

            return auth_encoded;
        }

        [System.Web.Services.WebMethod]
        public static String ekycsend(string Kyc_xml)
        {
            try
            {
                string signed_Kyc_xml = ForSignAuthXML(Kyc_xml);
                File.AppendAllText(@"D:\AADHAAR_Related\AADHAAR_Logs\Signed_ekycXML.txt", signed_Kyc_xml);

                string ekyc_url_string = "http://developer.uidai.gov.in/kyc/2.1/public/" + uid1st + "/" + uid2nd + "/" + lk;
                Uri ekyc_url = new Uri(ekyc_url_string);

                HttpWebRequest ekycRequest = (HttpWebRequest)WebRequest.Create(ekyc_url);
                ekycRequest.Method = "POST";
                ekycRequest.ContentType = "application/xml";

                StreamWriter stOut = new StreamWriter(ekycRequest.GetRequestStream());
                stOut.WriteLine(signed_Kyc_xml);
                stOut.Close();
                StreamReader stIn = new StreamReader(ekycRequest.GetResponse().GetResponseStream());
                string strResponse = stIn.ReadToEnd();

                File.AppendAllText(@"D:\AADHAAR_Related\AADHAAR_Logs\ekyc_Response.txt", strResponse);
                string ekyc_resp_xml = strResponse;
                //return strResponse;

                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.LoadXml(ekyc_resp_xml);
                XmlNodeList xnList = xmlDoc.SelectNodes("/Resp");
                foreach (XmlNode xn in xnList)
                {
                    Ret = xn.Attributes["ret"].Value;
                    try
                    {
                        if (Ret == "N")
                        {
                            Err = xn.Attributes["err"].Value;
                        }

                    }
                    catch
                    {

                    }
                }
                string eKyc_result = ekycerror(Ret, Err);
                return eKyc_result;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        public static string ekycerror(string Ret, string Err)
        {
            if (Ret == "N")
            {
                //return "Authentication Error";
                //int Err = Convert.ToInt32(sErr);
                if (Err == Resident_authentication_failed_ekyc)
                    return "Error K-100” – Resident authentication failed";
                else if (Err == Resident_data_currently_not_available_ekyc)
                    return "Error K-200” – Resident data currently not available";
                else if (Err == Invalid_KYC_XML_ekyc)
                    return "Error K-540 – Invalid KYC XML";
                else if (Err == Invalid_eKYC_API_version_ekyc)
                    return "Error K-541 – Invalid e-KYC API version";
                else if (Err == Invalid_resident_consent_rc_attribute_in_Kyc_element_ekyc)
                    return "Error K-542 – Invalid resident consent ('rc' attribute in 'Kyc' element)";
                else if (Err == Invalid_resident_auth_type_ra_attribute_in_Kyc_element_does_not_match_what_is_in_PID_block_ekyc)
                    return "Error K-544 – Invalid resident auth type ('ra' attribute in 'Kyc' element does not match what is in PID block)";
                else if (Err == Resident_has_optedout_of_this_service_This_feature_is_not_implemented_currently_ekyc)
                    return "Error K-545 – Resident has opted-out of this service. This feature is not implemented currently.";
                else if (Err == Invalid_value_for_pfr_attribute_ekyc)
                    return "Error K-546 – Invalid value for 'pfr' attribute";
                else if (Err == Invalid_value_for_wadh_attribute_within_PID_block_ekyc)
                    return "Error K-547 – Invalid value for 'wadh' attribute within PID block";
                else if (Err == Invalid_Uses_Attribute_ekyc)
                    return "Error K-550 - Invalid Uses Attribute";
                else if (Err == Invalid_Txn_namespace_ekyc)
                    return "Error K-551 – Invalid 'Txn' namespace";
                else if (Err == Invalid_License_key_ekyc)
                    return "Error K-552 – Invalid License key";
                else if (Err == Digital_signature_verification_failed_for_eKYC_XML_ekyc)
                    return "Error K-569 – Digital signature verification failed for e-KYC XML";
                else if (Err == Invalid_key_info_in_digital_signature_for_eKYC_XML_it_is_either_expired_or_does_not_belong_to_the_AUA_or_is_not_created_by_a_wellknown_Certification_Authority_ekyc)
                    return "Error K-570 – Invalid key info in digital signature for e-KYC XML (it is either expired, or does not belong to the AUA or is not created by a well-known Certification Authority)";
                else if (Err == AUA_is_invalid_or_not_an_authorized_KUA_ekyc)
                    return "Error K-600 – AUA is invalid or not an authorized KUA";
                else if (Err == ASA_is_invalid_or_not_an_authorized_ASA_ekyc)
                    return "Error K-601 – ASA is invalid or not an authorized ASA";
                else if (Err == KUA_encryption_key_not_available_ekyc)
                    return "Error K-602 – KUA encryption key not available";
                else if (Err == ASA_encryption_key_not_available_ekyc)
                    return "Error K-603 – ASA encryption key not available";
                else if (Err == ASA_Signature_not_allowed_ekyc)
                    return "Error K-604 – ASA Signature not allowed";
                else if (Err == Neither_KUA_key_nor_ASA_encryption_key_are_available_ekyc)
                    return "Error K-605 – Neither KUA key nor ASA encryption key are available";
                else if (Err == Technical_Failure_ekyc)
                    return "Error K-955 – Technical Failure";
                else if (Err == Unknown_error_ekyc)
                    return "Error K-999 – Unknown error";
                return Err;
            }
            else
            {
                return "e-KYC Successfull";
            }

        }

        public class ComboboxItem
        {
            public string Text { get; set; }
            public object Value { get; set; }
            public override string ToString()
            {
                return Text;
            }
        }

        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            //Session.RemoveAll();
            //Response.Redirect("Login.aspx");
        }

        //private void scanForRDService()
        //{
        //    try
        //    {
        //        //if (Dispatcher.CheckAccess())
        //        //{
        //        //    this.Dispatcher.BeginInvoke(new Action(delegate
        //        //    {
        //        //        img_load.Visibility = Visibility.Visible;
        //        //        //pictureBox1.Image = Properties.Resources.wait_image;
        //        //    }));

        //        //}
        //        //else
        //        //{
        //        //    img_load.Visibility = Visibility.Visible;
        //        //    //pictureBox1.Image = Properties.Resources.wait_image;
        //        //}

        //        List<ComboboxItem> portList = new List<ComboboxItem>();
        //        bool rdFound = false;
        //        for (int i = 11100; i < 11121; i++)
        //        {
        //            if (closeAllThreads)
        //            {
        //                return;
        //            }
        //            if (Dispatcher.CheckAccess())
        //            {
        //                this.Dispatcher.BeginInvoke(new Action(delegate
        //                {
        //                    //lblCurrPort.Content = i.ToString();
        //                }));

        //            }
        //            else
        //            {
        //                //lblCurrPort.Content = i.ToString();
        //            }
        //            try
        //            {
        //                string completeUrl = "http://LocalHost:" + i.ToString() + "/rd/info";
        //                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(completeUrl);
        //                request.Method = "DEVICEINFO";
        //                request.Credentials = CredentialCache.DefaultCredentials;
        //                request.ContentType = "text/xml";
        //                WebResponse response = default(WebResponse);
        //                response = request.GetResponse();
        //                Stream str = response.GetResponseStream();
        //                StreamReader sr = new StreamReader(str);
        //                string finalResponse = sr.ReadToEnd();
        //                if (finalResponse.ToUpper().Contains("EVOLUTE.EVOLUTE"))
        //                {

        //                    ComboboxItem item = new ComboboxItem();

        //                    //item.Content = i.ToString();
        //                    item.Text = i.ToString();
        //                    item.Value = i.ToString();
        //                    portList.Add(item);
        //                    if (this.Dispatcher.CheckAccess())
        //                    {
        //                        this.Dispatcher.BeginInvoke(new Action(delegate
        //                        {

        //                            //comboPOrts.DisplayMemberPath = "Text";
        //                            //comboPOrts.SelectedValuePath = "Value";

        //                            //comboPOrts.ItemsSource = portList;
        //                            rdFound = true;
        //                            //btnRDInfo.Enabled = true;
        //                            //btnDevInfo.Enabled = true;
        //                            //groupBoxFinger.Enabled = true;
        //                            //btnCapture.Enabled = true;
        //                            // btnCaptureKyc.Enabled = true;
        //                            //comboPOrts.SelectedIndex = 0;
        //                        }));
        //                    }
        //                    else
        //                    {
        //                        //comboPOrts.DisplayMemberPath = "Text";
        //                        //comboPOrts.SelectedValuePath = "Value";

        //                        //comboPOrts.ItemsSource = portList; ;
        //                        rdFound = true;
        //                        //btnRDInfo.Enabled = true;
        //                        //btnDevInfo.Enabled = true;
        //                        //groupBoxFinger.Enabled = true;
        //                        //btnCapture.Enabled = true;
        //                        //btnCaptureKyc.Enabled = true;
        //                        //comboPOrts.SelectedIndex = 0;
        //                    }
        //                }
        //            }
        //            catch (Exception) { }
        //        }
        //        if (this.Dispatcher.CheckAccess())
        //        {
        //            this.Dispatcher.BeginInvoke(new Action(delegate
        //            {
        //                //lblCurrPort.Content = "Scan completed";
        //                //img_load.Visibility = Visibility.Hidden;
        //            }));

        //        }
        //        else
        //        {
        //            //lblCurrPort.Content = "Scan completed";
        //            //img_load.Visibility = Visibility.Hidden;//pictureBox1.Image = null;
        //        }
        //        if (!rdFound)
        //        {
        //            //btnRDInfo.Enabled = false;
        //            //btnDevInfo.Enabled = false;
        //            //groupBoxFinger.Enabled = false;
        //            //btnCapture.Enabled = false;
        //            //btnCaptureKyc.Enabled = false;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        //btnRDInfo.Enabled = false;
        //        //btnDevInfo.Enabled = false;
        //        //groupBoxFinger.Enabled = false;
        //        //btnCapture.Enabled = false;
        //        //btnCaptureKyc.Enabled = false;
        //        //MessageBox.Show("Exception:- " + ex.Message);
        //    }
        //}
        //btnDevInfo.Enabled = true;
        //groupBoxFinger.Enabled = true;
        //btnCapture.Enabled = true;
        //btnCaptureKyc.Enabled = true;
        //comboPOrts.SelectedIndex = 0;
    }
}






//Combined XML start
//        private static volatile bool help = false;//Setup.help;
//        private static String TAG = "CombinedXmlClass == == >>>";
//        private static int count = 0;
//        private static String resultIntValue = "";

//        public static String getCombinedXMl(String img, String txt) {
//        String updated_dataXML = "";
//        if (img!="" && txt!="") {
//            String sub_txt = null;
//            try {
//                sub_txt = txt.substring(txt.indexOf("<Param name=\"1\""));
//                if (help) Console.WriteLine(TAG + "sub xml is : " + sub_txt);
//                String forCount = sub_txt;
//                int index = forCount.indexOf("Param");
//                count = 0;
//                while (index != -1) {
//                    count++;
//                    forCount = forCount.substring(index + 1);
//                    index = forCount.indexOf("Param");
//                }
//            } catch (Exception e) {
//                 Console.WriteLine(e.Message);
//            }

//            if (help) Console.WriteLine(TAG + "count value is: " + count);
//            if (help) Console.WriteLine(TAG + "sub xml is : " + sub_txt);
//            String sub_img = img.replace("</CustOpts></PostAuth>", "");
//            try {
//                InputStream is = new ByteArrayInputStream(img.getBytes());
//                DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
//                domFactory.setIgnoringComments(true);
//                DocumentBuilder builder = domFactory.newDocumentBuilder();
//                Document doc = builder.parse(is);
//                ArrayList<String> paramarrayList = new ArrayList<String>();
//                NodeList paramElmntLst = doc.getElementsByTagName("Param");
//                Element baseElmntparam = (Element) paramElmntLst.item(0);
//                if (baseElmntparam == null) {
//                    if (help) Console.WriteLine(TAG + "baseElmntparam = " + baseElmntparam);
//                } else {
//                    NamedNodeMap paramElmnattrattr = baseElmntparam.getAttributes();
//                    for (int i = 0; i < paramElmnattrattr.getLength(); ++i) {
//                        Node attr = paramElmnattrattr.item(i);
//                        String paramattributes = attr.getNodeName();
//                        paramarrayList.add(paramattributes);
//                    }
//                }
//                if (paramarrayList.contains("name")) {
//                    String resultValueName = doc.getElementsByTagName("Param").item(3).getAttributes().getNamedItem("name").getTextContent();
//                    if (help) Console.WriteLine(TAG + "resultValueName = " + resultValueName);

//                }
//                if (paramarrayList.contains("value")) {
//                    resultIntValue = doc.getElementsByTagName("Param").item(3).getAttributes().getNamedItem("value").getTextContent();
//                    if (help) Console.WriteLine(TAG + "resultIntValue = " + resultIntValue);
//                }
//                updated_dataXML = getUpdatedDataXML(sub_img.concat(sub_txt));
//                if (help) Console.WriteLine(TAG + "updated_dataXML : " + updated_dataXML);
//            } catch (Exception e) {
//                Console.WriteLine(e.Message);
//            }
//        }
//        return  updated_dataXML;
//    }

//        private static String getUpdatedDataXML(String data)
//        {
//            String updated_data = "";
//            try
//            {
//                Document doc = StringToDocument(data);
//                updateNodeValue(doc);
//                updated_data = DocumentToString(doc);
//                updated_data = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" + updated_data;
//                if (help) Log.d(TAG, "updated string is :" + updated_data);
//            }
//            catch (Exception e)
//            {
//                Console.WriteLine(e.Message);
//            }
//            return updated_data;
//        }

//        private static void updateNodeValue(Document doc) {
//        int updatedval = 0;
//        try {
//            updatedval = (Integer.parseInt(resultIntValue))+count;
//            NodeList nodeList = doc.getElementsByTagName("*");
//            ArrayList<String> elmntarrayList = new ArrayList<String>();
//            for (int i = 0; i < nodeList.getLength(); i++) {
//                Element element = (Element) nodeList.item(i);
//                String params = element.getNodeName();
//                elmntarrayList.add(params);
////           if (help) Log.d("main","elemaentry array is :"+elmntarrayList);
////           if (help) Log.d("main","elemaentry array is :"+elmntarrayList.size());
//            }

//            ArrayList<String> paramarrayList = new ArrayList<String>();
//            NodeList paramElmntLst = doc.getElementsByTagName("Param");
//            Element baseElmntparam = (Element) paramElmntLst.item(0);
//            if (baseElmntparam == null) {
//                if (help) Log.d("main", "baseElmntparam = " + baseElmntparam);
//            } else {
//                NamedNodeMap paramElmnattrattr = baseElmntparam.getAttributes();
//                for (int i = 0; i < paramElmnattrattr.getLength(); ++i) {
//                    Node attr = paramElmnattrattr.item(i);
//                    String paramattributes = attr.getNodeName();
//                    paramarrayList.add(paramattributes);
//                }
//            }
//            if (paramarrayList.contains("name")) {
//                String resultValueName = doc.getElementsByTagName("Param").item(3).getAttributes().getNamedItem("name").getTextContent();
//                if (help) Log.d("main", "resultValueName = " + resultValueName);

//            }
//            if (paramarrayList.contains("value")) {
//                doc.getElementsByTagName("Param").item(3).getAttributes().getNamedItem("value").setTextContent(String.valueOf(updatedval));
//            }
//            int j=1;
//            for (int i = (Integer.parseInt(resultIntValue))+7; i <= elmntarrayList.size(); i++) {
//                int oldval = Integer.parseInt(resultIntValue);
//                if (paramarrayList.contains("name")) {
//                    doc.getElementsByTagName("Param").item(i-3).getAttributes().getNamedItem("name").setTextContent(String.valueOf(oldval+j));
//                    j++;
//                }
//            }
//        } catch (NumberFormatException e) {
//            e.printStackTrace();
//        }
//    }

//        private static String DocumentToString(Document doc)
//        {
//            String output = null;
//            try
//            {
//                TransformerFactory tf = TransformerFactory.newInstance();
//                Transformer transformer = tf.newTransformer();
//                transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
//                StringWriter writer = new StringWriter();
//                transformer.transform(new DOMSource(doc), new StreamResult(writer));
//                output = writer.getBuffer().toString();
//            }
//            catch (Exception e)
//            {
//                e.printStackTrace();
//            }
//            return output;
//        }

//        private static Document StringToDocument(String strXml) {
//        Document doc = null;
//        try {
//            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//            DocumentBuilder builder = factory.newDocumentBuilder();
//            StringReader strReader = new StringReader(strXml);
//            InputSource is = new InputSource(strReader);
//            doc = (Document) builder.parse(is);
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw e;
//        }
//        return doc;
//    }

//protected void printerdemo(object sender, EventArgs e)
//{
//    string textipdata = textprintdata.Value;
//    Printer prn = new Printer();
//    byte[] m;

//    string inXMl = operations(RAD_TEST_PRINT);
//    var bytes = Encoding.UTF8.GetBytes(inXMl);
//    m = bytes;
//    String dat = textipdata;
//    prn.iFlushBuf();
//    prn.iPrinterAddData(Printer.PR_FONTLARGENORMAL, dat);
//    // prn.iPrinterAddData(printer.PR_FONTLARGENORMAL, "   1\n" + dataTest);
//    string XML = prn.sStartPrinting("abc");
//    string editxml = XML.ToString();

//    //string editxml1 = editxml.Replace("\\","");
//    string editxml1 = Regex.Replace(editxml, @"\\", "");
//    //string editxml1 = editxml.Remove('\\');
//    string ResponseXML = editxml1.ToString();
//    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "printerbtn", "printer('" + editxml1 + "')", true);
//}

//protected void bmpprinter(object sender, EventArgs e)
//{
//    Printer prn = new Printer();
//    byte[] m;
//}

//protected void barcodeprint(object sender, EventArgs e)
//{
//    string barcodeipdata = barcodedata.Value;
//    Printer prn = new Printer();
//    byte[] m;

//    string inXMl = operations(RAD_BARCODE_PRINT);
//    var bytes = Encoding.UTF8.GetBytes(inXMl);
//    m = bytes;
//    String dat = barcodeipdata;
//    String bar = dat;
//    string XML = prn.sPrintBarcode(Printer.BARCODE3OF9COMPRESSED, bar, "abc");

//    string editxml = XML.ToString();
//    //string editxml1 = editxml.Replace("\\","");
//    string editxml1 = Regex.Replace(editxml, @"\\", "");
//    //string editxml1 = editxml.Remove('\\');
//    string ResponseXML = editxml1.ToString();
//    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "barcodeprintbtn", "barcodeprint('" + editxml1 + "')", true);
//}

//    }
//}
