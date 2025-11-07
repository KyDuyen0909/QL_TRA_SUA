<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Defult.aspx.cs" Inherits="QL_QUAN_TRA_SUA.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContent" Runat="Server">
    <asp:Label ID="lblWelcomeMessage" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>
    <br />
    Nội dung hiển thị tại Content
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderHotNews" Runat="Server">
    Nội dung hiển thị tại HotNews
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderBottom" Runat="Server">
    Nội dung hiển thị tại Bottom
</asp:Content>
