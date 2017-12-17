<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="OnlineOrder.Orders" %>

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
       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" 
            BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" AllowPaging="True" EmptyDataText="暂无记录" >
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <Columns>
                
                <asp:TemplateField HeaderText="订单编号" SortExpression="订单编号">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("订单编号") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="商品名称" SortExpression="商品名称">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("商品名称") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="商品数量" SortExpression="商品数量">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("商品数量") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField> 
                <asp:TemplateField HeaderText="订单总价" SortExpression="订单总价">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("订单总价") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="订单状态" SortExpression="订单状态">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("订单状态") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>             
           </Columns>
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <PagerStyle BackColor="#C0C0FF" ForeColor="#003399" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        </asp:GridView>       
    </center>
        
    </div>
    </form>
</body>
</html>
