Public Class WebForm8
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("flash") = ""
    End Sub

    Protected Sub delete_selected_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles delete_selected_btn.Click
        If Not Request("delete_choices") = "" Then
            Dim choises As Array = Request("delete_choices").Split(",")

            For Each choise In choises
                For Each Pair In Session("cart")
                    If Pair(0) = Integer.Parse(choise) Then
                        Session("cart").remove(Pair)
                        Exit For
                    End If
                Next
            Next
        End If
    End Sub

    Protected Sub proceed_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles proceed_btn.Click
        Response.Redirect("CheckOut.aspx")
    End Sub
End Class