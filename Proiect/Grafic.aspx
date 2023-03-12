<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Grafic.aspx.cs" Inherits="Proiect.Grafic" %>

<%@ Register assembly="ZedGraph.Web" namespace="ZedGraph.Web" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <cc1:ZedGraphWeb ID="ZedGraphWeb1" runat="server" Height="600" Width="1500" >
            </cc1:ZedGraphWeb>
        </div>
    </form>
</body>
</html>
