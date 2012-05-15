Public Class WebForm6
    Inherits System.Web.UI.Page
    Protected Sub Calendar2_Init(ByVal sender As Object, ByVal e As EventArgs) Handles Calendar2.Init
        Calendar2.SelectedDate = "2012/4/18"
        Calendar2.SelectedDate = "2012/4/27"
        Calendar2.SelectedDate = "2012/5/10"
        Calendar2.SelectedDate = "2012/5/15"
        Calendar2.SelectedDate = "2012/5/23"
    End Sub

    Protected Sub Calendar2_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Calendar2.Load
        Calendar2.SelectedDates.Add(New DateTime(2012, 4, 18))
        Calendar2.SelectedDates.Add(New DateTime(2012, 4, 27))
        Calendar2.SelectedDates.Add(New DateTime(2012, 5, 10))
        Calendar2.SelectedDates.Add(New DateTime(2012, 5, 15))
        Calendar2.SelectedDates.Add(New DateTime(2012, 5, 23))

    End Sub

End Class