using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MCT_GL_Application.UI_FORMS;
using MCT_GL_Application.FUNCTION_CLASS;

namespace MCT_GL_Application.UI_FORMS
{
    public partial class Validation : Form
    {
        Validate_BNP V_BNP = new Validate_BNP();
        Validate_LODH V_LODH = new Validate_LODH();
        Validate_JB V_JB = new Validate_JB();
        Small_Operation SMOP = new Small_Operation();

        public string selectedBank;

        public Validation()
        {
            InitializeComponent();
            cmbInvestmentBankList.Enabled = true;
        }

        private void Validation_Load(object sender, EventArgs e)
        {
            LoadBankList();
            btnValidate.Enabled = true;
            btnCreateRawGLEntry.Enabled = false;

        }

        private void btnValidate_Click(object sender, EventArgs e)
        {
            DataTable RawDataTable;

            try
            {
                #region Validation
                
                if (!string.IsNullOrEmpty(lblCmbChangeValue.Text) && lblCmbChangeValue.Text != "0")
                {
                    bool rslt = false, rslt1 = false, rslt2 = false;

                    if (drgValidateData.Rows.Count > 1)
                    {
                        if (lblCmbChangeValue.Text == "BNP")
                        {
                            RawDataTable = SMOP.LoadGridData("dbo.Get_TEMP_RAW_DATA_BNP");
                            if (RawDataTable.Rows.Count > 0)
                            {
                                cmbInvestmentBankList.Enabled = false;
                                rslt = V_BNP.Validate_BNP_Records(RawDataTable);
                                if (rslt == true)
                                {
                                    LoadValidatedTempData(lblCmbChangeValue.Text);
                                    ImportFInalData();
                                    btnValidate.Enabled = false;
                                    btnCreateRawGLEntry.Enabled = true;
                                }
                                else
                                {
                                    btnValidate.Enabled = false;
                                    btnCreateRawGLEntry.Enabled = false;
                                }
                                //call validation method
                            }
                        }
                        else if (lblCmbChangeValue.Text == "JB")
                        {
                            RawDataTable = SMOP.LoadGridData("dbo.Get_TEMP_RAW_DATA_JB");
                            if (RawDataTable.Rows.Count > 0)
                            {
                                cmbInvestmentBankList.Enabled = false;
                                rslt1 = V_JB.Validate_JB_Records(RawDataTable);                                
                                if (rslt1 == true)
                                {
                                    LoadValidatedTempData(lblCmbChangeValue.Text);
                                    ImportFInalData();
                                    btnValidate.Enabled = false;
                                    btnCreateRawGLEntry.Enabled = true;
                                }
                                else
                                {
                                    btnValidate.Enabled = false;
                                    btnCreateRawGLEntry.Enabled = false;
                                }
                                //call validation method
                            }

                        }
                        else if (lblCmbChangeValue.Text == "LODH")
                        {
                            RawDataTable = SMOP.LoadGridData("dbo.Get_TEMP_RAW_DATA_LODH");
                            if (RawDataTable.Rows.Count > 0)
                            {
                                cmbInvestmentBankList.Enabled = false;
                                rslt2 = V_LODH.Validate_LODH_Records(RawDataTable);                                
                                if (rslt2 == true)
                                {
                                    LoadValidatedTempData(lblCmbChangeValue.Text);
                                    ImportFInalData();
                                    btnValidate.Enabled = false;
                                    btnCreateRawGLEntry.Enabled = true;
                                }
                                else
                                {
                                    btnValidate.Enabled = false;
                                    btnCreateRawGLEntry.Enabled = false;
                                }
                                //call validation method
                            }
                        }
                    }
                    else
                    {
                        MessageBox.Show("Unable to proceed without Data.", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                    }

                }
                else
                {
                    MessageBox.Show("Please Select Valid Bank.", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                }
                
                #endregion
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }

        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            frmFileUpload F_Upload = new frmFileUpload();
            F_Upload.Show();
            this.Hide();
        }

        private void cmbInvestmentBankList_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                string selectedBank = (string)((System.Data.DataRowView)(cmbInvestmentBankList.SelectedItem)).Row.ItemArray[1];
                lblCmbChangeValue.Text = (string)((System.Data.DataRowView)(cmbInvestmentBankList.SelectedItem)).Row.ItemArray[1];

                if (selectedBank == "BNP")
                {
                    drgValidateData.DataSource = SMOP.LoadGridData("dbo.Get_TEMP_RAW_DATA_BNP");
                }
                else if (selectedBank == "JB")
                {
                    drgValidateData.DataSource = SMOP.LoadGridData("dbo.Get_TEMP_RAW_DATA_JB");

                }
                else if (selectedBank == "LODH")
                {
                    drgValidateData.DataSource = SMOP.LoadGridData("dbo.Get_TEMP_RAW_DATA_LODH");
                }

            }
            catch (Exception er)
            {
                MessageBox.Show(er.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }
        }

        private void LoadBankList()
        {
            try
            {
                cmbInvestmentBankList.DropDownStyle = ComboBoxStyle.DropDownList;
                Small_Operation SmlOperation = new Small_Operation();


                cmbInvestmentBankList.DataSource = SmlOperation.LoadBankTypes();
                cmbInvestmentBankList.DisplayMember = "BankName";
                cmbInvestmentBankList.ValueMember = "Code";
                cmbInvestmentBankList.SelectedIndex = 0;


            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }

        }

        private void LoadValidatedTempData(string OperatedBNK)
        {

            try
            {

                if (OperatedBNK == "BNP")
                {
                    drgValidateData.DataSource = V_BNP.Load_ValidatedTempDataToGrid("dbo.Get_ValidatedTempRecordList_BNP");
                }
                else if (OperatedBNK == "JB")
                {
                    drgValidateData.DataSource = V_BNP.Load_ValidatedTempDataToGrid("dbo.Get_ValidatedTempRecordList_JB");

                }
                else if (OperatedBNK == "LODH")
                {
                    drgValidateData.DataSource = V_LODH.Load_ValidatedTempDataToGrid("dbo.Get_ValidatedTempRecordList_LODH");
                }

            }
            catch (Exception er)
            {
                MessageBox.Show(er.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }
        }
        
        private void ImportFInalData()
        {
            #region Import Data to RAW_DATA_????
            DataTable ImportedList;
            try
            {

                if (lblCmbChangeValue.Text == "BNP")
                {
                    int a;
                    ImportedList = V_BNP.Load_ValidatedTempDataToGrid("dbo.Get_ValidatedTempRecordList_BNP");

                    for (a = 0; a < ImportedList.Rows.Count; a++)
                    {
                        V_BNP.Import_ValidatedRecords_To_RAW_DATA_BNP(int.Parse(ImportedList.Rows[a].ItemArray[0].ToString()));
                    }

                    if (ImportedList.Rows.Count == a)
                    {
                        DialogResult rslt = MessageBox.Show("Records Successfully Imported to Base GL Table.", "SUCCESS !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                        if (rslt == DialogResult.OK)
                        {
                            V_BNP.CleanTempValidatedTable_BNP();
                            btnCreateRawGLEntry.Enabled = false;
                            btnCreateRawGLEntry.Enabled = true;
                        }

                    }
                }
                else if (lblCmbChangeValue.Text == "JB")
                {
                    int a;
                    ImportedList = V_JB.Load_ValidatedTempDataToGrid("dbo.Get_ValidatedTempRecordList_JB");
                    for (a = 0; a < ImportedList.Rows.Count; a++)
                    {
                        V_JB.Import_ValidatedRecords_To_RAW_DATA_JB(int.Parse(ImportedList.Rows[a].ItemArray[0].ToString()));
                    }

                    if (ImportedList.Rows.Count == a)
                    {
                        DialogResult rslt = MessageBox.Show("Records Successfully Imported to Base GL Table.", "SUCCESS !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                        if (rslt == DialogResult.OK)
                        {
                            V_JB.CleanTempValidatedTable_JB();
                            btnCreateRawGLEntry.Enabled = false;
                            btnCreateRawGLEntry.Enabled = true;
                        }

                    }

                }
                else if (lblCmbChangeValue.Text == "LODH")
                {
                    int a;
                    ImportedList = V_LODH.Load_ValidatedTempDataToGrid("dbo.Get_ValidatedTempRecordList_LODH");
                    for (a = 0; a < ImportedList.Rows.Count; a++)
                    {
                        V_LODH.Import_ValidatedRecords_To_RAW_DATA_LODH(int.Parse(ImportedList.Rows[a].ItemArray[0].ToString()));
                    }

                    if (ImportedList.Rows.Count == a)
                    {
                        DialogResult rslt = MessageBox.Show("Records Successfully Imported to Base GL Table.", "SUCCESS !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                        if (rslt == DialogResult.OK)
                        {
                            V_LODH.CleanTempValidatedTable_LODH();
                            btnCreateRawGLEntry.Enabled = false;
                            btnCreateRawGLEntry.Enabled = true;
                        }

                    }
                }

            }
            catch (Exception er)
            {
                MessageBox.Show(er.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }

            #endregion
        }

        private void btnCreateRawGLEntry_Click(object sender, EventArgs e)
        {
            frmDisplayRawGLRecords DPL_RW_GL = new frmDisplayRawGLRecords();
            DPL_RW_GL.Show();
            this.Hide();
        }

       
    }
}
 
