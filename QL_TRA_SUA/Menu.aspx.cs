using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QL_TRA_SUA
{
    public partial class Menu : System.Web.UI.Page
    {
        // Lấy chuỗi kết nối từ Web.config
        string connectionString = ConfigurationManager.ConnectionStrings["QL_TraSuaConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMenuData();
            }

            // Luôn cập nhật số lượng giỏ hàng mỗi khi tải trang
            UpdateCartCount();
        }

        // 1. LOAD DỮ LIỆU DANH MỤC VÀ SECTION
        private void LoadMenuData()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Giả sử bảng danh mục tên là MENU, cột tên là Ten_menu
                    // Alias "Label" để khớp với <%# Eval("Label") %> bên HTML
                    string query = "SELECT ID_MN, Ten_menu AS Label FROM MENU ORDER BY ID_MN ASC";

                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        // Bind cho thanh menu ngang
                        rptCategories.DataSource = dt;
                        rptCategories.DataBind();

                        // Bind cho các Section dọc (Repeater cha)
                        rptMenuSections.DataSource = dt;
                        rptMenuSections.DataBind();

                        pnlNoData.Visible = false;
                    }
                    else
                    {
                        pnlNoData.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi tải dữ liệu: " + ex.Message;
            }
        }

        // 2. BIND SẢN PHẨM VÀO TỪNG DANH MỤC (NESTED REPEATER)
        protected void rptMenuSections_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Kiểm tra xem item hiện tại có phải là Item hoặc AlternatingItem không
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Tìm Repeater con (rptProducts) bên trong Repeater cha
                Repeater rptProducts = (Repeater)e.Item.FindControl("rptProducts");

                // Lấy ID_MN của dòng hiện tại (DataRowView)
                DataRowView drv = (DataRowView)e.Item.DataItem;
                int categoryId = Convert.ToInt32(drv["ID_MN"]);

                // Truy vấn sản phẩm thuộc danh mục này
                LoadProductsForCategory(rptProducts, categoryId);
            }
        }

        private void LoadProductsForCategory(Repeater rpt, int categoryId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Lấy sản phẩm theo ID_MN
                string query = "SELECT * FROM SAN_PHAM WHERE ID_MN = @ID_MN";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ID_MN", categoryId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rpt.DataSource = dt;
                rpt.DataBind();
            }
        }

        // 3. XỬ LÝ THÊM VÀO GIỎ HÀNG
        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                string idSP = e.CommandArgument.ToString();
                AddToCart(idSP);
            }
        }

        private void AddToCart(string idSP)
        {
            DataTable dtCart;

            // Kiểm tra Session giỏ hàng đã tồn tại chưa
            if (Session["GioHang"] == null)
            {
                dtCart = new DataTable();
                dtCart.Columns.Add("ID_SP");
                dtCart.Columns.Add("Ten_san_pham");
                dtCart.Columns.Add("Hinh_anh");
                dtCart.Columns.Add("Gia_co_ban", typeof(decimal));
                dtCart.Columns.Add("So_luong", typeof(int));
                dtCart.Columns.Add("Thanh_tien", typeof(decimal));
            }
            else
            {
                dtCart = (DataTable)Session["GioHang"];
            }

            // Kiểm tra sản phẩm đã có trong giỏ chưa
            DataRow[] foundRows = dtCart.Select("ID_SP = '" + idSP + "'");
            string productName = "";

            if (foundRows.Length > 0)
            {
                // Đã có -> Tăng số lượng
                foundRows[0]["So_luong"] = Convert.ToInt32(foundRows[0]["So_luong"]) + 1;
                foundRows[0]["Thanh_tien"] = Convert.ToInt32(foundRows[0]["So_luong"]) * Convert.ToDecimal(foundRows[0]["Gia_co_ban"]);
                productName = foundRows[0]["Ten_san_pham"].ToString();
            }
            else
            {
                // Chưa có -> Lấy từ DB bỏ vào
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT Ten_san_pham, Hinh_anh, Gia_co_ban FROM SAN_PHAM WHERE ID_SP = @ID_SP";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ID_SP", idSP);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        DataRow dr = dtCart.NewRow();
                        dr["ID_SP"] = idSP;
                        dr["Ten_san_pham"] = reader["Ten_san_pham"];
                        dr["Hinh_anh"] = reader["Hinh_anh"];
                        dr["Gia_co_ban"] = reader["Gia_co_ban"];
                        dr["So_luong"] = 1;
                        dr["Thanh_tien"] = reader["Gia_co_ban"]; // 1 * giá
                        dtCart.Rows.Add(dr);

                        productName = reader["Ten_san_pham"].ToString();
                    }
                    conn.Close();
                }
            }

            // Lưu lại vào Session
            Session["GioHang"] = dtCart;

            // Cập nhật UI số lượng
            UpdateCartCount();

            // Gọi hàm JS showToast để hiện thông báo
            ClientScript.RegisterStartupScript(this.GetType(), "showToast", $"showToast('{productName}');", true);
        }

        private void UpdateCartCount()
        {
            if (Session["GioHang"] != null)
            {
                DataTable dt = (DataTable)Session["GioHang"];

                // Tính tổng số lượng item
                // object sumQty = dt.Compute("Sum(So_luong)", ""); // Cách tính tổng số ly
                int itemCount = dt.Rows.Count; // Cách tính số loại món

                string countStr = itemCount.ToString();

                // Cập nhật label Desktop
                if (itemCount > 0)
                {
                    lblCartCount.Text = countStr;
                    lblCartCount.Visible = true;

                    lblMobileCartCount.Text = countStr;
                    lblMobileCartCount.Visible = true;
                }
                else
                {
                    lblCartCount.Visible = false;
                    lblMobileCartCount.Visible = false;
                }
            }
        }
    }
}