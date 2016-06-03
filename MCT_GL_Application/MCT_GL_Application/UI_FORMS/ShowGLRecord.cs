using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace MCT_GL_Application.UI_FORMS
{
    public partial class frmShowGLRecord : Form
    {
        public frmShowGLRecord(DataTable DT)
        {
            InitializeComponent();
            CreateGLRecordDesign(DT);

        }

        private void frmShowGLRecord_Load(object sender, EventArgs e)
        {

        }

        private void CreateGLRecordDesign(DataTable DT)
        {
            int i;
            Label A = new Label();
            try
            {
                for (i = 0; i < DT.Rows.Count; i++)
                {
                    dgGLRecord.Rows[i].Cells[0].Value = (i+1).ToString();
                    dgGLRecord.Rows[i].Cells[1].Value = DT.Rows[i].ItemArray[7].ToString();
                    dgGLRecord.Rows[i].Cells[2].Value = DT.Rows[i].ItemArray[2].ToString();
                    dgGLRecord.Rows[i].Cells[3].Value = DT.Rows[i].ItemArray[11].ToString();
                    dgGLRecord.Rows[i].Cells[4].Value = DT.Rows[i].ItemArray[10].ToString();
                    dgGLRecord.Rows[i].Cells[5].Value = DT.Rows[i].ItemArray[13].ToString();
                    dgGLRecord.Rows[i].Cells[6].Value = DT.Rows[i].ItemArray[18].ToString();
                    dgGLRecord.Rows[i].Cells[7].Value = DT.Rows[i].ItemArray[3].ToString();
                    dgGLRecord.Rows[i].Cells[8].Value = DT.Rows[i].ItemArray[1].ToString();
                    dgGLRecord.Rows[i].Cells[9].Value = DT.Rows[i].ItemArray[4].ToString();
                    dgGLRecord.Rows[i].Cells[10].Value = DT.Rows[i].ItemArray[5].ToString();
                    dgGLRecord.Rows[i].Cells[11].Value = DT.Rows[i].ItemArray[6].ToString();
                    dgGLRecord.Rows[i].Cells[12].Value = DT.Rows[i].ItemArray[7].ToString();
                    dgGLRecord.Rows[i].Cells[13].Value = DT.Rows[i].ItemArray[8].ToString();

                  
                }
            }
            catch (Exception ex)
            {

            }
        }

        
    }
}
