using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using MCT_GL_Application.FUNCTION_CLASS;
using System.Configuration;
using MCT_GL_Application.UI_FORMS;

namespace MCT_GL_Application.UI_FORMS
{
    public partial class frmFileUpload : Form
    {
        string SelectedBank = string.Empty;
        DB_Operation DBOP = new DB_Operation();
        MasterDataDBOperation MD_DBOP = new MasterDataDBOperation();
        public String CopyPath = ConfigurationSettings.AppSettings["CopyPath"].ToString();
        bool BNP_BNK_Arrange, BNP_BNK_Read, BNP_MKT_Arrange, BNP_MKT_READ, JB_BNK_Arrange, JB_BNK_Read, JB_MKT_Arrange, JB_MKT_READ, LODH_BNK_Arrange, LODH_BNK_Read, LODH_MKT_Arrange, LODH_MKT_READ;
        
        public frmFileUpload()
        {
            InitializeComponent();
            LoadBankList();
            LoadBankAccountList();
            LoadCurrencyList();
            LoadBankCode();
            LoadFEECode();
        }

        private void frmFileUpload_Load(object sender, EventArgs e)
        {
            //btnValidate.Enabled = false;
            btnShowPositionRecord.Enabled = false;
            txtIdentification.Enabled = false;
            BindGridView();

        }

        private void btnUploadBankRawData_Click(object sender, EventArgs e)
        {
            FDialog(lblBankFIleLocation);
        }

        private void UploadPositionRawData_Click(object sender, EventArgs e)
        {
            FDialog(lblPositionFileLocation);
        }

