namespace MCT_GL_Application.UI_FORMS
{
    partial class Validation
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
            this.grpSltBank = new System.Windows.Forms.GroupBox();
            this.btnBack = new System.Windows.Forms.Button();
            this.lblCmbChangeValue = new System.Windows.Forms.Label();
            this.btnClose = new System.Windows.Forms.Button();
            this.btnValidate = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.cmbInvestmentBankList = new System.Windows.Forms.ComboBox();
            this.grpValidate = new System.Windows.Forms.GroupBox();
            this.drgValidateData = new System.Windows.Forms.DataGridView();
            this.btnCreateRawGLEntry = new System.Windows.Forms.Button();
            this.grpSltBank.SuspendLayout();
            this.grpValidate.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.drgValidateData)).BeginInit();
            this.SuspendLayout();
            // 
            // grpSltBank
            // 
            this.grpSltBank.Controls.Add(this.btnCreateRawGLEntry);
            this.grpSltBank.Controls.Add(this.btnBack);
            this.grpSltBank.Controls.Add(this.lblCmbChangeValue);
            this.grpSltBank.Controls.Add(this.btnClose);
            this.grpSltBank.Controls.Add(this.btnValidate);
            this.grpSltBank.Controls.Add(this.label1);
            this.grpSltBank.Controls.Add(this.cmbInvestmentBankList);
            this.grpSltBank.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grpSltBank.Location = new System.Drawing.Point(12, 10);
            this.grpSltBank.Name = "grpSltBank";
            this.grpSltBank.Size = new System.Drawing.Size(1247, 59);
            this.grpSltBank.TabIndex = 4;
            this.grpSltBank.TabStop = false;
            this.grpSltBank.Text = "Select Bank";
            // 
            // btnBack
            // 
            this.btnBack.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btnBack.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnBack.Location = new System.Drawing.Point(417, 19);
            this.btnBack.Name = "btnBack";
            this.btnBack.Size = new System.Drawing.Size(92, 30);
            this.btnBack.TabIndex = 11;
            this.btnBack.Text = "<<< Back";
            this.btnBack.UseVisualStyleBackColor = true;
            this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
            // 
            // lblCmbChangeValue
            // 
            this.lblCmbChangeValue.AutoSize = true;
            this.lblCmbChangeValue.Location = new System.Drawing.Point(411, 25);
            this.lblCmbChangeValue.Name = "lblCmbChangeValue";
            this.lblCmbChangeValue.Size = new System.Drawing.Size(0, 18);
            this.lblCmbChangeValue.TabIndex = 9;
            this.lblCmbChangeValue.Visible = false;
            // 
            // btnClose
            // 
            this.btnClose.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClose.Location = new System.Drawing.Point(1151, 21);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(75, 28);
            this.btnClose.TabIndex = 8;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // btnValidate
            // 
            this.btnValidate.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnValidate.Location = new System.Drawing.Point(525, 19);
            this.btnValidate.Name = "btnValidate";
            this.btnValidate.Size = new System.Drawing.Size(91, 30);
            this.btnValidate.TabIndex = 6;
            this.btnValidate.Text = "Validate";
            this.btnValidate.UseVisualStyleBackColor = true;
            this.btnValidate.Click += new System.EventHandler(this.btnValidate_Click);
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
            this.cmbInvestmentBankList.Location = new System.Drawing.Point(119, 22);
            this.cmbInvestmentBankList.Name = "cmbInvestmentBankList";
            this.cmbInvestmentBankList.Size = new System.Drawing.Size(268, 26);
            this.cmbInvestmentBankList.TabIndex = 0;
            this.cmbInvestmentBankList.SelectedIndexChanged += new System.EventHandler(this.cmbInvestmentBankList_SelectedIndexChanged);
            // 
            // grpValidate
            // 
            this.grpValidate.Controls.Add(this.drgValidateData);
            this.grpValidate.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grpValidate.Location = new System.Drawing.Point(12, 77);
            this.grpValidate.Name = "grpValidate";
            this.grpValidate.Size = new System.Drawing.Size(1247, 419);
            this.grpValidate.TabIndex = 5;
            this.grpValidate.TabStop = false;
            this.grpValidate.Text = "Validated Records";
            // 
            // drgValidateData
            // 
            this.drgValidateData.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.drgValidateData.Location = new System.Drawing.Point(7, 20);
            this.drgValidateData.Name = "drgValidateData";
            this.drgValidateData.RowHeadersVisible = false;
            this.drgValidateData.Size = new System.Drawing.Size(1234, 393);
            this.drgValidateData.TabIndex = 0;
            // 
            // btnCreateRawGLEntry
            // 
            this.btnCreateRawGLEntry.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCreateRawGLEntry.Location = new System.Drawing.Point(633, 19);
            this.btnCreateRawGLEntry.Name = "btnCreateRawGLEntry";
            this.btnCreateRawGLEntry.Size = new System.Drawing.Size(162, 29);
            this.btnCreateRawGLEntry.TabIndex = 12;
            this.btnCreateRawGLEntry.Text = "Prepare GL Entry";
            this.btnCreateRawGLEntry.UseVisualStyleBackColor = true;
            this.btnCreateRawGLEntry.Click += new System.EventHandler(this.btnCreateRawGLEntry_Click);
            // 
            // Validation
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1271, 508);
            this.Controls.Add(this.grpValidate);
            this.Controls.Add(this.grpSltBank);
            this.MaximizeBox = false;
            this.Name = "Validation";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Validation";
            this.Load += new System.EventHandler(this.Validation_Load);
            this.grpSltBank.ResumeLayout(false);
            this.grpSltBank.PerformLayout();
            this.grpValidate.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.drgValidateData)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox grpSltBank;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cmbInvestmentBankList;
        private System.Windows.Forms.GroupBox grpValidate;
        private System.Windows.Forms.Button btnValidate;
        private System.Windows.Forms.DataGridView drgValidateData;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Label lblCmbChangeValue;
        private System.Windows.Forms.Button btnBack;
        private System.Windows.Forms.Button btnCreateRawGLEntry;
    }
}