using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;

namespace QL_TRA_SUA
{
    public partial class Gio_Hang : System.Web.UI.Page
    {
        // -------------------------------------------------------------
        // TODO: THAY THẾ PHẦN NÀY BẰNG CODE KẾT NỐI DATABASE THỰC TẾ
        // -------------------------------------------------------------

        // Giả lập Dữ liệu Giỏ Hàng bằng DataTable (Thay thế bằng DB)
        private DataTable GioHang
        {
            get
            {
                // Sử dụng Session để lưu trữ giỏ hàng giả lập
                if (Session["GioHang"] == null)
                {
                    // Khởi tạo cấu trúc bảng Giỏ Hàng
                    DataTable dt = new DataTable();
                    dt.Columns.Add("ID_GH", typeof(int));        // ID Giỏ Hàng (Key)
                    dt.Columns.Add("Ten_san_pham", typeof(string));
                    dt.Columns.Add("So_luong", typeof(int));
                    dt.Columns.Add("Gia_tai_thoi_diem", typeof(decimal));
                    dt.Columns.Add("Hinh_anh", typeof(string));    // Tên file hình ảnh
                    dt.Columns.Add("Ghi_chu", typeof(string));
                    dt.Columns.Add("Tong_thanh_tien", typeof(decimal), "So_luong * Gia_tai_thoi_diem"); // Cột tính toán
                    dt.PrimaryKey = new DataColumn[] { dt.Columns["ID_GH"] };

                    // Thêm dữ liệu mẫu (đã được sửa lại để khớp với hình ảnh mẫu)
                    dt.Rows.Add(1, "Trà Sữa Truyền Thống", 2, 25000, "ts.jpg", "Ít đường, trân châu");
                    dt.Rows.Add(2, "Trà Sữa Socola", 1, 30000, "sôcola.jpg", "Thêm topping socola");
                    dt.Rows.Add(3, "Trà Đào Cam Sả", 1, 35000, "camsa.jpg", "Tươi mát, ít đường");

                    Session["GioHang"] = dt;
                }
                return (DataTable)Session["GioHang"];
            }
            set
            {
                Session["GioHang"] = value;
            }
        }

        // -------------------------------------------------------------
        // KẾT THÚC PHẦN GIẢ LẬP DỮ LIỆU
        // -------------------------------------------------------------

        protected void Page_Load(object sender, EventArgs e)
        {
            // Thiết lập thông báo lỗi/thành công ban đầu (giả lập)
            if (lblMessage == null)
            {
                // Tạo một Label giả lập nếu nó chưa tồn tại trên trang ASPX
                lblMessage = new Label() { ID = "lblMessage", ForeColor = System.Drawing.Color.Red };
                this.Controls.Add(lblMessage);
            }
            if (lblThongBaoTrong == null)
            {
                lblThongBaoTrong = new Label() { ID = "lblThongBaoTrong", Text = "Giỏ hàng trống!" };
                this.Controls.Add(lblThongBaoTrong);
            }
            if (!IsPostBack)
            {
                // Giả định UserID và Số điện thoại được lấy từ Session/Database khi đăng nhập
                // TODO: Thay thế bằng dữ liệu người dùng thực tế
                txtSoDienThoai.Text = "0987654321";
                txtDiaChiGiaoHang.Text = "Đồng Tháp";
                LoadGioHang();
            }

            // Tính toán tổng tiền mỗi lần load trang (ĐẢM BẢO TÍNH TOÁN LẠI SAU MỖI POSTBACK)
            CalculateTotal();
        }

        private void LoadGioHang()
        {
            DataTable dtGioHang = GioHang;

            if (dtGioHang.Rows.Count == 0)
            {
                // gvGioHang.Visible = false; // Bỏ comment này nếu bạn đã có control này trên trang
                // lblThongBaoTrong.Visible = true;
                lblTongTien.Text = "0 VNĐ";
            }
            else
            {
                gvGioHang.DataSource = dtGioHang;
                gvGioHang.DataBind();
                // gvGioHang.Visible = true;
                // lblThongBaoTrong.Visible = false;
            }
        }

