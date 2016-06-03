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
    public partial class frmDisplayRawGLRecords : Form
    {
        Small_Operation SML_OPR = new Small_Operation();
        CreateGLRecords CGL = new CreateGLRecords();        

        public frmDisplayRawGLRecords()
        {
            InitializeComponent();

        }

        private void frmDisplayRawGLRecords_Load(object sender, EventArgs e)
        {
            try
            {
                bool rslt1, rslt2, rslt3, rslt4, rslt5, rslt6, rslt7, rslt8, rslt9, rslt10;
                
                //=============================================================
                rslt1 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE();
                rslt2 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE_BNP();
                rslt3 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE_COUPON();
                rslt4 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE_FOREX();
                rslt5 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE_FORWARD();
                rslt6 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH();
                rslt7 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FOREX();
                rslt8 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FTC_FPC();
                rslt9 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE_MP();
                rslt10 = CGL.GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_DCC_DTC();
                //==============================================================

                if ((rslt1 == true) || (rslt2 == true) || (rslt3 == true) || (rslt4 == true) || (rslt5 == true) || (rslt6 == true) || (rslt7 == true) || (rslt8 == true) || (rslt9 == true))
                {
                    DialogResult rslt = MessageBox.Show("Raw GL Record Generate Successfully Completed. \nDo you want to Continue ?", "Finish.", MessageBoxButtons.YesNo, MessageBoxIcon.Information);
                    if (rslt == DialogResult.Yes)
                    {
                        FillRawGlGridView();
                    }
                }
                else
                {
                    MessageBox.Show("Raw GL Record Generate Not Completed.", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                }
            }
            catch (Exception exx)
            {
                MessageBox.Show(exx.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }
            
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }        

        private void FillRawGlGridView()
        {
            try
            {
                DataGridViewButtonColumn btn = new DataGridViewButtonColumn();
                dgRawGLRecords.Columns.Add(btn);
                btn.HeaderText = "";
                btn.Text = "VIew GL Record";
                btn.Name = "btnClickGLRecord";
                
                btn.UseColumnTextForButtonValue = true;

                dgRawGLRecords.DataSource = SML_OPR.LoadRawGLRecords();
                dgRawGLRecords.Columns[1].Visible = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }
        }

        private void dgRawGLRecords_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.ColumnIndex == 0)
            {
                DataTable DT;
                int selectedrowindex = dgRawGLRecords.SelectedCells[0].RowIndex;
                DataGridViewRow selectedRow = dgRawGLRecords.Rows[selectedrowindex];
                string RefID = Convert.ToString(selectedRow.Cells[1].Value);

                DT = SML_OPR.GetGLTransaction(RefID);
                frmShowGLRecord SHW_GL_REC = new frmShowGLRecord(DT);
                SHW_GL_REC.ShowDialog();

                //MessageBox.Show(RefID.ToString());

            }
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            frmFileUpload FL_UP = new frmFileUpload();
            FL_UP.Show();
            this.Hide();
        }

    }
}
