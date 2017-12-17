<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="OnlineOrder.Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div >
    <center>
        <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="Index.aspx">首页</asp:HyperLink>        
        <asp:HyperLink ID="HyperLink1" runat="server"  NavigateUrl="Register.aspx">注册</asp:HyperLink>        
        <asp:HyperLink ID="HyperLink2" runat="server" BorderStyle="None" NavigateUrl ="Login.aspx" >登录</asp:HyperLink>
    </center> 
        
    </div>
    <div>
        <center>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="搜索" onclick="Button1_Click" />     
        </center>
       <p> 
       </p>
    </div>
    <div> 
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <center>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>                 
                    
                    <asp:AdRotator ID="AdRotator1" runat="server" Width="960px" Height="480px"
        AdvertisementFile="ad.xml"/>
     
                </ContentTemplate>
            </asp:UpdatePanel>
        </center>
        <p> 
       </p>
    </div>
    <div>
        <center>
            <div>
            
                <asp:HyperLink ID="HyperLink3" runat="server" BackColor="#66FFFF" Height="40px" 
                    NavigateUrl="goodlist.aspx?protype_id=pty1000001" Width="300px">海鲜</asp:HyperLink>
                               
                 <asp:HyperLink ID="HyperLink4" NavigateUrl="goodlist.aspx?protype_id=pty1000002"  
                    runat="server" BackColor="#FFCCCC" Height="40px" Width="300px">肉类</asp:HyperLink>
            </div>
            <div>
                <asp:HyperLink ID="HyperLink5" runat="server" 
                    NavigateUrl="goodlist.aspx?protype_id=pty1000003" BackColor="Lime" Height="40px" 
                    Width="300px">蔬菜</asp:HyperLink>
                             
                <asp:HyperLink ID="HyperLink6" runat="server" 
                    NavigateUrl="goodlist.aspx?protype_id=pty1000004" BackColor="#FFFF66" Height="40px" 
                    style="margin-bottom: 0px" Width="300px">水果</asp:HyperLink>
            </div>             
        </center>       
    </div>   
    </form>
    </body>
</html>
