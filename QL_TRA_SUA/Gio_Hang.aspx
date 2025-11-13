<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gio_Hang.aspx.cs" Inherits="QL_TRA_SUA.Gio_Hang" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Giỏ Hàng Của Bạn</title>
    <style>
        body { font-family: 'Arial', sans-serif; background-color: #f4f7f6; color: #333; }
        .container {
            margin: 30px auto;
            width: 95%;
            max-width: 1200px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 { 
            color: #007bff; 
            text-align: center; 
            margin-bottom: 30px; 
            font-size: 2em;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        h2 i { margin-right: 10px; color: #ffc107; }

        h3 { color: #555; border-bottom: 2px solid #eee; padding-bottom: 10px; margin-top: 20px; }

        /* GridView Giỏ Hàng */
        .gridview-style {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .gridview-style th, .gridview-style td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
            vertical-align: middle;
        }
        .gridview-style th {
            background-color: #507CD1;
            color: white;
            font-size: 14px;
            text-transform: uppercase;
        }
        .gridview-style tr:nth-child(even) { background-color: #f6f6f6; }
        .gridview-style tr:hover { background-color: #e9ecef; }
        .gridview-style img { max-width: 80px; max-height: 80px; border-radius: 4px; object-fit: cover; border: 1px solid #ddd; }
        .gridview-style .product-name { font-weight: bold; font-size: 1.1em; color: #007bff; }
        .gridview-style .price { color: #dc3545; font-weight: bold; }
        .gridview-style input[type="text"] { width: 60px; padding: 5px; border: 1px solid #ccc; border-radius: 4px; text-align: center; }
        
        /* Vùng Tổng Tiền và Thanh Toán */
        .checkout-area {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #007bff;
        }
        .summary-total {
            flex-basis: 48%;
            font-size: 1.5em;
            font-weight: bold;
            color: #dc3545;
            text-align: right;
            padding-top: 10px;
        }
        .checkout-form {
            flex-basis: 48%;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #eee;
        }
        /* ... CSS cho form group giữ nguyên ... */
        .checkout-form .form-group { margin-bottom: 15px; }
        .checkout-form label { display: block; font-weight: bold; margin-bottom: 5px; }
        .checkout-form input[type="text"], 
        .checkout-form select, 
        .checkout-form textarea { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .checkout-form textarea { min-height: 70px; resize: vertical; }

        .action-button {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            color: white;
            font-size: 1.1em;
            transition: background-color 0.3s;
        }
        .btn-update { background-color: #007bff; color: white; padding: 5px 10px; font-size: 0.9em; border-radius: 3px; }
        .btn-delete { background-color: #dc3545; color: white; padding: 5px 10px; font-size: 0.9em; border-radius: 3px; }
        .btn-checkout { 
            background-color: #28a745; 
            box-shadow: 0 4px 6px rgba(40, 167, 69, 0.3);
        }
        .btn-checkout:hover { background-color: #1e7e34; }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .checkout-area { flex-direction: column; }
            .summary-total, .checkout-form { flex-basis: 100%; }
            .summary-total { text-align: left; margin-top: 20px; border-top: 1px dashed #ccc; padding-top: 15px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>🛒 Giỏ Hàng Của Bạn</h2>
            
            <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
            
            <asp:GridView ID="gvGioHang" runat="server" 
            AutoGenerateColumns="False" 
            DataKeyNames="ID_GH" 
            CssClass="gridview-style"
            OnRowCommand="gvGioHang_RowCommand"
            OnDataBound="gvGioHang_DataBound">
            <Columns>
                <%-- Cột MỚI: CheckBox để chọn thanh toán --%>
                <asp:TemplateField HeaderText="Chọn" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkChonThanhToan" runat="server" Checked="true" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sản Phẩm" ItemStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Image ID="imgHinhAnh" runat="server" 
                            ImageUrl='<%# Eval("Hinh_anh", "~/image/{0}") %>' 
                             Visible='<%# !string.IsNullOrEmpty(Eval("Hinh_anh") as string) %>'
                            AlternateText='<%# Eval("Ten_san_pham") %>' Width="80" Height="80" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Tên Sản Phẩm">
                    <ItemTemplate>
                        <div class="product-name"><%# Eval("Ten_san_pham") %></div>
                        <div style="font-size: 0.9em;">Đơn giá: <span class="price"><%# Eval("Gia_tai_thoi_diem", "{0:N0} VNĐ") %></span></div>
                        <div style="margin-top: 8px;">Ghi chú: 
                            <asp:TextBox ID="txtGhiChuItem" runat="server" Text='<%# Bind("Ghi_chu") %>' Width="150px" placeholder="Ít đá, thêm topping..." />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Số Lượng" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:TextBox ID="txtSoLuong" runat="server" Text='<%# Bind("So_luong") %>' Width="50px" TextMode="Number" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Thành Tiền" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <div class="price">
                            <%# Convert.ToDecimal(Eval("So_luong")) * Convert.ToDecimal(Eval("Gia_tai_thoi_diem")) == 0 
                                ? "0 VNĐ" 
                                : string.Format("{0:N0} VNĐ", Convert.ToDecimal(Eval("So_luong")) * Convert.ToDecimal(Eval("Gia_tai_thoi_diem"))) %>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Hành Động" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" Text="Cập nhật" CommandName="CapNhatItem" 
                            CommandArgument='<%# Eval("ID_GH") %>' CssClass="action-button btn-update" />
                        <br /><br />
                        <asp:LinkButton ID="btnDelete" runat="server" Text="Xóa" CommandName="XoaItem" 
                            CommandArgument='<%# Eval("ID_GH") %>' CssClass="action-button btn-delete" 
                            OnClientClick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

            <asp:Label ID="lblThongBaoTrong" runat="server" Text="Giỏ hàng của bạn đang trống." Visible="false" Font-Size="Large" />

            <!-- VÙNG TỔNG TIỀN VÀ THANH TOÁN -->
            <div class="checkout-area">
                
                <div class="checkout-form">
                    <h3>Thông Tin Đặt Hàng</h3>
                    <div class="form-group">
                        <label>Số điện thoại (Người nhận):</label>
                        <asp:TextBox ID="txtSoDienThoai" runat="server" ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ giao hàng:</label>
                        <asp:TextBox ID="txtDiaChiGiaoHang" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>Hình thức đặt hàng:</label>
                        <asp:DropDownList ID="ddlHinhThucDatDon" runat="server" Width="100%">
                            <asp:ListItem Value="Thanh toán khi nhận hàng" Selected="True">Thanh toán khi nhận hàng (COD)</asp:ListItem>
                            <asp:ListItem Value="Chuyển khoản">Chuyển khoản</asp:ListItem>
                            <asp:ListItem Value="Ví điện tử">Ví điện tử</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Ghi chú chung (cho đơn hàng):</label>
                        <asp:TextBox ID="txtGhiChuChung" runat="server" TextMode="MultiLine" Rows="3" />
                    </div>
                    <div class="form-group" style="text-align: right;">
                        <asp:Button ID="btnDatHang" runat="server" Text="TIẾN HÀNH ĐẶT HÀNG" OnClick="btnDatHang_Click" CssClass="action-button btn-checkout" />
                    </div>
                </div>

                <div class="summary-total">
                    TỔNG TIỀN CẦN THANH TOÁN:
                    <br />
                    <!-- lblTongTien sẽ được cập nhật bằng Code-behind dựa trên các mục được CHỌN -->
                    <asp:Label ID="lblTongTien" runat="server" Text="0 VNĐ" />
                </div>

            </div>
        </div>
    </form>
</body>
</html>