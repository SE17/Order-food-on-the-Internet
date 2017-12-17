<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="OnlineOrder.UserInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
   
    <div>
    <center>
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl = "Index.aspx">首页</asp:HyperLink>  
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl = "UserInfo.aspx">个人中心</asp:HyperLink>  
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl = "Cart.aspx">购物车</asp:HyperLink>    
    </center>
          
    </div>
    <div>
         <center>
            <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/Orders.aspx">我的订单</asp:HyperLink>  
            <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl ="~/Collection.aspx" >我的收藏</asp:HyperLink>  
            <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl ="~/UserInfo.aspx" >个人信息</asp:HyperLink>  
            <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl ="~/Address.aspx">收货地址</asp:HyperLink>
         </center>   
    </div>
    <div>
        <center>
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" BorderColor="#00C0C0"
            BorderWidth="1px" CellPadding="4" EmptyDataText="暂无记录" ForeColor="#333333" Height="208px"
            Width="960px" AutoGenerateEditButton="True" OnModeChanging="DetailsView1_ModeChanging"
                OnItemUpdating="DetailsView1_ItemUpdating"    
                 >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left" Width="500px" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <Fields>
                <asp:BoundField DataField="登录账号" HeaderText="登录账号" SortExpression="登录账号">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="用户名称" HeaderText="用户名称" SortExpression="用户名称">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="用户类别" HeaderText="用户类别" SortExpression="用户类别" ReadOnly="True">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="性别" HeaderText="性别" SortExpression="性别">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="账户余额" HeaderText="账户余额" SortExpression="账户余额" ReadOnly="True">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="电话" HeaderText="联系电话" SortExpression="联系电话">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Fields>
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" Width="200px" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Width="200px" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
        </center>      
    </div>
    </form>
</body>
</html>
