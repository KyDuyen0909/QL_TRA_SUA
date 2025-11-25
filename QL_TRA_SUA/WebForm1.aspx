<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="QL_TRA_SUA.WebForm1" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chào Mừng Đến Cửa Hàng Trà Sữa Đồng Tháp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

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

        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f7f3f3;
        }
        .typing-effect::after {
            content: '|';
            animation: blink 1s infinite;
        }
        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0; }
        }
        .gradient-text {
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .swiper-pagination-bullet-active {
            background-color: #4c673d !important;
        }
        .contact-form {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2d5016;
            font-weight: bold;
        }
        /* CSS cho Slider */
.slider-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    opacity: 0;
    transition: opacity 1.5s ease-in-out; /* Chuyển cảnh mượt trong 1.5s */
    z-index: 0;
}
.slider-image.active {
    opacity: 1;
    z-index: 1;
}
/* Lớp phủ đen lên trên ảnh để chữ dễ đọc */
.slider-overlay {
    position: absolute;
    inset: 0;
    background-color: rgba(0, 0, 0, 0.4);
    z-index: 2;
    display: flex;
    align-items: center;
    justify-content: center;
}
        /* CSS cho tin tức */
        .news-container { display: flex; flex-wrap: wrap; gap: 20px; justify-content: center; margin-top: 20px;}
        .news-item { width: 300px; border: 1px solid #ddd; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .news-item img { width: 100%; height: 180px; object-fit: cover; }
        .news-content { padding: 15px; }
        .news-title { font-size: 18px; color: #333; margin-bottom: 10px; font-weight: bold; }
        .news-desc { font-size: 14px; color: #666; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }
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
        <section id="noi-dung-chinh" class="max-w-4xl mx-auto p-4 sm:p-6 lg:p-8 -mt-24 relative z-20">


        <div class="max-w-6xl mx-auto p-4 sm:p-6 lg:p-8 font-[Inter]">
            
           <!-- === BANNER SLIDER (MỚI) === -->
<div class="relative h-64 sm:h-80 md:h-[500px] rounded-2xl overflow-hidden shadow-2xl mb-12 group">
    
    <!-- Danh sách các ảnh trong Slider -->
    <div id="heroSlider">
        <!-- Ảnh 1: Không gian quán ấm cúng -->
        <img src="https://images.unsplash.com/photo-1666956175288-848f477c5788?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
             class="slider-image active" alt="Không gian quán">
        
        <!-- Ảnh 2: Cận cảnh trà sữa ngon -->
        <img src="https://images.unsplash.com/photo-1658646479124-bc31e6849497?q=80&w=951&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
             class="slider-image" alt="Cà phê và trà">

        <!-- Ảnh 3: Quầy pha chế hiện đại -->
        <img src="https://images.unsplash.com/photo-1497935586351-b67a49e012bf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1920" 
             class="slider-image" alt="Quầy pha chế">
             
        <!-- Ảnh 4: Trà sữa trái cây tươi mát -->
        <img src="https://images.unsplash.com/photo-1558160074-4d7d8bdf4256?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1920" 
             class="slider-image" alt="Trà trái cây">
    </div>

    <!-- Lớp phủ chứa Tiêu đề -->
    <div class="slider-overlay">
        <div class="text-center px-4 animate-fade-in-up">
            <h1 class="text-white text-4xl sm:text-6xl font-extrabold tracking-tight drop-shadow-lg mb-4">
                Trà Sữa Milk Cat
            </h1>
            <p class="text-gray-100 text-lg sm:text-2xl font-light tracking-wide drop-shadow-md">
                Đậm vị trà - Thơm vị sữa - Thỏa đam mê
            </p>
        </div>
    </div>

    <!-- Nút điều hướng (Tùy chọn) -->
    <div class="absolute bottom-5 left-0 right-0 z-10 flex justify-center gap-2">
        <span class="w-3 h-3 bg-white rounded-full opacity-50 cursor-pointer hover:opacity-100 transition" onclick="changeSlide(0)"></span>
        <span class="w-3 h-3 bg-white rounded-full opacity-50 cursor-pointer hover:opacity-100 transition" onclick="changeSlide(1)"></span>
        <span class="w-3 h-3 bg-white rounded-full opacity-50 cursor-pointer hover:opacity-100 transition" onclick="changeSlide(2)"></span>
        <span class="w-3 h-3 bg-white rounded-full opacity-50 cursor-pointer hover:opacity-100 transition" onclick="changeSlide(3)"></span>
    </div>
</div>
<!-- === KẾT THÚC SLIDER === -->

            <!-- Giới thiệu -->
            <section class="text-center mb-12">
                <h2 class="text-3xl font-bold text-[#4c673d] mb-4">Hương Vị Tươi Mới Mỗi Ngày</h2>
                <p class="text-gray-600 text-lg">Chúng tôi mang đến những ly trà sữa thơm ngon, nguyên liệu tự nhiên, phục vụ tận tâm.</p>
            </section>

             <!-- === PHẦN MỚI: TIN TỨC & BÀI VIẾT (LẤY TỪ CSDL) === -->
 <section class="mb-16">
     <h3 class="text-2xl font-semibold text-gray-800 mb-6 text-center relative">
         <span class="border-b-4 border-[#4c673d] pb-2">Tin Tức & Sự Kiện Mới</span>
     </h3>

     <!-- Repeater để lặp dữ liệu bài viết -->
     <div class="news-container">
                <!-- Repeater này sẽ lặp lại dữ liệu từ hàm GetArticles() -->
                <asp:Repeater ID="rptNewestArticles" runat="server">
                    <ItemTemplate>
                        <div class="news-card">
                            <!-- Hình ảnh bài viết -->
                            <img src='<%# "image/" + Eval("Hinh_anh_page") %>' 
                                 alt='<%# Eval("Tieu_de") %>' 
                                 class="news-img" 
                                 onerror="this.src='Images/default-news.png'" />
                            
                            <div class="news-content">
                                <!-- Tiêu đề -->
                                <h3 class="news-title"><%# Eval("Tieu_de") %></h3>
                                
                                <!-- Tóm tắt -->
                                <p class="news-summary"><%# Eval("Tom_tac") %></p>
                                
                                <!-- Link xem chi tiết (nếu có trang chi tiết) -->
                                <a href='<%# "Bai_iet.aspx?id=" + Eval("ID_BV") %>' 
                                   style="color: #e74c3c; text-decoration: none; font-weight: bold; font-size: 13px;">
                                   Xem thêm &rarr;
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
             </ItemTemplate>
             <FooterTemplate>
                 <%-- Hiển thị nếu không có bài viết --%>
                 <asp:Label ID="lblEmpty" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>' Text="Chưa có bài viết nào." CssClass="text-center col-span-3 text-gray-500 py-10" />
             </FooterTemplate>
         </asp:Repeater>
     </div>
     
     <div class="text-center mt-8">
         <a href="#" class="inline-block px-6 py-2 border border-[#4c673d] text-[#4c673d] rounded-full font-medium hover:bg-[#4c673d] hover:text-white transition">Xem tất cả tin tức</a>
     </div>
 </section>
 <!-- === KẾT THÚC PHẦN TIN TỨC === -->

            <!-- Sản phẩm nổi bật -->
            <section class="mb-16">
                <h3 class="text-2xl font-semibold text-gray-800 mb-6 text-center">Sản Phẩm Nổi Bật</h3>
                
                <div class="swiper product-slider pb-10">
                    <div class="swiper-wrapper">
                        
                        <div class="swiper-slide">
                            <div class="relative group cursor-pointer overflow-hidden rounded-xl shadow-lg bg-white">
                                <img src="https://images.unsplash.com/photo-1572490122763-91b35b83416c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=600" 
                                    alt="Trà Sữa Dâu" class="w-full h-64 object-cover transition transform duration-500 group-hover:scale-110">
                                <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-4 pt-10">
                                    <h4 class="text-white font-bold text-lg">Trà Sữa Dâu</h4>
                                    <p class="text-gray-200 text-sm opacity-0 group-hover:opacity-100 transition-opacity duration-300">Ngọt ngào vị dâu tươi</p>
                                </div>
                                <div class="absolute top-3 right-3 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded-full shadow">HOT</div>
                            </div>
                        </div>
                        
                        <div class="swiper-slide">
                            <div class="relative group cursor-pointer overflow-hidden rounded-xl shadow-lg bg-white">
                                <img src="https://images.unsplash.com/photo-1516421942-A0086E527F38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=600" 
                                    alt="Trà Sữa Matcha" class="w-full h-64 object-cover transition transform duration-500 group-hover:scale-110">
                                <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-4 pt-10">
                                    <h4 class="text-white font-bold text-lg">Matcha Latte</h4>
                                    <p class="text-gray-200 text-sm opacity-0 group-hover:opacity-100 transition-opacity duration-300">Đậm đà vị trà xanh Nhật Bản</p>
                                </div>
                            </div>
                        </div>

                        <div class="swiper-slide">
                            <div class="relative group cursor-pointer overflow-hidden rounded-xl shadow-lg bg-white">
                                <img src="https://images.unsplash.com/photo-1562207520-19c0ebd8264f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=600" 
                                    alt="Trà Sữa Socola" class="w-full h-64 object-cover transition transform duration-500 group-hover:scale-110">
                                <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-4 pt-10">
                                    <h4 class="text-white font-bold text-lg">Socola Kem</h4>
                                    <p class="text-gray-200 text-sm opacity-0 group-hover:opacity-100 transition-opacity duration-300">Béo ngậy, thơm lừng</p>
                                </div>
                            </div>
                        </div>

                        <div class="swiper-slide">
                            <div class="relative group cursor-pointer overflow-hidden rounded-xl shadow-lg bg-white">
                                <img src="https://images.unsplash.com/photo-1558160074-4d7d8bdf4256?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=600" 
                                    alt="Hồng Trà Sữa" class="w-full h-64 object-cover transition transform duration-500 group-hover:scale-110">
                                <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-4 pt-10">
                                    <h4 class="text-white font-bold text-lg">Hồng Trà Sữa</h4>
                                    <p class="text-gray-200 text-sm opacity-0 group-hover:opacity-100 transition-opacity duration-300">Hương vị truyền thống</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="swiper-slide">
                            <div class="relative group cursor-pointer overflow-hidden rounded-xl shadow-lg bg-white">
                                <img src="https://images.unsplash.com/photo-1595981267035-7b04ca84a82d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=600" 
                                    alt="Trà Đào Cam Sả" class="w-full h-64 object-cover transition transform duration-500 group-hover:scale-110">
                                <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-4 pt-10">
                                    <h4 class="text-white font-bold text-lg">Trà Đào Cam Sả</h4>
                                    <p class="text-gray-200 text-sm opacity-0 group-hover:opacity-100 transition-opacity duration-300">Thanh mát giải nhiệt</p>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="swiper-pagination"></div>
                </div>
            </section>

            <!-- Không gian quán -->
            <section class="mb-12">
                <h3 class="text-2xl font-semibold text-gray-800 mb-6 text-center">Không Gian Quán</h3>
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                    <img src="https://images.unsplash.com/photo-1554118811-1e0d58224f24?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1920" 
                        alt="Quán ấm cúng" class="w-full h-80 object-cover rounded-lg shadow-lg hover:shadow-xl transition duration-300">
                    
                    <img src="https://images.unsplash.com/photo-1559925393-8be0ec4767c8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1920" 
                        alt="Quán trẻ trung" class="w-full h-80 object-cover rounded-lg shadow-lg hover:shadow-xl transition duration-300">
                    
                    <img src="https://images.unsplash.com/photo-1600093463592-8e36ae95ef56?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1920" 
                        alt="Quán ngoài trời" class="w-full h-80 object-cover rounded-lg shadow-lg hover:shadow-xl transition duration-300">
                </div>
            </section>

            <!-- AI Gợi Ý -->
            <section class="mb-16 bg-gradient-to-br from-green-50 to-blue-50 rounded-2xl p-8 shadow-inner border border-green-100 relative overflow-hidden">
                <div class="absolute top-0 right-0 -mt-4 -mr-4 text-6xl opacity-20 select-none">✨</div>
                <div class="absolute bottom-0 left-0 -mb-4 -ml-4 text-6xl opacity-20 select-none">🌿</div>

                <div class="text-center max-w-2xl mx-auto relative z-10">
                    <h2 class="text-3xl font-bold text-[#4c673d] mb-3 flex items-center justify-center gap-2">
                        <span class="text-2xl">✨</span> AI Gợi Ý Đồ Uống <span class="text-2xl">✨</span>
                    </h2>
                    <p class="text-gray-600 mb-6">
                        Bạn đang phân vân không biết uống gì? Hãy cho chúng tôi biết tâm trạng hoặc sở thích của bạn hôm nay!
                    </p>

                    <div class="bg-white p-2 rounded-xl shadow-md flex flex-col sm:flex-row gap-2">
                        <input type="text" id="userMood" 
                               placeholder="VD: Mình đang buồn ngủ, cần tỉnh táo..." 
                               class="flex-1 p-3 rounded-lg border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#4c673d] text-gray-700 placeholder-gray-400">
                        <button type="button" onclick="askGemini()" id="btnAsk"
                                class="px-6 py-3 bg-gradient-to-r from-[#4c673d] to-green-600 text-white font-bold rounded-lg shadow hover:shadow-lg transform hover:-translate-y-0.5 transition duration-200 whitespace-nowrap flex items-center justify-center gap-2">
                            <span>Gợi ý cho tôi ✨</span>
                            <svg id="loadingSpinner" class="hidden animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                            </svg>
                        </button>
                    </div>

                    <div id="aiResponseContainer" class="hidden mt-6 bg-white rounded-lg p-6 border-l-4 border-[#4c673d] text-left shadow-sm">
                        <div class="flex items-start gap-3">
                            <div class="flex-shrink-0 w-10 h-10 bg-green-100 rounded-full flex items-center justify-center text-xl">
                                🤖
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800 text-lg mb-1">Gợi ý dành riêng cho bạn:</h4>
                                <p id="aiResponseText" class="text-gray-700 leading-relaxed"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Tạo Caption -->
            <section class="mb-16 bg-gradient-to-br from-pink-50 to-purple-50 rounded-2xl p-8 shadow-inner border border-pink-100 relative overflow-hidden">
                <div class="absolute top-0 left-0 -mt-2 -ml-2 text-5xl opacity-10 select-none">📸</div>
                <div class="absolute bottom-0 right-0 -mb-4 -mr-4 text-6xl opacity-10 select-none">✍️</div>

                <div class="text-center max-w-3xl mx-auto relative z-10">
                    <h2 class="text-3xl font-bold mb-3 flex items-center justify-center gap-2">
                        <span class="bg-gradient-to-r from-pink-500 to-purple-600 gradient-text text-transparent">✨ Góc Sống Ảo AI ✨</span>
                    </h2>
                    <p class="text-gray-600 mb-8">
                        Bạn đã có ảnh đẹp cùng ly trà sữa? Hãy để AI viết giúp bạn một chiếc caption "triệu like" để đăng Facebook/Instagram nhé!
                    </p>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div class="text-left">
                            <label class="block text-gray-700 font-bold mb-2" for="captionDrink">Bạn đang uống gì?</label>
                            <select id="captionDrink" class="w-full p-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-pink-400 focus:border-transparent transition">
                                <option value="Trà Sữa Truyền Thống">Trà Sữa Truyền Thống</option>
                                <option value="Trà Sữa Thái Xanh">Trà Sữa Thái Xanh</option>
                                <option value="Trà Sữa Socola">Trà Sữa Socola</option>
                                <option value="Trà Đào Cam Sả">Trà Đào Cam Sả</option>
                                <option value="Trà Dâu Tây">Trà Dâu Tây</option>
                                <option value="Bánh Mousse">Bánh Mousse</option>
                            </select>
                        </div>

                        <div class="text-left">
                            <label class="block text-gray-700 font-bold mb-2" for="captionVibe">Vibe (Phong cách) mong muốn:</label>
                            <select id="captionVibe" class="w-full p-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-pink-400 focus:border-transparent transition">
                                <option value="thả thính ngọt ngào">💕 Thả thính ngọt ngào</option>
                                <option value="hài hước, lầy lội">🤣 Hài hước, lầy lội</option>
                                <option value="chill, sâu lắng">🌿 Chill, sâu lắng (Deep)</option>
                                <option value="năng động, vui vẻ">☀️ Năng động, vui vẻ</option>
                                <option value="review chân thực">📝 Review chân thực</option>
                            </select>
                        </div>
                    </div>

                    <button type="button" onclick="generateCaption()" id="btnCaption"
                            class="w-full md:w-auto px-8 py-3 bg-gradient-to-r from-pink-500 to-purple-600 text-white font-bold rounded-full shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition duration-200 flex items-center justify-center gap-2 mx-auto">
                        <span>✍️ Viết Caption Ngay</span>
                        <svg id="captionSpinner" class="hidden animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                        </svg>
                    </button>

                    <div id="captionResult" class="hidden mt-8 p-6 bg-white rounded-xl border-2 border-dashed border-pink-300 relative">
                        <button type="button" onclick="copyToClipboard()" class="absolute top-2 right-2 text-gray-400 hover:text-pink-500 p-2" title="Sao chép">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z" />
                                <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z" />
                            </svg>
                        </button>
                        <p id="captionText" class="text-gray-800 font-medium text-lg italic font-serif"></p>
                        <p class="text-xs text-gray-400 mt-4 text-right">✨ Generated by Gemini AI</p>
                    </div>
                </div>
            </section>

            <!-- Call to Action -->
            <div class="flex flex-col sm:flex-row gap-4 justify-center mt-10 mb-10">
                <a href="Menu.aspx" class="px-6 py-3 bg-[#4c673d] text-white font-semibold rounded-lg shadow-md hover:bg-green-700 transition duration-300 transform hover:scale-105 text-center">
                    XEM MENU
                </a>
                <a href="DatHang.aspx" class="px-6 py-3 bg-indigo-500 text-white font-semibold rounded-lg shadow-md hover:bg-indigo-700 transition duration-300 transform hover:scale-105 text-center">
                    ĐẶT HÀNG NGAY
                </a>
            </div>

            

            <!-- Footer -->
            <footer class="text-center mt-12 pt-6 border-t border-gray-300">
                <p class="text-gray-500 text-sm">&copy; 2025 Cửa Hàng Trà Sữa Đồng Tháp. Vui lòng liên hệ 0337335364 để được hỗ trợ.</p>
                <p>📍 Địa chỉ: 123 Đường Trà Xanh, Quận 1, TP.HCM</p>
                <p>📞 Điện thoại: 0123 456 789 | ✉️ Email: contact@trathiennhien.vn</p>
                <p>&copy; 2024 Trà Thiên Nhiên. All rights reserved.</p>
            </footer>
        </div>
    </form>

    <script>
        var productSwiper = new Swiper('.product-slider', {
            slidesPerView: 1,
            spaceBetween: 20,
            loop: true,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
            breakpoints: {
                640: {
                    slidesPerView: 2,
                    spaceBetween: 20,
                },
                1024: {
                    slidesPerView: 3,
                    spaceBetween: 30,
                },
            },
        });

        const apiKey = "AIzaSyASi4e_7CBWKP_5LXUqDqYgqKsfjAXvH94";

        async function exponentialBackoffFetch(url, options, maxRetries = 3) {
            for (let i = 0; i < maxRetries; i++) {
                try {
                    const response = await fetch(url, options);
                    if (response.ok || response.status < 500) return response;
                    if (response.status >= 500) {
                        if (i < maxRetries - 1) {
                            const delay = Math.pow(2, i) * 1000 + (Math.random() * 1000);
                            await new Promise(resolve => setTimeout(resolve, delay));
                        } else {
                            throw new Error(`API call failed after ${maxRetries} attempts`);
                        }
                    }
                } catch (error) {
                    if (i < maxRetries - 1) {
                        const delay = Math.pow(2, i) * 1000 + (Math.random() * 1000);
                        await new Promise(resolve => setTimeout(resolve, delay));
                    } else {
                        throw new Error(`Lỗi kết nối sau ${maxRetries} lần thử: ${error.message}`);
                    }
                }
            }
        }

        async function askGemini() {
            const input = document.getElementById('userMood');
            const mood = input.value.trim();
            const btn = document.getElementById('btnAsk');
            const spinner = document.getElementById('loadingSpinner');
            const container = document.getElementById('aiResponseContainer');
            const responseText = document.getElementById('aiResponseText');

            if (!mood) {
                container.classList.remove('hidden');
                responseText.innerHTML = '<span class="text-red-500">❌ Vui lòng nhập sở thích hoặc tâm trạng của bạn!</span>';
                return;
            }

            btn.disabled = true;
            btn.classList
            spinner.classList.remove('hidden');
            container.classList.add('hidden');
            responseText.innerText = '';

            try {
                const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=${apiKey}`;
                const menu = "Trà Sữa Truyền Thống, Trà Sữa Thái Xanh, Trà Sữa Socola, Trà Sữa Khoai Môn, Trà Đào Cam Sả, Trà Vải Hồng Trà, Trà Chanh Mật Ong, Trà Dâu Tây, Bánh Mousse Phô Mai, Bánh Tiramisu";
                const prompt = `Bạn là nhân viên tư vấn của quán Trà Sữa Đồng Tháp. Menu: ${menu}. Khách hàng cảm thấy: "${mood}". Gợi ý 1 món đồ uống và giải thích ngắn gọn, vui vẻ. Dùng emoji. Tiếng Việt.`;

                const response = await exponentialBackoffFetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ contents: [{ parts: [{ text: prompt }] }] })
                });

                const data = await response.json();

                if (data.candidates && data.candidates[0].content) {
                    const aiText = data.candidates[0].content.parts[0].text;
                    container.classList.remove('hidden');
                    typeWriterEffect(responseText, aiText);
                } else {
                    container.classList.remove('hidden');
                    responseText.innerHTML = '<span class="text-red-500">💔 Xin lỗi, hệ thống AI đang bận.</span>';
                }
            } catch (error) {
                console.error(error);
                container.classList.remove('hidden');
                responseText.innerHTML = '<span class="text-red-500">🚨 Lỗi kết nối! Vui lòng thử lại.</span>';
            } finally {
                btn.disabled = false;
                btn.classList.remove('opacity-75');
                spinner.classList.add('hidden');
            }
        }
        // --- 1. SCRIPT CHO SLIDER ---
        let currentSlide = 0;
        const slides = document.querySelectorAll('.slider-image');
        const dots = document.querySelectorAll('.absolute.bottom-5 span');
        const totalSlides = slides.length;

        // Hàm chuyển slide
        function changeSlide(index) {
            // Xóa class active cũ
            slides[currentSlide].classList.remove('active');
            dots[currentSlide].classList.replace('opacity-100', 'opacity-50');

            // Cập nhật index mới (nếu không truyền index thì tự tăng)
            if (typeof index === 'number') {
                currentSlide = index;
            } else {
                currentSlide = (currentSlide + 1) % totalSlides;
            }

            // Thêm class active mới
            slides[currentSlide].classList.add('active');
            dots[currentSlide].classList.replace('opacity-50', 'opacity-100');
        }

        // Tự động chạy slider mỗi 4 giây
        let slideInterval = setInterval(changeSlide, 4000);

        // Reset timer khi người dùng click thủ công
        function manualSlide(index) {
            clearInterval(slideInterval);
            changeSlide(index);
            slideInterval = setInterval(changeSlide, 4000);
        }

        // Gán sự kiện click cho các chấm tròn
        dots.forEach((dot, index) => {
            dot.onclick = () => manualSlide(index);
        });


        // === TÍNH NĂNG 2: TẠO CAPTION SỐNG ẢO ===
        async function generateCaption() {
            const drink = document.getElementById('captionDrink').value;
            const vibe = document.getElementById('captionVibe').value;
            const btn = document.getElementById('btnCaption');
            const spinner = document.getElementById('captionSpinner');
            const container = document.getElementById('captionResult');
            const textElem = document.getElementById('captionText');

            btn.disabled = true;
            btn.classList.add('opacity-75');
            spinner.classList.remove('hidden');
            container.classList.add('hidden');
            textElem.innerText = '';

            try {
                const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=${apiKey}`;
                const prompt = `Viết một caption ngắn (dưới 50 từ) cho mạng xã hội (Facebook/Instagram) về món đồ uống "${drink}" tại quán Trà Sữa Đồng Tháp. Phong cách (vibe): "${vibe}". Thêm hashtag và emoji phù hợp. Tiếng Việt.`;

                const response = await exponentialBackoffFetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ contents: [{ parts: [{ text: prompt }] }] })
                });

                const data = await response.json();

                if (data.candidates && data.candidates[0].content) {
                    const aiText = data.candidates[0].content.parts[0].text;
                    container.classList.remove('hidden');
                    typeWriterEffect(textElem, aiText.replace(/^"|"$/g, ''));
                } else {
                    alert("Không thể tạo caption lúc này. Thử lại sau nhé!");
                }
            } catch (error) {
                console.error(error);
                alert("Lỗi kết nối. Vui lòng thử lại.");
            } finally {
                btn.disabled = false;
                btn.classList.remove('opacity-75');
                spinner.classList.add('hidden');
            }
        }

        // Hàm hiệu ứng gõ chữ
        function typeWriterEffect(element, text) {
            element.innerHTML = '';
            let i = 0;
            element.classList.add('typing-effect');
            const type = () => {
                if (i < text.length) {
                    element.innerHTML += text.charAt(i);
                    i++;
                    setTimeout(type, 15);
                } else {
                    element.classList.remove('typing-effect');
                }
            };
            type();
        }

        // Hàm copy caption
        function copyToClipboard() {
            const text = document.getElementById('captionText').innerText;
            const tempInput = document.createElement("textarea");
            tempInput.value = text;
            document.body.appendChild(tempInput);
            tempInput.select();
            document.execCommand("copy");
            document.body.removeChild(tempInput);
            alert("Đã sao chép caption!");
        }

        // Cho phép nhấn Enter ở ô mood
        document.getElementById('userMood').addEventListener('keypress', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                askGemini();
            }
        });
</script>
