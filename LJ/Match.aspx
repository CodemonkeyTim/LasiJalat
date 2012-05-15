<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Match.aspx.vb" Inherits="LJ.Match" %>

<%@ Import Namespace="System.Data.OleDb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
                <% 
             Dim conn As OleDbConnection
             Dim cmd As OleDbCommand
             Dim reader As OleDbDataReader
             
             Dim application_path As String = Page.Server.MapPath("Default.aspx")
             application_path = application_path.Replace("Default.aspx", "")
             
             Dim connStr As String = "Provider=Microsoft.ACE.OLEDB.12.0;" _
                                & "Data Source = " & application_path & "App_Data\Game.mdb"
             
             conn = New OleDbConnection()
             conn.ConnectionString = connStr
             conn.Open()

             cmd = New OleDbCommand()
             cmd.CommandType = Data.CommandType.Text
             cmd.Connection = conn
             
                    Dim score As String = ""
                    Dim story As String = ""
                    Dim game_date As String = ""
                    Dim set_up As String = ""
                    
                    cmd.CommandText = "SELECT * FROM Game WHERE id = " & Request("game_id")
                    reader = cmd.ExecuteReader
             
                    If reader.Read() Then
                        set_up = reader.Item("team")
                        score = reader.Item("socore")
                        story = reader.Item("description")
                        game_date = reader.Item("Game_date")
                    End If
                    
                    
             %>

    <div class="equal">
        <div class="row">
            <div class="one">
                <h2><%= set_up %></h2>
                <p class="date"><%= game_date %></p>

                <h3><%= score %></h3
			 	<br />
		        <p><%= story %></p>
                <img src="/report/image/match<%= Request("game_id") %>.jpg"  alt="match1" width="280" height="300" />
            </div>            
        </div>
    </div>             

</asp:Content>
