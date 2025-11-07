<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginList.aspx.cs" Inherits="QL_QUAN_TRA_SUA.LoginList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <title>Management Dashboard</title>
  <style>
      .container {
          margin: 30px auto;
          width: 95%;
          border: 1px solid #ccc;
          padding: 20px;
          border-radius: 10px;
          box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      }
      .section-separator {
          margin-top: 30px;
          padding-top: 20px;
          border-top: 1px solid #eee;
      }
  </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class ="container">
            <h2 style="text-align: center;"> QUẢN LÝ TÀI KHOẢN</h2>

            <h3 style="text-align: left;">👤 Account List</h3>
             <asp:DropDownList ID="ddlPhanQuyen" runat="server" width="246px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" style="margin-top: 20px" Height="82px">
               </asp:DropDownList>
                                     <br />
                                     <br />
            Họ Và Tên :<asp:TextBox ID="txtht" runat="server" Width="229px"></asp:TextBox> 
            Số Điện Thoại : <asp:TextBox ID="txtsdt" runat="server"></asp:TextBox> 
            Địa Chỉ  :<asp:TextBox ID="txtdchi" runat="server" Width="222px"></asp:TextBox> 
            Mật Khẩu: <asp:TextBox ID="txtmk" runat="server"></asp:TextBox> 

             <asp:Button ID="butAdd" runat="server" Text="Add" OnClick="butAdd_Click" />
             <br />

             <b><asp:Label ID="lblMessage" runat="server" Text="" ></asp:Label>
            <br />
            </b>
            <h3 style="text-align: left;"><asp:GridView ID="GridViewAccounts" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="So_dien_thoai" OnRowDeleting="GridView1_RowDeleting" Width="1237px" OnRowDataBound="GridView1_RowDataBound">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Ho_va_ten" HeaderText="Họ và Tên">
                    <FooterStyle Width="80px" />
                    <HeaderStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="So_dien_thoai" HeaderText="Số Điện Thoại">
                    <FooterStyle Width="80px" />
                    <HeaderStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Dia_Chi" HeaderText="Địa Chỉ">
                    <FooterStyle Width="80px" />
                    <HeaderStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Mat_khau" HeaderText="Mật Khẩu">
                    <FooterStyle Width="80px" />
                   
                    <HeaderStyle HorizontalAlign="Center" />
                   
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="So_dien_thoai" Text="Sửa" />
                    <asp:CommandField DeleteText="Xóa" ShowDeleteButton="True" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
            </h3>

        </div>
    </form>
</body>
</html>
