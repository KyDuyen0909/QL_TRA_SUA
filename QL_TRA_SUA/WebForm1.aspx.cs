using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Xml.Linq;

namespace QL_TRA_SUA
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        // Chuỗi kết nối database
        private string connectionString = @"Data Source=DESKTOP-EXAMPLE\KY_DUYEN\SQLEXPRESS;Initial Catalog=Cua_Hang_Tra_Sua;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // FIX LỖI: UnobtrusiveValidationMode requires a ScriptResourceMapping
            Page.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                // Khởi tạo dữ liệu khi trang load lần đầu
                LoadInitialData();
            }
        }

        // Phương thức khởi tạo dữ liệu
        private void LoadInitialData()
        {
            try
            {
                // Log truy cập trang (tùy chọn - có thể comment nếu chưa có bảng)
                LogPageVisit();
            }
            catch (Exception ex)
            {
                // Log lỗi
                System.Diagnostics.Debug.WriteLine($"LoadInitialData error: {ex.Message}");
            }
        }

       
        // Lấy IP của người dùng
        private string GetUserIP()
        {
            string ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(ip))
            {
                ip = Request.ServerVariables["REMOTE_ADDR"];
            }
            return ip ?? "Unknown";
        }

        // Log truy cập trang (TÙY CHỌN - cần tạo bảng PageVisits trước)
        private void LogPageVisit()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO PageVisits (PageName, VisitTime, IPAddress, UserAgent) 
                                   VALUES (@PageName, @VisitTime, @IPAddress, @UserAgent)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@PageName", "HomePage");
                        cmd.Parameters.AddWithValue("@VisitTime", DateTime.Now);
                        cmd.Parameters.AddWithValue("@IPAddress", GetUserIP());
                        cmd.Parameters.AddWithValue("@UserAgent", Request.UserAgent ?? "Unknown");

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Log error: {ex.Message}");
            }
        }

        // Phương thức lấy danh sách sản phẩm từ database
        public DataTable GetProducts()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT ID_SP, Ten_san_pham, Mo_ta_san_pham, Gia_co_ban, Hinh_anh, Trang_thai 
                                   FROM San_Pham 
                                   WHERE Trang_thai = N'Còn hàng' 
                                   ORDER BY Ten_san_pham";

                    using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                    {
                        da.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"GetProducts error: {ex.Message}");
            }

            return dt;
        }

        // Phương thức lấy sản phẩm nổi bật (TOP 5)
        public DataTable GetPopularProducts()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT TOP 5 ID_SP, Ten_san_pham, Mo_ta_san_pham, Gia_co_ban, Hinh_anh 
                                   FROM San_Pham 
                                   WHERE Trang_thai = N'Còn hàng' 
                                   ORDER BY ID_SP DESC";

                    using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                    {
                        da.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"GetPopularProducts error: {ex.Message}");
            }

            return dt;
        }

        // Phương thức lấy thông tin tài khoản
        public DataTable GetAccountInfo(string phone)
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT Ho_va_ten, So_dien_thoai, Dia_chi, Phan_quyen 
                                   FROM Tai_Khoan 
                                   WHERE So_dien_thoai = @Phone";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"GetAccountInfo error: {ex.Message}");
            }

            return dt;
        }

        // Phương thức kiểm tra đăng nhập
        public bool CheckLogin(string phone, string password)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT COUNT(*) 
                                   FROM Tai_Khoan 
                                   WHERE So_dien_thoai = @Phone AND Mat_khau = @Password";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@Password", password);

                        conn.Open();
                        int count = (int)cmd.ExecuteScalar();
                        return count > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"CheckLogin error: {ex.Message}");
                return false;
            }
        }

        // Phương thức thêm sản phẩm vào giỏ hàng
        public bool AddToCart(string phone, int productId, int quantity, string note)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Lấy giá sản phẩm
                    decimal price = GetProductPrice(productId);

                    string query = @"INSERT INTO Gio_Hang (So_dien_thoai, ID_SP, So_luong, Gia_tai_thoi_diem, Ghi_chu, Ngay_them) 
                                   VALUES (@Phone, @ProductId, @Quantity, @Price, @Note, @Date)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        cmd.Parameters.AddWithValue("@Quantity", quantity);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@Note", note ?? "");
                        cmd.Parameters.AddWithValue("@Date", DateTime.Now);

                        conn.Open();
                        int result = cmd.ExecuteNonQuery();
                        return result > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"AddToCart error: {ex.Message}");
                return false;
            }
        }

        // Lấy giá sản phẩm
        private decimal GetProductPrice(int productId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT Gia_co_ban FROM San_Pham WHERE ID_SP = @ProductId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        return result != null ? Convert.ToDecimal(result) : 0;
                    }
                }
            }
            catch
            {
                return 0;
            }
        }
    }
}