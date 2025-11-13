using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration; // Thêm thư viện này để đọc web.config

namespace QL_TRA_SUA
{
    // Đổi tên Class thành QL_DH nếu tên file aspx.cs của bạn là QL_DH.aspx.cs
    public partial class QL_DONHANG : System.Web.UI.Page
    {
        // Khởi tạo chuỗi kết nối an toàn (Sử dụng toán tử ?? để tránh NullReferenceException)
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["QLTSConnectionString"]?.ConnectionString ?? "";

        // Giả định tên GridView của bạn là gvDanhSachDH
        protected GridView gvDanhSachDH; // Cần được khai báo trong QL_DH.aspx

        // Giả định tên các button tab
        protected LinkButton btnPending;
        protected LinkButton btnHistory;

        // Giả định Panel chứa danh sách đơn hàng
        protected Panel pnlPendingOrders;
        protected Panel pnlHistoryOrders;


        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra lỗi chuỗi kết nối
            if (string.IsNullOrEmpty(connectionString))
            {
                // Thay thế bằng một Label hoặc thông báo lỗi phù hợp trên UI
                // Response.Write("<script>alert('Lỗi: Không tìm thấy chuỗi kết nối trong Web.config.');</script>");
                return;
            }

            if (!IsPostBack)
            {
                // Mặc định load tab Đơn hàng Đang chờ (Trạng thái = false/Pending)
                Load_Data(false);
                UpdateTabStyles(false); // Cập nhật style cho tab
            }
        }

        /// <summary>
        /// Lấy dữ liệu đơn hàng và hiển thị lên GridView
        /// </summary>
        /// <param name="isHistory">True nếu lấy đơn hàng đã xử lý, False nếu lấy đơn hàng đang chờ</param>
        private void Load_Data(bool isHistory)
        {
            // Thiết lập điều kiện trạng thái (0: Đang chờ, 1: Đã xử lý)
            int trangThai = isHistory ? 1 : 0;

            string sql = $@"
                SELECT 
                    ID_DH, 
                    Ten_khach_hang, 
                    Dia_chi, 
                    Tong_tien, 
                    Ngay_dat_hang,
                    Trang_thai_xu_ly
                FROM Don_Hang 
                WHERE Trang_thai_xu_ly = @TrangThai";

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@TrangThai", trangThai);
                        con.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Gán dữ liệu cho GridView
                        if (isHistory)
                        {
                            // pnlHistoryOrders.Visible = true;
                            // pnlPendingOrders.Visible = false;
                            // gvDanhSachDH_History.DataSource = dt; // Cần có GridView khác cho History
                            // gvDanhSachDH_History.DataBind(); 
                            // Tạm thời, tôi sẽ giả định bạn chỉ dùng 1 GridView 
                            gvDanhSachDH.DataSource = dt;
                            gvDanhSachDH.DataBind();
                        }
                        else
                        {
                            // pnlHistoryOrders.Visible = false;
                            // pnlPendingOrders.Visible = true;
                            gvDanhSachDH.DataSource = dt;
                            gvDanhSachDH.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // In ra lỗi chi tiết để debug
                Response.Write($"<script>console.error('Lỗi khi tải dữ liệu: {ex.Message}');</script>");
                // Hiển thị thông báo lỗi thân thiện hơn cho người dùng
                // lblErrorMessage.Text = "Không thể tải dữ liệu đơn hàng.";
            }
        }

        /// <summary>
        /// Xử lý sự kiện khi người dùng click vào tab (LinkButton)
        /// </summary>
        protected void Tab_Click(object sender, EventArgs e)
        {
            LinkButton btn = sender as LinkButton;
            if (btn == null) return;

            bool isHistory = (btn.CommandName == "History");

            // 1. Cập nhật trạng thái hiển thị của Panel và tab styles
            pnlPendingOrders.Visible = !isHistory;
            pnlHistoryOrders.Visible = isHistory;
            UpdateTabStyles(isHistory);

            // 2. Load dữ liệu tương ứng
            Load_Data(isHistory);
        }

        /// <summary>
        /// Cập nhật CSS cho các nút Tab để thể hiện tab đang được chọn
        /// </summary>
        /// <param name="isHistorySelected">True nếu tab Lịch sử (History) được chọn</param>
        private void UpdateTabStyles(bool isHistorySelected)
        {
            // Đặt CSS cho tab Đang chờ
            if (btnPending != null)
            {
                btnPending.CssClass = isHistorySelected
                    ? "btn btn-outline-primary"
                    : "btn btn-primary"; // Primary là tab đang active
            }

            // Đặt CSS cho tab Lịch sử
            if (btnHistory != null)
            {
                btnHistory.CssClass = isHistorySelected
                    ? "btn btn-primary" // Primary là tab đang active
                    : "btn btn-outline-primary";
            }
        }

        /// <summary>
        /// Xử lý sự kiện khi click nút "Xử lý" đơn hàng
        /// </summary>
        protected void gvDanhSachDH_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "XuLy")
            {
                // Lấy ID_DH từ CommandArgument
                int idDh = Convert.ToInt32(e.CommandArgument);

                // Cập nhật trạng thái đơn hàng trong CSDL
                Update_OrderStatus(idDh, 1); // 1: Đã xử lý

                // Sau khi xử lý, reload lại tab Đang chờ
                Load_Data(false);
                UpdateTabStyles(false);
            }
        }

        /// <summary>
        /// Hàm cập nhật trạng thái đơn hàng trong CSDL
        /// </summary>
        private void Update_OrderStatus(int orderId, int status)
        {
            string sql = "UPDATE Don_Hang SET Trang_thai_xu_ly = @Status WHERE ID_DH = @ID";
            try
            {
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
            catch (Exception ex)
            {
                Response.Write($"<script>console.error('Lỗi khi cập nhật trạng thái đơn hàng: {ex.Message}');</script>");
            }
        }
        protected void Filter_Data(object sender, EventArgs e)
        {
            // Lấy giá trị được chọn từ DropDownList
            DropDownList ddl = (DropDownList)sender;
            if (int.TryParse(ddl.SelectedValue, out int trangThai))
            {
                // Gọi hàm tải dữ liệu với trạng thái mới
                BindOrders(trangThai);
                UpdateTabStyles(trangThai); // Cập nhật style nếu cần
            }
        }

        private void UpdateTabStyles(int trangThai)
        {
            throw new NotImplementedException();
        }

        private void BindOrders(int trangThai)
        {
            throw new NotImplementedException();
        }
    }
}