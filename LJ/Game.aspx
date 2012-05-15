<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Game.aspx.vb" Inherits="LJ.WebForm6" %>

<%@ Import Namespace="System.Data.OleDb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
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
                    
                        cmd.CommandText = "SELECT id, team, game_date FROM Game WHERE Year = '2012'"
                    reader = cmd.ExecuteReader
                        Dim game_data As ArrayList = New ArrayList
                        
                        While reader.Read()
                            Dim values(3) As String
                            values(0) = reader.Item("id")
                            values(1) = reader.Item("team")
                            values(2) = reader.Item("game_date")
                            
                            game_data.Add(values)
                        End While
                    
             %>



    <div class="equal">
        <div class="row">
            <div class="one">
            
             <h1>World Championships of the Swamp Soccer, Lahden Suo-ja Lumijalkapallokerho LasiJalat</h1>

             <p>LJ local tournaments and tournaments arranged elsewhere both in swamp soccer and snow soccer is showing in the calendar. This is
             followed by the reporting results can be shown in below links. 
              </p>


              <h2>Latest Reports Headlines</h2>
              <div id="report">
              <ul>
            
                <%  For Each game_datum In game_data%>
                    <li><a href="/Match.aspx?game_id=<%= game_datum(0) %>"><%= game_datum(1)%> (<%= game_datum(2)%>)</a></li>
                <%  Next%>
              
              </ul>

             </div>

               <br />
               
                          
              <h2>Statistics</h2>
               <div>
              
              
              
              
                   <asp:DropDownList ID="CalendarYear" runat="server" DataSourceID="CaldendarYear" 
                       DataTextField="Year" DataValueField="Year" AutoPostBack="True">
                   </asp:DropDownList>
                   <asp:AccessDataSource ID="CaldendarYear" runat="server" 
                       DataFile="~/App_Data/Game.mdb" 
                       SelectCommand="SELECT DISTINCT [Year] FROM [Game]"></asp:AccessDataSource>
              
              
              
              
                  <asp:GridView ID="GridView2" runat="server" DataSourceID="Game" 
                      AutoGenerateColumns="False" ViewStateMode="Enabled">
                      <Columns>
                          <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" />
                          <asp:BoundField DataField="Team" HeaderText="Team" SortExpression="Team" />
                          <asp:BoundField DataField="Socore" HeaderText="Socore" 
                              SortExpression="Socore" />
                      </Columns>
                  </asp:GridView>
                  <asp:AccessDataSource ID="Game" runat="server" DataFile="~/App_Data/Game.mdb" 
                      
                       
                       
                       SelectCommand="SELECT [Time], [Team], [Socore] FROM [Game] WHERE ([Year] = ?)">
                      <SelectParameters>
                          <asp:ControlParameter ControlID="CalendarYear" DefaultValue="2012" Name="Year" 
                              PropertyName="SelectedValue" Type="String" />
                      </SelectParameters>
                   </asp:AccessDataSource>
              
              
              
              
              </div>
            

              </div>
  
             <div class="two">

                  <h2>Game Schedule</h2>
                  <p>
                      The Finland championship in Swamp soccer will take place&nbsp; in Helsinki arena 
                      on 3. – 5. August, 2012!<br />
                  </p>
                  <p>
                      All the matches can be found in the below dates.</p>
                      <br />
                  <p>
                      <asp:Calendar ID="Calendar2" runat="server" style="margin-left: 9px">
                          <TodayDayStyle BackColor="Aqua" />
                      </asp:Calendar>
                  </p>
                  <p>
                      <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                          DataSourceID="AccessDataSource1" Width="306px">
                          <Columns>
                              <asp:BoundField DataField="HomeTeam" HeaderText="HomeTeam" 
                                  SortExpression="HomeTeam" />
                              <asp:BoundField DataField="AwayTeam" HeaderText="AwayTeam" 
                                  SortExpression="AwayTeam" />
                              <asp:BoundField DataField="Time" HeaderText="Time" 
                                  SortExpression="Time" />
                              <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" 
                                  DataFormatString="{0:dd MMMM yyyy}" />
                          </Columns>
                      </asp:GridView>
                      <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
                          DataFile="~/App_Data/Calendar.mdb" 
                          SelectCommand="SELECT Team.TeamName AS HomeTeam, Team_1.TeamName AS AwayTeam, [Date].[Time], [Date].[Date] FROM (([Date] INNER JOIN Team ON [Date].HomeTeamID = Team.ID) INNER JOIN Team Team_1 ON [Date].AwayTeamID = Team_1.ID) WHERE ([Date].[Date] = ?)">
                          <SelectParameters>
                              <asp:ControlParameter ControlID="Calendar2" Name="?" 
                                  PropertyName="SelectedDate" />
                          </SelectParameters>
                      </asp:AccessDataSource>
                  </p>
                  <p>&nbsp;</p>
                 
              </div>
         </div>
        </div>
  
                
</asp:Content>
 