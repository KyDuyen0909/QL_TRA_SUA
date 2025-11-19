<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddBai_Viet.aspx.cs" Inherits="QL_TRA_SUA.AddBai_Viet"ValidateRequest="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sử dụng Textarea làm Editor</title>
    <style>
        .container {
            width: 80%;
            margin: 20px auto;
            font-family: Arial, sans-serif;
        }
        h2 {
            color: #507CD1;
        }
        .btn {
            margin: 10px 5px 20px 0;
            padding: 8px 15px; /* Tăng padding */
            background: #507CD1;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none; /* Cho HyperLink */
            display: inline-block; /* Cho HyperLink */
            line-height: normal; /* Cho HyperLink */
        }
        .btn-secondary {
            background: #6c757d; /* Màu xám cho nút Quay lại */
        }
        .btn:hover {
            background: #365fa3;
        }
        .btn-secondary:hover {
            background: #5a6268;
        }
        .result {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            background: #f9f9f9;
        }
        .action-buttons {
            margin-top: 10px;
            margin-bottom: 20px;
        }
    </style>
    
    <!-- Tích hợp TinyMCE -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/7.1.0/tinymce.min.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            // Khởi tạo TinyMCE trên TextBox (sử dụng ClientID)
            tinymce.init({
                selector: '#' + document.getElementById('<%= txtContentEditor.ClientID %>').id,
                plugins: 'anchor autolink charmap codesample emoticons link lists searchreplace table visualblocks wordcount',
                toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bulllist indent outdent | emoticons charmap | removeformat'
            });
        };
    </script>

</head>
<body>
    <form id="form1" runat="server">
        
        <div class="container">
            <h2>🖋️ Rich Text Editor Demo</h2>

            <!-- Thay thế RTE:Editor bằng asp:TextBox đa dòng -->
            <asp:TextBox ID="txtContentEditor" runat="server" 
                         TextMode="MultiLine" Rows="15" 
                         Width="100%" />

            <!-- Khu vực các nút thao tác -->
            <div class="action-buttons">
                <!-- Nút Lưu & Hiển thị -->
                <asp:Button ID="btnSave" runat="server" Text="Lưu & Hiển thị" CssClass="btn"
                            OnClick="btnSave_Click" />

                <!-- Nút Quay lại (sử dụng HyperLink để chuyển hướng đơn giản) -->
                <asp:HyperLink ID="hlBack" runat="server" NavigateUrl="~/Bai_Viet.aspx" 
                               CssClass="btn btn-secondary" Text="Quay lại Bài Viết" />

                <%-- Đã loại bỏ: <asp:Button ID="Button1" runat="server" Text="Button" /> --%>
            </div>
            
            <br />
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <!-- Hiển thị kết quả -->
            <div class="result">
                <asp:Literal ID="litResult" runat="server"></asp:Literal>
            </div>
        </div>
    </form>
</body>
</html>