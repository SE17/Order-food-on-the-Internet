<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Address.aspx.cs" Inherits="OnlineOrder.Address" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
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
                <asp:TemplateField HeaderText="商品名" SortExpression="商品名">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("商品名") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="商品价格" SortExpression="商品价格">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("商品价格") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>               
                <asp:HyperLinkField DataNavigateUrlFields="" Text="删除"
                  HeaderText="删除" DataNavigateUrlFormatString="GoodDetail.aspx?pro_id={0}" />
                <asp:HyperLinkField DataNavigateUrlFields="pro_id" Text="编辑"
                  HeaderText="编辑" DataNavigateUrlFormatString="GoodDetail.aspx?pro_id={0}" />
           </Columns>
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <PagerStyle BackColor="#C0C0FF" ForeColor="#003399" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        </asp:GridView> 
    </center>       
    </div>
    </div>
    </form>
</body>
</html>
