<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TB_BAI_VIET.aspx.cs" Inherits="QL_TRA_SUA.TB_BAI_VIET" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Báo - Cửa Hàng Trà Sữa</title>
    <!-- Tải Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Tải Swiper.js (Thư viện Slider) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <style>
        /* (CSS giữ nguyên như file của bạn) */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #fdf8f8;
        }
        .swiper-pagination-bullet-active {
            background-color: #db2777 !important;
        }
        .article-content h3 {
            font-size: 1.5rem; font-weight: 700; margin-top: 1.5rem;
            margin-bottom: 0.5rem; border-bottom: 1px solid #e5e7eb; padding-bottom: 4px;
        }
        .article-content p { margin-bottom: 1rem; line-height: 1.75; }
        .article-content ul { list-style-type: disc; padding-left: 2rem; margin-bottom: 1rem; }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
            opacity: 0;
        }
    </style>

</head>
<body>

    <%-- SỬA 2: Thêm thẻ <form> bắt buộc cho ASP.NET --%>
    <form id="form1" runat="server">
    
        <!-- Khung chứa chính giữa, responsive -->
        <div class="max-w-4xl mx-auto p-4 sm:p-6 lg:p-8">

            <!-- Tiêu đề Cửa hàng -->
            <header class="text-center mb-10 fade-in" style="animation-delay: 100ms;">
                <h1 class="text-3xl font-extrabold text-pink-800 tracking-tight sm:text-4xl">
                    CỬA HÀNG TRÀ SỮA ĐỒNG THÁP
                </h1>
                <p class="text-lg text-gray-500 mt-2">Nơi khởi nguồn những hương vị tuyệt vời</p>
            </header>

            <!-- SỬA 3: Chuyển 'article' thành 'asp:Panel' để chứa nội dung động -->
            <asp:Panel ID="pnlArticle" runat="server" CssClass="bg-white shadow-2xl rounded-xl overflow-hidden fade-in" style="animation-delay: 200ms;">
                
                <!-- SLIDER ẢNH (SWIPER.JS) -->
                <div class="relative h-64 sm:h-96">
                    <div class="swiper main-slider h-full">
                        <div class="swiper-wrapper">
                            <!-- Slide 1 (Dữ liệu động từ CSDL) -->
                            <div class="swiper-slide">
                                <%-- SỬA 4: Dùng asp:Image --%>
                                <asp:Image ID="imgBaiViet" runat="server" 
                                    AlternateText="Hình ảnh bài viết" 
                                    ImageUrl="https://placehold.co/1200x600/DB2777/FFFFFF?text=ANH+BAI+VIET"
                                    CssClass="w-full h-full object-cover" />
                            </div>
                            <!-- Slide 2 (Ảnh Tĩnh - Có thể giữ lại hoặc xóa đi) -->
                            <div class="swiper-slide">
                                <img src="https://placehold.co/1200x600/6B9A76/FFFFFF?text=TRA+SUA+DAU+BAC+HA" 
                                     alt="Sản phẩm mới" 
                                     class="w-full h-full object-cover">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://placehold.co/1200x600/3B2F2F/FFFFFF?text=TRA+SUA+SOCOLA" 
                                     alt="Sản phẩm mới" 
                                     class="w-full h-full object-cover">
                            </div>
                            <!-- Slide 3 (Ảnh Tĩnh - Có thể giữ lại hoặc xóa đi) -->
                            <div class="swiper-slide">
                                <img src="https://placehold.co/1200x600/F59E0B/FFFFFF?text=KHONG+GIAN+QUAN" 
                                     alt="Không gian quán" 
                                     class="w-full h-full object-cover">
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                    
                    <div class="absolute inset-0 bg-black opacity-30"></div>
                    <span class="absolute top-4 left-4 bg-red-600 text-white text-sm font-semibold px-4 py-2 rounded-full shadow-lg uppercase z-10">
                        Mới & Hot!
                    </span>
                </div>
                
                 <div class="p-6 sm:p-10">
                <!-- Tiêu đề bài viết (Tieu_de) -->
                <h2 class="text-3xl sm:text-4xl font-bold text-gray-900 mb-4 leading-tight">
                    KHAI TRƯƠNG LỚN: Ra Mắt Trà Sữa Dâu Tây Bạc Hà
                </h2>
                
                <!-- Tóm tắt & Thông tin bổ sung (Tom_tac) -->
                <div class="flex items-center text-sm text-gray-500 mb-6 border-b pb-4">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2 text-green-500" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd" />
                    </svg>
                    <span>Ngày đăng: 16/11/2025 | Tác giả: Admin | Chủ đề: Khai Trương & Sản Phẩm Mới</span>
                </div>

                <!-- Tóm tắt (Tom_tac - Sử dụng cho phần nổi bật) -->
                <p class="text-xl italic text-green-700 font-semibold mb-8 border-l-4 border-green-500 pl-4 bg-green-50 p-3 rounded-lg">
                    Cửa hàng Trà Sữa Đồng Tháp chính thức mở cửa! Giảm 20% toàn bộ menu trong tuần lễ khai trương (16/11 - 23/11).
                </p>

                <!-- Nội dung chi tiết (Noi_dung) -->
                <div class="text-gray-700 space-y-6 text-base leading-relaxed">
                    <p>
                        Chào mừng tất cả các tín đồ trà sữa! Sau bao ngày chờ đợi, chúng tôi vui mừng thông báo Cửa hàng Trà Sữa Đồng Tháp đã chính thức khai trương và đi vào hoạt động, sẵn sàng phục vụ những ly trà sữa thơm ngon nhất.
                    </p>
                    <p>
                        Đặc biệt, nhân dịp khai trương, chúng tôi xin giới thiệu sản phẩm độc quyền: <strong>Trà Sữa Dâu Tây Bạc Hà</strong>. Sự kết hợp hoàn hảo giữa vị dâu tây ngọt ngào, trà sữa béo ngậy và chút the mát của bạc hà chắc chắn sẽ làm bùng nổ vị giác của bạn. Đừng bỏ lỡ cơ hội thưởng thức món mới này! 
                    </p>
                    
                    <h3 class="text-2xl font-bold text-gray-800 pt-4 pb-2 border-b">
                        Chi Tiết Chương Trình Khuyến Mãi (20% OFF)
                    </h3>
                    <ul class="list-disc list-inside space-y-2 ml-4">
                        <li><strong>Thời gian áp dụng:</strong> Từ 16/11/2025 đến hết 23/11/2025.</li>
                        <li><strong>Phạm vi:</strong> Giảm 20% tổng hóa đơn cho tất cả khách hàng đặt tại quầy và đặt giao hàng qua ứng dụng.</li>
                        <li><strong>Điều kiện:</strong> Áp dụng cho toàn bộ Menu (Trà Sữa, Trà Trái Cây, Bánh Ngọt).</li>
                    </ul>
                    <p>
                        Hãy đến ngay cửa hàng của chúng tôi tại địa chỉ: **123 Đường Sáng Tạo, Phường Đổi Mới, TP. Đồng Tháp** để cùng nhau ăn mừng sự kiện này!
                    </p>
                </div>
                
                <!-- Khu vực Call to Action -->
                <div class="mt-10 pt-6 border-t flex flex-col sm:flex-row gap-4">
                    <button onclick="alert('Chức năng Xem Menu đang được phát triển!')" 
                            class="flex-1 px-6 py-3 bg-[#4c673d] text-white font-semibold rounded-lg shadow-md hover:bg-green-700 transition duration-300 transform hover:scale-105">
                        XEM TOÀN BỘ MENU
                    </button>
                    <button onclick="alert('Chức năng Tìm Vị Trí đang được phát triển!')"
                            class="flex-1 px-6 py-3 bg-indigo-500 text-white font-semibold rounded-lg shadow-md hover:bg-indigo-700 transition duration-300 transform hover:scale-105">
                        TÌM VỊ TRÍ CỬA HÀNG
                    </button>
                </div>

                </div>
            </asp:Panel>
            
            <!-- Footer đơn giản -->
            <footer class="text-center mt-10 text-gray-500 text-sm">
                &copy; 2025 Cửa Hàng Trà Sữa Đồng Tháp. Vui lòng liên hệ 0337335364 để được hỗ trợ.
            </footer>
        </div>

        <!-- CUSTOM MESSAGE BOX (Modal) -->
        <div id="custom-modal" class="fixed inset-0 bg-gray-600 bg-opacity-75 flex items-center justify-center p-4 hidden z-50">
            <div class="bg-white rounded-xl shadow-2xl w-full max-w-sm p-6 transform transition-all scale-100 opacity-100">
                <div class="flex justify-between items-center border-b pb-3 mb-4">
                    <h3 id="modal-title" class="text-xl font-bold text-gray-800">Thông báo</h3>
                    <button type="button" onclick="hideMessage()" class="text-gray-400 hover:text-gray-600 transition duration-150">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                    </button>
                </div>
                <p id="modal-message" class="text-gray-700 mb-6">Nội dung thông báo sẽ hiển thị ở đây.</p>
                <div class="flex justify-end">
                    <button type="button" onclick="hideMessage()" class="px-4 py-2 bg-pink-600 text-white font-semibold rounded-lg hover:bg-pink-700 transition duration-300 shadow">
                        Đóng
                    </button>
                </div>
            </div>
        </div>
    </form> <%-- SỬA 2: Đóng thẻ </form> --%>
    <script>
        // (JavaScript cho Swiper, Modal, và Fade-in giữ nguyên như file của bạn)
        var swiper = new Swiper('.main-slider', {
            loop: true,
            effect: 'fade',
            autoplay: {
                delay: 4000,
                disableOnInteraction: false,
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
        });

        function showMessage(title, message) {
            const modal = document.getElementById('custom-modal');
            const modalTitle = document.getElementById('modal-title');
            const modalMessage = document.getElementById('modal-message');

            modalTitle.textContent = title;
            modalMessage.textContent = message;
            modal.classList.remove('hidden');
        }

        function hideMessage() {
            const modal = document.getElementById('custom-modal');
            modal.classList.add('hidden');
        }

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('fade-in');
                }
            });
        }, {
            threshold: 0.1
        });

        document.querySelectorAll('.fade-in').forEach(el => {
            observer.observe(el);
        });

    </script>

</body>
</html>

