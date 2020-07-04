using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ContactBook
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void AddButton_Click(object sender, EventArgs e)
        {
            EditPopup.HeaderText = "Добавление нового контакта";
            EditPopup.Attributes["Mode"] = "Add";
            Name.Text = "";
            Phone.Text = "";
            Email.Text = "";
            EditPopup.ShowOnPageLoad = true;
        }

        protected void EditButton_Click(object sender, EventArgs e)
        {
            try
            {
                EditPopup.HeaderText = "Редактирование контакта";
                EditPopup.Attributes["Mode"] = "Edit";
                Name.Text = GridView.SelectedRow.Cells[2].Text;
                Phone.Text = GridView.SelectedRow.Cells[3].Text;
                Email.Text = GridView.SelectedRow.Cells[4].Text;
                EditPopup.ShowOnPageLoad = true;
            }
            catch (Exception)
            {
                //TODO: выдать ошибку
                //TODO: запись в лог
            }
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            try
            {
                var selectedRow = GridView.SelectedRow;
                SqlDataSource.DeleteParameters[0].DefaultValue = GridView.DataKeys[selectedRow.RowIndex].Value.ToString();
                SqlDataSource.Delete();
                DeselectGridRow(GridView);
            }
            catch (Exception)
            {
                //TODO: выдать ошибку
                //TODO: запись в лог
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            switch (EditPopup.Attributes["Mode"])
            {
                case "Add":
                    SqlDataSource.InsertParameters[0].DefaultValue = Name.Text;
                    SqlDataSource.InsertParameters[1].DefaultValue = Phone.Text;
                    SqlDataSource.InsertParameters[2].DefaultValue = Email.Text;
                    SqlDataSource.Insert();
                    break;
                case "Edit":
                    SqlDataSource.UpdateParameters[0].DefaultValue = GridView.DataKeys[GridView.SelectedRow.RowIndex].Value.ToString();
                    SqlDataSource.UpdateParameters[1].DefaultValue = Name.Text;
                    SqlDataSource.UpdateParameters[2].DefaultValue = Phone.Text;
                    SqlDataSource.UpdateParameters[3].DefaultValue = Email.Text;
                    SqlDataSource.Update();
                    DeselectGridRow(GridView);
                    break;
                default:
                    //TODO: выдать ошибку
                    //TODO: запись в лог
                    break;
            }
            EditPopup.ShowOnPageLoad = false;
        }

        protected void GridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (GridView.SelectedIndex > -1)
            {
                DeleteButton.Enabled = true;
                EditButton.Enabled = true;
            }
            else
            {
                DeleteButton.Enabled = false;
                EditButton.Enabled = false;
            }
        }

        private void DeselectGridRow(GridView gridView)
        {
            gridView.SelectedIndex = -1;
            GridView_SelectedIndexChanged(GridView, EventArgs.Empty);
        }
    }
}