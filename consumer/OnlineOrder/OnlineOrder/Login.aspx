<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineOrder.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <center>
        <form id="form1" runat="server">
            <div>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Index.aspx">首页</asp:HyperLink>   
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="Register.aspx">没有账号，先去注册！</asp:HyperLink>
            </div>
          
            <div>
                账号<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="账号不能为空！" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                <br />
                密码<asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage="密码不能为空" ControlToValidate="TextBox2"></asp:RequiredFieldValidator>
                <br />
                <asp:Button ID="Button1" runat="server" Text="登录" onclick="Button1_Click1" />
            </div>
        </form>
    </center>
</body>
</html>
