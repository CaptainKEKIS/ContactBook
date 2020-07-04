<%@ Page Title="Записная книжка" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ContactBook._Default" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ContactsDB %>"
        SelectCommand="SELECT * FROM [Contacts]" 
        DeleteCommand="DELETE FROM [Contacts] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [Contacts] ([Name], [Phone], [Email]) VALUES (@Name, @Phone, @Email)" 
        UpdateCommand="UPDATE [Contacts] SET [Name] = @Name, [Phone] = @Phone, [Email] = @Email WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Button ID="AddButton" runat="server" Text="Добавить" OnClick="AddButton_Click" />
    <asp:Button ID="EditButton" runat="server" Text="Редактировать" OnClick="EditButton_Click" Enabled="False" />
    <asp:Button ID="DeleteButton" runat="server" Text="Удалить" OnClick="DeleteButton_Click" Enabled="false" />

    <asp:GridView ID="GridView" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
        BorderStyle="None" BorderWidth="1px" CellPadding="4" CellSpacing="1" CssClass="table" 
        DataKeyNames="Id" DataSourceID="SqlDataSource" ForeColor="Black" GridLines="Horizontal"
        HorizontalAlign="Center" OnSelectedIndexChanged="GridView_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
            <asp:TemplateField HeaderText="№">
                <HeaderStyle Width="30px" />
                <ItemTemplate>
                    <asp:Button runat="server" Text="<%# Convert.ToString( Container.DataItemIndex + 1 ) %>" CommandName="Select" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText="Имя" SortExpression="Name">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <ItemStyle VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Phone" HeaderText="Номер телефона" SortExpression="Phone" />
            <asp:BoundField DataField="Email" HeaderText="Электронный адрес" SortExpression="Email" />
        </Columns>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>

    <dx:ASPxPopupControl ID="EditPopup" runat="server" Modal="True" 
        PopupElementID="body" ClientInstanceName="EditPopup" CloseAction="CloseButton" PopupAction="None"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="400px">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <h4>Информация о контакте</h4>
                <dx:ASPxTextBox ID="Name" runat="server" Font-Size="14pt" NullText="Имя" Width="350px">
                    <Paddings Padding="5px" />
                </dx:ASPxTextBox>
                <br />
                <dx:ASPxTextBox ID="Phone" runat="server" Width="350px" Font-Size="14pt" NullText="Номер телефона">
                    <MaskSettings Mask="+9 (999) 000-0000" />
                    <Paddings Padding="5px" />
                </dx:ASPxTextBox>
                <br />
                <dx:ASPxTextBox ID="Email" runat="server" Width="350px" Font-Size="14pt" NullText="Электронная почта">
                    <Paddings Padding="5px" />
                </dx:ASPxTextBox>
                <br />
                <asp:Button ID="SaveButton" runat="server" Text="Сохранить" OnClick="SaveButton_Click" />
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

</asp:Content>
