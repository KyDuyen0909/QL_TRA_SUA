<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterAccount.aspx.cs" Inherits="QL_TRA_SUA.RegisterAccount" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng Ký Tài Khoản Khách Hàng</title>
    <style>
        /* CSS Cơ bản và Thiết lập Font */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f8ff; /* Màu nền nhẹ nhàng, xanh nhạt */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        /* Container chính của Form */
        .register-box {
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px; /* Chiều rộng cố định, đủ rộng */
        }

        /* Tiêu đề */
        h2 {
            text-align: center;
            color: #4a90e2; /* Màu xanh thương hiệu */
            margin-bottom: 25px;
            font-weight: 600;
        }
        
        /* Nhóm điều khiển Input */
        .input-group {
            margin-bottom: 15px;
        }

        /* Label */
        .input-group label {
            display: block;
            font-weight: 500;
            color: #555;
            margin-bottom: 5px;
        }

        /* Thiết kế cho TextBox và Input */
        .register-box input[type=text], 
        .register-box input[type=password], 
        .register-box textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box; /* Quan trọng để padding không làm tăng chiều rộng */
            transition: border-color 0.3s;
        }

        .register-box input:focus, .register-box textarea:focus {
            border-color: #4a90e2;
            outline: none;
            box-shadow: 0 0 5px rgba(74, 144, 226, 0.3);
        }

        /* Nút Đăng ký */
        .btn-register {
            width: 100%;
            padding: 12px;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s;
        }

        .btn-register:hover {
            background-color: #357bd8;
        }

        /* Thông báo lỗi và xác thực */
        .validation-error {
            color: #ff4d4f; /* Màu đỏ nổi bật */
            font-size: 0.85em;
            display: block;
            margin-top: 3px;
        }
        .message-label {
            text-align: center;
            margin-top: 15px;
            font-weight: bold;
        }

        /* Liên kết Đăng nhập */
        .login-link {
            text-align: center;
            margin-top: 25px;
            font-size: 0.9em;
            color: #777;
        }
        .login-link a {
            color: #4a90e2;
            text-decoration: none;
            font-weight: 500;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-box">
            <h2>Tạo Tài Khoản Khách Hàng</h2>
            
            <div class="input-group">
                <label for="<%= txtHoTen.ClientID %>">Họ và tên</label>
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator 
                    ID="ReqHoTen" runat="server" 
                    ControlToValidate="txtHoTen" 
                    ErrorMessage="* Vui lòng nhập họ tên." 
                    CssClass="validation-error" Display="Dynamic" />
            </div>
            
            <div class="input-group">
                <label for="<%= txtSoDienThoai.ClientID %>">Số điện thoại (Tên đăng nhập)</label>
                <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator 
                    ID="ReqSDT" runat="server" 
                    ControlToValidate="txtSoDienThoai" 
                    ErrorMessage="* Vui lòng nhập số điện thoại." 
                    CssClass="validation-error" Display="Dynamic" />
            </div>
            
            <div class="input-group">
                <label for="<%= txtDiaChi.ClientID %>">Địa chỉ (Tùy chọn)</label>
                <asp:TextBox ID="txtDiaChi" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" />
            </div>
            
            <div class="input-group">
                <label for="<%= txtMatKhau.ClientID %>">Mật khẩu</label>
                <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator 
                    ID="ReqMatKhau" runat="server" 
                    ControlToValidate="txtMatKhau" 
                    ErrorMessage="* Vui lòng nhập mật khẩu." 
                    CssClass="validation-error" Display="Dynamic" />
            </div>
            
            <div class="input-group">
                <label for="<%= txtXacNhanMatKhau.ClientID %>">Xác nhận mật khẩu</label>
                <asp:TextBox ID="txtXacNhanMatKhau" runat="server" TextMode="Password" CssClass="form-control" />
                <asp:CompareValidator 
                    ID="CompareMatKhau" runat="server" 
                    ControlToValidate="txtXacNhanMatKhau" 
                    ControlToCompare="txtMatKhau" 
                    Operator="Equal" Type="String" 
                    ErrorMessage="* Mật khẩu không khớp." 
                    CssClass="validation-error" Display="Dynamic" />
            </div>
            
            <asp:Button ID="btnDangKy" runat="server" Text="Đăng Ký Tài Khoản" OnClick="btnDangKy_Click" CssClass="btn-register" />

            <div class="message-label">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" EnableViewState="false" />
            </div>
            
            <div class="login-link">
                Đã có tài khoản? <a href="Login.aspx">Đăng nhập ngay</a>
            </div>
        </div>
    </form>
</body>
</html>