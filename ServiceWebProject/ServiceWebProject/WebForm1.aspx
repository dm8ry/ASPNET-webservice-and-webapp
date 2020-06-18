<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="ServiceWebProject.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Agents Operations</title>

    <style type="text/css">
    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        text-align: left;
        padding: 8px;
    }

    tr:nth-child(even){background-color: #f2f2f2}

    th {
        background-color: #4CAF50;
        color: white;
    }
    </style>

    <script type="text/javascript" language="javascript">

        function GetAgentsOperationsData() {
            
            document.getElementById("txtStartDate").style.borderColor = "#e3e3e3";            
            document.getElementById("txtEndDate").style.borderColor = "#e3e3e3";
            
            var nErrors = 0;

            if (!document.getElementById("txtStartDate").value) {                

				document.getElementById("txtStartDate").style.borderColor = "red";                
                nErrors++;

            }

            if (!document.getElementById("txtEndDate").value) {

                document.getElementById("txtEndDate").style.borderColor = "red";                
                nErrors++;

            }

            if (nErrors == 0) {

                var dtStart = document.getElementById("txtStartDate").value;
                var dtEnd = document.getElementById("txtEndDate").value;
                var txtAgentName = document.getElementById('txtAgentName').value;

                txtAgentName = txtAgentName.replace("\'", "");
                txtAgentName = txtAgentName.replace("\"", "");
                txtAgentName = txtAgentName.replace("'", "");
                txtAgentName = txtAgentName.replace("&", "");
                txtAgentName = txtAgentName.replace("!", "");
                txtAgentName = txtAgentName.replace("\\", "");
                txtAgentName = txtAgentName.replace(";", "");
                txtAgentName = txtAgentName.replace("(", "");
                txtAgentName = txtAgentName.replace(")", "");
                txtAgentName = txtAgentName.replace("%", "");

                document.getElementById('txtAgentName').value = txtAgentName;
              
                ServiceWebProject.MyService1.GetAgentsOperationsData(dtStart, dtEnd, txtAgentName, GetAgentsOperationsDataCallBack);

            }
        }

        function GetAgentsOperationsDataCallBack(resultset) {            

            if (resultset.indexOf("Error!") >= 0) {
                document.getElementById("outputMessage").style.color = 'red';
            }
            else {
                document.getElementById("outputMessage").style.color = 'green';
            }

            //alert("resultset = " + resultset);
            document.getElementById("outputMessage").innerHTML = resultset;
        }

        function TestMe() {
            alert("Qlik!");
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/MyService1.asmx" />
        </Services>
    </asp:ScriptManager>
    <div>        
        <table>
            <tr>
                <td colspan='2' style='text-align:center'><h2>Agents Operations</h2></td>               
            </tr>
            <tr>
                <td style='text-align:right'>From Date:</td>
                <td><asp:TextBox runat="server" ID="txtStartDate"></asp:TextBox></td>                             
            </tr>
            <tr>
                <td style='text-align:right'>To Date:</td>
                <td><asp:TextBox runat="server" ID="txtEndDate"></asp:TextBox></td>                
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>                
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><input id="btnGetTheData" style='text-align:center; width: 71px;' 
                        onclick="GetAgentsOperationsData()" type="button" value="Find" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>                
            </tr>
            <tr>
                <td style='text-align:right'>Filter By Name:</td>
                <td><asp:TextBox runat="server" ID="txtAgentName" onkeyup="GetAgentsOperationsData()"></asp:TextBox></td>                
            </tr>
            <tr>
                <td colspan='2' style='text-align:center'>&nbsp;</td>
            </tr>
            <tr>
                <td colspan='2' style='text-align:center'><h4>Output</h4></td>
            </tr>
            <tr>                
                <td colspan='2' style='text-align:center'>
                    <asp:Label runat="server" ID="outputMessage">
                    </asp:Label>
                </td>
            </tr>
        </table>
                    
    </div>
    </form> 

</body>
</html>
