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
    public partial class goodlist : System.Web.UI.Page
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
                HyperLink1.Text = Session["account"].ToString();
                HyperLink1.NavigateUrl = "UserInfo.aspx";
                HyperLink2.Text = "购物车";
                HyperLink2.NavigateUrl = "Cart.aspx";
            }
            //搜索框搜索
            if (Request.QueryString["key"] != null)
            {
                String key = Request.QueryString["key"];
           
                produceSearch(key);                           
             
            }
             //类别搜索
            else
            {
                produceSelect();

            }       
        }
        //关键字模糊查询
        protected void produceSearch(string key)
        {
            String sql = "proc_ProduceNameSelect";
            con = new SqlConnection(ConnectionString);
            //打开连接
            con.Open();
            //生成SqlCommand对象
            com = new SqlCommand(sql, con);
            //选择执行命令，存储过程
            com.CommandType = CommandType.StoredProcedure;
            //添加参数
            com.Parameters.AddWithValue("@key", key);
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
            GridView1.DataSource = table;
            GridView1.DataBind();
        }
        //商品类别检索
        protected void produceSelect()
        {
            String sql = "proc_ProduceSelect";
            String protype_id = Request.QueryString["protype_id"];
            con = new SqlConnection(ConnectionString);
            //打开连接
            con.Open();
            //生成SqlCommand对象
            com = new SqlCommand(sql,con);
           
            //选择执行命令，存储过程
            com.CommandType = CommandType.StoredProcedure;
            //添加参数
            com.Parameters.AddWithValue("@protype_id", protype_id);
            //调用数据库接口存储过程proc_ProduceSelect
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
            GridView1.DataSource = table;
            GridView1.DataBind();
        }

       //响应用户搜索请求
        protected void Button1_Click(object sender, EventArgs e)
        {
            string key;
            string url;
            key = TextBox1.Text;
            //弹出对话框？
            if (key == null || key == "")
            {

            }
            else
            {
                url = "goodlist.aspx?key=" + key;
                Response.Redirect(url);
            }
        }
        
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            //搜索框搜索
            if (Request.QueryString["key"] != null)
            {
                String key = Request.QueryString["key"];

                produceSearch(key);

            }
            //类别搜索
            else
            {
                produceSelect();

            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //搜索框搜索
            if (Request.QueryString["key"] != null)
            {
                String key = Request.QueryString["key"];

                produceSearch(key);

            }
            //类别搜索
            else
            {
                produceSelect();

            }
        }
    }
}
