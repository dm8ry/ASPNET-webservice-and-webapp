using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using Newtonsoft.Json;
using System.Text.RegularExpressions;
using System.Globalization;

namespace ServiceWebProject
{
    /// <summary>
    /// Summary description for MyService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]    
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class MyService1 : System.Web.Services.WebService
    {

        [WebMethod]
        public String GetAgentsOperationsData(String txt_dtStartDateTime, String txt_dtEndDateTime, String txt_NamePattern)
        {

            if (txt_dtStartDateTime == null || txt_dtStartDateTime == String.Empty)
                return "Error! The *From Date* Field Cannot Be Null!";

            if (txt_dtEndDateTime == null || txt_dtEndDateTime == String.Empty)
                return "Error! The *End Date* Field Cannot Be Null!";

            Regex rgx = new Regex(@"\d{4,4}-\d{2,2}-\d{2,2} \d{2,2}:\d{2,2}:\d{2,2}");
       
            if (!rgx.IsMatch(txt_dtStartDateTime))
                return "Error! The *From Date* Field Format Should Be YYYY-MM-DD HH24:MI:SS!";

            if (!rgx.IsMatch(txt_dtEndDateTime))
                return "Error! The *End Date* Field Format Should Be YYYY-MM-DD HH24:MI:SS!";

            DateTime myDate1;
            if (!(DateTime.TryParseExact(txt_dtStartDateTime, "yyyy-MM-dd hh:mm:ss",
                CultureInfo.InvariantCulture, DateTimeStyles.None, out myDate1)))
            {       
                // String has only Date Portion
                return "Error! The *Start Date* Field Is Invalid! The Format Should Be YYYY-MM-DD HH24:MI:SS!";
            }

            DateTime myDate2;
            if (!(DateTime.TryParseExact(txt_dtEndDateTime, "yyyy-MM-dd hh:mm:ss",
                CultureInfo.InvariantCulture, DateTimeStyles.None, out myDate2)))
            {
                // String has only Date Portion
                return "Error! The *End Date* Field Is Invalid! The Format Should Be YYYY-MM-DD HH24:MI:SS!";
            }

            DateTime dtStartDateTime = Convert.ToDateTime(txt_dtStartDateTime);
            DateTime dtEndDateTime = Convert.ToDateTime(txt_dtEndDateTime);

            DataSet ds = new DataSet();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {

                using (SqlCommand cmd = new SqlCommand("GetAgentsOperationsData", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("dtStartDateTime", SqlDbType.DateTime).Value = dtStartDateTime;
                    cmd.Parameters.Add("dtEndDateTime", SqlDbType.DateTime).Value = dtEndDateTime;
                    cmd.Parameters.Add("strAgentName", SqlDbType.NVarChar).Value = txt_NamePattern;
                    

                    if (con.State != ConnectionState.Open)
                    {
                        con.Open();
                    }

                    SqlDataAdapter adp = new SqlDataAdapter();

                    adp.SelectCommand = cmd;

                    adp.Fill(ds);

                    if (con.State == ConnectionState.Open)
                    {
                        con.Close();
                    }                    

                }

            }           
  
            var json = JsonConvert.SerializeObject(ds);

            return json;

        }
    }
}
