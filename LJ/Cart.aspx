<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Cart.aspx.vb" Inherits="LJ.WebForm8" %>

<%@ Import Namespace="LJ" %>

<%@ Import Namespace="System.Data.OleDb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Your cart:</h2>
    <% If Session("cart").count = 0 Then %>
        <div>You don't have any items in your cart</div>
    <% else  %>
         <% 
             Dim conn As OleDbConnection
             Dim cmd As OleDbCommand
             Dim reader As OleDbDataReader
             
             Dim application_path As String = Page.Server.MapPath("Default.aspx")
             application_path = application_path.Replace("Default.aspx", "")
             
             Dim connStr As String = "Provider=Microsoft.ACE.OLEDB.12.0;" _
                                & "Data Source = " & application_path & "App_Data\WebShop.accdb"
        
             conn = New OleDbConnection()
             conn.ConnectionString = connStr
             conn.Open()

             cmd = New OleDbCommand()
             cmd.CommandType = Data.CommandType.Text
             cmd.Connection = conn
             
             cmd.CommandText = "SELECT Products.id, Products.product_name, Categories.category, Products.unit_price, Products.description, Products.image_url FROM Products INNER JOIN Categories ON Products.category_id = Categories.id"
             reader = cmd.ExecuteReader
             
             Dim products As new Collection
             
             Dim notEoF As Boolean = reader.Read()
             
             While notEoF
                 Dim id As Integer = Integer.Parse(reader.Item("id"))
                 Dim name As String = reader.Item("product_name")
                 Dim category_name As String = reader.Item("category")
                 Dim price As Decimal = Decimal.Parse(reader.Item("unit_price"))
                 Dim count As Integer = 0
                 Dim image_url As String = reader.Item("Image_url")
                 Dim description As String = reader.Item("description")
                 
                 For Each pair In Session("cart")
                     If pair(0) = id Then
                         count = pair(1)
                     End If
                 Next
                 
                 
                 Dim prod As ListProduct = New ListProduct(id, count, category_name, name, price, image_url, description)
                 products.Add(prod)
                 notEoF = reader.Read()
             End While
             
             reader.Close()
        %>
        <div>
            <table id="cart_table">
            <tr>
                <th>Product name</th>
                <th>Category</th>
                <th>Count</th>
                <th>Price</th>
                <th>Total</th>
                <th class="style1">Delete</th>
            </tr>

            <% Dim total As Decimal = 0 %>
            <% Dim row_total As Decimal = 0%>
            <% dim index As Integer = 1 %>

            <% For Each product In products%>        
                <% total = total + product.total %>
                <% If Not product.count = 0 Then%>
                <tr>
                        <td><%= product.name%></td>
                        <td><%= product.category%></td>
                        <td><%= product.count%></td>
                        <td><%= FormatNumber(product.price)%> €</td>
                        <td><%= FormatNumber(product.total)%> €</td>
                        <td class="style2"><input type="checkbox" name="delete_choices" value="<%= product.id %>" /> </td>
                    </tr>
                <% End If%>
            <% Next %>
            
         
            <tr>
                <td>Total</td>
                <td></td>
                <td></td>
                <td></td>
                <td><%= FormatNumber(total, 2) %> €</td>
            </tr>
        </table>
        </div>
    <% End If %>

    <br />
    
    <% If Not Session("cart").count = 0 Then %>
        <asp:Button ID="proceed_btn" runat="server" Text="Proceed to Checkout" />
            &nbsp;<%= Request("delete_choice") %>
        <asp:Button ID="delete_selected_btn" 
            runat="server" Text="Delete Selected" Width="160px" />
    <% end if  %>
</asp:Content>
