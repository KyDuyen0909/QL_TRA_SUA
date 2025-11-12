<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bai_viet.aspx.cs" Inherits="QL_TRA_SUA.Bai_viet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản Lý Bài Viết</title>
    <style>
        /* CSS Styling (tương tự trang Sản Phẩm) */
        body { font-family: 'Arial', sans-serif; background-color: #f4f7f6; color: #333; }
        .container {
            margin: 30px auto;
            width: 95%;
            max-width: 1400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 { color: #007bff; text-align: center; margin-bottom: 30px; }
        h3 { color: #555; border-bottom: 2px solid #eee; padding-bottom: 10px; margin-top: 20px; }
        
        .control-area {
            display: grid; /* Dùng Grid để sắp xếp form thêm mới */
            grid-template-columns: auto 1fr; /* Cột 1: Nhãn, Cột 2: Ô nhập */
            gap: 15px 10px;
            align-items: center;
            margin-bottom: 20px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }
        .control-area.filter-area { /* Dùng Flex cho vùng lọc */
             display: flex;
             flex-wrap: wrap;
             align-items: center;
             gap: 20px;
        }

        .control-area label { font-weight: bold; text-align: right; }
        .control-area input[type="text"], .control-area select, .control-area textarea {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box; /* Đảm bảo padding không làm vỡ layout */
        }
        .control-area textarea {
            min-height: 80px;
            resize: vertical;
        }
        .control-area .full-width {
            grid-column: 1 / -1; /* Cho phép control chiếm trọn 2 cột */
            display: flex;
            justify-content: flex-end; /* Đẩy nút Add về bên phải */
        }

        /* Nút */
        .action-button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px; 
            font-weight: bold;
            cursor: pointer;
            color: white;
            transition: background-color 0.3s, transform 0.1s;
        }
        .action-button:hover { transform: translateY(-1px); }
        .btn-add { background-color: #28a745; }
        .btn-add:hover { background-color: #1e7e34; }
        .btn-delete { background-color: #dc3545; }
        .btn-delete:hover { background-color: #c82333; }

        /* GridView Styling */
        .gridview-style {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .gridview-style th, .gridview-style td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
            vertical-align: middle;
        }
        .gridview-style th {
            background-color: #507CD1;
            color: white;
            font-size: 14px;
        }
        .gridview-style tr:nth-child(even) { background-color: #f6f6f6; }
        .gridview-style tr:hover { background-color: #e9ecef; }
        .gridview-style img { max-width: 100px; max-height: 100px; border-radius: 4px; }
        .gridview-style .col-tomtat {
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            text-align: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2> QUẢN LÝ BÀI VIẾT</h2>
            
            <div class="control-area filter-area">
                <label>Lọc theo Danh mục:</label>
                <asp:DropDownList ID="ddlFilterMenus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFilterMenus_SelectedIndexChanged">
                </asp:DropDownList>
                
                <asp:Button ID="butDeleteSelected" runat="server" Text="Xóa Bài Viết Đã Chọn" OnClick="butDeleteSelected_Click" CssClass="action-button btn-delete" />
            </div>

            <h3>➕ Thêm Bài Viết Mới</h3>
            <div class="control-area" style="background-color: #e9f7e9;">
                <label>Danh mục (Menu):</label>
                <asp:DropDownList ID="ddlAddMenu" runat="server">
                </asp:DropDownList>

                <label>Thứ tự (OrderKey):</label>
                <asp:TextBox ID="txtAddOrderKey" runat="server" Text="1" Width="100px" />
                
                <label>Tiêu đề:</label>
                <asp:TextBox ID="txtAddTieuDe" runat="server" />

                <label>Tóm tắt:</label>
                <asp:TextBox ID="txtAddTomTat" runat="server" TextMode="MultiLine" Rows="3" />

                <label>Nội dung đầy đủ:</label>
                <asp:TextBox ID="txtAddNoiDung" runat="server" TextMode="MultiLine" Rows="6" />

                <label>Hình ảnh đại diện:</label>
                <asp:FileUpload ID="fileUploadHinhAnh" runat="server" />

                <div class="full-width">
                    <asp:Button ID="butAdd" runat="server" Text="Thêm Bài Viết" OnClick="butAdd_Click" CssClass="action-button btn-add" />
                </div>
            </div>

            <b style="color: red; margin-top: 15px; display: inline-block;"><asp:Label ID="lblMessage" runat="server" Text=""></asp:Label></b>
            
            <h3>📋 Danh Sách Bài Viết</h3>

            <asp:GridView ID="GridViewBaiViet" runat="server" 
                AutoGenerateColumns="False" 
                CellPadding="4" 
                DataKeyNames="ID_BV" 
                ForeColor="#333333" 
                GridLines="None" 
                CssClass="gridview-style"
                OnRowDeleting="GridViewBaiViet_RowDeleting"
                OnRowEditing="GridViewBaiViet_RowEditing"
                OnRowUpdating="GridViewBaiViet_RowUpdating"
                OnRowCancelingEdit="GridViewBaiViet_RowCancelingEdit" OnSelectedIndexChanged="GridViewBaiViet_SelectedIndexChanged"
                >
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="ID_BV" HeaderText="ID_BV" ReadOnly="True" ItemStyle-Width="50px" >
                    
<ItemStyle Width="50px"></ItemStyle>
                    </asp:BoundField>
                    
                    <asp:TemplateField HeaderText="Hình ảnh" ItemStyle-Width="120px">
                        <ItemTemplate>
                            <asp:Image ID="imgBaiViet" runat="server" 
                                ImageUrl='<%# Eval("Hinh_anh_page", "~/Images/{0}") %>' 
                                Visible='<%# !string.IsNullOrEmpty(Eval("Hinh_anh_page") as string) %>'
                                AlternateText='<%# Eval("Tieu_de") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditHinhAnh" runat="server" Text='<%# Bind("Hinh_anh_page") %>' Width="100px"></asp:TextBox>
                        </EditItemTemplate>

<ItemStyle Width="120px"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Tiêu đề" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Tieu_de") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditTieuDe" runat="server" Text='<%# Bind("Tieu_de") %>' Width="95%"></asp:TextBox>
                        </EditItemTemplate>

<ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Tóm tắt" ItemStyle-CssClass="col-tomtat">
                         <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Tom_tac") %>'></asp:Label>
                         </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditTomTat" runat="server" Text='<%# Bind("Tom_tac") %>' Width="95%" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </EditItemTemplate>

<ItemStyle CssClass="col-tomtat"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="ID Menu" ItemStyle-Width="80px">
                         <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("ID_MN") %>'></asp:Label>
                         </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditIDMN" runat="server" Text='<%# Bind("ID_MN") %>' Width="60px"></asp:TextBox>
                        </EditItemTemplate>

<ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Thứ tự" ItemStyle-Width="80px">
                         <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("OrderKey") %>'></asp:Label>
                         </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditOrderKey" runat="server" Text='<%# Bind("OrderKey") %>' Width="60px"></asp:TextBox>
                        </EditItemTemplate>

<ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Chọn Xóa" ItemStyle-Width="70px">
                        <HeaderTemplate>
                            <asp:Button ID="butDelete" runat="server" OnClick="butDelete_Click" Text="Xóa" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkDelete" runat="server" />
                        </ItemTemplate>

<ItemStyle Width="70px"></ItemStyle>
                    </asp:TemplateField>
                    
                    <asp:CommandField ShowEditButton="True" EditText="Sửa" UpdateText="Lưu" CancelText="Hủy" ItemStyle-Width="80px" >
<ItemStyle Width="80px"></ItemStyle>
                    </asp:CommandField>
                    <asp:CommandField ShowDeleteButton="True" DeleteText="Xóa" ItemStyle-Width="80px" >
<ItemStyle Width="80px"></ItemStyle>
                    </asp:CommandField>
                </Columns>
                
                <EditRowStyle BackColor="#FFFFCC" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            </asp:GridView>

        </div>
    </form>
</body>
</html>