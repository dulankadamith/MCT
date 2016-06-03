namespace MCT_GL_Application.UI_FORMS
{
    partial class frmDisplayPositionDetails
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
            this.grpPositionDetailsSelect = new System.Windows.Forms.GroupBox();
            this.btnClose = new System.Windows.Forms.Button();
            this.btnSearch = new System.Windows.Forms.Button();
            this.dtpToDate = new System.Windows.Forms.DateTimePicker();
            this.dtpFromDate = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.lblFromDate = new System.Windows.Forms.Label();
            this.grpPosition = new System.Windows.Forms.GroupBox();
            this.dgPositionData = new System.Windows.Forms.DataGridView();
            this.grpPositionDetailsSelect.SuspendLayout();
            this.grpPosition.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgPositionData)).BeginInit();
            this.SuspendLayout();
            // 
            // grpPositionDetailsSelect
            // 
            this.grpPositionDetailsSelect.Controls.Add(this.btnClose);
            this.grpPositionDetailsSelect.Controls.Add(this.btnSearch);
            this.grpPositionDetailsSelect.Controls.Add(this.dtpToDate);
            this.grpPositionDetailsSelect.Controls.Add(this.dtpFromDate);
            this.grpPositionDetailsSelect.Controls.Add(this.label1);
            this.grpPositionDetailsSelect.Controls.Add(this.lblFromDate);
            this.grpPositionDetailsSelect.Location = new System.Drawing.Point(13, 13);
            this.grpPositionDetailsSelect.Name = "grpPositionDetailsSelect";
            this.grpPositionDetailsSelect.Size = new System.Drawing.Size(688, 112);
            this.grpPositionDetailsSelect.TabIndex = 0;
            this.grpPositionDetailsSelect.TabStop = false;
            this.grpPositionDetailsSelect.Text = "Selection Criteria";
            // 
            // btnClose
            // 
            this.btnClose.Location = new System.Drawing.Point(568, 65);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(95, 29);
            this.btnClose.TabIndex = 5;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // btnSearch
            // 
            this.btnSearch.Location = new System.Drawing.Point(568, 22);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(95, 29);
            this.btnSearch.TabIndex = 4;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = true;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // dtpToDate
            // 
            this.dtpToDate.Location = new System.Drawing.Point(124, 64);
            this.dtpToDate.Name = "dtpToDate";
            this.dtpToDate.Size = new System.Drawing.Size(200, 20);
            this.dtpToDate.TabIndex = 3;
            // 
            // dtpFromDate
            // 
            this.dtpFromDate.Location = new System.Drawing.Point(124, 21);
            this.dtpFromDate.Name = "dtpFromDate";
            this.dtpFromDate.Size = new System.Drawing.Size(200, 20);
            this.dtpFromDate.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(28, 70);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(82, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "To Date           :";
            // 
            // lblFromDate
            // 
            this.lblFromDate.AutoSize = true;
            this.lblFromDate.Location = new System.Drawing.Point(28, 27);
            this.lblFromDate.Name = "lblFromDate";
            this.lblFromDate.Size = new System.Drawing.Size(80, 13);
            this.lblFromDate.TabIndex = 0;
            this.lblFromDate.Text = "From Date       :";
            // 
            // grpPosition
            // 
            this.grpPosition.Controls.Add(this.dgPositionData);
            this.grpPosition.Location = new System.Drawing.Point(13, 160);
            this.grpPosition.Name = "grpPosition";
            this.grpPosition.Size = new System.Drawing.Size(688, 336);
            this.grpPosition.TabIndex = 1;
            this.grpPosition.TabStop = false;
            this.grpPosition.Text = "Position Details";
            // 
            // dgPositionData
            // 
            this.dgPositionData.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgPositionData.Location = new System.Drawing.Point(13, 19);
            this.dgPositionData.Name = "dgPositionData";
            this.dgPositionData.RowHeadersVisible = false;
            this.dgPositionData.Size = new System.Drawing.Size(663, 305);
            this.dgPositionData.TabIndex = 0;
            // 
            // frmDisplayPositionDetails
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(713, 508);
            this.Controls.Add(this.grpPosition);
            this.Controls.Add(this.grpPositionDetailsSelect);
            this.MaximizeBox = false;
            this.Name = "frmDisplayPositionDetails";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Display Position Details";
            this.grpPositionDetailsSelect.ResumeLayout(false);
            this.grpPositionDetailsSelect.PerformLayout();
            this.grpPosition.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgPositionData)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox grpPositionDetailsSelect;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Button btnSearch;
        private System.Windows.Forms.DateTimePicker dtpToDate;
        private System.Windows.Forms.DateTimePicker dtpFromDate;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblFromDate;
        private System.Windows.Forms.GroupBox grpPosition;
        private System.Windows.Forms.DataGridView dgPositionData;
    }
}