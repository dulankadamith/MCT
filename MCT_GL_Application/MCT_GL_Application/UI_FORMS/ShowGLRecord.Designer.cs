namespace MCT_GL_Application.UI_FORMS
{
    partial class frmShowGLRecord
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
            this.dgGLRecord = new System.Windows.Forms.DataGridView();
            this.ID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Reference = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Description = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.C_Account = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Account = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Currency = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Date = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.BNK = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DOE = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.FEE = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PRC = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.QTY = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.REF = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TOP = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dgGLRecord)).BeginInit();
            this.SuspendLayout();
            // 
            // dgGLRecord
            // 
            this.dgGLRecord.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgGLRecord.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ID,
            this.Reference,
            this.Description,
            this.C_Account,
            this.Account,
            this.Currency,
            this.Date,
            this.BNK,
            this.DOE,
            this.FEE,
            this.PRC,
            this.QTY,
            this.REF,
            this.TOP});
            this.dgGLRecord.Location = new System.Drawing.Point(12, 12);
            this.dgGLRecord.Name = "dgGLRecord";
            this.dgGLRecord.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            this.dgGLRecord.RowHeadersVisible = false;
            this.dgGLRecord.Size = new System.Drawing.Size(1142, 150);
            this.dgGLRecord.TabIndex = 0;
            // 
            // ID
            // 
            this.ID.HeaderText = "ID";
            this.ID.Name = "ID";
            this.ID.ReadOnly = true;
            // 
            // Reference
            // 
            this.Reference.HeaderText = "Reference";
            this.Reference.Name = "Reference";
            this.Reference.ReadOnly = true;
            // 
            // Description
            // 
            this.Description.HeaderText = "Description";
            this.Description.Name = "Description";
            this.Description.ReadOnly = true;
            // 
            // C_Account
            // 
            this.C_Account.HeaderText = "Account";
            this.C_Account.Name = "C_Account";
            // 
            // Account
            // 
            this.Account.HeaderText = "Account";
            this.Account.Name = "Account";
            this.Account.ReadOnly = true;
            // 
            // Currency
            // 
            this.Currency.HeaderText = "Currency";
            this.Currency.Name = "Currency";
            this.Currency.ReadOnly = true;
            // 
            // Date
            // 
            this.Date.HeaderText = "Date";
            this.Date.Name = "Date";
            this.Date.ReadOnly = true;
            // 
            // BNK
            // 
            this.BNK.HeaderText = "BNK";
            this.BNK.Name = "BNK";
            this.BNK.ReadOnly = true;
            // 
            // DOE
            // 
            this.DOE.HeaderText = "DOE";
            this.DOE.Name = "DOE";
            this.DOE.ReadOnly = true;
            // 
            // FEE
            // 
            this.FEE.HeaderText = "FEE";
            this.FEE.Name = "FEE";
            this.FEE.ReadOnly = true;
            // 
            // PRC
            // 
            this.PRC.HeaderText = "PRC";
            this.PRC.Name = "PRC";
            this.PRC.ReadOnly = true;
            // 
            // QTY
            // 
            this.QTY.HeaderText = "QTY";
            this.QTY.Name = "QTY";
            this.QTY.ReadOnly = true;
            // 
            // REF
            // 
            this.REF.HeaderText = "REF";
            this.REF.Name = "REF";
            this.REF.ReadOnly = true;
            // 
            // TOP
            // 
            this.TOP.HeaderText = "TOP";
            this.TOP.Name = "TOP";
            this.TOP.ReadOnly = true;
            // 
            // frmShowGLRecord
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1166, 172);
            this.Controls.Add(this.dgGLRecord);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmShowGLRecord";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Show GL Record";
            this.Load += new System.EventHandler(this.frmShowGLRecord_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgGLRecord)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dgGLRecord;
        private System.Windows.Forms.DataGridViewTextBoxColumn ID;
        private System.Windows.Forms.DataGridViewTextBoxColumn Reference;
        private System.Windows.Forms.DataGridViewTextBoxColumn Description;
        private System.Windows.Forms.DataGridViewTextBoxColumn C_Account;
        private System.Windows.Forms.DataGridViewTextBoxColumn Account;
        private System.Windows.Forms.DataGridViewTextBoxColumn Currency;
        private System.Windows.Forms.DataGridViewTextBoxColumn Date;
        private System.Windows.Forms.DataGridViewTextBoxColumn BNK;
        private System.Windows.Forms.DataGridViewTextBoxColumn DOE;
        private System.Windows.Forms.DataGridViewTextBoxColumn FEE;
        private System.Windows.Forms.DataGridViewTextBoxColumn PRC;
        private System.Windows.Forms.DataGridViewTextBoxColumn QTY;
        private System.Windows.Forms.DataGridViewTextBoxColumn REF;
        private System.Windows.Forms.DataGridViewTextBoxColumn TOP;

    }
}