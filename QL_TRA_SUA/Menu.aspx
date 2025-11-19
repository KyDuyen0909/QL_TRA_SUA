<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="QL_TRA_SUA.Menu" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thực Đơn - Trà Sữa Đồng Tháp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Tải Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Tải Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            scroll-behavior: smooth;
        }

        /* Hiệu ứng Fade In cho trang */
        .fade-in-up {
            animation: fadeInUp 0.8s cubic-bezier(0.2, 0.8, 0.2, 1) forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        @keyframes fadeInUp {
            to { opacity: 1; transform: translateY(0); }
        }

        /* Thanh cuộn ẩn cho danh mục trên mobile */
        .hide-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .hide-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        /* Card sản phẩm */
        .product-card {
            transition: all 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .product-image-container {
            overflow: hidden;
        }
        .product-image {
            transition: transform 0.5s ease;
        }
        .product-card:hover .product-image {
            transform: scale(1.1);
        }

        /* Nút thêm vào giỏ */
        .btn-add-cart {
            background: linear-gradient(135deg, #4c673d 0%, #6b9a76 100%);
            transition: all 0.3s;
        }
        .btn-add-cart:hover {
            filter: brightness(1.1);
            transform: scale(1.05);
        }
        .btn-add-cart:active {
            transform: scale(0.95);
        }
        
        /* Category Active State */
        .category-btn.active {
            background-color: #4c673d;
            color: white;
            border-color: #4c673d;
        }
    </style>
</head>
<body class="bg-gray-50">
    <form id="form1" runat="server">
        
        <!-- 1. HEADER & BANNER -->
        <header class="relative bg-white shadow-sm sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
                <!-- Logo/Home Link -->
                <a href="WebForm1.aspx" class="text-2xl font-extrabold text-[#4c673d] tracking-tighter flex items-center gap-2">
                    <i class="fas fa-leaf"></i> ĐỒNG THÁP TEA
                </a>

                <!-- Giỏ hàng Mini -->
                <a href="GioHang.aspx" class="relative p-2 text-gray-600 hover:text-[#4c673d] transition">
                    <i class="fas fa-shopping-bag text-2xl"></i>
                    <asp:Label ID="lblCartCount" runat="server" CssClass="absolute top-0 right-0 bg-red-500 text-white text-xs font-bold rounded-full h-5 w-5 flex items-center justify-center" Text="0" Visible="false"></asp:Label>
                </a>
            </div>
        </header>

        <!-- Banner Khuyến Mãi -->
        <div class="relative bg-[#4c673d] text-white py-12 px-4 overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-full opacity-10 bg-[url('https://www.transparenttextures.com/patterns/food.png')]"></div>
            <div class="relative max-w-4xl mx-auto text-center fade-in-up">
                <h1 class="text-3xl md:text-5xl font-bold mb-4">Thực Đơn Hôm Nay</h1>
                <p class="text-lg md:text-xl text-green-100">Tươi ngon - Đậm vị - Giá hợp lý</p>
            </div>
        </div>

        <!-- 2. THANH DANH MỤC (STICKY) -->
        <div class="sticky top-16 z-40 bg-white/90 backdrop-blur-md border-b border-gray-200 shadow-sm">
            <div class="max-w-7xl mx-auto px-4 py-3">
                <div class="flex space-x-4 overflow-x-auto hide-scrollbar pb-1">
                    <!-- Repeater danh mục -->
                    <asp:Repeater ID="rptCategories" runat="server">
                        <ItemTemplate>
                            <a href="#cat-<%# Eval("ID_MN") %>" 
                               class="category-btn whitespace-nowrap px-5 py-2 rounded-full border border-gray-200 text-gray-600 font-semibold hover:border-[#4c673d] hover:text-[#4c673d] transition text-sm md:text-base">
                                <%# Eval("Label") %>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

        <!-- 3. DANH SÁCH SẢN PHẨM THEO DANH MỤC -->
        <div class="max-w-7xl mx-auto px-4 py-8 pb-24 space-y-12">
            
            <asp:Label ID="lblMessage" runat="server" EnableViewState="false" />

            <!-- Repeater bọc ngoài: Duyệt từng Danh mục -->
            <asp:Repeater ID="rptMenuSections" runat="server" OnItemDataBound="rptMenuSections_ItemDataBound">
                <ItemTemplate>
                    <section id='cat-<%# Eval("ID_MN") %>' class="scroll-mt-32 fade-in-up" style="animation-delay: 0.1s;">
                        <!-- Tiêu đề Danh mục -->
                        <div class="flex items-center mb-6">
                            <h2 class="text-2xl md:text-3xl font-bold text-gray-800 border-l-4 border-[#4c673d] pl-4">
                                <%# Eval("Label") %>
                            </h2>
                            <div class="h-px bg-gray-200 flex-grow ml-4"></div>
                        </div>

                        <!-- Grid Sản phẩm -->
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                            
                            <!-- Repeater con: Duyệt từng Sản phẩm trong Danh mục này -->
                            <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                                <ItemTemplate>
                                    <div class="product-card bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden flex flex-col h-full">
                                        
                                        <!-- Ảnh sản phẩm -->
                                        <div class="product-image-container relative h-56 bg-gray-100 cursor-pointer group">
                                            <img src='<%# ResolveUrl("~/Images/" + (string.IsNullOrEmpty(Eval("Hinh_anh") as string) ? "default.jpg" : Eval("Hinh_anh"))) %>' 
                                                 alt='<%# Eval("Ten_san_pham") %>'
                                                 class="product-image w-full h-full object-cover"
                                                 onerror="this.src='https://placehold.co/400x400/e2e8f0/64748b?text=No+Image'">
                                            
                                            <!-- Nút thêm nhanh (hiện khi hover) -->
                                            <div class="absolute inset-0 bg-black/20 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                                                <asp:LinkButton ID="btnQuickAdd" runat="server" CommandName="AddToCart" CommandArgument='<%# Eval("ID_SP") %>'
                                                    CssClass="bg-white text-[#4c673d] font-bold py-2 px-6 rounded-full shadow-lg hover:bg-[#4c673d] hover:text-white transition transform translate-y-4 group-hover:translate-y-0 duration-300">
                                                    <i class="fas fa-plus mr-1"></i> Thêm
                                                </asp:LinkButton>
                                            </div>
                                        </div>

                                        <!-- Thông tin sản phẩm -->
                                        <div class="p-5 flex flex-col flex-grow">
                                            <h3 class="text-lg font-bold text-gray-800 mb-1 line-clamp-2 min-h-[3.5rem]">
                                                <%# Eval("Ten_san_pham") %>
                                            </h3>
                                            
                                            <p class="text-gray-500 text-sm mb-4 line-clamp-2 flex-grow">
                                                <%# Eval("Mo_ta_san_pham") ?? "Hương vị tuyệt vời, đáng để thử!" %>
                                            </p>

                                            <div class="flex items-center justify-between mt-auto pt-4 border-t border-gray-50">
                                                <span class="text-xl font-bold text-[#4c673d]">
                                                    <%# Eval("Gia_co_ban", "{0:N0}") %>₫
                                                </span>
                                                
                                                <asp:LinkButton ID="btnAddToCart" runat="server" CommandName="AddToCart" CommandArgument='<%# Eval("ID_SP") %>'
                                                    CssClass="btn-add-cart h-10 w-10 rounded-full flex items-center justify-center text-white shadow-md shadow-green-200">
                                                    <i class="fas fa-cart-plus"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                    </section>
                </ItemTemplate>
            </asp:Repeater>
            
            <!-- Thông báo nếu không có sản phẩm -->
            <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="text-center py-20">
                <div class="text-6xl mb-4">🍵</div>
                <h3 class="text-2xl font-bold text-gray-400">Chưa có sản phẩm nào</h3>
                <p class="text-gray-500">Vui lòng quay lại sau nhé!</p>
            </asp:Panel>

        </div>

        <!-- Footer Navigation (Mobile Only) -->
        <div class="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-6 py-3 flex justify-between items-center z-50 shadow-[0_-4px_6px_-1px_rgba(0,0,0,0.05)]">
            <a href="Homepage.aspx" class="text-gray-400 hover:text-[#4c673d] flex flex-col items-center text-xs">
                <i class="fas fa-home text-xl mb-1"></i> Trang chủ
            </a>
            <a href="San_pham.aspx" class="text-[#4c673d] flex flex-col items-center text-xs font-bold">
                <i class="fas fa-mug-hot text-xl mb-1"></i> Menu
            </a>
            <a href="Gio_Hang.aspx" class="text-gray-400 hover:text-[#4c673d] flex flex-col items-center text-xs">
                <div class="relative">
                    <i class="fas fa-shopping-cart text-xl mb-1"></i>
                    <asp:Label ID="lblMobileCartCount" runat="server" CssClass="absolute -top-2 -right-2 bg-red-500 text-white text-[10px] font-bold rounded-full h-4 w-4 flex items-center justify-center" Text="0" Visible="false"></asp:Label>
                </div>
                Giỏ hàng
            </a>
        </div>

        <!-- Toast Notification (Hiển thị khi thêm giỏ hàng thành công) -->
        <div id="toast" class="fixed top-24 right-5 bg-white border-l-4 border-green-500 shadow-2xl rounded-lg p-4 transform translate-x-full transition-transform duration-300 z-[100] flex items-center gap-3" style="max-width: 300px;">
            <div class="text-green-500 text-xl"><i class="fas fa-check-circle"></i></div>
            <div>
                <h4 class="font-bold text-gray-800 text-sm">Thành công!</h4>
                <p id="toast-message" class="text-gray-600 text-xs">Đã thêm vào giỏ hàng.</p>
            </div>
        </div>

        <script>
            // Script để hiện Toast
            function showToast(productName) {
                const toast = document.getElementById('toast');
                const msg = document.getElementById('toast-message');
                msg.innerText = "Đã thêm " + productName + " vào giỏ.";
                toast.classList.remove('translate-x-full');
                setTimeout(() => {
                    toast.classList.add('translate-x-full');
                }, 3000);
            }
            
            // Script Highlight Active Category on Scroll
            document.addEventListener('DOMContentLoaded', () => {
                const sections = document.querySelectorAll('section[id^="cat-"]');
                const navLinks = document.querySelectorAll('.category-btn');

                window.addEventListener('scroll', () => {
                    let current = '';
                    sections.forEach(section => {
                        const sectionTop = section.offsetTop;
                        const sectionHeight = section.clientHeight;
                        if (scrollY >= (sectionTop - 200)) {
                            current = section.getAttribute('id');
                        }
                    });

                    navLinks.forEach(link => {
                        link.classList.remove('active');
                        if (link.getAttribute('href').includes(current)) {
                            link.classList.add('active');
                        }
                    });
                });
            });
        </script>

    </form>
</body>
</html>