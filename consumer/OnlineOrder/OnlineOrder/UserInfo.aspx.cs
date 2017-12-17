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
    public partial class UserInfo : System.Web.UI.Page
    {
        SqlConnection con;
        String ConnectionString = "Data Source=localhost;Persist Security Info=True;User ID=sa;Password=root; Initial Catalog=OnlineOrderVegetable;";
        SqlCommand com;
        SqlDataAdapter da;
        DataTable table;
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (Session["account"] != null)
            {

                //显示用户个人信息
                showUserInfo();
            }
            
        }
        protected void showUserInfo()
        {
           
            String sql = "proc_WebuserSelect";
            con = new SqlConnection(ConnectionString);
            //打开连接
            con.Open();
            //生成SqlCommand对象
            com = new SqlCommand(sql, con);
            //选择执行命令，存储过程
            com.CommandType = CommandType.StoredProcedure;
            //添加参数
            com.Parameters.AddWithValue("@account", Session["account"].ToString());
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
            DetailsView1.DataSource = table.DefaultView; 
            DetailsView1.DataBind();
        }

        protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            String sql = "proc_WebuserUpdate";
            string account = ((TextBox)DetailsView1.Rows[0].Cells[1].Controls[0]).Text.ToString();
            string user_name = ((TextBox)DetailsView1.Rows[1].Cells[1].Controls[0]).Text.ToString();
            string user_sex = ((TextBox)DetailsView1.Rows[3].Cells[1].Controls[0]).Text.ToString();
            string user_tel = ((TextBox)DetailsView1.Rows[5].Cells[1].Controls[0]).Text.ToString();
            con = new SqlConnection(ConnectionString);
            //打开连接
            con.Open();
            //生成SqlCommand对象
            com = new SqlCommand(sql, con);
            //选择执行命令，存储过程
            com.CommandType = CommandType.StoredProcedure;
            //添加参数
            com.Parameters.AddWithValue("@account", account);
            com.Parameters.AddWithValue("@user_name",user_name);
            com.Parameters.AddWithValue("@user_sex", user_sex);
            com.Parameters.AddWithValue("@user_tel",user_tel);
            //执行存储过程
            com.ExecuteNonQuery();
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
            DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
            DetailsView1.DataSource = table.DefaultView;
            DetailsView1.DataBind();
            showUserInfo();
             
        }

        protected void DetailsView1_ModeChanging(object sender, DetailsViewModeEventArgs e)
        {
            DetailsView1.ChangeMode(DetailsViewMode.Edit);
            showUserInfo();
         
        }
    }
}
