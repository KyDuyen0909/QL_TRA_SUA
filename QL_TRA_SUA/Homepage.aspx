<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="QL_TRA_SUA.Homepage" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chào Mừng Đến Cửa Hàng Trà Sữa Đồng Tháp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f7f3f3;
            overflow-x: hidden; /* Ngăn cuộn ngang */
        }

        /* --- 1. PHẦN HERO SỐNG ĐỘNG --- */

        .hero-section {
            height: 100vh; /* Cao 100% màn hình */
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            overflow: hidden; /* Ẩn các hiệu ứng tràn ra ngoài */
        }

        /* Lớp nền (background) với hiệu ứng Ken Burns "sống động" */
        .hero-background {
            position: absolute;
            inset: 0;
            background-image: url('https://placehold.co/1920x1080/6B9A76/FFFFFF?text=Hình+Ảnh+Chào+Mừng');
            background-size: cover;
            background-position: center;
            
            /* Animation Ken Burns (phóng to và di chuyển chậm) */
            animation: kenBurns 20s ease-in-out infinite alternate;
        }

        @keyframes kenBurns {
            0% {
                transform: scale(1) translate(0, 0);
            }
            100% {
                transform: scale(1.1) translate(-2%, 2%);
            }
        }

        /* Lớp phủ mờ (overlay) để làm nổi bật chữ */
        .hero-overlay {
            position: absolute;
            inset: 0;
            background-color: rgba(0, 0, 0, 0.5); /* Màu đen mờ 50% */
        }

        /* --- 2. HIỆU ỨNG BONG BÓNG "WAO" --- */

        .bubbles-container {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none; /* Cho phép click xuyên qua */
        }

        .bubble {
            position: absolute;
            bottom: -50px; /* Bắt đầu bên dưới */
            background-color: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            animation: floatUp 25s infinite linear;
            opacity: 0;
        }

        /* Tạo 10 bong bóng với kích thước, vị trí, độ trễ khác nhau */
        .bubble:nth-child(1) { width: 20px; height: 20px; left: 10%; animation-duration: 22s; animation-delay: 0s; }
        .bubble:nth-child(2) { width: 35px; height: 35px; left: 20%; animation-duration: 25s; animation-delay: 3s; }
        .bubble:nth-child(3) { width: 15px; height: 15px; left: 30%; animation-duration: 20s; animation-delay: 5s; }
        .bubble:nth-child(4) { width: 50px; height: 50px; left: 40%; animation-duration: 18s; animation-delay: 1s; }
        .bubble:nth-child(5) { width: 25px; height: 25px; left: 50%; animation-duration: 26s; animation-delay: 7s; }
        .bubble:nth-child(6) { width: 30px; height: 30px; left: 60%; animation-duration: 21s; animation-delay: 2s; }
        .bubble:nth-child(7) { width: 18px; height: 18px; left: 70%; animation-duration: 23s; animation-delay: 4s; }
        .bubble:nth-child(8) { width: 40px; height: 40px; left: 80%; animation-duration: 19s; animation-delay: 6s; }
        .bubble:nth-child(9) { width: 22px; height: 22px; left: 90%; animation-duration: 24s; animation-delay: 8s; }
        .bubble:nth-child(10){ width: 30px; height: 30px; left: 55%; animation-duration: 20s; animation-delay: 10s; }

        @keyframes floatUp {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(-120vh) rotate(360deg); /* Bay lên cao và xoay */
                opacity: 0;
            }
        }

        /* --- 3. VĂN BẢN HOẠT HÌNH --- */

        /* Hiệu ứng trượt lên và mờ dần (fade-in-up) */
        .animate-fade-in-up {
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease-out forwards;
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- ===== PHẦN 1: HERO TOÀN MÀN HÌNH ===== -->
        <section class="hero-section">
            <!-- Lớp nền sống động -->
            <div class="hero-background"></div>
            <!-- Lớp phủ mờ -->
            <div class="hero-overlay"></div>
            
            <!-- Hiệu ứng bong bóng "wao" -->
            <div class="bubbles-container">
                <div class="bubble"></div>
                <div class="bubble"></div>
                <div class="bubble"></div>
                <div class="bubble"></div>
                <div class="bubble"></div>
                <div class="bubble"></div>
                <div class="bubble"></div>
                <div class="bubble"></div>
                <div class="bubble"></div>
                <div class="bubble"></div>
            </div>

            <!-- Nội dung chính giữa (văn bản hoạt hình) -->
            <div class="relative z-10 text-center p-4">
                <h1 class="text-4xl sm:text-6xl font-extrabold tracking-tight animate-fade-in-up" 
                    style="animation-delay: 0.2s;">
                    Chào Mừng Khai Trương
                </h1>
                <p class="text-xl sm:text-2xl mt-4 max-w-2xl mx-auto animate-fade-in-up" 
                   style="animation-delay: 0.5s;">
                    Khám phá hương vị mới: Trà Sữa Dâu Tây Bạc Hà & ưu đãi 20% toàn bộ menu!
                </p>
                <div class="mt-10 animate-fade-in-up" style="animation-delay: 0.8s;">
                    <!-- Sử dụng thẻ <a> (Link) để điều hướng -->
                    <a href="#noi-dung-chinh" 
                       class="px-8 py-4 bg-red-600 text-white font-semibold rounded-lg shadow-lg hover:bg-red-700 transition duration-300 transform hover:scale-105 text-lg mx-2">
                        Xem Chi Tiết
                    </a>
                    <a href="#" onclick="alert('Chức năng Xem Menu đang được phát triển!')" 
                       class="px-8 py-4 bg-white text-gray-900 font-semibold rounded-lg shadow-lg hover:bg-gray-200 transition duration-300 transform hover:scale-105 text-lg mx-2">
                        Xem Menu
                    </a>
                </div>
            </div>
        </section>

        <!-- ===== PHẦN 2: NỘI DUNG BÀI VIẾT (Lấy từ TB_BAI_VIET) ===== -->
        <!-- 'id' này dùng để cho nút "Xem Chi Tiết" ở trên nhảy xuống -->
        <section id="noi-dung-chinh" class="max-w-4xl mx-auto p-4 sm:p-6 lg:p-8 -mt-24 relative z-20">

            <article class="bg-white shadow-2xl rounded-xl overflow-hidden">
                
                <!-- Hình ảnh (có thể dùng lại ảnh placeholder hoặc ảnh thật) -->
                <div class="relative h-64 sm:h-96">
                    <img src="https://placehold.co/1200x600/6B9A76/FFFFFF?text=ANH+MINH+HỌA+THÔNG+BÁO" 
                         alt="Hình ảnh thông báo khai trương và sản phẩm mới" 
                         class="w-full h-full object-cover">
                    <span class="absolute top-4 left-4 bg-red-600 text-white text-sm font-semibold px-4 py-2 rounded-full shadow-lg uppercase">
                        Mới & Hot!
                    </span>
                </div>
                
                <div class="p-6 sm:p-10">
                    <!-- Tiêu đề bài viết -->
                    <h2 class="text-3xl sm:text-4xl font-bold text-gray-900 mb-4 leading-tight">
                        KHAI TRƯƠNG LỚN: Ra Mắt Trà Sữa Dâu Tây Bạc Hà
                    </h2>
                    
                    <!-- Thông tin ngày đăng -->
                    <div class="flex items-center text-sm text-gray-500 mb-6 border-b pb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2 text-green-500" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd" />
                        </svg>
                        <span>Ngày đăng: 16/11/2025 | Chủ đề: Khai Trương & Sản Phẩm Mới</span>
                    </div>

                    <!-- Tóm tắt (phần nổi bật) -->
                    <p class="text-xl italic text-green-700 font-semibold mb-8 border-l-4 border-green-500 pl-4 bg-green-50 p-3 rounded-lg">
                        Cửa hàng Trà Sữa Đồng Tháp chính thức mở cửa! Giảm 20% toàn bộ menu trong tuần lễ khai trương (16/11 - 23/11).
                    </p>

                    <!-- Nội dung chi tiết -->
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
                            <li><strong>Phạm vi:</strong> Giảm 20% tổng hóa đơn cho tất cả khách hàng.</li>
                            <li><strong>Điều kiện:</strong> Áp dụng cho toàn bộ Menu.</li>
                        </ul>
                        <p>
                            Hãy đến ngay cửa hàng của chúng tôi tại địa chỉ: **123 Đường Sáng Tạo, Phường Đổi Mới, TP. Đồng Tháp** để cùng nhau ăn mừng sự kiện này!
                        </p>
                    </div>
                </div>
            </article>
            
            <!-- Footer đơn giản -->
            <footer class="text-center mt-10 text-gray-500 text-sm">
                &copy; 2025 Cửa Hàng Trà Sữa Đồng Tháp. Vui lòng liên hệ 0337335364 để được hỗ trợ.
            </footer>
        </div>
    </form>
</body>
</html>
