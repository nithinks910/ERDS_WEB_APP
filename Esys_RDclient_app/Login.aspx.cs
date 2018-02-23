using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Esys_RDclient_app.ServiceReference_Login;

namespace Esys_RDclient_app
{
    public partial class Login : System.Web.UI.Page
    {
        
        ServiceReference_Login.LoginClient obj = new ServiceReference_Login.LoginClient();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginbtn_Click(object sender, EventArgs e)
        {
            try
            {
                UserLoginDetails userinfo = new UserLoginDetails();
                userinfo.UserName = userName.Text;
                userinfo.Password = password.Text;
                List<string> msg = obj.LoginUserDetails(userinfo).ToList();
                Label.Text = " Name = " + msg.ElementAt(0) + " Id = " + msg.ElementAt(1);
      
                    Session["id"] = userName.Text;
                    Response.Redirect("Sample.aspx");
                    Session.RemoveAll();
            
                
            }
            catch (Exception ex)
            {
                Label.Text = "Wrong Id Or Password";
            }
        }
    }
}