using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cua_Hang_Tra_Sua; // Đảm bảo đúng namespace chứa DataContext của bạn

namespace QL_TRA_SUA
{
    public partial class AddBai_Viet : System.Web.UI.Page
    {
        private Cua_Hang_Tra_SuaDataContext context = new Cua_Hang_Tra_SuaDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Không cần làm gì khi load, chỉ đợi bấm nút Lưu
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Lấy nội dung từ TinyMCE (txtContentEditor)
                string htmlContent = txtContentEditor.Text;

                if (string.IsNullOrWhiteSpace(htmlContent))
                {
                    Label1.Text = "⚠️ Nội dung trống!";
                    return;
                }

                // 2. Tạo đối tượng Bài Viết mới
                Bai_Viet newPost = new Bai_Viet();

                // --- GÁN DỮ LIỆU ---
                newPost.Noi_dung = htmlContent; // Lưu nội dung HTML vào cột Noi_dung
                newPost.Tieu_de = "Bài viết ngày " + DateTime.Now.ToString("dd/MM/yyyy HH:mm"); // Tự sinh tiêu đề tránh lỗi NULL
                newPost.Tom_tac = "Tóm tắt tự động";
                newPost.Hinh_anh_page = ""; // Để trống nếu không upload ảnh

                // --- XỬ LÝ LỖI UNIQUE KEY (OrderKey) ---
                // Tìm số thứ tự lớn nhất hiện có + 1
                int nextOrder = 1;
                if (context.Bai_Viets.Any())
                {
                    int maxVal = context.Bai_Viets.Max(x => (int?)x.OrderKey) ?? 0;
                    nextOrder = maxVal + 1;
                }
                newPost.OrderKey = nextOrder;

                // --- XỬ LÝ DANH MỤC (ID_MN) ---
                // Lấy ID Menu đầu tiên tìm thấy để tránh lỗi khóa ngoại
                var defaultMenu = context.Menus.FirstOrDefault();
                if (defaultMenu != null)
                {
                    newPost.ID_MN = defaultMenu.ID_MN;
                }
                else
                {
                    Label1.Text = "❌ Lỗi: CSDL chưa có Danh mục (Menu) nào. Vui lòng tạo Menu trước.";
                    return;
                }

                // 3. LƯU VÀO CSDL
                context.Bai_Viets.InsertOnSubmit(newPost);
                context.SubmitChanges();

                // 4. THÔNG BÁO & CHUYỂN HƯỚNG
                Label1.Text = "✅ Đã lưu thành công!";

                // (Quan trọng) Chờ 1 giây rồi chuyển về trang danh sách để bạn thấy kết quả ngay
                Response.AddHeader("REFRESH", "1;URL=Bai_viet.aspx");
            }
            catch (Exception ex)
            {
                Label1.Text = "❌ Lỗi: " + ex.Message;
            }
        }
    }
}