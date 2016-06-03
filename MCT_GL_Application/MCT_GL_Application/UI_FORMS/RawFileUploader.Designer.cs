namespace MCT_GL_Application.UI_FORMS
{
    partial class frmFileUpload
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnShowPositionRecord = new System.Windows.Forms.Button();
            this.btnValidate = new System.Windows.Forms.Button();
            this.lblPositionFileLocation = new System.Windows.Forms.Label();
            this.lblBankFIleLocation = new System.Windows.Forms.Label();
            this.btnExit = new System.Windows.Forms.Button();
            this.btnUpload = new System.Windows.Forms.Button();
            this.UploadPositionRawData = new System.Windows.Forms.Button();
            this.btnUploadBankRawData = new System.Windows.Forms.Button();
            this.grpSltBank = new System.Windows.Forms.GroupBox();
            this.label1 = new System.Windows.Forms.Label();
            this.cmbInvestmentBankList = new System.Windows.Forms.ComboBox();
            this.OpnFileDialogPosition = new System.Windows.Forms.OpenFileDialog();
            this.OpnFileDialogBank = new System.Windows.Forms.OpenFileDialog();
            this.tbIntregration = new System.Windows.Forms.TabControl();
            this.Intregration = new System.Windows.Forms.TabPage();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.tbIntregrationTypes = new System.Windows.Forms.TabControl();
            this.Bank_Transaction = new System.Windows.Forms.TabPage();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.Position_Data = new System.Windows.Forms.TabPage();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.Master_Data = new System.Windows.Forms.TabPage();
            this.tbBank = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.grdBank = new System.Windows.Forms.GroupBox();
            this.cmbBankCode = new System.Windows.Forms.ComboBox();
            this.cmbCurrency = new System.Windows.Forms.ComboBox();
            this.cmbBankAccountNumber = new System.Windows.Forms.ComboBox();
            this.label11 = new System.Windows.Forms.Label();
            this.cmbBankListMasterData = new System.Windows.Forms.ComboBox();
            this.label9 = new System.Windows.Forms.Label();
            this.txtIdentification = new System.Windows.Forms.TextBox();
            this.btnAddBank = new System.Windows.Forms.Button();
            this.gdBankDetailHistory = new System.Windows.Forms.DataGridView();
            this.txtGLAccount = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.grpCharges = new System.Windows.Forms.GroupBox();
            this.btnAddChardes = new System.Windows.Forms.Button();
            this.gdCharge = new System.Windows.Forms.DataGridView();
            this.txtchargeReferanceID = new System.Windows.Forms.TextBox();
            this.txtChargeDescription = new System.Windows.Forms.TextBox();
            this.txtChargeBankAccount = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.cmbChargeCode = new System.Windows.Forms.ComboBox();
            this.grpSltBank.SuspendLayout();
            this.tbIntregration.SuspendLayout();
            this.Intregration.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.tbIntregrationTypes.SuspendLayout();
            this.Bank_Transaction.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.Position_Data.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.Master_Data.SuspendLayout();
            this.tbBank.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.grdBank.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gdBankDetailHistory)).BeginInit();
            this.tabPage2.SuspendLayout();
            this.grpCharges.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gdCharge)).BeginInit();
            this.SuspendLayout();
            // 
            // btnShowPositionRecord
            // 
            this.btnShowPositionRecord.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnShowPositionRecord.Location = new System.Drawing.Point(365, 14);
            this.btnShowPositionRecord.Name = "btnShowPositionRecord";
            this.btnShowPositionRecord.Size = new System.Drawing.Size(163, 27);
            this.btnShowPositionRecord.TabIndex = 9;
            this.btnShowPositionRecord.Text = "View Position File";
            this.btnShowPositionRecord.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnShowPositionRecord.UseVisualStyleBackColor = true;
            this.btnShowPositionRecord.Click += new System.EventHandler(this.btnShowPositionRecord_Click);
            // 
            // btnValidate
            // 
            this.btnValidate.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnValidate.Location = new System.Drawing.Point(135, 14);
            this.btnValidate.Name = "btnValidate";
            this.btnValidate.Size = new System.Drawing.Size(161, 27);
            this.btnValidate.TabIndex = 8;
            this.btnValidate.Text = "Validate Transactions";
            this.btnValidate.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnValidate.UseVisualStyleBackColor = true;
            this.btnValidate.Click += new System.EventHandler(this.btnValidate_Click);
            // 
            // lblPositionFileLocation
            // 
            this.lblPositionFileLocation.AutoSize = true;
            this.lblPositionFileLocation.BackColor = System.Drawing.SystemColors.ControlLight;
            this.lblPositionFileLocation.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.lblPositionFileLocation.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblPositionFileLocation.Location = new System.Drawing.Point(15, 60);
            this.lblPositionFileLocation.MaximumSize = new System.Drawing.Size(500, 0);
            this.lblPositionFileLocation.Name = "lblPositionFileLocation";
            this.lblPositionFileLocation.Size = new System.Drawing.Size(2, 20);
            this.lblPositionFileLocation.TabIndex = 7;
            this.lblPositionFileLocation.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // lblBankFIleLocation
            // 
            this.lblBankFIleLocation.AutoSize = true;
            this.lblBankFIleLocation.BackColor = System.Drawing.SystemColors.ControlLight;
            this.lblBankFIleLocation.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.lblBankFIleLocation.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBankFIleLocation.Location = new System.Drawing.Point(18, 64);
            this.lblBankFIleLocation.MaximumSize = new System.Drawing.Size(500, 0);
            this.lblBankFIleLocation.Name = "lblBankFIleLocation";
            this.lblBankFIleLocation.Size = new System.Drawing.Size(2, 20);
            this.lblBankFIleLocation.TabIndex = 6;
            this.lblBankFIleLocation.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // btnExit
            // 
            this.btnExit.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Location = new System.Drawing.Point(570, 14);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(75, 27);
            this.btnExit.TabIndex = 5;
            this.btnExit.Text = "Exit";
            this.btnExit.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnUpload
            // 
            this.btnUpload.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnUpload.Location = new System.Drawing.Point(9, 14);
            this.btnUpload.Name = "btnUpload";
            this.btnUpload.Size = new System.Drawing.Size(75, 27);
            this.btnUpload.TabIndex = 4;
            this.btnUpload.Text = "Upload";
            this.btnUpload.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnUpload.UseVisualStyleBackColor = true;
            this.btnUpload.Click += new System.EventHandler(this.btnUpload_Click);
            // 
            // UploadPositionRawData
            // 
            this.UploadPositionRawData.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.UploadPositionRawData.Location = new System.Drawing.Point(15, 19);
            this.UploadPositionRawData.Name = "UploadPositionRawData";
            this.UploadPositionRawData.Size = new System.Drawing.Size(208, 28);
            this.UploadPositionRawData.TabIndex = 3;
            this.UploadPositionRawData.Text = "Select Bank Position File";
            this.UploadPositionRawData.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.UploadPositionRawData.UseVisualStyleBackColor = true;
            this.UploadPositionRawData.Click += new System.EventHandler(this.UploadPositionRawData_Click);
            // 
            // btnUploadBankRawData
            // 
            this.btnUploadBankRawData.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnUploadBankRawData.Location = new System.Drawing.Point(16, 21);
            this.btnUploadBankRawData.Name = "btnUploadBankRawData";
            this.btnUploadBankRawData.Size = new System.Drawing.Size(213, 28);
            this.btnUploadBankRawData.TabIndex = 2;
            this.btnUploadBankRawData.Text = "Select Bank Transaction File";
            this.btnUploadBankRawData.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnUploadBankRawData.UseVisualStyleBackColor = true;
            this.btnUploadBankRawData.Click += new System.EventHandler(this.btnUploadBankRawData_Click);
            // 
            // grpSltBank
            // 
            this.grpSltBank.Controls.Add(this.label1);
            this.grpSltBank.Controls.Add(this.cmbInvestmentBankList);
            this.grpSltBank.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grpSltBank.Location = new System.Drawing.Point(6, 6);
            this.grpSltBank.Name = "grpSltBank";
            this.grpSltBank.Size = new System.Drawing.Size(655, 59);
            this.grpSltBank.TabIndex = 3;
            this.grpSltBank.TabStop = false;
            this.grpSltBank.Text = "Select Bank";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(23, 26);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(69, 18);
            this.label1.TabIndex = 1;
            this.label1.Text = "Bank         :";
            // 
            // cmbInvestmentBankList
            // 
            this.cmbInvestmentBankList.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbInvestmentBankList.FormattingEnabled = true;
            this.cmbInvestmentBankList.Location = new System.Drawing.Point(254, 19);
            this.cmbInvestmentBankList.Name = "cmbInvestmentBankList";
            this.cmbInvestmentBankList.Size = new System.Drawing.Size(268, 26);
            this.cmbInvestmentBankList.TabIndex = 0;
            this.cmbInvestmentBankList.SelectedIndexChanged += new System.EventHandler(this.cmbInvestmentBankList_SelectedIndexChanged);
            // 
            // OpnFileDialogPosition
            // 
            this.OpnFileDialogPosition.FileName = "OpnFileDialogPosition";
            // 
            // OpnFileDialogBank
            // 
            this.OpnFileDialogBank.FileName = "OpnFileDialogBank";
            // 
            // tbIntregration
            // 
            this.tbIntregration.Controls.Add(this.Intregration);
            this.tbIntregration.Controls.Add(this.Master_Data);
            this.tbIntregration.Font = new System.Drawing.Font("Calibri", 11.25F);
            this.tbIntregration.Location = new System.Drawing.Point(3, 12);
            this.tbIntregration.Name = "tbIntregration";
            this.tbIntregration.SelectedIndex = 0;
            this.tbIntregration.Size = new System.Drawing.Size(685, 477);
            this.tbIntregration.TabIndex = 5;
            this.tbIntregration.SelectedIndexChanged += new System.EventHandler(this.tbIntregration_SelectedIndexChanged);
            // 
            // Intregration
            // 
            this.Intregration.Controls.Add(this.groupBox1);
            this.Intregration.Controls.Add(this.tbIntregrationTypes);
            this.Intregration.Controls.Add(this.grpSltBank);
            this.Intregration.Location = new System.Drawing.Point(4, 27);
            this.Intregration.Name = "Intregration";
            this.Intregration.Padding = new System.Windows.Forms.Padding(3);
            this.Intregration.Size = new System.Drawing.Size(677, 446);
            this.Intregration.TabIndex = 1;
            this.Intregration.Text = "Intregration";
            this.Intregration.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnShowPositionRecord);
            this.groupBox1.Controls.Add(this.btnUpload);
            this.groupBox1.Controls.Add(this.btnValidate);
            this.groupBox1.Controls.Add(this.btnExit);
            this.groupBox1.Location = new System.Drawing.Point(6, 393);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(665, 49);
            this.groupBox1.TabIndex = 5;
            this.groupBox1.TabStop = false;
            // 
            // tbIntregrationTypes
            // 
            this.tbIntregrationTypes.Controls.Add(this.Bank_Transaction);
            this.tbIntregrationTypes.Controls.Add(this.Position_Data);
            this.tbIntregrationTypes.Location = new System.Drawing.Point(6, 88);
            this.tbIntregrationTypes.Name = "tbIntregrationTypes";
            this.tbIntregrationTypes.SelectedIndex = 0;
            this.tbIntregrationTypes.Size = new System.Drawing.Size(665, 299);
            this.tbIntregrationTypes.TabIndex = 4;
            this.tbIntregrationTypes.SelectedIndexChanged += new System.EventHandler(this.tbIntregrationTypes_SelectedIndexChanged_1);
            // 
            // Bank_Transaction
            // 
            this.Bank_Transaction.Controls.Add(this.groupBox2);
            this.Bank_Transaction.Location = new System.Drawing.Point(4, 27);
            this.Bank_Transaction.Name = "Bank_Transaction";
            this.Bank_Transaction.Padding = new System.Windows.Forms.Padding(3);
            this.Bank_Transaction.Size = new System.Drawing.Size(657, 268);
            this.Bank_Transaction.TabIndex = 0;
            this.Bank_Transaction.Text = "Bank Transaction";
            this.Bank_Transaction.UseVisualStyleBackColor = true;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.btnUploadBankRawData);
            this.groupBox2.Controls.Add(this.lblBankFIleLocation);
            this.groupBox2.Location = new System.Drawing.Point(6, 4);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(645, 263);
            this.groupBox2.TabIndex = 0;
            this.groupBox2.TabStop = false;
            // 
            // Position_Data
            // 
            this.Position_Data.Controls.Add(this.groupBox3);
            this.Position_Data.Location = new System.Drawing.Point(4, 27);
            this.Position_Data.Name = "Position_Data";
            this.Position_Data.Padding = new System.Windows.Forms.Padding(3);
            this.Position_Data.Size = new System.Drawing.Size(657, 268);
            this.Position_Data.TabIndex = 1;
            this.Position_Data.Text = "Position Data";
            this.Position_Data.UseVisualStyleBackColor = true;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.lblPositionFileLocation);
            this.groupBox3.Controls.Add(this.UploadPositionRawData);
            this.groupBox3.Location = new System.Drawing.Point(7, 6);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(644, 261);
            this.groupBox3.TabIndex = 1;
            this.groupBox3.TabStop = false;
            this.groupBox3.Enter += new System.EventHandler(this.groupBox3_Enter);
            // 
            // Master_Data
            // 
            this.Master_Data.Controls.Add(this.tbBank);
            this.Master_Data.Location = new System.Drawing.Point(4, 27);
            this.Master_Data.Name = "Master_Data";
            this.Master_Data.Padding = new System.Windows.Forms.Padding(3);
            this.Master_Data.Size = new System.Drawing.Size(677, 446);
            this.Master_Data.TabIndex = 2;
            this.Master_Data.Text = "Master Data";
            this.Master_Data.UseVisualStyleBackColor = true;
            // 
            // tbBank
            // 
            this.tbBank.Controls.Add(this.tabPage1);
            this.tbBank.Controls.Add(this.tabPage2);
            this.tbBank.Font = new System.Drawing.Font("Calibri", 11.25F);
            this.tbBank.Location = new System.Drawing.Point(6, 6);
            this.tbBank.Name = "tbBank";
            this.tbBank.SelectedIndex = 0;
            this.tbBank.Size = new System.Drawing.Size(665, 439);
            this.tbBank.TabIndex = 1;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.grdBank);
            this.tabPage1.Location = new System.Drawing.Point(4, 27);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(657, 408);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Bank";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // grdBank
            // 
            this.grdBank.Controls.Add(this.cmbBankCode);
            this.grdBank.Controls.Add(this.cmbCurrency);
            this.grdBank.Controls.Add(this.cmbBankAccountNumber);
            this.grdBank.Controls.Add(this.label11);
            this.grdBank.Controls.Add(this.cmbBankListMasterData);
            this.grdBank.Controls.Add(this.label9);
            this.grdBank.Controls.Add(this.txtIdentification);
            this.grdBank.Controls.Add(this.btnAddBank);
            this.grdBank.Controls.Add(this.gdBankDetailHistory);
            this.grdBank.Controls.Add(this.txtGLAccount);
            this.grdBank.Controls.Add(this.label4);
            this.grdBank.Controls.Add(this.label3);
            this.grdBank.Controls.Add(this.label2);
            this.grdBank.Controls.Add(this.label5);
            this.grdBank.Location = new System.Drawing.Point(6, 6);
            this.grdBank.Name = "grdBank";
            this.grdBank.Size = new System.Drawing.Size(645, 404);
            this.grdBank.TabIndex = 2;
            this.grdBank.TabStop = false;
            this.grdBank.Text = "Bank Account";
            // 
            // cmbBankCode
            // 
            this.cmbBankCode.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbBankCode.FormattingEnabled = true;
            this.cmbBankCode.Location = new System.Drawing.Point(191, 154);
            this.cmbBankCode.Name = "cmbBankCode";
            this.cmbBankCode.Size = new System.Drawing.Size(268, 26);
            this.cmbBankCode.TabIndex = 16;
            // 
            // cmbCurrency
            // 
            this.cmbCurrency.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbCurrency.FormattingEnabled = true;
            this.cmbCurrency.Location = new System.Drawing.Point(191, 117);
            this.cmbCurrency.Name = "cmbCurrency";
            this.cmbCurrency.Size = new System.Drawing.Size(268, 26);
            this.cmbCurrency.TabIndex = 15;
            // 
            // cmbBankAccountNumber
            // 
            this.cmbBankAccountNumber.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbBankAccountNumber.FormattingEnabled = true;
            this.cmbBankAccountNumber.Location = new System.Drawing.Point(191, 194);
            this.cmbBankAccountNumber.Name = "cmbBankAccountNumber";
            this.cmbBankAccountNumber.Size = new System.Drawing.Size(268, 26);
            this.cmbBankAccountNumber.TabIndex = 14;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.Location = new System.Drawing.Point(25, 40);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(62, 18);
            this.label11.TabIndex = 1;
            this.label11.Text = "Bank        ";
            // 
            // cmbBankListMasterData
            // 
            this.cmbBankListMasterData.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbBankListMasterData.FormattingEnabled = true;
            this.cmbBankListMasterData.Location = new System.Drawing.Point(191, 37);
            this.cmbBankListMasterData.Name = "cmbBankListMasterData";
            this.cmbBankListMasterData.Size = new System.Drawing.Size(268, 26);
            this.cmbBankListMasterData.TabIndex = 0;
            this.cmbBankListMasterData.SelectedIndexChanged += new System.EventHandler(this.cmbBankListMasterData_SelectedIndexChanged);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(25, 82);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(145, 18);
            this.label9.TabIndex = 13;
            this.label9.Text = "Bank Account Number";
            // 
            // txtIdentification
            // 
            this.txtIdentification.Location = new System.Drawing.Point(191, 234);
            this.txtIdentification.Name = "txtIdentification";
            this.txtIdentification.Size = new System.Drawing.Size(268, 26);
            this.txtIdentification.TabIndex = 12;
            // 
            // btnAddBank
            // 
            this.btnAddBank.Location = new System.Drawing.Point(508, 30);
            this.btnAddBank.Name = "btnAddBank";
            this.btnAddBank.Size = new System.Drawing.Size(116, 29);
            this.btnAddBank.TabIndex = 9;
            this.btnAddBank.Text = "SAVE";
            this.btnAddBank.UseVisualStyleBackColor = true;
            this.btnAddBank.Click += new System.EventHandler(this.btnAddBank_Click);
            // 
            // gdBankDetailHistory
            // 
            this.gdBankDetailHistory.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gdBankDetailHistory.Location = new System.Drawing.Point(6, 274);
            this.gdBankDetailHistory.Name = "gdBankDetailHistory";
            this.gdBankDetailHistory.RowHeadersVisible = false;
            this.gdBankDetailHistory.Size = new System.Drawing.Size(633, 120);
            this.gdBankDetailHistory.TabIndex = 8;
            // 
            // txtGLAccount
            // 
            this.txtGLAccount.Location = new System.Drawing.Point(191, 79);
            this.txtGLAccount.Name = "txtGLAccount";
            this.txtGLAccount.Size = new System.Drawing.Size(268, 26);
            this.txtGLAccount.TabIndex = 7;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(25, 197);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(88, 18);
            this.label4.TabIndex = 3;
            this.label4.Text = "G \\ L Account";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(25, 157);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(73, 18);
            this.label3.TabIndex = 2;
            this.label3.Text = "Bank Code";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(25, 120);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(63, 18);
            this.label2.TabIndex = 1;
            this.label2.Text = "Currency";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(25, 237);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(124, 18);
            this.label5.TabIndex = 0;
            this.label5.Text = "Identification Code";
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.grpCharges);
            this.tabPage2.Location = new System.Drawing.Point(4, 27);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(657, 408);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Charges";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // grpCharges
            // 
            this.grpCharges.Controls.Add(this.cmbChargeCode);
            this.grpCharges.Controls.Add(this.btnAddChardes);
            this.grpCharges.Controls.Add(this.gdCharge);
            this.grpCharges.Controls.Add(this.txtchargeReferanceID);
            this.grpCharges.Controls.Add(this.txtChargeDescription);
            this.grpCharges.Controls.Add(this.txtChargeBankAccount);
            this.grpCharges.Controls.Add(this.label6);
            this.grpCharges.Controls.Add(this.label7);
            this.grpCharges.Controls.Add(this.label8);
            this.grpCharges.Controls.Add(this.label10);
            this.grpCharges.Location = new System.Drawing.Point(6, 3);
            this.grpCharges.Name = "grpCharges";
            this.grpCharges.Size = new System.Drawing.Size(628, 404);
            this.grpCharges.TabIndex = 3;
            this.grpCharges.TabStop = false;
            this.grpCharges.Text = "Charges";
            // 
            // btnAddChardes
            // 
            this.btnAddChardes.Location = new System.Drawing.Point(477, 28);
            this.btnAddChardes.Name = "btnAddChardes";
            this.btnAddChardes.Size = new System.Drawing.Size(116, 29);
            this.btnAddChardes.TabIndex = 10;
            this.btnAddChardes.Text = "Save";
            this.btnAddChardes.UseVisualStyleBackColor = true;
            this.btnAddChardes.Click += new System.EventHandler(this.btnAddChardes_Click);
            // 
            // gdCharge
            // 
            this.gdCharge.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gdCharge.Location = new System.Drawing.Point(6, 195);
            this.gdCharge.Name = "gdCharge";
            this.gdCharge.RowHeadersVisible = false;
            this.gdCharge.Size = new System.Drawing.Size(616, 203);
            this.gdCharge.TabIndex = 8;
            // 
            // txtchargeReferanceID
            // 
            this.txtchargeReferanceID.Location = new System.Drawing.Point(186, 148);
            this.txtchargeReferanceID.Name = "txtchargeReferanceID";
            this.txtchargeReferanceID.Size = new System.Drawing.Size(185, 26);
            this.txtchargeReferanceID.TabIndex = 7;
            // 
            // txtChargeDescription
            // 
            this.txtChargeDescription.Location = new System.Drawing.Point(186, 108);
            this.txtChargeDescription.Name = "txtChargeDescription";
            this.txtChargeDescription.Size = new System.Drawing.Size(185, 26);
            this.txtChargeDescription.TabIndex = 6;
            // 
            // txtChargeBankAccount
            // 
            this.txtChargeBankAccount.Location = new System.Drawing.Point(186, 31);
            this.txtChargeBankAccount.Name = "txtChargeBankAccount";
            this.txtChargeBankAccount.Size = new System.Drawing.Size(185, 26);
            this.txtChargeBankAccount.TabIndex = 4;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(20, 151);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(88, 18);
            this.label6.TabIndex = 3;
            this.label6.Text = "Reference ID";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(20, 111);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(78, 18);
            this.label7.TabIndex = 2;
            this.label7.Text = "Description";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(20, 74);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(29, 18);
            this.label8.TabIndex = 1;
            this.label8.Text = "FEE";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(20, 34);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(145, 18);
            this.label10.TabIndex = 0;
            this.label10.Text = "Bank Account Number";
            // 
            // cmbChargeCode
            // 
            this.cmbChargeCode.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbChargeCode.FormattingEnabled = true;
            this.cmbChargeCode.Location = new System.Drawing.Point(186, 71);
            this.cmbChargeCode.Name = "cmbChargeCode";
            this.cmbChargeCode.Size = new System.Drawing.Size(192, 26);
            this.cmbChargeCode.TabIndex = 16;
            // 
            // frmFileUpload
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(692, 494);
            this.Controls.Add(this.tbIntregration);
            this.MaximizeBox = false;
            this.Name = "frmFileUpload";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Bank Transaction File";
            this.Load += new System.EventHandler(this.frmFileUpload_Load);
            this.grpSltBank.ResumeLayout(false);
            this.grpSltBank.PerformLayout();
            this.tbIntregration.ResumeLayout(false);
            this.Intregration.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.tbIntregrationTypes.ResumeLayout(false);
            this.Bank_Transaction.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.Position_Data.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.Master_Data.ResumeLayout(false);
            this.tbBank.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.grdBank.ResumeLayout(false);
            this.grdBank.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gdBankDetailHistory)).EndInit();
            this.tabPage2.ResumeLayout(false);
            this.grpCharges.ResumeLayout(false);
            this.grpCharges.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gdCharge)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnUpload;
        private System.Windows.Forms.Button UploadPositionRawData;
        private System.Windows.Forms.Button btnUploadBankRawData;
        private System.Windows.Forms.GroupBox grpSltBank;
        private System.Windows.Forms.OpenFileDialog OpnFileDialogPosition;
        private System.Windows.Forms.OpenFileDialog OpnFileDialogBank;
        private System.Windows.Forms.Label lblPositionFileLocation;
        private System.Windows.Forms.Label lblBankFIleLocation;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cmbInvestmentBankList;
        private System.Windows.Forms.Button btnValidate;
        private System.Windows.Forms.Button btnShowPositionRecord;
        private System.Windows.Forms.TabControl tbIntregration;
        private System.Windows.Forms.TabPage Intregration;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TabControl tbIntregrationTypes;
        private System.Windows.Forms.TabPage Bank_Transaction;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TabPage Position_Data;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TabPage Master_Data;
        private System.Windows.Forms.TabControl tbBank;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.GroupBox grdBank;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox txtIdentification;
        private System.Windows.Forms.Button btnAddBank;
        private System.Windows.Forms.DataGridView gdBankDetailHistory;
        private System.Windows.Forms.TextBox txtGLAccount;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.GroupBox grpCharges;
        private System.Windows.Forms.Button btnAddChardes;
        private System.Windows.Forms.DataGridView gdCharge;
        private System.Windows.Forms.TextBox txtchargeReferanceID;
        private System.Windows.Forms.TextBox txtChargeDescription;
        private System.Windows.Forms.TextBox txtChargeBankAccount;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.ComboBox cmbBankListMasterData;
        private System.Windows.Forms.ComboBox cmbBankAccountNumber;
        private System.Windows.Forms.ComboBox cmbCurrency;
        private System.Windows.Forms.ComboBox cmbBankCode;
        private System.Windows.Forms.ComboBox cmbChargeCode;

    }
}

