using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;

namespace QL_TRA_SUA
{
    public partial class TB_BAI_VIET : System.Web.UI.Page
    {
        protected Literal ltrTieuDe;
        protected Literal ltrTomTat;
        protected Literal ltrNoiDung;
        protected Literal ltrNgayDang;
        protected Literal ltrTacGia;
        protected Literal ltrChuDe;
        protected Image imgBaiViet;
        protected Panel pnlArticle;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int baiVietId = 1;

                if (Request.QueryString["id"] != null &&
                    int.TryParse(Request.QueryString["id"], out int idFromQuery))
                {
                    baiVietId = idFromQuery;
                }

                Load_BaiViet(baiVietId);
            }
        }

        private void Load_BaiViet(int id)
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    string query = @"
                        SELECT Tieu_de, Tom_tac, Noi_dung, Hinh_anh_page,
                               Ngay_dang, Tac_gia, Chu_de
                        FROM Bai_Viet
                        WHERE ID = @ID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.Add("@ID", System.Data.SqlDbType.Int).Value = id;

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                SetLiteralSafe(ltrTieuDe, dr["Tieu_de"]);
                                SetLiteralSafe(ltrTomTat, dr["Tom_tac"]);
                                SetLiteralSafe(ltrNoiDung, dr["Noi_dung"]);
                                SetLiteralSafe(ltrTacGia, dr["Tac_gia"]);
                                SetLiteralSafe(ltrChuDe, dr["Chu_de"]);

                                if (dr["Ngay_dang"] != DBNull.Value)
                                    ltrNgayDang.Text = Convert.ToDateTime(dr["Ngay_dang"])
                                                        .ToString("dd/MM/yyyy");

                                string imgUrl = dr["Hinh_anh_page"]?.ToString();
                                if (!string.IsNullOrWhiteSpace(imgUrl) && imgBaiViet != null)
                                {
                                    imgBaiViet.ImageUrl = imgUrl;
                                    imgBaiViet.Visible = true;
                                }
                                else if (imgBaiViet != null)
                                {
                                    imgBaiViet.Visible = false;
                                }

                                if (pnlArticle != null) pnlArticle.Visible = true;
                            }
                            else
                            {
                                RenderNotFound();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                RenderError(ex);
            }
        }

        // =====================================================
        // ========== HÀM HỖ TRỢ ĐỂ CODE GỌN HƠN ===============
        // =====================================================
        private void SetLiteralSafe(Literal literal, object value)
        {
            if (literal != null)
                literal.Text = value == DBNull.Value ? "" : value?.ToString();
        }

        private void RenderNotFound()
        {
            SetLiteralSafe(ltrTieuDe, "Không tìm thấy bài viết");
            SetLiteralSafe(ltrTomTat, "Bài viết bạn đang tìm không tồn tại hoặc đã bị xóa.");
            SetLiteralSafe(ltrNoiDung,
                "<p class='text-center text-red-500'>Vui lòng kiểm tra lại đường dẫn hoặc mã bài viết.</p>");

            if (pnlArticle != null) pnlArticle.Visible = true;
            if (imgBaiViet != null) imgBaiViet.Visible = false;
        }

        private void RenderError(Exception ex)
        {
            SetLiteralSafe(ltrTieuDe, "LỖI HỆ THỐNG");
            SetLiteralSafe(ltrTomTat, "");
            SetLiteralSafe(ltrNoiDung,
                $"<p class='text-center text-red-700'>Không thể tải dữ liệu bài viết.<br/>" +
                $"Vui lòng kiểm tra lại kết nối CSDL hoặc liên hệ quản trị viên.<br/>" +
                $"Chi tiết lỗi: {Server.HtmlEncode(ex.Message)}</p>");

            if (pnlArticle != null) pnlArticle.Visible = true;
            if (imgBaiViet != null) imgBaiViet.Visible = false;

            System.Diagnostics.Debug.WriteLine("[Database Error] " + ex);
        }
    }
}
