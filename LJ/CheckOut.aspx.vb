Imports System.Data.OleDb

Public Class CheckOut
    Inherits System.Web.UI.Page

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles proceed_from_cust_info_btn.Click
        Dim f_name As String = f_name_txtbox.Text
        Dim l_name As String = l_name_txtbox.Text
        Dim shipping_address As String = shipping_address_txtbox.Text
        Dim postal_code As Integer = Integer.Parse(postal_code_txtbox.Text)
        Dim city As String = city_txtbox.Text
        Dim phone_number As String = phone_number_txtbox.Text
        Dim email As String = email_textbox.Text

        Dim customer = New Customer(f_name, l_name, shipping_address, city, postal_code, phone_number, email)

        Session("customer") = customer

        checkout_multiview.ActiveViewIndex = checkout_multiview.ActiveViewIndex + 1
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles back_to_cart_btn.Click
        Response.Redirect("Cart.aspx")
    End Sub

    Protected Sub confirm_order_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles confirm_order_btn.Click
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

        cmd.CommandText = "INSERT INTO Customers (first_Name, last_Name, shipping_address, postal_code, city, phone_number, email) VALUES " & _
            "('" & Session("customer")._f_name & "', '" & Session("customer")._l_name & "', '" & Session("customer").shipping_address & "', '" & _
            Session("customer").postal_code & "', '" & Session("customer").city & "', '" & Session("customer").phone_number & "', '" & Session("customer").email & "')"
        cmd.ExecuteNonQuery()

        cmd.CommandText = "SELECT Customers.id FROM Customers"
        reader = cmd.ExecuteReader

        Dim hasNext As Boolean = reader.Read()
        Dim id As Integer = 0

        While hasNext
            id = Integer.Parse(reader.Item("id"))
            hasNext = reader.Read()
        End While

        reader.Close()

        For Each pair In Session("cart")
            cmd.CommandText = "INSERT INTO Orders (customer_id, product_id, quantity, order_date) VALUES " & _
            "('" & id & "', '" & pair(0) & "', '" & pair(1) & "', '" & Date.Today.Day & "." & Date.Today.Month & "." & Date.Today.Year & "')"
            cmd.ExecuteNonQuery()
        Next

        Session("cart") = Nothing
        Session("flash") = "Order was sent successfully"
        Response.Redirect("WebShop.aspx")
    End Sub

    Protected Sub back_to_cust_info_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles back_to_cust_info_btn.Click
        checkout_multiview.ActiveViewIndex = checkout_multiview.ActiveViewIndex - 1
    End Sub

    Protected Sub checkout_multiview_ActiveViewChanged(ByVal sender As Object, ByVal e As EventArgs)

    End Sub
End Class

Public Class Customer
    Public _f_name As String
    Public _l_name As String
    Public _shipping_address As String
    Public _city As String
    Public _postal_code As Integer
    Public _phone_number As String
    Public _email As String

    Sub New(ByVal f_name As String, ByVal l_name As String, ByVal shipping_address As String, _
            ByVal city As String, ByVal postal_code As Integer, ByVal phone_number As String, _
            ByVal email As String)
        _f_name = f_name
        _l_name = l_name
        _shipping_address = shipping_address
        _city = city
        _postal_code = postal_code
        _phone_number = phone_number
        _email = email
    End Sub

    Public ReadOnly Property full_name() As String
        Get
            Return _f_name & " " & _l_name
        End Get
    End Property

    Public ReadOnly Property shipping_address() As String
        Get
            Return _shipping_address
        End Get
    End Property

    Public ReadOnly Property city() As String
        Get
            Return _city
        End Get
    End Property

    Public ReadOnly Property postal_code() As String
        Get
            Return _postal_code
        End Get
    End Property

    Public ReadOnly Property phone_number() As String
        Get
            Return _phone_number
        End Get
    End Property

    Public ReadOnly Property email() As String
        Get
            Return _email
        End Get
    End Property

End Class