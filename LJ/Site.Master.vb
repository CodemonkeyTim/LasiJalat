Public Class Site
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("cart") Is Nothing Then
            Session("cart") = New ArrayList
        End If
    End Sub

End Class