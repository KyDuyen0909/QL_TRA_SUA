using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.UI;

namespace QL_TRA_SUA
{
    // Tên class phải khớp với 'Inherits' trong file ASPX
    public partial class QL_DONHANG : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["QLTSConnectionString"]?.ConnectionString ?? "";

        // Các controls đã được liên kết từ file .designer.cs
        // (Không cần khai báo lại ở đây nếu đã có trong file .designer.cs)

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(connectionString))
            {
                ShowNotification("Lỗi: Không tìm thấy chuỗi kết nối 'QLTSConnectionString' trong Web.config.", "error");
                return;
            }

            if (!IsPostBack)
            {
                // Mặc định tải tab Đang chờ (Trạng thái 0)
                // Giá trị mặc định của ddlStatusPending là "Tất cả Đơn Chờ"
                BindOrders(0, ddlStatusPending.SelectedValue, txtSearchPending.Text);
                UpdateTabStyles(0);
            }
        }

        /// <summary>
        /// Hàm hiển thị thông báo JS (Giữ nguyên)
        /// </summary>
        private void ShowNotification(string message, string type)
        {
            string safeMessage = message.Replace("'", "\\'");
            string script = $"showToastNotification('{type}', '{safeMessage}');";
            // ScriptManager1 được tham chiếu từ file .designer.cs
            ScriptManager.RegisterStartupScript(this, GetType(), "StatusAlert", script, true);
        }

        // --- HÀM XỬ LÝ SỰ KIỆN TỪ .ASPX ---

        /// <summary>
        /// Xử lý khi nhấn 2 tab "Đang chờ" hoặc "Lịch sử"
        /// </summary>
        protected void Tab_Click(object sender, EventArgs e)
        {
            LinkButton btn = sender as LinkButton;
            if (btn == null) return;

            // 0 = Pending, 1 = History
            int newStatusType = (btn.CommandName == "History") ? 1 : 0;

            UpdateTabVisibility(newStatusType);
            UpdateTabStyles(newStatusType);

            // Tải dữ liệu cho tab tương ứng
            if (newStatusType == 0)
            {
                BindOrders(0, ddlStatusPending.SelectedValue, txtSearchPending.Text);
            }
            else
            {
                BindOrders(1, ddlStatusHistory.SelectedValue, txtSearchHistory.Text);
            }
        }

        /// <summary>
        /// Xử lý lọc cho tab Đang Chờ
        /// (Khớp với OnClick và OnSelectedIndexChanged trong ASPX)
        /// </summary>
        protected void Filter_Pending_Click(object sender, EventArgs e)
        {
            // Lọc tab Pending (trạng thái 0)
            BindOrders(0, ddlStatusPending.SelectedValue, txtSearchPending.Text);
            UpdateTabStyles(0);
        }

        /// <summary>
        /// Xử lý lọc cho tab Lịch Sử
        /// (Khớp với OnClick và OnSelectedIndexChanged trong ASPX)
        /// </summary>
        protected void Filter_History_Click(object sender, EventArgs e)
        {
            // Lọc tab History (trạng thái 1)
            BindOrders(1, ddlStatusHistory.SelectedValue, txtSearchHistory.Text);
            UpdateTabStyles(1);
        }

        /// <summary>
        /// Xử lý các nút trong GridView (Xác nhận, Hủy, Chi tiết)
        /// </summary>
        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idDh = 0;
            if (!int.TryParse(e.CommandArgument.ToString(), out idDh))
            {
                ShowNotification("Lỗi: ID đơn hàng không hợp lệ.", "error");
                return;
            }

            try
            {
                if (e.CommandName == "ConfirmOrder")
                {
                    Update_OrderStatus(idDh, "Đang giao");
                    ShowNotification($"Đơn hàng #{idDh} đã được xác nhận và đang giao.", "success");
                    BindOrders(0, ddlStatusPending.SelectedValue, txtSearchPending.Text);
                }
                else if (e.CommandName == "CancelOrder")
                {
                    Update_OrderStatus(idDh, "Đã hủy");
                    ShowNotification($"Đơn hàng #{idDh} đã được hủy.", "success");
                    BindOrders(0, ddlStatusPending.SelectedValue, txtSearchPending.Text);
                }
                else if (e.CommandName == "ViewDetail")
                {
                    LoadDetailModal(idDh);
                    pnlDetailModal.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ShowNotification($"Lỗi xử lý đơn hàng #{idDh}: {ex.Message}", "error");
            }
        }

        /// <summary>
        /// Xử lý màu mè cho Trạng thái trong GridView
        /// </summary>
        protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Tìm Label trạng thái (lblStatusPending hoặc lblStatusHistory)
                Label lblStatus = (Label)e.Row.FindControl("lblStatusPending") ?? (Label)e.Row.FindControl("lblStatusHistory");

                if (lblStatus != null)
                {
                    string status = lblStatus.Text;
                    string cssClass = "status-badge ";

                    switch (status.ToLower())
                    {
                        case "chờ xác nhận":
                            cssClass += "status-pending"; // Vàng
                            break;
                        case "đang giao":
                            cssClass += "status-shipping"; // Xanh dương
                            break;
                        case "hoàn thành":
                            cssClass += "status-completed"; // Xanh lá
                            break;
                        case "đã hủy":
                            cssClass += "status-cancelled"; // Đỏ
                            break;
                        default:
                            cssClass += "bg-gray-400 text-gray-800"; // Xám
                            break;
                    }
                    lblStatus.CssClass = cssClass;
                }
            }
        }

        /// <summary>
        /// Xử lý nút Đóng Modal
        /// </summary>
        protected void btnCloseDetail_Click(object sender, EventArgs e)
        {
            pnlDetailModal.Visible = false;
        }


        // --- CÁC HÀM HỖ TRỢ (ĐÃ SỬA LỖI) ---

        /// <summary>
        /// Hàm chính tải dữ liệu cho GridView (đã sửa)
        /// </summary>
        private void BindOrders(int statusType, string statusFilter, string searchTerm)
        {
            GridView targetGridView = (statusType == 0) ? gvPendingOrders : gvHistoryOrders;
            if (targetGridView == null) return;

            UpdateTabVisibility(statusType);

            string sql = @"
                SELECT ID_DH, Ten_khach_hang, Dia_chi, Tong_tien, Thoi_gian_dat, Trang_thai 
                FROM Don_Hang 
                WHERE 1=1";

            // 1. Lọc theo loại Tab (Pending/History)
            if (statusType == 0) // Đang chờ
            {
                sql += " AND (Trang_thai = 'Chờ xác nhận' OR Trang_thai = 'Đang giao')";
            }
            else // Lịch sử
            {
                sql += " AND (Trang_thai = 'Hoàn thành' OR Trang_thai = 'Đã hủy')";
            }

            // 2. Lọc theo DropDownList (statusFilter)
            // Logic C# này đã khớp với các giá trị "Tất cả Đơn Chờ" và "Tất cả"
            if (statusFilter != "Tất cả" && statusFilter != "Tất cả Đơn Chờ" && statusFilter != "Tất Cả Lịch Sử")
            {
                sql += " AND Trang_thai = @StatusFilter";
            }

            // 3. Lọc theo Search Term
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                sql += " AND (Ten_khach_hang LIKE @SearchTerm OR So_dien_thoai LIKE @SearchTerm OR ID_DH LIKE @SearchTerm)";
            }

            sql += " ORDER BY Thoi_gian_dat DESC";

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        if (statusFilter != "Tất cả" && statusFilter != "Tất cả Đơn Chờ" && statusFilter != "Tất Cả Lịch Sử")
                        {
                            cmd.Parameters.AddWithValue("@StatusFilter", statusFilter);
                        }
                        if (!string.IsNullOrWhiteSpace(searchTerm))
                        {
                            cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
                        }

                        con.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        targetGridView.DataSource = dt;
                        targetGridView.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowNotification($"Lỗi kết nối hoặc tải dữ liệu CSDL: {ex.Message}", "error");
            }
        }

        /// <summary>
        /// Cập nhật CSS cho 2 nút Tab (đã sửa)
        /// </summary>
        private void UpdateTabStyles(int statusType)
        {
            string activeClass = "tab-button px-6 py-3 text-lg font-medium text-blue-700 border-b-2 border-blue-700";
            string inactiveClass = "tab-button px-6 py-3 text-lg font-medium text-gray-500 hover:text-blue-700 hover:border-blue-700";

            bool isHistorySelected = (statusType == 1);

            if (btnTabPending != null)
            {
                btnTabPending.CssClass = isHistorySelected ? inactiveClass : activeClass;
            }
            if (btnTabHistory != null)
            {
                btnTabHistory.CssClass = isHistorySelected ? activeClass : inactiveClass;
            }
        }

        /// <summary>
        /// Ẩn/hiện Panel của 2 tab
        /// </summary>
        private void UpdateTabVisibility(int statusType)
        {
            if (pnlPendingOrders != null) pnlPendingOrders.Visible = (statusType == 0);
            if (pnlHistory != null) pnlHistory.Visible = (statusType == 1);
        }

        /// <summary>
        /// Cập nhật trạng thái đơn hàng trong CSDL
        /// </summary>
        private void Update_OrderStatus(int orderId, string status)
        {
            string sql = "UPDATE Don_Hang SET Trang_thai = @Status WHERE ID_DH = @ID";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@ID", orderId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        /// <summary>
        /// Tải chi tiết đơn hàng lên Modal (đã sửa)
        /// </summary>
        private void LoadDetailModal(int idDh)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // 1. Lấy thông tin đơn hàng chung
                    string sqlOrder = "SELECT * FROM Don_Hang WHERE ID_DH = @ID_DH";
                    using (SqlCommand cmdOrder = new SqlCommand(sqlOrder, con))
                    {
                        cmdOrder.Parameters.AddWithValue("@ID_DH", idDh);
                        SqlDataReader reader = cmdOrder.ExecuteReader();
                        if (reader.Read())
                        {
                            lblOrderID.Text = reader["ID_DH"].ToString();
                            lblCustomerName.Text = reader["Ten_khach_hang"].ToString();
                            lblPhone.Text = reader["So_dien_thoai"].ToString();
                            lblAddress.Text = reader["Dia_chi"].ToString();
                            lblOrderTime.Text = Convert.ToDateTime(reader["Thoi_gian_dat"]).ToString("g");
                            lblStatusDetail.Text = reader["Trang_thai"].ToString();
                            lblNote.Text = reader["Ghi_chu"].ToString();
                            lblTotalDetail.Text = Convert.ToDecimal(reader["Tong_tien"]).ToString("N0") + " VNĐ";
                        }
                        reader.Close();
                    }

                    // 2. Lấy chi tiết sản phẩm
                    string sqlDetail = @"
                        SELECT CT.So_luong, CT.Gia_tai_thoi_diem, CT.Ghi_chu_item, SP.Ten_san_pham 
                        FROM Chi_Tiet_Don_Hang CT
                        JOIN San_Pham SP ON CT.ID_SP = SP.ID_SP
                        WHERE CT.ID_DH = @ID_DH";
                    using (SqlCommand cmdDetail = new SqlCommand(sqlDetail, con))
                    {
                        cmdDetail.Parameters.AddWithValue("@ID_DH", idDh);
                        SqlDataAdapter da = new SqlDataAdapter(cmdDetail);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvOrderDetail.DataSource = dt;
                        gvOrderDetail.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowNotification("Lỗi khi tải chi tiết đơn hàng: " + ex.Message, "error");
            }
        }
    }
}