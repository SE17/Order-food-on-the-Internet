<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="goodlist.aspx.cs" Inherits="OnlineOrder.goodlist" %>

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
        <asp:HyperLink ID="HyperLink1" runat="server">注册</asp:HyperLink>
        <asp:HyperLink ID="HyperLink2" runat="server">登录</asp:HyperLink>
    </center>     
    </div>
    <div>
    <center >
        <asp:TextBox ID="TextBox1" runat="server" ></asp:TextBox>    
        <asp:Button ID="Button1" runat="server" Text="搜索" onclick="Button1_Click" />
    </center>       
    </div>
    <div>
     <center>     
         <asp:Label ID="Label3" runat="server" Text="排序"></asp:Label>
         <asp:DropDownList ID="DropDownList1" runat="server" onselectedindexchanged="DropDownList1_SelectedIndexChanged"> 
             <asp:ListItem Value="pro_price" Selected="True">价格</asp:ListItem>
             <asp:ListItem Value="pro_amount">商品库存数</asp:ListItem>
         </asp:DropDownList>
        
         <asp:DropDownList ID="DropDownList2" runat="server" 
             onselectedindexchanged="DropDownList2_SelectedIndexChanged">
             <asp:ListItem Value="ASC" Selected="True">升序</asp:ListItem>
             <asp:ListItem Value="DESC">降序</asp:ListItem>
         </asp:DropDownList>
        
     </center>   
    </div>
    <div>
    <center>       
       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" 
            BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" AllowPaging="True" EmptyDataText="暂无记录" >
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <Columns>
                
                <asp:TemplateField HeaderText="商品名称" SortExpression="商品名称">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("商品名称") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ImageField AlternateText="123" DataImageUrlField = "商品图片" >
                                        
                 </asp:ImageField>
                <asp:TemplateField HeaderText="商品价格" SortExpression="商品价格">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("商品价格") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:HyperLinkField DataNavigateUrlFields="pro_id" Text="查看详情"
                  HeaderText="查看详情" DataNavigateUrlFormatString="GoodDetail.aspx?pro_id={0}" />
           </Columns>
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <PagerStyle BackColor="#C0C0FF" ForeColor="#003399" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        </asp:GridView>       
    </center>
        
    </div>
    </form>
    <p>
           
    </p>
</body>
</html>
