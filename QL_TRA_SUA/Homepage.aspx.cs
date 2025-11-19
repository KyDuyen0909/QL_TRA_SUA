using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cua_Hang_Tra_Sua;

namespace QL_TRA_SUA
{
    public partial class Homepage : System.Web.UI.Page
    {
        // Khởi tạo DataContext
        private Cua_Hang_Tra_SuaDataContext context = new Cua_Hang_Tra_SuaDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLatestNews();
                // Các hàm load khác (nếu có)
            }
        }

        /// <summary>
        /// Tải các bài viết mới nhất từ CSDL lên Repeater
        /// </summary>
        private void LoadLatestNews()
        {
            try
            {
                // Lấy 3 hoặc 6 bài viết mới nhất
                // Sắp xếp theo ID_BV giảm dần (bài mới nhất lên đầu)
                // Hoặc OrderKey nếu bạn muốn sắp xếp thủ công
                var latestNews = context.Bai_Viets
                                        .OrderByDescending(bv => bv.ID_BV)
                                        .Take(3) // Lấy 3 bài viết mới nhất
                                        .Select(bv => new
                                        {
                                            bv.ID_BV,
                                            bv.Tieu_de,
                                            bv.Tom_tac,
                                            bv.Noi_dung,
                                            // Kiểm tra nếu Hinh_anh_page null thì dùng ảnh mặc định
                                            Hinh_anh_page = string.IsNullOrEmpty(bv.Hinh_anh_page) ? "default_news.jpg" : bv.Hinh_anh_page
                                        })
                                        .ToList();

                // Gán dữ liệu vào Repeater
                rptNews.DataSource = latestNews;
                rptNews.DataBind();
            }
            catch (Exception ex)
            {
                // Xử lý lỗi (trong thực tế nên ghi log)
                System.Diagnostics.Debug.WriteLine("Lỗi tải bài viết: " + ex.Message);
            }
        }
    }
}