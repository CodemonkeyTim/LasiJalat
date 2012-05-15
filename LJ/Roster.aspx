<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Roster.aspx.vb" Inherits="LJ.WebForm2" %>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 101px;
        }
        .style2
        {
            width: 350px;
        }
    </style>
   </asp:Content>

<asp:Content ID="Content1" runat="server" contentplaceholderid="mainContent">
    <div >
    
    </div>
        <div class="equal">
        <div class="row">
            <div class="one">
            
             <h1>Players Information</h1>
                <p>&nbsp;</p>
             <h2> Player List:&nbsp; 
                 <asp:DropDownList ID="DropDownList1" runat="server" 
                     DataSourceID="AccessDataSource1" DataTextField="Name" 
                     DataValueField="ID" AutoPostBack="True">
                 </asp:DropDownList>
                 <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
                     DataFile="~/App_Data/PlayerInfor.mdb" 
                     SelectCommand="SELECT * FROM [PlayersInfor]">
                 </asp:AccessDataSource>
                </h2>
                <p> 
                    &nbsp;</p> 
                    <table style="width:96%; margin-left: 49px;">
                        <tr>
                            <td class="style1" style="color: #DC143C; font-size: large">
                                Name:</td>
                            <td class="style2">
                                <asp:Label ID="lblName" runat="server" EnableTheming="True"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style1" style="color: #DC143C; font-size: large">
                                Age:</td>
                            <td class="style2">
                                <asp:Label ID="lblAge" runat="server"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style1" dir="ltr" style="color: #DC143C; font-size: large">
                                Position:</td>
                            <td class="style2">
                                <asp:Label ID="lblPosition" runat="server"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style1" style="color: #DC143C; font-size: large">
                                Description:</td>
                            <td class="style2">
                                <asp:Label ID="lblDescription" runat="server"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
   
            </div>
        
    
      
             <div class="two">

                <h2>Pictures:</h2>
                 <p>
                     <asp:Image ID="ImagePlayer" runat="server" Height="200px" 
                         style="margin-left: 0px" Width="207px" />
                 </p>
     
              </div>
         </div>
      </div>

      </asp:Content>


