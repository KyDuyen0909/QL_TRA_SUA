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
                LoadDataDropDownList();
            }
            LoadDataAccount();

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

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[5].Attributes.Add("onclick", "javascript:return confirm('Xóa thiệt không?');");

        }

        protected void butAdd_Click(object sender, EventArgs e)
        {

        }
    }
}