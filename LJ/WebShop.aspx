<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="WebShop.aspx.vb" Inherits="LJ.WebForm7" %>

<%@ Import Namespace="LJ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<%@ Import Namespace="System.Data.OleDb" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
                 
                    If Not Request("category") Is Nothing Then
                        If category_name = Request("category") Then
                            Dim prod As ListProduct = New ListProduct(id, count, category_name, name, price, image_url, description)
                            products.Add(prod)
                        End If
                    Else
                        Dim prod As ListProduct = New ListProduct(id, count, category_name, name, price, image_url, description)
                        products.Add(prod)
                    End If
                    
                    notEoF = reader.Read()
                End While
             
                reader.Close()
        %>
    
    
    <div id="side_nav">
        <h3 id="side_nav_header">Find by category</h3>
        <ul style="border-style: none; border-width: 0px; padding: 0px; margin: 0px; list-style-type: none; list-style-image: none">
            <li class="side_nav_li"><a href="WebShop.aspx">All</a></li>
            <li class="side_nav_li"><a href="WebShop.aspx?category=Tickets">Tickets</a></li>
            <li class="side_nav_li"><a href="WebShop.aspx?category=Fan Items">Fan stuff</a></li>
        </ul>

        <ul id="cart_nav">
            <li class="side_nav_li" id="cart_nav_li"><a href="Cart.aspx">Cart</a></li>
        </ul>
    </div>

    <div id="products_panel">
        <% If Not Session("flash") = "" Then%>
            <div id="flash"><%= Session("flash") %></div>
        <%End If%>
        <%For Each product In products%>
            <div class="product">
                <a href="http://www.google.fi"><img src="<%= "images" + product.image_url %>" alt="Image of a product" /></a>
                <div class="names"><a><%= product.name %></a></div>
                <input class="product_btn" type="button" value="Details" onclick="window.location = 'Product.aspx?product_id=<%= product.id %>'" />
                <input class="product_btn" type="button" value="Add to cart" onclick="window.location = 'WebShop.aspx?product_id=<%= product.id %>'" />
            </div>
        <% Next %>
    </div>

</asp:Content>
