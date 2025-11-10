using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cua_Hang_Tra_Sua;

namespace QL_QUAN_TRA_SUA
{
    public partial class LoginList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Chỉ nạp dữ liệu DropDownList lần đầu
                LoadDataDropDownList();
                // Nạp dữ liệu GridView lần đầu
                LoadDataAccount();
            }
            // BỎ nạp LoadDataAccount() ở đây. Việc này sẽ được xử lý trong các sự kiện PostBack khác. 

            // Nếu bạn muốn nạp lại GridView khi ddlPhanQuyen thay đổi, hãy làm trong sự kiện của nó:
            // Protected void DropDownList1_SelectedIndexChanged(...) { LoadDataAccount(); }

        }
        /// <summary>
        /// Tải các phân quyền duy nhất (ví dụ: Quản Trị, Khách Hàng) 
        /// từ bảng Tai_Khoan vào DropDownList.
        /// </summary>
        private void LoadDataDropDownList()
        {
            // 1. Khởi tạo DataContext
            // (Giả sử bạn đang dùng NEWSDataContext như các ví dụ trước)
            Cua_Hang_Tra_SuaDataContext context = new Cua_Hang_Tra_SuaDataContext();

            // 2. Truy vấn để lấy các phân quyền duy nhất (Distinct)
            // Chúng ta tạo một đối tượng tạm thời 'new { Quyen = ... }' 
            // để dễ dàng gán DataTextField và DataValueField.
            var phanQuyenList = context.Tai_Khoans
                                       .Select(tk => new { Quyen = tk.Phan_quyen })
                                       .Distinct()
                                       .OrderBy(q => q.Quyen); // Sắp xếp A-Z

            // 3. Gán dữ liệu cho DropDownList (Giả sử ID là ddlPhanQuyen)
            ddlPhanQuyen.DataSource = phanQuyenList.ToList();

            // 4. Chỉ định cột để hiển thị Text và cột chứa Value
            // (Trong trường hợp này, cả hai đều là tên phân quyền)
            ddlPhanQuyen.DataTextField = "Quyen";
            ddlPhanQuyen.DataValueField = "Quyen";

            // 5. Liên kết dữ liệu
            ddlPhanQuyen.DataBind();

            // 6. (Tùy chọn) Thêm một mục "Chọn" hoặc "Tất cả" ở đầu danh sách
            ddlPhanQuyen.Items.Insert(0, new ListItem("-- Chọn phân quyền --", ""));
        }
        /// <summary>
        /// Tải danh sách tài khoản vào GridViewAccounts, 
        /// lọc theo phân quyền được chọn trong ddlPhanQuyen.
        /// </summary>
        /// <summary>
        /// Tải danh sách tài khoản vào GridViewAccounts, 
        /// lọc theo phân quyền được chọn trong ddlPhanQuyen.
        /// </summary>
        private void LoadDataAccount()
        {
            try
            {
                // 1. Lấy phân quyền được chọn từ DropDownList
                // (Giả sử ID DropDownList là ddlPhanQuyen)
                string selectedQuyen = Convert.ToString(ddlPhanQuyen.SelectedValue);

                // 2. Khởi tạo DataContext
                Cua_Hang_Tra_SuaDataContext context = new Cua_Hang_Tra_SuaDataContext();

                // 3. Lấy IQueryable cơ sở của bảng Tai_Khoan
                // (Giả định tên bảng trong DBML là Tai_Khoans)
                var query = context.Tai_Khoans.AsQueryable();

                // 4. Áp dụng bộ lọc NẾU một phân quyền cụ thể được chọn
                // (Nếu SelectedValue = "", nghĩa là người dùng chọn "-- Chọn phân quyền --")
                if (!string.IsNullOrEmpty(selectedQuyen))
                {
                    query = query.Where(tk => tk.Phan_quyen == selectedQuyen);
                }

                // 5. Gán dữ liệu cho GridView (Giả sử ID là GridViewAccounts)
                // Sắp xếp theo Họ và Tên (thay vì Số điện thoại)
                GridViewAccounts.DataSource = query.OrderBy(tk => tk.Ho_va_ten).ToList();
                GridViewAccounts.DataBind();
            }
            catch (Exception ex)
            {
                // Bạn nên có một Label (ví dụ: lblMessage) để hiển thị lỗi nếu có
                 lblMessage.Text = "Lỗi tải danh sách tài khoản: " + ex.Message;
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Lấy số điện thoại từ khóa chính của hàng được chọn
                string soDienThoai = e.Keys["So_dien_thoai"].ToString();

                // Khởi tạo kết nối đến DB
                Cua_Hang_Tra_SuaDataContext context = new Cua_Hang_Tra_SuaDataContext();

                // Tìm tài khoản cần xóa theo số điện thoại
                Tai_Khoan taiKhoan = context.Tai_Khoans.SingleOrDefault(tk => tk.So_dien_thoai == soDienThoai);

                if (taiKhoan != null)
                {
                    // Xóa và lưu thay đổi
                    context.Tai_Khoans.DeleteOnSubmit(taiKhoan);
                    context.SubmitChanges();

                    // Tải lại danh sách sau khi xóa
                    LoadDataAccount();
                    lblMessage.Text = "✅ Xóa tài khoản thành công.";
                }
                else
                {
                    lblMessage.Text = "⚠️ Không tìm thấy tài khoản cần xóa.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Lỗi khi xóa tài khoản: " + ex.Message;
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Khi DropDownList thay đổi, ta nạp lại GridView theo lựa chọn mới
            LoadDataAccount();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[5].Attributes.Add("onclick", "javascript:return confirm('Xóa thiệt không?');");

        }

        protected void butAdd_Click(object sender, EventArgs e)
        {

        }

        protected void GridViewAccounts_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void butDelete_Click(object sender, EventArgs e)
        {
            try
            {
                Cua_Hang_Tra_SuaDataContext context = new Cua_Hang_Tra_SuaDataContext();
                int soTaiKhoanDaXoa = 0;

                for (int i = 0; i < GridViewAccounts.Rows.Count; i++)
                {
                    // 1. Tìm CheckBox. Tên ID của CheckBox trong ItemTemplate là "ckhDelete".
                    // FindControl phải được gọi trên đối tượng GridViewRow hoặc TemplateField
                    // Nếu CheckBox nằm trong TemplateField cuối cùng, ta tìm trực tiếp trên Row.
                    CheckBox chk = (CheckBox)GridViewAccounts.Rows[i].FindControl("ckhDelete");

                    if (chk != null && chk.Checked)
                    {
                        // 2. Lấy khóa chính (So_dien_thoai) bằng DataKeys - CÁCH CHÍNH XÁC
                        // Đảm bảo GridViewAccounts.DataKeyNames đã đặt là "So_dien_thoai" trong .aspx
                        if (GridViewAccounts.DataKeys[i] != null && GridViewAccounts.DataKeys[i].Value != null)
                        {
                            string soDienThoai = GridViewAccounts.DataKeys[i].Value.ToString();

                            // 3. Tìm và đánh dấu xóa tài khoản
                            Tai_Khoan tk = context.Tai_Khoans.SingleOrDefault(t => t.So_dien_thoai == soDienThoai);

                            if (tk != null)
                            {
                                context.Tai_Khoans.DeleteOnSubmit(tk);
                                soTaiKhoanDaXoa++;
                            }
                        }
                    }
                }

                // 4. Lưu thay đổi vào cơ sở dữ liệu
                if (soTaiKhoanDaXoa > 0)
                {
                    context.SubmitChanges();
                    lblMessage.Text = $"✅ Đã xóa thành công {soTaiKhoanDaXoa} tài khoản được chọn.";
                }
                else
                {
                    // Nếu không có tài khoản nào được chọn, không cần SubmitChanges
                    lblMessage.Text = "⚠️ Vui lòng chọn ít nhất một tài khoản để xóa.";
                }

                // 5. Tải lại danh sách
                LoadDataAccount();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Lỗi khi xóa hàng loạt: " + ex.Message;
            }
        }

        // Phương thức xử lý sự kiện cho nút "Đăng Ký Tài Khoản Mới"
        protected void btnRegisterAccount_Click(object sender, EventArgs e)
        {
            // Chuyển hướng đến trang Đăng ký (RegisterAccount.aspx)
            Response.Redirect("RegisterAccount.aspx");
        }

        // Phương thức xử lý sự kiện cho nút "Đăng Nhập Tài Khoản"
        protected void btnLoginPage_Click(object sender, EventArgs e)
        {
            // Chuyển hướng đến trang Đăng nhập (Login.aspx)
            Response.Redirect("Login.aspx");
        }
    }
}