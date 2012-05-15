<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Forum.aspx.vb" Inherits="LJ.WebForm5" %>

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
                                & "Data Source = " & application_path & "App_Data\Forum.accdb"
             
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
                    
                        cmd.CommandText = "SELECT * FROM Forums"
                    reader = cmd.ExecuteReader
                    
                        Dim forums As ArrayList = New ArrayList
                        
                        While reader.Read()
                            Dim values(3) As String
                            values(0) = reader.Item("id")
                            values(1) = reader.Item("forum_name")
                            values(2) = reader.Item("description")
                            
                            forums.Add(values)
                    End while
                    
             %>
    <div id="forums_container">
        <table id="forums_table">
            <thead>
                <tr>
                    <th id="first">Forum name</th>
                    <th id="second">Description</th>
                </tr>
            </thead>
            <tbody>
                <% For Each forum In forums%>
                    <tr>
                        <td><a href="Threads.aspx?forum_id=<%= forum(0) %>"><%= forum(1) %></a></td>
                        <td><%= forum(2) %></td>
                    </tr>    
                <% Next%>
            </tbody>
        </table>
    </div>
</asp:Content>

