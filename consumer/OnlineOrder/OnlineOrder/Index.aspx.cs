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

namespace OnlineOrder
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["webuser_id"] != null)
            {
                HyperLink1.Text = Session["account"].ToString();
                HyperLink1.NavigateUrl = "UserInfo.aspx";
                HyperLink2.Text = "购物车";
                HyperLink2.NavigateUrl = "Cart.aspx";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string key;
            string url;
            key = TextBox1.Text;
            //弹出对话框？
            if (key == null|| key == "")
            {
                Response.Write("<script>alert(\"不能为空！\")</script>");
            }
            else
            {
                url = "goodlist.aspx?key="+key;
                Response.Redirect(url);
            }
        }
    }
}
