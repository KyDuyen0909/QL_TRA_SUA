<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageList.aspx.cs" Inherits="QL_TRA_SUA.PageList" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Danh Sách Sản Phẩm & Đặt Hàng</title>
    <style>
        /* FONT & CHUNG */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F8F4F0; /* Màu nền ấm */
            margin: 0;
            padding: 0;
            color: #333;
            padding-top: 70px; /* Thêm padding để nội dung không bị che bởi Fixed Header */
        }

        /* FIXED HEADER / NAVIGATION BAR */
        .fixed-header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #000000; /* Thay đổi sang màu đen như mẫu */
            color: white;
            z-index: 1000;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 30px;
        }
        .fixed-header h1 {
            font-size: 1.5em; /* Kích thước nhỏ hơn để vừa với menu nav */
            letter-spacing: 1px;
            margin: 0;
            font-weight: 500;
        }
        /* MÔ PHỎNG MENU NAV TOP (chỉ dùng h1 làm logo) */
        .fixed-header h1::before {
            content: 'ToCoToCo Tea'; 
            font-weight: 700;
            font-size: 1.2em;
            margin-right: 20px;
            color: #F3A953; /* Màu vàng cam */
        }


        /* CONTAINER & LAYOUT */
        .main-content-wrapper {
            width: 95%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 0;
            display: flex;
            gap: 30px;
        }
        .sidebar {
            width: 250px;
            flex-shrink: 0;
            padding-right: 20px;
        }
        .product-content {
            flex-grow: 1;
        }
        
        /* SIDEBAR MENU (LỌC DANH MỤC) */
        .sidebar-menu {
            padding: 0;
            list-style: none;
        }
        .sidebar-menu-item {
            font-size: 1.1em;
            padding: 10px 0;
            color: #4A3325;
            cursor: pointer;
            transition: color 0.2s, background-color 0.2s;
            font-weight: 600;
            text-transform: uppercase;
        }
        .sidebar-menu-item.active, .sidebar-menu-item:hover {
            color: #F3A953;
        }

        /* CONTROL BAR (Dropdown ẩn đi, chỉ dùng cho mobile) */
        .control-bar {
            display: none; 
        }
        #ddlCategories {
            /* Giữ lại style cho mobile */
            padding: 10px 15px;
            border-radius: 8px;
            border: 1px solid #D4B097;
            font-size: 1em;
            background-color: #FEFCF7;
            cursor: pointer;
            width: 100%;
        }

        /* MESSAGE BOX */
        .message-box {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 600;
            text-align: center;
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* PRODUCT GRID */
        .section-title {
            font-size: 2em;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
            color: #4A3325;
            text-transform: uppercase;
        }
        .category-title {
            font-size: 1.5em;
            font-weight: 700;
            color: #4A3325;
            margin-bottom: 20px;
            border-bottom: 2px solid #F3A953;
            padding-bottom: 5px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); /* Điều chỉnh nhỏ hơn để vừa 4 cột */
            gap: 20px;
            margin-bottom: 40px;
        }
        .product-item {
            background-color: white;
            border-radius: 8px; /* Bo tròn ít hơn */
            box-shadow: none; /* Bỏ box-shadow cho layout nhẹ nhàng hơn */
            border: 1px solid #eee;
            overflow: hidden;
            text-align: center;
            transition: transform 0.3s ease;
            position: relative;
        }
        .product-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        /* DISCOUNT BADGE */
        .discount-badge {
            position: absolute;
            top: 0;
            left: 0;
            background-color: #4A3325; /* Màu nâu đen */
            color: white;
            padding: 5px 10px;
            font-size: 0.9em;
            font-weight: 700;
            border-bottom-right-radius: 8px;
            z-index: 10;
        }

        .product-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .product-info {
            padding: 15px;
        }
        .product-name {
            font-size: 1em;
            font-weight: 600;
            color: #4A3325;
            margin-bottom: 5px;
            height: 40px; /* Chiều cao cố định để không bị xê dịch */
            overflow: hidden;
        }
        .product-price {
            font-size: 1.1em;
            font-weight: 800;
            color: #E74C3C; 
            margin-bottom: 5px;
        }
        .original-price {
            color: #999;
            font-size: 0.8em;
            text-decoration: line-through;
            margin-right: 10px;
            font-weight: 400;
        }
        
        /* CONTROLS (Quantity & Button) */
        .product-controls {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 5px;
            margin-top: 10px;
        }

        /* QUANTITY INPUT (Lưu ý: Input Quantity trong ListView ItemTemplate bị ẩn) */
        #txtQuantity {
            display: none; 
        }
        .btn-order {
            background-color: #F3A953; /* Đổi màu nút MUA HÀNG sang màu cam */
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            width: 100%;
            transition: background-color 0.2s;
        }
        .btn-order:hover {
            background-color: #e09944;
        }
        /* Nút trong ListView */
        .product-item .btn-order {
            background-color: #5AA96E; /* Xanh lá cho nút Thêm vào Giỏ hàng */
        }
        .product-item .btn-order:hover {
            background-color: #4a9160;
        }
        
        /* CART BUTTON STYLING (In Fixed Header) */
        #btnViewCart {
            background-color: #F3A953; 
            box-shadow: none;
            font-size: 0.9em;
            padding: 8px 15px;
            border-radius: 5px;
            width: auto; 
            margin: 0;
        }
        #btnViewCart:hover {
            background-color: #e09944;
        }
        
        /* RESPONSIVE */
        @media (max-width: 900px) {
            .sidebar {
                display: none;
            }
            .main-content-wrapper {
                flex-direction: column;
            }
            .control-bar {
                display: flex; /* Hiện dropdown lọc danh mục cho mobile */
                justify-content: flex-start;
                align-items: center;
                margin-bottom: 20px;
            }
        }

        @media (max-width: 600px) {
            body {
                padding-top: 80px;
            }
            .fixed-header h1 {
                font-size: 1.2em;
            }
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 15px;
            }
            .product-img {
                height: 150px;
            }
        }
        
        /* ======================================= */
        /* MODAL STYLING (HỘP THOẠI ĐẶT HÀNG NHANH) */
        /* ======================================= */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 2000;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s, visibility 0.3s;
        }
        .modal-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .quick-order-modal {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 750px;
            max-height: 90vh;
            overflow-y: auto;
            transform: scale(0.95);
            transition: transform 0.3s ease-out;
        }
        .modal-overlay.active .quick-order-modal {
            transform: scale(1);
        }

        .modal-header {
            background-color: #9D7660; /* Màu nền header modal */
            color: white;
            padding: 15px 20px;
            font-size: 1.2em;
            font-weight: 700;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .modal-close {
            background: none;
            border: none;
            color: white;
            font-size: 1.5em;
            cursor: pointer;
            transition: color 0.2s;
        }
        .modal-close:hover {
            color: #F3A953;
        }

        .modal-body {
            display: flex;
            padding: 20px;
            gap: 20px;
        }
        
        /* Product Info Side */
        .modal-product-info {
            flex: 1;
            padding-right: 20px;
            border-right: 1px solid #eee;
        }
        .modal-product-image {
            width: 100%;
            max-width: 200px;
            height: auto;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .modal-product-name {
            font-size: 1.2em;
            font-weight: 700;
            color: #4A3325;
            margin-bottom: 5px;
        }
        .modal-product-price-current {
            font-size: 1.4em;
            font-weight: 800;
            color: #E74C3C;
        }
        .modal-product-price-original {
            color: #999;
            font-size: 0.9em;
            text-decoration: line-through;
            margin-right: 10px;
            font-weight: 400;
        }
        .modal-quantity-control {
            display: flex;
            align-items: center;
            margin-top: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 120px;
        }
        .modal-quantity-control button {
            width: 30px;
            height: 30px;
            border: none;
            background-color: #f7f7f7;
            cursor: pointer;
            font-size: 1.2em;
            line-height: 1;
        }
        .modal-quantity-control button:hover {
            background-color: #eee;
        }
        .modal-quantity-control input {
            width: 60px;
            height: 30px;
            text-align: center;
            border: none;
            font-weight: 600;
            -moz-appearance: textfield; /* Firefox */
        }
        .modal-quantity-control input::-webkit-outer-spin-button,
        .modal-quantity-control input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Customer Info Side */
        .modal-customer-form {
            flex: 1.5;
        }
        .modal-customer-form h3 {
            font-size: 1.1em;
            font-weight: 600;
            color: #4A3325;
            margin-top: 0;
            margin-bottom: 15px;
        }
        .form-row {
            margin-bottom: 15px;
        }
        .form-row label {
            display: block;
            font-size: 0.9em;
            font-weight: 600;
            margin-bottom: 5px;
        }
        .form-row input[type="text"],
        .form-row textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1em;
        }
        .form-row textarea {
            height: 80px;
            resize: vertical;
        }
        .modal-total-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-top: 1px solid #eee;
            margin-top: 20px;
        }
        .modal-total-label {
            font-size: 1.2em;
            font-weight: 600;
            color: #333;
        }
        .modal-total-amount {
            font-size: 1.5em;
            font-weight: 800;
            color: #E74C3C;
        }
        .modal-action-button {
            text-align: right;
            margin-top: 10px;
        }
        
        /* Responsive for Modal */
        @media (max-width: 768px) {
            .modal-body {
                flex-direction: column;
            }
            .modal-product-info {
                border-right: none;
                padding-right: 0;
                border-bottom: 1px solid #eee;
                padding-bottom: 20px;
                text-align: center;
            }
            .modal-product-image {
                max-width: 150px;
                margin-left: auto;
                margin-right: auto;
            }
            .modal-quantity-control {
                margin: 15px auto 0;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        
        <!-- FIXED HEADER (Mô phỏng Thanh điều hướng Top) -->
        <div class="fixed-header">
            <h1>TRANG CHỦ / TRÀ SỮA</h1> 
            <asp:Button ID="btnViewCart" runat="server" Text="🛒 ĐẶT HÀNG NHANH" OnClick="btnViewCart_Click" CssClass="btn-order"/>
        </div>

        <div class="main-content-wrapper">
            
            <!-- SIDEBAR MENU -->
            <div class="sidebar">
                <div class="category-title" style="border-bottom: none; margin-bottom: 10px;">MENU</div>
                <div id="sidebarCategories" runat="server" class="sidebar-menu">
                    <!-- Các items sẽ được thêm bằng code-behind -->
                </div>
            </div>

            <!-- PRODUCT CONTENT -->
            <div class="product-content">
                <!-- Message Box (Sử dụng UpdatePanel để cập nhật thông báo không cần refresh) -->
                <asp:UpdatePanel ID="upMessage" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblMessage" runat="server" CssClass="message-box" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
                
                <h2 class="section-title">SẢN PHẨM NỔI BẬT</h2>
                
                <div class="control-bar">
                    <div class="category-filter">
                        <h3>Lọc theo Danh mục:</h3>
                        <asp:DropDownList ID="ddlCategories" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                </div>

                <div class="category-title">TRÀ SỮA</div> 

                <!-- DANH SÁCH SẢN PHẨM -->
                <div class="product-grid">
                    <asp:ListView ID="lvProducts" runat="server" DataKeyNames="ID_SP" OnItemCommand="lvProducts_ItemCommand">
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholder"></div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="product-item">
                                <!-- Nhãn giảm giá (Hardcode để giống mẫu) -->
                                <div class="discount-badge">-<%# new Random().Next(10, 50) %>%%</div> 
                                
                                <asp:Image ID="imgProduct" runat="server" 
                                    ImageUrl='<%# Eval("Hinh_anh", "images/{0}") %>' 
                                    AlternateText='<%# Eval("Ten_san_pham") %>' 
                                    CssClass="product-img" 
                                    OnError="this.onerror=null;this.src='https://placehold.co/220x200/9D7660/FFFFFF?text=Milktea+Item';" />
                                
                                <div class="product-info">
                                    <div class="product-name"><%# Eval("Ten_san_pham") %></div>
                                    
                                    <div style="margin-top: auto;">
                                        <!-- Giả định giá mới là 25.000 VNĐ -->
                                        <div class="product-price">
                                            <span class="original-price"><%# Eval("Gia_co_ban", "{0:N0}₫") %></span>
                                            25.000₫ 
                                        </div>
                                        
                                        <div class="product-controls">
                                            <!-- Nút MUA HÀNG thay cho AddToCart -->
                                            <asp:Button ID="btnQuickOrder" runat="server" Text="MUA HÀNG" CommandName="QuickOrder" CommandArgument='<%# Eval("ID_SP") %>' CssClass="btn-order" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <div class="message-box" style="background-color: #FEFCF7; border-color: #D4B097; color: #6A4E3A; ">Không tìm thấy sản phẩm nào trong danh mục này hoặc sản phẩm đã hết hàng.</div>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
        
        <!-- ======================================= -->
        <!-- MODAL ĐẶT HÀNG NHANH -->
        <!-- ======================================= -->
        <div id="quickOrderModal" class="modal-overlay">
            <div class="quick-order-modal">
                <div class="modal-header">
                    <span>ĐẶT MUA <asp:Label ID="lblModalProductNameHeader" runat="server" /></span>
                    <button type="button" class="modal-close" onclick="closeModal(); return false;">&times;</button>
                </div>
                
                <asp:UpdatePanel ID="upModalContent" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <!-- Cột 1: Thông tin Sản phẩm -->
                            <div class="modal-product-info">
                                <asp:Image ID="imgModalProduct" runat="server" CssClass="modal-product-image" />
                                <div class="modal-product-name"><asp:Label ID="lblModalProductName" runat="server" /></div>
                                
                                <div style="margin-top: 10px;">
                                    <span class="modal-product-price-original"><asp:Label ID="lblModalProductPriceOriginal" runat="server" /></span>
                                    <span class="modal-product-price-current"><asp:Label ID="lblModalProductPrice" runat="server" Text="25.000₫" /></span>
                                </div>
                                
                                <div class="modal-quantity-control">
                                    <!-- Nút giảm số lượng: Dùng __doPostBack -->
                                    <button type="button" onclick="changeQuantity('decrease', '<%= txtModalQuantity.ClientID %>'); return false;">-</button>
                                    <asp:TextBox ID="txtModalQuantity" runat="server" Text="1" TextMode="Number" AutoPostBack="true" OnTextChanged="txtModalQuantity_TextChanged" />
                                    <!-- Nút tăng số lượng: Dùng __doPostBack -->
                                    <button type="button" onclick="changeQuantity('increase', '<%= txtModalQuantity.ClientID %>'); return false;">+</button>
                                </div>
                                
                                <p style="font-size: 0.85em; color: #666; margin-top: 15px;">
                                    Vui lòng nhập đúng số điện thoại để chúng tôi sẽ gọi xác nhận đơn hàng trước khi giao hàng. Xin cảm ơn!
                                </p>
                            </div>
                            
                            <!-- Cột 2: Form Thông tin người mua -->
                            <div class="modal-customer-form">
                                <h3>Thông tin người mua</h3>
                                
                                <div class="form-row">
                                    <div style="display: flex; gap: 20px;">
                                        <asp:RadioButton ID="rbAnh" runat="server" GroupName="Gender" Text="Anh" Checked="true" />
                                        <asp:RadioButton ID="rbChi" runat="server" GroupName="Gender" Text="Chị" />
                                    </div>
                                </div>

                                <div class="form-row" style="display: flex; gap: 10px;">
                                    <div style="flex: 1;">
                                        <label for="txtModalFullName">Họ và tên</label>
                                        <asp:TextBox ID="txtModalFullName" runat="server" placeholder="Họ và tên" />
                                    </div>
                                    <div style="flex: 1;">
                                        <label for="txtModalPhone">Số điện thoại (*)</label>
                                        <asp:TextBox ID="txtModalPhone" runat="server" placeholder="Số điện thoại" />
                                    </div>
                                </div>
                                
                                <div class="form-row">
                                    <label for="txtModalAddress">Địa chỉ (Không bắt buộc)</label>
                                    <asp:TextBox ID="txtModalAddress" runat="server" placeholder="Địa chỉ giao hàng" />
                                </div>
                                
                                <div class="form-row">
                                    <label for="txtModalNote">Ghi chú đơn hàng (Không bắt buộc)</label>
                                    <asp:TextBox ID="txtModalNote" runat="server" TextMode="MultiLine" placeholder="Ví dụ: Ít đường, thêm trân châu..." />
                                </div>
                                
                                <div class="modal-total-section">
                                    <span class="modal-total-label">Tổng cộng:</span>
                                    <span class="modal-total-amount"><asp:Label ID="lblModalTotalAmount" runat="server" /></span>
                                </div>
                                
                                <div class="modal-action-button">
                                    <asp:Button ID="btnPlaceQuickOrder" runat="server" Text="ĐẶT HÀNG NGAY" OnClick="btnPlaceQuickOrder_Click" CssClass="btn-order" />
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <!-- Thêm trigger từ chính nút "ĐẶT HÀNG NGAY" để khi có lỗi validation,
                             nó có thể cập nhật thông báo và tự động mở lại modal -->
                        <asp:AsyncPostBackTrigger ControlID="btnPlaceQuickOrder" EventName="Click" />
                        <!-- Cần Trigger từ Quantity Textbox để cập nhật tổng tiền -->
                        <asp:AsyncPostBackTrigger ControlID="txtModalQuantity" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>

            </div>
        </div>
        
        <!-- Javascript cho Modal và Quantity Control (Đã được đơn giản hóa) -->
        <script type="text/javascript">
            // Mở Modal
            function openModal() {
                document.getElementById('quickOrderModal').classList.add('active');
            }

            // Đóng Modal
            function closeModal() {
                document.getElementById('quickOrderModal').classList.remove('active');
            }

            // Điều chỉnh số lượng và kích hoạt PostBack
            function changeQuantity(action, txtClientID) {
                var txtQty = document.getElementById(txtClientID);
                if (!txtQty) return false;

                var currentVal = parseInt(txtQty.value) || 1;
                var newVal = currentVal;

                if (action === 'increase') {
                    newVal = currentVal + 1;
                } else if (action === 'decrease' && currentVal > 1) {
                    newVal = currentVal - 1;
                }

                if (newVal !== currentVal) {
                    txtQty.value = newVal;
                    // Kích hoạt PostBack để cập nhật tổng tiền
                    // Thay thế cho __doPostBack bị lỗi trước đó
                    var eventTarget = txtClientID;
                    var eventArgument = '';
                    if (typeof (WebForm_DoPostBackWithOptions) == 'function') {
                        WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(eventTarget, eventArgument, true, '', '', false, true));
                    } else if (typeof (__doPostBack) == 'function') {
                        __doPostBack(eventTarget, eventArgument);
                    }
                }
                return false;
            }
        </script>
        
    </form>
</body>
</html>