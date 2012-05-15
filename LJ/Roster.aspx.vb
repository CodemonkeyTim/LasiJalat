Imports System.Data.OleDb
Public Class WebForm2
    Inherits System.Web.UI.Page
    Dim MyConnection As OleDbConnection
    Dim MyCommand As OleDbCommand
    Dim MyReader As OleDbDataReader
    Private SelectedPlayer As Players

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim Connstr As String
        Dim application_path As String = Page.Server.MapPath("Default.aspx")
        application_path = application_path.Replace("Default.aspx", "")
        Connstr = "Provider = Microsoft.Jet.OLEDB.4.0;" & "Data Source = " & application_path & "App_Data\PlayerInfor.mdb;"
        MyConnection = New OleDbConnection()
        MyConnection.ConnectionString = Connstr
        MyConnection.Open()

        If (DropDownList1.Items.Count > 0) Then
            MyCommand = New OleDbCommand()
            MyCommand.Connection = MyConnection
            MyCommand.CommandText = "SELECT ID,Name,Position,Description,Age FROM PlayersInfor WHERE Name='" & DropDownList1.SelectedItem.Text & "'"
            MyCommand.CommandType = Data.CommandType.Text
        End If

        If Not IsPostBack Then
            DropDownList1.DataBind()
        End If

        SelectedPlayer = Me.GetSelectedPlayer()
        lblName.Text = SelectedPlayer.Name
        lblAge.Text = SelectedPlayer.Age
        lblPosition.Text = SelectedPlayer.Position
        lblDescription.Text = SelectedPlayer.Description
        ImagePlayer.ImageUrl = "PlayersPicture\" & SelectedPlayer.Picture
    End Sub

    Private Function GetSelectedPlayer() As Players
        Dim dvPlayer As DataView = CType( _
            AccessDataSource1.Select(DataSourceSelectArguments.Empty), DataView)
        dvPlayer.RowFilter = "ID = '" & DropDownList1.SelectedValue & "'"
        Dim Player As New Players
        Player.ID = dvPlayer(0)("ID").ToString
        Player.Name = dvPlayer(0)("Name").ToString
        Player.Age = dvPlayer(0)("Age")
        Player.Position = dvPlayer(0)("Position").ToString
        Player.Description = dvPlayer(0)("Description").ToString
        Player.Picture = dvPlayer(0)("Picture").ToString
        Return Player
    End Function
End Class
