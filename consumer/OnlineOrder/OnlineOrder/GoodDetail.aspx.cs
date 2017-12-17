using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;

namespace OnlineOrder
{
    public partial class GoodDetail : System.Web.UI.Page
    {
        SqlConnection con;
        String ConnectionString = "Data Source=localhost;Persist Security Info=True;User ID=sa;Password=root; Initial Catalog=OnlineOrderVegetable;";
        SqlCommand com;
        SqlDataAdapter da;
        DataTable table;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["webuser_id"] != null)
            {
                HyperLink1.Text = "个人中心";
                HyperLink1.NavigateUrl = "UserInfo.aspx";
                HyperLink2.Text = "购物车";
                HyperLink2.NavigateUrl = "Cart.aspx";
            }
            showGoodsDetail();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["webuser_id"] == null)
            {
                Response.Write("<script>alert(\"请先登录！\");</script>");
            }
            else
            {
                
                Response.Write("<script>alert(\"加入购物车成功！\");</script>");
            }
        }
        protected void showGoodsDetail()
        {
            String pro_id = Request.QueryString["pro_id"];
            String sql = "proc_ProduceIdSelect";
            con = new SqlConnection(ConnectionString);
            //打开连接
            con.Open();
            //生成SqlCommand对象
            com = new SqlCommand(sql, con);
            //选择执行命令，存储过程
            com.CommandType = CommandType.StoredProcedure;
            //添加参数
            com.Parameters.AddWithValue("@pro_id", pro_id);
            //执行存储过程
            com.ExecuteNonQuery();
            //生成Adapter对象
            da = new SqlDataAdapter();
            //生成table
            table = new DataTable();
            //Adapter对象获取数据
            da.SelectCommand = com;
            //Adapter对象填充数据
            da.Fill(table);
            //释放对象
            con.Close();
            //数据绑定
            DetailsView1.DataSource = table;
            DetailsView1.DataBind();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //收藏商品
            String sql = "proc_CollectInsert";
            String pro_id =Request.QueryString["pro_id"];
            con = new SqlConnection(ConnectionString);
            //打开连接
            con.Open();
            //生成SqlCommand对象
            com = new SqlCommand(sql, con);
            //选择执行命令，存储过程
            com.CommandType = CommandType.StoredProcedure;
            //添加参数
            com.Parameters.AddWithValue("@pro_id", pro_id);
            com.Parameters.AddWithValue("@webuser_id",Session["webuser_id"].ToString());
            //执行存储过程
            com.ExecuteNonQuery();
            //释放对象
            con.Close();
            Response.Write("<script>alert(\"收藏成功！\");</script>");
        }
    }
}
