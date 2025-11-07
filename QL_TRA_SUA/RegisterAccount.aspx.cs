using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cua_Hang_Tra_Sua;

namespace QL_TRA_SUA
{
    public partial class RegisterAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            // BƯỚC 1: KIỂM TRA TÍNH HỢP LỆ CỦA TRANG
            if (!Page.IsValid)
            {
                // Hiển thị thông báo chung nếu có lỗi xác thực (validation)
                lblMessage.Text = "Vui lòng kiểm tra lại các trường thông tin bắt buộc.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string hoTen = txtHoTen.Text.Trim();
            string soDienThoai = txtSoDienThoai.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();
            string matKhau = txtMatKhau.Text;

            // Phân quyền mặc định cho người dùng đăng ký
            const string phanQuyenMacDinh = "Khách Hàng";

            try
            {
                Cua_Hang_Tra_SuaDataContext context = new Cua_Hang_Tra_SuaDataContext();

                // BƯỚC 2: KIỂM TRA SỐ ĐIỆN THOẠ ĐÃ TỒN TẠI CHƯA
                var existingAccount = context.Tai_Khoans.SingleOrDefault(tk => tk.So_dien_thoai == soDienThoai);

                if (existingAccount != null)
                {
                    lblMessage.Text = "Số điện thoại này đã được đăng ký. Vui lòng sử dụng số khác.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // BƯỚC 3: TẠO VÀ LƯU TÀI KHOẢN MỚI
                Tai_Khoan newAccount = new Tai_Khoan
                {
                    Ho_va_ten = hoTen,
                    So_dien_thoai = soDienThoai,
                    Dia_chi = string.IsNullOrEmpty(diaChi) ? null : diaChi,
                    Mat_khau = matKhau,
                    Phan_quyen = phanQuyenMacDinh
                };

                context.Tai_Khoans.InsertOnSubmit(newAccount);
                context.SubmitChanges();

                // BƯỚC 4: ĐĂNG NHẬP TỰ ĐỘNG VÀ CHUYỂN HƯỚNG ĐẾN TRANG QUẢN LÝ TÀI KHOẢN (LoginListaspx.aspx)

                // Lưu thông tin vào Session để đánh dấu người dùng đã đăng nhập
                Session["SoDienThoai"] = soDienThoai; // Lưu số điện thoại (tên đăng nhập)
                Session["PhanQuyen"] = phanQuyenMacDinh; // Lưu phân quyền

                // Chuyển hướng người dùng đến trang Quản lý sau khi đăng ký thành công
                Response.Redirect("LoginList.aspx");

            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi hệ thống khi đăng ký. Vui lòng thử lại. Chi tiết lỗi: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                // Ghi log lỗi chi tiết
            }
        }
        
        void Application_Start(object sender, EventArgs e)
        {
            // ... các code khởi tạo khác nếu có

            // **THÊM ĐOẠN NÀY ĐỂ KHẮC PHỤC LỖI**
            System.Web.UI.ScriptManager.ScriptResourceMapping.AddDefinition(
                "jquery",
                new System.Web.UI.ScriptResourceDefinition
                {
                    Path = "~/Scripts/jquery-3.7.1.min.js" // Thay thế bằng đường dẫn thực tế đến file jQuery của bạn
                });
        }
    }
}