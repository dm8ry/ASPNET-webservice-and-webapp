using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Script.Serialization;  

namespace ServiceWebProject
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtAgentName.Attributes.Add("onkeyup", "return GetAgentsOperationsData()"); 
        }


        protected void btnGetTheData_Click(object sender, EventArgs e)
        {
            // nothing to do
            // will work with Ajax :)
        }
        
    }
}