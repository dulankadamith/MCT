using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MCT_GL_Application.FUNCTION_CLASS;

namespace MCT_GL_Application.UI_FORMS
{
    public partial class frmDisplayPositionDetails : Form
    {
        public frmDisplayPositionDetails()
        {
            InitializeComponent();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                Small_Operation SMOP = new Small_Operation();
                dgPositionData.DataSource = SMOP.LoadPositionDetails(dtpFromDate.Value, dtpToDate.Value);

            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }
           
        }
    }
}
