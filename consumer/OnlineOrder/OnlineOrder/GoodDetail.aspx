<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodDetail.aspx.cs" Inherits="OnlineOrder.GoodDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>
        <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="Index.aspx">首页</asp:HyperLink>       
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Register.aspx">注册</asp:HyperLink>        
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="Login.aspx">登录</asp:HyperLink>               
    </center>      
    </div>
    <div>
    <center>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" BorderColor="#00C0C0"
            BorderWidth="1px" CellPadding="4" EmptyDataText="暂无记录" ForeColor="#333333" Height="208px"
            Width="960px"  >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left" Width="500px" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <Fields>
            
                <asp:BoundField DataField="商品名称" HeaderText="商品名称" SortExpression="商品名称">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="商品价格" HeaderText="商品价格" SortExpression="商品价格">
                    <HeaderStyle HorizontalAlign="Center" />
                    
                </asp:BoundField>
                <asp:BoundField DataField="商品数量" HeaderText="商品数量" SortExpression="商品数量">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="商品简介" HeaderText="商品简介" SortExpression="商品简介">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="收藏次数" HeaderText="收藏次数" SortExpression="收藏次数">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Fields>
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" Width="200px" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Width="200px" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
        <asp:Button ID="Button1" runat="server" Text="加入购物车" onclick="Button1_Click" />  
        <asp:Button ID="Button2" runat="server" Text="收藏" onclick="Button2_Click" />
    </center>
        
    </div>
    
    </form>
</body>
</html>
