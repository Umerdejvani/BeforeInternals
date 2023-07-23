<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LinkedIn.aspx.cs" Inherits="JobApplication.LinkedIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   <form id="form1" runat="server">
    <asp:Button Text="Login with LinkedIn" runat="server" OnClick="Authorize" />
    <asp:Panel ID="pnlDetails" runat="server" Visible="false">
        <hr />
        <asp:Image ID="imgPicture" runat="server" /><br />
        Name:
        <asp:Label ID="lblName" runat="server" /><br />
        LinkedInId:
        <asp:Label ID="lblLinkedInId" runat="server" /><br />
        Location:
        <asp:Label ID="lblLocation" runat="server" /><br />
        EmailAddress:
        <asp:Label ID="lblEmailAddress" runat="server" /><br />
        Industry:
        <asp:Label ID="lblIndustry" runat="server" /><br />
        Headline:
        <asp:Label ID="lblHeadline" runat="server" /><br />
    </asp:Panel>
    </form>
</body>
</html>