        public void FDialog(Label lbl)
        {
            Stream myStream = null;
            OpenFileDialog openFileDialog1 = new OpenFileDialog();

            openFileDialog1.InitialDirectory = "C:\\";
            openFileDialog1.Filter = "txt files (*.txt)|*.txt|All files (*.*)|*.*";
            openFileDialog1.FilterIndex = 2;
            openFileDialog1.RestoreDirectory = true;

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    if ((myStream = openFileDialog1.OpenFile()) != null)
                    {
                        using (myStream)
                        {
                            lbl.Text =  openFileDialog1.FileName.ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error: Could not read file from disk. Original error: " + ex.Message);
                }
            }
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnUpload_Click(object sender, EventArgs e)
        {            
               
            try
            {                
                if (cmbInvestmentBankList.SelectedValue.ToString() != "0")
                {
                    SelectedBank = cmbInvestmentBankList.SelectedValue.ToString();
                    string BankFileName = string.Empty, PositionFileName = string.Empty;
                    
                    BankFileName = lblBankFIleLocation.Text.Split('\\').Last();
                    PositionFileName = lblPositionFileLocation.Text.Split('\\').Last();

                    String[] BankFileExtention = BankFileName.Split('.');
                    String[] PositionFileExtention = PositionFileName.Split('.');

                    if (SelectedBank == "BNP")
                    {
                        #region BNP
                        if ((BankFileName.Substring(0, 9) == "DIG2_ope_" && BankFileExtention[1].ToString() == "csv") || (PositionFileName.Substring(0, 9) == "DIG2_pos_" && PositionFileExtention[1].ToString() == "csv"))
                        {
                           
                            //=================BANK FILE UPLOAD ======================================================================
                            if (!string.IsNullOrEmpty(lblBankFIleLocation.Text) || !string.IsNullOrEmpty(lblPositionFileLocation.Text))
                            {
                                if (!string.IsNullOrEmpty(lblBankFIleLocation.Text))
                                {
                                    BNP_BNK_Arrange = DBOP.ArrangeFileList_BNP(lblBankFIleLocation.Text);
                                    BNP_BNK_Read = DBOP.ReadFileContaint_BNP(CopyPath);
                                }
                                if (!string.IsNullOrEmpty(lblPositionFileLocation.Text))
                                {

                                    BNP_MKT_Arrange = DBOP.MarketPrice_ArrangeFileList_BNP(lblPositionFileLocation.Text);
                                    BNP_MKT_READ = DBOP.MarketPrice_ReadFileContaint_BNP(CopyPath);
                                }
                                if ((BNP_BNK_Arrange == true && BNP_BNK_Read == true) || (BNP_MKT_Arrange == true && BNP_MKT_READ == true))
                                {
                                    MessageBox.Show("BNP Files are Successfully Imported.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                    ResetForm();
                                    btnValidate.Enabled = true;
                                    btnShowPositionRecord.Enabled = true;

                                }
                                else
                                {
                                    MessageBox.Show("Unable to complete BNP file import process.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                    ResetForm();
                                }

                            }
                            else
                            {
                                MessageBox.Show("Please Select Bank File And Position File.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                            }
                            //==============MKT FILE UPLOAD===========================================================================================

                            
                        }
                        else
                        {
                            MessageBox.Show("Please Select Valid Bank and Position File.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                        }
                        #endregion
                    }
                    else if (SelectedBank == "JB")
                    {

                        #region JB

                        //if ((BankFileExtention.Length == 2 ) || (PositionFileExtention.Length == 2))
                        //{

                            if (((BankFileName.Substring(0, 5) == "BEWGM" || BankFileName.Substring(0, 5) == "BEWCH" && (BankFileExtention[2].ToString() == "stp")))
                                || ((PositionFileName.Substring(0, 5) == "POSGM" || PositionFileName.Substring(0, 5) == "POSCH") && (PositionFileExtention[2].ToString()  == "stp")))
                            {

                                if (!string.IsNullOrEmpty(lblBankFIleLocation.Text) || !string.IsNullOrEmpty(lblPositionFileLocation.Text))
                                {
                                    JB_BNK_Arrange = DBOP.ArrangeFileList(lblBankFIleLocation.Text);
                                    JB_BNK_Read = DBOP.ReadFileContaint(CopyPath);

                                    JB_MKT_Arrange = DBOP.MarketPrice_ArrangeFileList(lblPositionFileLocation.Text);
                                    JB_MKT_READ = DBOP.MarketPrice_ReadFileContaint(CopyPath);

                                    if ((JB_BNK_Arrange == true && JB_BNK_Read == true) || (JB_MKT_Arrange == true && JB_MKT_READ == true))
                                    {
                                        MessageBox.Show("JB Files are Successfully Imported.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                        ResetForm();
                                        btnValidate.Enabled = true;
                                        btnShowPositionRecord.Enabled = true;
                                    }
                                    else
                                    {
                                        MessageBox.Show("Unable to complete JB file import process.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                        ResetForm();
                                    }
                                }
                                else
                                {
                                    MessageBox.Show("Please Select Bank File And Position File.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                }

                            }
                            else
                            {
                                MessageBox.Show("Please Select Valid Bank and Position File.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                            }
                            
                        //}
                        //else
                        //{
                        //    MessageBox.Show("Unable to find File Extention.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                        //}
                        #endregion
                    }
                    else if (SelectedBank == "LODH")
                    {
                        #region LODH

                        if ((BankFileName.Substring(0, 8) == "30102_TR" && BankFileExtention[1].ToString() == "TXT") || (PositionFileName.Substring(0, 10) == "30102POSIT"  && PositionFileExtention[1].ToString() == "txt"))
                        {

                            if (!string.IsNullOrEmpty(lblBankFIleLocation.Text) || !string.IsNullOrEmpty(lblPositionFileLocation.Text))
                            {
                                LODH_BNK_Arrange = DBOP.ArrangeFileList_LODH(lblBankFIleLocation.Text);
                                LODH_BNK_Read = DBOP.ReadFileContaint_LODH(CopyPath);


                                LODH_MKT_Arrange = DBOP.MarketPrice_ArrangeFileList_LODH(lblPositionFileLocation.Text);
                                LODH_MKT_READ = DBOP.MarketPrice_ReadFileContaint_LODH(CopyPath);

                                if ((LODH_BNK_Arrange == true && LODH_BNK_Read == true) || (LODH_MKT_Arrange == true && LODH_MKT_READ == true))
                                {
                                    MessageBox.Show("LODH Files are Successfully Imported.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                    ResetForm();
                                    btnValidate.Enabled = true;
                                    btnShowPositionRecord.Enabled = true;
                                }
                                else
                                {
                                    MessageBox.Show("Unable to complete LODH file import process.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                    ResetForm();
                                }
                            }
                            else
                            {
                                MessageBox.Show("Please Select Bank File And Position File.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                            }

                        }
                        else
                        {
                            MessageBox.Show("Please Select Valid Bank and Position File.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                        }

                        #endregion
                    }

                }
                else
                {
                    MessageBox.Show("Please Select Correct Investment Bank.", "Info !", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                }
            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message.ToString(), "Error ", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }
            
        }

        private void btnValidate_Click(object sender, EventArgs e)
        {
            Validation Vld = new Validation();

            this.Hide();
            Vld.Show();
        }

        private void btnShowPositionRecord_Click(object sender, EventArgs e)
        {
            try
            {

                frmDisplayPositionDetails SHPODT = new frmDisplayPositionDetails();
                SHPODT.Show();
                this.Hide();
            }
            catch (Exception erx)
            {
                MessageBox.Show(erx.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }
        }

        private void groupBox3_Enter(object sender, EventArgs e)
        {

        }

        private void tbIntregrationTypes_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            if (tbIntregrationTypes.SelectedTab == tbIntregrationTypes.TabPages["Bank_Transaction"])
            {
                btnShowPositionRecord.Enabled = false;
            }
            else if (tbIntregrationTypes.SelectedTab == tbIntregrationTypes.TabPages["Position_Data"])
            {
                btnShowPositionRecord.Enabled = true;
            }
        }

        private void tbIntregration_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnShowPositionRecord.Enabled = false;
        }

        private void cmbBankListMasterData_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbBankListMasterData.SelectedValue.ToString() == "LODH")
            {
                txtIdentification.Enabled = true;
            }
            else
            {
                txtIdentification.Enabled = false;
            }
        }

        private void btnAddChardes_Click(object sender, EventArgs e)
        {
            try
            {
                int result;
                if (!string.IsNullOrEmpty(txtChargeBankAccount.Text) && (cmbChargeCode.SelectedIndex != 0) && !string.IsNullOrEmpty(txtChargeDescription.Text) && !string.IsNullOrEmpty(txtchargeReferanceID.Text))
                {
                    result = MD_DBOP.AddFEEMap(txtChargeBankAccount.Text, cmbChargeCode.SelectedValue.ToString(), txtChargeDescription.Text, txtchargeReferanceID.Text);
                    Clear();
                    BindGridView();
                }
                else
                {
                    MessageBox.Show("All fields are mandatory !");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void btnAddBank_Click(object sender, EventArgs e)
        {
            try
            {
                int result;

                if ((cmbBankAccountNumber.SelectedIndex != 0) && (cmbCurrency.SelectedIndex != 0) && (cmbBankCode.SelectedIndex != 0) && !string.IsNullOrEmpty(txtGLAccount.Text))
                {
                    result = MD_DBOP.AddBankMap(txtGLAccount.Text, cmbCurrency.SelectedValue.ToString(), cmbBankCode.SelectedValue.ToString(), cmbBankAccountNumber.SelectedValue.ToString(), txtIdentification.Text);
                    Clear();
                    BindGridView();
                }
                else
                {
                    MessageBox.Show("All fields are mandatory !");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void cmbInvestmentBankList_SelectedIndexChanged(object sender, EventArgs e)
        {

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

                cmbBankListMasterData.DataSource = SmlOperation.LoadBankTypes();
                cmbBankListMasterData.DisplayMember = "BankName";
                cmbBankListMasterData.ValueMember = "Code";
                cmbBankListMasterData.SelectedIndex = 0;
                

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }
           
        }

        private void LoadBankAccountList()
        {
            try
            {
                cmbBankAccountNumber.DropDownStyle = ComboBoxStyle.DropDownList;

                cmbBankAccountNumber.DataSource = MD_DBOP.LoadBankList();
                cmbBankAccountNumber.DisplayMember = "ACCTID";
                cmbBankAccountNumber.ValueMember = "ACCTID";
                cmbBankAccountNumber.SelectedIndex = 0;

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }

        }

        private void LoadCurrencyList()
        {
            try
            {
                cmbCurrency.DropDownStyle = ComboBoxStyle.DropDownList;

                cmbCurrency.DataSource = MD_DBOP.LoadCurrencyList();
                cmbCurrency.DisplayMember = "CURID";
                cmbCurrency.ValueMember = "CURID";
                cmbCurrency.SelectedIndex = 0;

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }

        }

        private void LoadBankCode()
        {
            try
            {
                cmbBankCode.DropDownStyle = ComboBoxStyle.DropDownList;

                cmbBankCode.DataSource = MD_DBOP.LoadBankCodeList();
                cmbBankCode.DisplayMember = "VALUE";
                cmbBankCode.ValueMember = "VALUE";
                cmbBankCode.SelectedIndex = 0;

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }

        }

        private void LoadFEECode()
        {
            try
            {
                cmbChargeCode.DropDownStyle = ComboBoxStyle.DropDownList;

                cmbChargeCode.DataSource = MD_DBOP.LoadFEECodeList();
                cmbChargeCode.DisplayMember = "VALUE";
                cmbChargeCode.ValueMember = "VALUE";
                cmbChargeCode.SelectedIndex = 0;

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }

        }

        private void ResetForm()
        {
            LoadBankList();
            lblPositionFileLocation.Text = "";
            lblBankFIleLocation.Text = "";
        }
        
        private void Clear()
        {
            cmbBankAccountNumber.SelectedIndex = 0;
            cmbCurrency.SelectedIndex = 0;
            cmbBankCode.SelectedIndex = 0;
            txtGLAccount.Clear();
            txtChargeBankAccount.Clear();
            cmbChargeCode.SelectedIndex = 0;
            txtChargeDescription.Clear();
            txtchargeReferanceID.Clear();
            txtIdentification.Clear();
        }

        private void BindGridView()
        {
            try
            {
                gdBankDetailHistory.DataSource = MD_DBOP.BindGrid("SELECT ID AS ID,BANK_REFERANCE AS [Transaction Account],CURRENCY AS Currency,BANK_CODE AS [Bank Code],BANK_ACCOUNT AS [Bank Account],IDENTIFICATION_CODE AS [Identification Code] FROM dbo.BANK_MAP");



                gdCharge.DataSource = MD_DBOP.BindGrid("SELECT ID AS ID,BANK_CODE AS [Transaction Account] ,FEE AS FEE,DESCRIPTION AS [Description],REFERANCE_ID AS [Charge Reference] FROM dbo.FEE_MAP");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }


    }
}
