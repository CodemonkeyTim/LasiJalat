<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Threads.aspx.vb" Inherits="LJ.Threads" %>

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
                    
                        cmd.CommandText = "SELECT * FROM Threads WHERE forum_id = " & Request("forum_id")
                    reader = cmd.ExecuteReader
                    
                        Dim threads As ArrayList = New ArrayList
                        
                        While reader.Read()
                            Dim values(2) As String
                            values(0) = reader.Item("id")
                            values(1) = reader.Item("Thread_title")
                            
                            threads.Add(values)
                    End while
                    
             %>

    <div id="forums_container">
        <table id="forums_table">
            <thead>
                <tr>
                    <th id="first">Thread title</th>
                </tr>
            </thead>
            <tbody>
                <% For Each thread In threads %>
                    <tr>
                        <td><a href="Thread.aspx?thread_id=<%= thread(0) %>"><%= thread(1) %></a></td>
                    </tr>    
                <% Next%>
            </tbody>
        </table>
    </div>
</asp:Content>
