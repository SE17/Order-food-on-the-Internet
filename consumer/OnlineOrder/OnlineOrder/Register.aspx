<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineOrder.Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
     
        <form id="form1" runat="server">  
        <div>
            
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Index.aspx">首页</asp:HyperLink>   
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="Login.aspx">已有账号，去登录！</asp:HyperLink>
            
        </div>
        <div>
        
            <asp:Label ID="Label1" runat="server" Text="账号"></asp:Label> 
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>        
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                 ControlToValidate="TextBox1" ErrorMessage="请填写用户账号！"></asp:RequiredFieldValidator>
                                    
            <br />
            <asp:Label ID="Label2" runat="server" Text="密码"></asp:Label>  
            <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                 ControlToValidate="TextBox2" ErrorMessage="请输入6-20字符！" 
                 ValidationExpression="\w{6,20}"></asp:RegularExpressionValidator>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                 ErrorMessage="密码不能为空！" ControlToValidate="TextBox2"></asp:RequiredFieldValidator> 
                 
            <br />
            <asp:Label ID="Label3" runat="server" Text="用户名"></asp:Label>  
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>        
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                 ControlToValidate="TextBox3" ErrorMessage="用户名不能为空！"></asp:RequiredFieldValidator>      
                                 
            <br />
            <asp:Label ID="Label4" runat="server" Text="性别"></asp:Label>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                 ControlToValidate="RadioButtonList1" ErrorMessage="请选择性别!"></asp:RequiredFieldValidator>                
                                     
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
                 RepeatDirection="Horizontal">
                <asp:ListItem>男</asp:ListItem><asp:ListItem>女</asp:ListItem>       
            </asp:RadioButtonList>                                
                            
            <br />
            <asp:Label ID="Label5" runat="server" Text="电话"></asp:Label>   
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                 ControlToValidate="TextBox4" ErrorMessage="请填写正确的手机号！" 
                 ValidationExpression="\d{11}"></asp:RegularExpressionValidator>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                 ErrorMessage="手机号不能为空！" ControlToValidate="TextBox4"></asp:RequiredFieldValidator>
            <br />
            <asp:Button ID="Button1" runat="server" Text="注册" onclick="Button1_Click" />
            
              
        </div>
        </form>
     
    
</body>
</html>
