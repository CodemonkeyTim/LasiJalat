Public Class WebForm7
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("flash") = ""
        If Not Request("product_id") Is Nothing Then
            Dim value As Integer = Integer.Parse(Request("product_id"))
            Dim count As Integer = 0

            For Each pair In Session("cart")
                If pair(0) = value Then
                    count = pair(1)
                    Session("cart").remove(pair)
                    Exit For
                End If
            Next

            count = count + 1

            Dim value_pair(0 To 1) As Integer
            value_pair(0) = value
            value_pair(1) = count

            Session("cart").add(value_pair)
            Session("flash") = "Product was added to your cart"
        End If
    End Sub

End Class