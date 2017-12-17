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
    public partial class Orders : System.Web.UI.Page
    {
        SqlConnection con;
        String ConnectionString = "Data Source=localhost;Persist Security Info=True;User ID=sa;Password=root; Initial Catalog=OnlineOrderVegetable;";
        SqlCommand com;
        SqlDataAdapter da;
        DataTable table;
        protected void Page_Load(object sender, EventArgs e)
        {
            String sql = "proc_OrdersStateSelect";
            String webuser_id = Session["webuser_id"].ToString();
            con = new SqlConnection(ConnectionString);
            //打开连接
            con.Open();
            //生成SqlCommand对象
            com = new SqlCommand(sql, con);
            //选择执行命令，存储过程
            com.CommandType = CommandType.StoredProcedure;
            //添加参数
            com.Parameters.AddWithValue("@webuser_id",webuser_id);
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
    }
}