        // HÀM QUAN TRỌNG: Chỉ tính tổng tiền của các mục đã được Check
        private void CalculateTotal()
        {
            decimal totalAmount = 0;

            // Duyệt qua từng hàng trong GridView
            foreach (GridViewRow row in gvGioHang.Rows)
            {
                // Tìm CheckBox đã chọn
                CheckBox chk = (CheckBox)row.FindControl("chkChonThanhToan");

                // CHỈ CỘNG TIỀN NẾU CHECKBOX ĐƯỢC CHỌN
                if (chk != null && chk.Checked)
                {
                    // Lấy ID_GH để tìm trong DataTable gốc (vì GridView chỉ hiển thị)
                    int idGh = (int)gvGioHang.DataKeys[row.RowIndex].Value;
                    DataRow dr = GioHang.Rows.Find(idGh);

                    if (dr != null)
                    {
                        try
                        {
                            int soLuong = Convert.ToInt32(dr["So_luong"]);
                            decimal donGia = Convert.ToDecimal(dr["Gia_tai_thoi_diem"]);
                            totalAmount += soLuong * donGia;
                        }
                        catch (Exception ex)
                        {
                            // Ghi log lỗi nếu có vấn đề về định dạng số
                            lblMessage.Text = "Lỗi tính toán: " + ex.Message;
                        }
                    }
                }
            }

            lblTongTien.Text = string.Format("{0:N0} VNĐ", totalAmount);
        }

        // Sự kiện xảy ra khi người dùng click vào LinkButton trong cột Hành Động
        protected void gvGioHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Lấy ID_GH của sản phẩm được chọn
            int idGh = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "XoaItem")
            {
                XoaSanPham(idGh);
            }
            else if (e.CommandName == "CapNhatItem")
            {
                // Lấy chỉ số hàng (Row Index)
                int rowIndex = -1;
                for (int i = 0; i < gvGioHang.Rows.Count; i++)
                {
                    if (Convert.ToInt32(gvGioHang.DataKeys[i].Value) == idGh)
                    {
                        rowIndex = i;
                        break;
                    }
                }

                if (rowIndex >= 0)
                {
                    CapNhatSanPham(rowIndex, idGh);
                }
            }

