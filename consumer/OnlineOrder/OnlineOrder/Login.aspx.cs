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
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con;
        String ConnectionString = "Data Source=localhost;Persist Security Info=True;User ID=sa;Password=root; Initial Catalog=OnlineOrderVegetable;";
        SqlCommand com;
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

    
        protected void Button1_Click1(object sender, EventArgs e)
        {
            String sql = "proc_WebUserSelectLogin";
            int returnValue,outputValue;
            con = new SqlConnection(ConnectionString);
            //打开连接
            con.Open();
            //生成SqlCommand对象
            com = new SqlCommand(sql, con);
            //选择执行命令，存储过程
            com.CommandType = CommandType.StoredProcedure;
            //添加参数
            com.Parameters.AddWithValue("@account", TextBox1.Text.ToString());
            com.Parameters.AddWithValue("@pwd", TextBox2.Text.ToString());
            
            //输出参数
            SqlParameter output = new SqlParameter("@webuser_id", SqlDbType.Char,10);
            output.Direction = ParameterDirection.Output;
            com.Parameters.Add(output);
            //返回值
            SqlParameter result = new SqlParameter("@return", SqlDbType.Int);
            result.Direction = ParameterDirection.ReturnValue; 　　//参数类型为ReturnValue                     
            com.Parameters.Add(result);
            //执行存储过程
            com.ExecuteNonQuery();
            //获取返回值
            returnValue = int.Parse(com.Parameters["@return"].Value.ToString());
            if (returnValue == 1)
            {
                //session添加用户和密码参数
               // outputValue = com.Parameters["@webuser_id"].Value.ToString();
                Session["webuser_id"] = com.Parameters["@webuser_id"].Value.ToString();
                Session["account"] = TextBox1.Text;
                Session["pwd"] = TextBox2.Text;
                Response.Redirect("Index.aspx");
            }
            else if (returnValue == 2)
            {
                Response.Write("<script>alert(\"账号不存在！\");</script>");
            }
            else
            {
                Response.Write("<script>alert(\"密码错误！\");</script>");
            }

        }
    }
}
