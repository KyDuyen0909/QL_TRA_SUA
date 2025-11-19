using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QL_TRA_SUA
{
    public partial class EditBai_Viet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label1.Text = "Nhập nội dung bài viết bên dưới rồi nhấn 'Lưu & Hiển thị'.";
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Lấy toàn bộ nội dung HTML từ Editor
            string htmlContent = Request.Unvalidated["Editor1"];
            //hiện thị nội dung html
            Label1.Text = htmlContent;
            // Hiển thị nguyên bản HTML ra Literal (giữ nguyên hình ảnh, bảng, in đậm...)
            litResult.Text = "<h3>Nội dung đã nhập:</h3>" + htmlContent;
        }
    }
    
}