            // Tải lại giỏ hàng và tính toán tổng tiền sau khi thao tác
            LoadGioHang();
            CalculateTotal();
        }

        private void XoaSanPham(int idGh)
        {
            try
            {
                DataRow dr = GioHang.Rows.Find(idGh);
                if (dr != null)
                {
                    dr.Delete();
                    GioHang.AcceptChanges(); // Xác nhận xóa trong DataTable giả lập
                    lblMessage.Text = $"Đã xóa sản phẩm ID {idGh} khỏi giỏ hàng.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi xóa sản phẩm: " + ex.Message;
            }
        }

        private void CapNhatSanPham(int rowIndex, int idGh)
        {
            GridViewRow row = gvGioHang.Rows[rowIndex];

            // Tìm TextBox Số Lượng
            TextBox txtSoLuong = (TextBox)row.FindControl("txtSoLuong");
            // Tìm TextBox Ghi Chú
            TextBox txtGhiChu = (TextBox)row.FindControl("txtGhiChuItem");

            if (txtSoLuong != null && txtGhiChu != null)
            {
                if (int.TryParse(txtSoLuong.Text, out int newSoLuong) && newSoLuong > 0)
                {
                    try
                    {
                        DataRow dr = GioHang.Rows.Find(idGh);
                        if (dr != null)
                        {
                            // Cập nhật dữ liệu trong DataTable giả lập
                            dr["So_luong"] = newSoLuong;
                            dr["Ghi_chu"] = txtGhiChu.Text;
                            GioHang.AcceptChanges();
                            lblMessage.Text = $"Đã cập nhật số lượng ({newSoLuong}) và ghi chú cho sản phẩm ID {idGh}.";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Lỗi khi cập nhật sản phẩm: " + ex.Message;
                    }
                }
                else
                {
                    lblMessage.Text = "Số lượng không hợp lệ. Vui lòng nhập số nguyên dương.";
                }
            }
            else
            {
                lblMessage.Text = "Không tìm thấy điều khiển cập nhật trong hàng.";
            }
        }


        // Xử lý sự kiện Đặt Hàng
        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            // Code Đặt Hàng giữ nguyên...
            // 1. Kiểm tra thông tin bắt buộc
            if (string.IsNullOrWhiteSpace(txtDiaChiGiaoHang.Text))
            {
                lblMessage.Text = "Vui lòng nhập Địa chỉ giao hàng.";
                return;
            }

            // Tạo một DataTable mới để lưu trữ các sản phẩm được chọn để đặt hàng
            DataTable dtDonHangItems = GioHang.Clone();
            decimal tongTienDonHang = 0;

            // 2. Duyệt qua GridView để lấy các mục đã được chọn
            for (int i = 0; i < gvGioHang.Rows.Count; i++)
            {
                GridViewRow row = gvGioHang.Rows[i];
                CheckBox chk = (CheckBox)row.FindControl("chkChonThanhToan");

                if (chk != null && chk.Checked)
                {
                    int idGh = (int)gvGioHang.DataKeys[i].Value;
                    DataRow drGioHang = GioHang.Rows.Find(idGh);

                    if (drGioHang != null)
                    {
                        // Thêm hàng đã chọn vào DataTable của Đơn Hàng
                        dtDonHangItems.ImportRow(drGioHang);

                        // Cập nhật tổng tiền
                        int soLuong = Convert.ToInt32(drGioHang["So_luong"]);
                        decimal donGia = Convert.ToDecimal(drGioHang["Gia_tai_thoi_diem"]);
                        tongTienDonHang += soLuong * donGia;
                    }
                }
            }

            // 3. Kiểm tra xem có sản phẩm nào được chọn không
            if (dtDonHangItems.Rows.Count == 0)
            {
                lblMessage.Text = "Vui lòng chọn ít nhất một sản phẩm để đặt hàng.";
                return;
            }

            // 4. Tiến hành Lưu Đơn Hàng vào Database (TODO: Thay thế bằng code DB thực tế)
            // GIẢ LẬP: Xóa các mục đã đặt khỏi giỏ hàng giả lập (DataTable)
            foreach (DataRow dr in dtDonHangItems.Rows)
            {
                DataRow drOriginal = GioHang.Rows.Find(dr["ID_GH"]);
                if (drOriginal != null)
                {
                    drOriginal.Delete();
                }
            }
            GioHang.AcceptChanges();


            // 5. Thông báo và làm sạch
            lblMessage.Text = $"ĐẶT HÀNG THÀNH CÔNG! Đơn hàng gồm {dtDonHangItems.Rows.Count} sản phẩm, Tổng tiền: {string.Format("{0:N0} VNĐ", tongTienDonHang)}. Cảm ơn quý khách!";
            txtDiaChiGiaoHang.Text = "";
            txtGhiChuChung.Text = "";

            // Tải lại giỏ hàng (lúc này sẽ trống)
            LoadGioHang();
            CalculateTotal();
        }

        // Sự kiện này giúp tính toán lại tổng tiền khi trạng thái CheckBox thay đổi
        protected void gvGioHang_DataBound(object sender, EventArgs e)
        {
            // Gán sự kiện cho CheckBox sau khi DataBind để sự kiện postback khi thay đổi
            foreach (GridViewRow row in gvGioHang.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkChonThanhToan");
                if (chk != null)
                {
                    // ĐẢM BẢO CHK GỬI POSTBACK KHI BỊ BỎ CHỌN HOẶC CHỌN
                    chk.AutoPostBack = true;

                    // Gán sự kiện cho CheckBox
                    // NOTE: Bạn đã gán sự kiện này ở bên ngoài class Gio_Hang trong code gốc.
                    // Nếu bạn không thể gán trực tiếp qua thuộc tính 'OnCheckedChanged' trong ASPX
                    // thì cách gán sự kiện programmatic (như dưới) là bắt buộc.
                    chk.CheckedChanged += ChkChonThanhToan_CheckedChanged;
                }
            }
        }

        // Xử lý sự kiện CheckBox thay đổi để tính lại tổng tiền
        protected void ChkChonThanhToan_CheckedChanged(object sender, EventArgs e)
        {
            // Chỉ cần gọi lại hàm tính tổng tiền
            // Vì CalculateTotal() đã được gọi ở Page_Load, nên bạn có thể không cần gọi lại ở đây
            // Nhưng gọi lại ở đây đảm bảo tính toán được refresh ngay lập tức sau PostBack từ CheckBox.
            CalculateTotal();
        }

        // CÁC CONTROL KHAI BÁO GIẢ LẬP ĐỂ CODE CÓ THỂ BIÊN DỊCH
        protected GridView gvGioHang = new GridView() { ID = "gvGioHang" };
        protected Label lblTongTien = new Label() { ID = "lblTongTien" };
        protected Label lblMessage = new Label() { ID = "lblMessage" };
        protected Label lblThongBaoTrong = new Label() { ID = "lblThongBaoTrong" };
        protected TextBox txtSoDienThoai = new TextBox() { ID = "txtSoDienThoai" };
        protected TextBox txtDiaChiGiaoHang = new TextBox() { ID = "txtDiaChiGiaoHang" };
        protected TextBox txtGhiChuChung = new TextBox() { ID = "txtGhiChuChung" };
        protected DropDownList ddlHinhThucDatDon = new DropDownList() { ID = "ddlHinhThucDatDon" };
    }
}