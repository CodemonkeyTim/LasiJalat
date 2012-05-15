<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="CheckOut.aspx.vb" Inherits="LJ.CheckOut" %>

<%@ Import Namespace="System.Data.OleDb" %>

<%@ Import Namespace="LJ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<asp:MultiView ID="checkout_multiview" runat="server" ActiveViewIndex="0">
        <asp:View ID="customer_info_view" runat="server">
            <div>
                <h3>Please fill in your customer information</h3>
                <p>
                    First Name
                    <br />
                    <asp:TextBox ID="f_name_txtbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="First name can't be empty!" ForeColor="Red" 
                        ControlToValidate="f_name_txtbox" Display="Dynamic"></asp:RequiredFieldValidator>
                </p>
                <p>
                    Last Name
                    <br />
                    <asp:TextBox ID="l_name_txtbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="l_name_txtbox" ErrorMessage="Last name can't be empty!" 
                        ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </p>
                <p>
                    Shipping Address
                    <br />
                    <asp:TextBox ID="shipping_address_txtbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="shipping_address_txtbox" 
                        ErrorMessage="Shipping Address can't be empty!" ForeColor="Red"></asp:RequiredFieldValidator>
                </p>
                <p>
                    City
                    <br />
                    <asp:TextBox ID="city_txtbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="city_txtbox" ErrorMessage="City can't be empty!" 
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </p>
                <p>
                    Postal/Zip Code
                    <br />
                    <asp:TextBox ID="postal_code_txtbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="postal_code_txtbox" 
                        ErrorMessage="Postal code can't be empty!" ForeColor="Red" 
                        Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                        ControlToValidate="postal_code_txtbox" ErrorMessage="Postal code is not valid!" 
                        ForeColor="Red" ValidationExpression="\d{5}" Display="Dynamic"></asp:RegularExpressionValidator>
                </p>
                <p>
                    Phone number
                    <br />
                    <asp:TextBox ID="phone_number_txtbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="phone_number_txtbox" 
                        ErrorMessage="Phone number can't be empty!" ForeColor="Red" 
                        Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="phone_number_txtbox" 
                        ErrorMessage="Phone number has to  be in format 040(0)-1234567!" 
                        ForeColor="Red" 
                        ValidationExpression="(\d{3}?|\d{4}?)-\d{3}\d{4}" Display="Dynamic"></asp:RegularExpressionValidator>
                </p>
                <p>
                    Email Address
                    <br />
                    <asp:TextBox ID="email_textbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="email_textbox" ErrorMessage="Email can't be empty!" 
                        ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="email_textbox" 
                        ErrorMessage="Email must be in format name@host.domain!" ForeColor="Red" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                        Display="Dynamic"></asp:RegularExpressionValidator>
                </p>
                <p>
                    <asp:Button ID="back_to_cart_btn" runat="server" Text="Back to cart" />
                    <asp:Button ID="proceed_from_cust_info_btn" runat="server" Text="Proceed" />
                </p>
            </div>
        </asp:View>
        <asp:View ID="confirmation_view" runat="server">
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
            <h3>Shopping cart</h3>
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
        <div>
            <h3>Customer information</h3>
            
            <table id="customer_info">
                <tr>
                    <td>Name</td>
                    <td><%= Session("customer").full_name %></td>
                </tr>
                <tr>
                    <td>Shipping Address</td>
                    <td><%= Session("customer").shipping_address%></td>
                </tr>
                <tr>
                    <td>Postal Code</td>
                    <td><%= Session("customer").postal_code%></td>
                </tr>
                <tr>
                    <td>City</td>
                    <td><%= Session("customer").city%></td>
                </tr>
                <tr>
                    <td>Phone Number</td>
                    <td><%= Session("customer").phone_number%></td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td><%= Session("customer").email%></td>
                </tr>
            </table>
        </div>

            <asp:Button ID="back_to_cust_info_btn" runat="server" 
                Text="Back to customer information" />
            <asp:Button ID="confirm_order_btn" runat="server" 
                Text="Confirm and send order" />

        <br />

        </asp:View>
    </asp:MultiView>
</asp:Content>
