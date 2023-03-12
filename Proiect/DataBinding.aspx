<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBinding.aspx.cs" Inherits="Proiect.DataBinding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 2390px;
        }
        .button {
  background-color:#008CBA;
   border: 1px solid white;
  border-radius: 10px;
  color: white;
  padding: 8px 8px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
  
            <asp:Label ID="Label27" runat="server" Font-Bold="True" Font-Size="XX-Large" Text="   Date despre zborurile din perioada viitoare " BorderStyle="None" Font-Strikeout="False" Font-Underline="False" ForeColor="#0000CC" BorderColor="#FF99CC"></asp:Label>
            <br /> <br />
        <div style ="border-top: 3px solid gray; padding: 1px">
        <asp:SqlDataSource ID="DropDownComapniiDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [CompanieAeriana]"></asp:SqlDataSource>
            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Aeronavele in uz pentru fiecare companie aeriana"></asp:Label>
 
            <br />
            <asp:Label ID="Label11" runat="server" Text="Companie aeriana"></asp:Label>
 
            <br />
 
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" BackColor="#D5D5FF" Font-Overline="False" Height="52px" style="margin-bottom: 51px" Width="402px" DataSourceID="DropDownListAeronave" DataTextField="denumire" DataValueField="Id">
        </asp:DropDownList>
            <asp:SqlDataSource ID="DropDownListAeronave" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeronava]"></asp:SqlDataSource>
            <br />
            <asp:Label ID="Label12" runat="server" Text="Aeronave"></asp:Label>
        <asp:GridView ID="GVAeronave" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="GridViewAeronaveDS" ForeColor="#333333" GridLines="None" OnRowCancelingEdit="GVAeronave_RowCancelingEdit" OnRowUpdated="GVAeronave_RowUpdated" OnRowUpdating="GVAeronave_RowUpdating" ShowFooter="True">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Button class="button button1" ID="btnAeronaveInsert" runat="server" OnClick="btnAeronaveInsert_Click" Text="Inserare" />
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Select" Text="Select" Visible="False"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Id" InsertVisible="False" SortExpression="Id" Visible="False">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Denumire" SortExpression="denumire">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("denumire") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtAeronavaDenumire" runat="server"></asp:TextBox>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("denumire") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Numar Locuri" SortExpression="nrLocuri">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("nrLocuri") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtAeronaveNrLocuri" runat="server"></asp:TextBox>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("nrLocuri") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Companie Aeriana" SortExpression="idCompanieAeriana">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="DropDownCompanieDS" DataTextField="denumire" DataValueField="Id" SelectedValue='<%# Bind("idCompanieAeriana") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownCompanieDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [CompanieAeriana]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:DropDownList ID="DropDownAeronaveCompanieAeriana" runat="server" DataSourceID="InsertAeronaveCompanieAerianaDS" DataTextField="denumire" DataValueField="Id">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="InsertAeronaveCompanieAerianaDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [CompanieAeriana]"></asp:SqlDataSource>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("idCompanieAeriana") %>' Visible="False"></asp:Label>
                        <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="SqlDataSourceTRY" DataTextField="denumire" DataValueField="Id" Enabled="False" SelectedValue='<%# Bind("idCompanieAeriana") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceTRY" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [CompanieAeriana]"></asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
            <br />
            <asp:Label ID="LabelMessage" runat="server" ForeColor="Red"></asp:Label>
        <asp:SqlDataSource ID="GridViewAeronaveDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" DeleteCommand="DELETE FROM [Aeronava] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Aeronava] ([denumire], [nrLocuri], [idCompanieAeriana]) VALUES (@denumire, @nrLocuri, @idCompanieAeriana)" SelectCommand="SELECT * FROM [Aeronava] WHERE ([idCompanieAeriana] = @idCompanieAeriana)" UpdateCommand="UPDATE [Aeronava] SET [denumire] = @denumire, [nrLocuri] = @nrLocuri, [idCompanieAeriana] = @idCompanieAeriana WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="denumire" Type="String" />
                <asp:Parameter Name="nrLocuri" Type="Int32" />
                <asp:Parameter Name="idCompanieAeriana" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="idCompanieAeriana" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="denumire" Type="String" />
                <asp:Parameter Name="nrLocuri" Type="Int32" />
                <asp:Parameter Name="idCompanieAeriana" Type="Int32" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br /> 
        <br />
        </div>
        <br />
        <div style ="border-top: 3px solid gray; padding: 1px">

            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Zboruri viitoare pentru fiecare aeronava"></asp:Label>
           
              <br />
            Data Plecare
            <asp:DropDownList ID="DropDownDataPlecare" runat="server" DataSourceID="DSData" DataTextField="dataPlecare" DataValueField="dataPlecare">
            </asp:DropDownList>
            <asp:SqlDataSource ID="DSData" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT DISTINCT * FROM [Zbor]"></asp:SqlDataSource>
           
              <br />
            <asp:Label ID="Label13" runat="server" Text="Aeronave"></asp:Label>
           
              <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlGridViewAeronaveDS" GridLines="None" AllowPaging="True" AllowSorting="True" ForeColor="#333333">
                  <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
                    <asp:BoundField DataField="denumire" HeaderText="Denumire" SortExpression="denumire" />
                    <asp:TemplateField HeaderText="Locuri" SortExpression="nrLocuri">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("nrLocuri") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("nrLocuri") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Companie Aeriana" SortExpression="idCompanieAeriana">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("idCompanieAeriana") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("idCompanieAeriana") %>' Visible="False"></asp:Label>
                            <asp:DropDownList ID="DropDownList10" runat="server" DataSourceID="companii2" DataTextField="denumire" DataValueField="Id" Enabled="False" SelectedValue='<%# Bind("idCompanieAeriana") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="companii2" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [CompanieAeriana]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                  <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <br />
            <asp:Label ID="Label14" runat="server" Text="Zboruri"></asp:Label>
            &nbsp;
            <asp:GridView ID="GVZboruri" runat="server" AutoGenerateColumns="False" CaptionAlign="Top" DataKeyNames="Id" DataSourceID="GridViewZboruriDS" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" PagerSettings-Position="Top" OnRowCancelingEdit="GVZboruri_RowCancelingEdit" OnRowUpdated="GVZboruri_RowUpdated" OnRowUpdating="GVZboruri_RowUpdating" ShowFooter="True">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:Button ID="btnZboruriInsert" runat="server" class="button button1" OnClick="btnZboruriInsert_Click" Text="Inserare" />
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Select" Text="Select" Visible="False"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Id" InsertVisible="False" SortExpression="Id" Visible="False">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Numar" SortExpression="numar">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("numar") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtZborNumar" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("numar") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Data Plecare" SortExpression="dataPlecare">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("dataPlecare") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtZborDataPlecare" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("dataPlecare") %>' OnDataBinding="Label3_DataBinding"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Durata" SortExpression="durata">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("durata") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtZborDurata" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("durata") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Aeroport Plecare" SortExpression="idAeroportPlecare">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="DropDownEditAeroportPlecare" DataTextField="denumire" DataValueField="Id" SelectedValue='<%# Bind("idAeroportPlecare") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DropDownEditAeroportPlecare" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="ddZborAeroportPlecare" runat="server" DataSourceID="DropDownAeroportPlecareDS" DataTextField="denumire" DataValueField="Id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DropDownAeroportPlecareDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("idAeroportPlecare") %>' Visible="False"></asp:Label>
                            <asp:DropDownList ID="DropDownList11" runat="server" DataSourceID="plecareDisplay" DataTextField="denumire" DataValueField="Id" Enabled="False" SelectedValue='<%# Bind("idAeroportPlecare") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="plecareDisplay" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Aeroport Sosire" SortExpression="idAeroportSosire">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="DropDownEditAeroportSosireDS" DataTextField="denumire" DataValueField="Id" SelectedValue='<%# Bind("idAeroportSosire") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DropDownEditAeroportSosireDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="ddZboruriAeroportSosire" runat="server" DataSourceID="DropDownAeroportSosireDS" DataTextField="denumire" DataValueField="Id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DropDownAeroportSosireDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("idAeroportSosire") %>' Visible="False"></asp:Label>
                            <asp:DropDownList ID="DropDownList12" runat="server" DataSourceID="sosireDisplay" DataTextField="denumire" DataValueField="Id" Enabled="False" SelectedValue='<%# Bind("idAeroportSosire") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sosireDisplay" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Aeronava" SortExpression="idAeronava">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="DropDownAeronavaEditDS" DataTextField="denumire" DataValueField="Id" SelectedValue='<%# Bind("idAeronava") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DropDownAeronavaEditDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeronava]"></asp:SqlDataSource>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="ddZborAeronava" runat="server" DataSourceID="aeronaveInsert" DataTextField="denumire" DataValueField="Id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="aeronaveInsert" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeronava]"></asp:SqlDataSource>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("idAeronava") %>' Visible="False"></asp:Label>
                            <asp:DropDownList ID="DropDownList13" runat="server" DataSourceID="aeronavaDisplay" DataTextField="denumire" DataValueField="Id" Enabled="False" SelectedValue='<%# Bind("idAeronava") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="aeronavaDisplay" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeronava]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ora Plecare" SortExpression="oraPlecare">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("oraPlecare") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtZborOraPlecare" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("oraPlecare") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerSettings Position="Top" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
            </asp:GridView>
            <asp:Label ID="LabelMessage2" runat="server" ForeColor="Red"></asp:Label>
            <asp:SqlDataSource ID="GridViewZboruriDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Zbor] WHERE ([idAeronava] = @idAeronava AND [dataPlecare] &gt;= @dataPlecare)" DeleteCommand="DELETE FROM [Zbor] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Zbor] ([numar], [dataPlecare], [durata], [idAeroportPlecare], [idAeroportSosire], [idAeronava], [oraPlecare]) VALUES (@numar, @dataPlecare, @durata, @idAeroportPlecare, @idAeroportSosire, @idAeronava, @oraPlecare)" UpdateCommand="UPDATE [Zbor] SET [numar] = @numar, [dataPlecare] = @dataPlecare, [durata] = @durata, [idAeroportPlecare] = @idAeroportPlecare, [idAeroportSosire] = @idAeroportSosire, [idAeronava] = @idAeronava, [oraPlecare] = @oraPlecare WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="numar" Type="String" />
                    <asp:Parameter DbType="Date" Name="dataPlecare" />
                    <asp:Parameter Name="durata" Type="Single" />
                    <asp:Parameter Name="idAeroportPlecare" Type="Int32" />
                    <asp:Parameter Name="idAeroportSosire" Type="Int32" />
                    <asp:Parameter Name="idAeronava" Type="Int32" />
                    <asp:Parameter DbType="Time" Name="oraPlecare" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView2" Name="idAeronava" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownDataPlecare" Name="dataPlecare" PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="numar" Type="String" />
                    <asp:Parameter DbType="Date" Name="dataPlecare" />
                    <asp:Parameter Name="durata" Type="Single" />
                    <asp:Parameter Name="idAeroportPlecare" Type="Int32" />
                    <asp:Parameter Name="idAeroportSosire" Type="Int32" />
                    <asp:Parameter Name="idAeronava" Type="Int32" />
                    <asp:Parameter DbType="Time" Name="oraPlecare" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
        </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlGridViewAeronaveDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeronava]"></asp:SqlDataSource>
    </div>
          <p style ="border-top: 3px solid gray; padding: 1px"/>
      
        <br/>
            <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Bilete vandute pasager"></asp:Label>
           
            <br />
      
            
      
                
      
              <asp:Label ID="Label19" runat="server" Text="Afisati doar biletele business:"></asp:Label>
              <asp:CheckBox ID="CbBusiness" runat="server" AutoPostBack="True" OnCheckedChanged="CbBusiness_CheckedChanged" />
           
            
      
      <br/> <br />
                    <asp:Label ID="Label16" runat="server" Text="Pasageri"></asp:Label>
           
            <asp:GridView ID="GVPasageri" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="GVPasageriDS" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GVPasageri_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" >
                    <ItemStyle Font-Size="Smaller" ForeColor="Black" />
                    </asp:BoundField>
                    <asp:BoundField DataField="nume" HeaderText="Nume" SortExpression="nume" />
                    <asp:BoundField DataField="prenume" HeaderText="Prenume" SortExpression="prenume" />
                    <asp:BoundField DataField="dataNastere" HeaderText="Data Nastere" SortExpression="dataNastere" />
                    <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                    <asp:BoundField DataField="actIdentitate" HeaderText="Act Identitate" SortExpression="actIdentitate" />
                    <asp:BoundField DataField="nationalitate" HeaderText="Nationalitate" SortExpression="nationalitate" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="GVPasageriDS" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Pasager]"></asp:SqlDataSource>
        <br />     
        <asp:Label ID="Label17" runat="server" Text="Bilete"></asp:Label>
            <br />
            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                    <asp:BoundField DataField="loc" HeaderText="loc" SortExpression="loc" />
                    <asp:CheckBoxField DataField="business" HeaderText="business" SortExpression="business" />
                    <asp:CheckBoxField DataField="masa" HeaderText="masa" SortExpression="masa" />
                    <asp:BoundField DataField="idPasager" HeaderText="idPasager" SortExpression="idPasager" />
                    <asp:BoundField DataField="idZbor" HeaderText="idZbor" SortExpression="idZbor" />
                    <asp:BoundField DataField="pret" HeaderText="pret" SortExpression="pret" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceZborPasager" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT Id, loc, business, masa, idPasager, idZbor, pret FROM Bilet WHERE (idPasager = @idPasager) AND (business = @business) ">
                <SelectParameters>
                    <asp:Parameter Name="idPasager" Type="Int32" />
                   
                    <asp:Parameter Name="business" />
                   
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
                <p style ="border-top: 3px solid gray; padding: 1px"/>
  
            <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Zboruri dupa aeroportul destinatie si aeroportul sosire"></asp:Label>
            <br />
            <asp:DropDownList ID="DropDownList8" runat="server" AutoPostBack="True" DataSourceID="DSAeroportDestinatie" DataTextField="denumire" DataValueField="Id">
            </asp:DropDownList>
            <asp:SqlDataSource ID="DSAeroportDestinatie" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
            <asp:DropDownList ID="DropDownList9" runat="server" AutoPostBack="True" DataSourceID="DSAeroportSosire" DataTextField="denumire" DataValueField="Id">
            </asp:DropDownList>
            <asp:SqlDataSource ID="DSAeroportSosire" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
        <br />           
        <asp:Label ID="Label18" runat="server" Text="Zboruri"></asp:Label>
            <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="DSZboruri" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="Id" InsertVisible="False" SortExpression="Id" Visible="False">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Id") %>' Visible="False"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="numar" HeaderText="Numar" SortExpression="numar" />
                    <asp:BoundField DataField="dataPlecare" HeaderText="Data Plecare" SortExpression="dataPlecare" />
                    <asp:BoundField DataField="durata" HeaderText="Durata" SortExpression="durata" />
                    <asp:TemplateField HeaderText="Aeroport Plecare" SortExpression="idAeroportPlecare">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("idAeroportPlecare") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("idAeroportPlecare") %>' Visible="False"></asp:Label>
                            <asp:DropDownList ID="DropDownList16" runat="server" DataSourceID="aeroportPlecareView" DataTextField="denumire" DataValueField="Id" Enabled="False" SelectedValue='<%# Bind("idAeroportPlecare") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="aeroportPlecareView" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Aeroport Sosire" SortExpression="idAeroportSosire">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("idAeroportSosire") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("idAeroportSosire") %>' Visible="False"></asp:Label>
                            <asp:DropDownList ID="DropDownList17" runat="server" DataSourceID="aeroportSosireView" DataTextField="denumire" DataValueField="Id" Enabled="False" SelectedValue='<%# Bind("idAeroportSosire") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="aeroportSosireView" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeroport]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Aeronava" SortExpression="idAeronava">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("idAeronava") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("idAeronava") %>' Visible="False"></asp:Label>
                            <asp:DropDownList ID="DropDownList18" runat="server" DataSourceID="aeronavaView" DataTextField="denumire" DataValueField="Id" Enabled="False">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="aeronavaView" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Aeronava]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="oraPlecare" HeaderText="Ora Plecare" SortExpression="oraPlecare" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="DSZboruri" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Zbor] WHERE (([idAeroportPlecare] = @idAeroportPlecare) AND ([idAeroportSosire] = @idAeroportSosire))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList8" Name="idAeroportPlecare" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList9" Name="idAeroportSosire" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        
                 
  
           <p style ="border-top: 3px solid gray; padding: 1px"/>
            <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Numarul de locuri libere dupa zbor"></asp:Label>
            
            <p>
                        <asp:Label ID="LabelLocuriLibere" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#000099" Text="Selectati un zbor pentru a afla numarul de locuri libere"></asp:Label>
            </p>
            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="dsZboruriSelect" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView6_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
                    <asp:BoundField DataField="numar" HeaderText="numar" SortExpression="numar" />
                    <asp:BoundField DataField="dataPlecare" HeaderText="dataPlecare" SortExpression="dataPlecare" />
                    <asp:BoundField DataField="durata" HeaderText="durata" SortExpression="durata" />
                    <asp:BoundField DataField="idAeroportPlecare" HeaderText="idAeroportPlecare" SortExpression="idAeroportPlecare" Visible="False" />
                    <asp:BoundField DataField="idAeroportSosire" HeaderText="idAeroportSosire" SortExpression="idAeroportSosire" Visible="False" />
                    <asp:BoundField DataField="idAeronava" HeaderText="idAeronava" SortExpression="idAeronava" Visible="False" />
                    <asp:BoundField DataField="oraPlecare" HeaderText="oraPlecare" SortExpression="oraPlecare" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="dsZboruriSelect" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="SELECT * FROM [Zbor]"></asp:SqlDataSource>
        
                    <br />
            <br />

        <p style ="border-top: 3px solid gray; padding: 1px"/>
        <asp:Label ID="Label20" runat="server" Font-Size="Medium" Text="Creati o functie care determina incasarile din vanzarea de bilete pentru o companie aeriana" Font-Bold="True"></asp:Label>
        
                    <asp:Button class="button button1" ID="btnCreareFunctie" runat="server" OnClick="btnCreareFunctie_Click" Text="Creare" />
            <br />
            <asp:Label ID="Label22" runat="server" Text="Introduceti denumire companie aeriana"></asp:Label>
            <asp:TextBox ID="tbDenumireCompanieAeriana" runat="server"></asp:TextBox>
            <asp:Button class="button button1" ID="btnApelFunctieIncasari" runat="server" Enabled="False" OnClick="btnApelFunctieIncasari_Click" Text="Calculeaza" />
        <br />    
        <asp:Label ID="LabelIncasari" runat="server" ForeColor="#0000CC"></asp:Label>

        <br />
        <br />
        
                    <p style ="border-top: 3px solid gray; padding: 1px"/>
                       
                <asp:Label ID="LabelProceduraDetaliiBilete" runat="server" Text="Creati o procedura care afiseaza pentru un pasager numarul de bilete detinute si detaliile biletului si ale zborului aferent" Font-Bold="True"></asp:Label>
        
                        &nbsp;&nbsp;
        
                        <asp:Button class="button button1" ID="btnCreareProceduraDetaliiBilet" runat="server" Text="Creare" OnClick="btnCreareProceduraDetaliiBilet_Click" />
          
                       
                <br />
          
                       
                <asp:Label ID="Label23" runat="server" Text="Introduceti nume"></asp:Label>
        
                   
        
                        <asp:TextBox ID="tbNume" runat="server"></asp:TextBox>
                        <asp:Label ID="Label24" runat="server" Text="Introduceti prenume"></asp:Label>
                        <asp:TextBox ID="tbPrenume" runat="server"></asp:TextBox>
