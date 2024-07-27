using Lab_6.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Lab_6
{
    public partial class Cheezious : System.Web.UI.Page
    {
        DataAccessLayerManager dalManager = new DataAccessLayerManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeGrid();
            }
        }

        private void InitializeGrid()
        {
            //GridView1.DataSource = dalManager.GetItems();
            //GridView1.DataBind();
        }
    }
}