&nbsp;
                        <asp:Button class="button button1" ID="btnApelProceduraDetaliiBilete" runat="server" Enabled="False" Text="Afiseaza" OnClick="btnApelProceduraDetaliiBilete_Click" />
        <br />    <br />
        <asp:TextBox ID="TextBox8" runat="server" TextMode="MultiLine" Width="1089px" Visible="False"></asp:TextBox>
        
                   
        <br />
                    <asp:Label ID="LabelNrBilete" runat="server" ForeColor="#0000CC"></asp:Label>
                        <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="numar" HeaderText="Numar Zbor" SortExpression="numar" />
                                <asp:BoundField DataField="dataPlecare" HeaderText="Data Plecare" SortExpression="dataPlecare" />
                                <asp:BoundField DataField="durata" HeaderText="Durata" SortExpression="durata" />
                                <asp:BoundField DataField="loc" HeaderText="Loc" SortExpression="loc" />
                                <asp:BoundField DataField="pret" HeaderText="Pret Bilet" SortExpression="pret" />
                                <asp:BoundField DataField="denumire" HeaderText="Aeroport Plecare" SortExpression="denumire" />
                                <asp:BoundField DataField="denumire1" HeaderText="Aeroport Sosire" SortExpression="denumire1" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="DSProcedure" runat="server" ConnectionString="<%$ ConnectionStrings:ZboruriConnectionString2 %>" SelectCommand="detaliiBilet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="tbNume" DefaultValue="" Name="nume" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="tbPrenume" DefaultValue="" Name="prenume" PropertyName="Text" Type="String" />
                                <asp:Parameter Direction="Output" Name="numarBilete" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

        <br />
          <p style ="border-top: 3px solid gray; padding: 1px"/>
                        <asp:Label ID="LabelProceduraPret" runat="server" Font-Bold="True" Text="Creati procedura care returneaza pretul celui mai scump bilet vandut pentru un zbor"></asp:Label>
       <asp:Button class="button button1" ID="btnCreareProceduraPret" runat="server" OnClick="btnCreareProceduraPret_Click" Text="Creare" />
        <br />
                    
                   
        
                    <asp:Label ID="Label26" runat="server" Text="Introduceti numar zbor"></asp:Label>
            <asp:TextBox ID="tbNumarZbor" runat="server"></asp:TextBox>
            <asp:Button class="button button1" ID="btnApelProceduraPret" runat="server" Enabled="False" OnClick="btnApelProceduraPret_Click" Text="Afiseaza" />
            <br />
            <asp:Label ID="LabelPretMaxim" runat="server" ForeColor="#0000CC"></asp:Label>
                    
                   
        <br />
                    <p style ="border-top: 3px solid gray; padding: 1px"/>
            <asp:Label ID="Label28" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Vizualizari Grafice"></asp:Label>
          
         <br />          
                   
        
                    <asp:Label ID="Label29" runat="server" Text="Selectati graficul dorit"></asp:Label>
            <br />

                               
        
                    <asp:Button class="button button1" ID="Button1" runat="server" OnClick="Button1_Click" Text="Numarul de bilete vandute per zbor" />
        <br /><br />
            <asp:Button class="button button1"  ID="Button2" runat="server" OnClick="Button2_Click" Text="Cota de piata a fiecarei companii aeriene" />
        <br /><br />
            <asp:Button class="button button1" ID="Button3" runat="server" OnClick="Button3_Click" Text="Evolutia  numarului de bilete vandute in 2023" />

                               
        
                    </form>
</body>
</html>
