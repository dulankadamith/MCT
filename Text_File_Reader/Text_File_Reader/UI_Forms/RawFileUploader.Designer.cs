namespace Text_File_Reader.UI_Forms
{
    partial class RawFileUploader
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
            this.rbtnJB = new System.Windows.Forms.RadioButton();
            this.rbtnLodh = new System.Windows.Forms.RadioButton();
            this.rbtnBNP = new System.Windows.Forms.RadioButton();
            this.grpRawData = new System.Windows.Forms.GroupBox();
            this.prgFileUpload = new System.Windows.Forms.ProgressBar();
            this.OpnFileDialogBank = new System.Windows.Forms.OpenFileDialog();
            this.lblRawFile = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.btnUpload = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.OpnFileDialogPosition = new System.Windows.Forms.OpenFileDialog();
            this.grpSltBank.SuspendLayout();
            this.grpRawData.SuspendLayout();
            this.SuspendLayout();
            // 
            // grpSltBank
            // 
            this.grpSltBank.Controls.Add(this.rbtnBNP);
            this.grpSltBank.Controls.Add(this.rbtnLodh);
            this.grpSltBank.Controls.Add(this.rbtnJB);
            this.grpSltBank.Location = new System.Drawing.Point(13, 13);
            this.grpSltBank.Name = "grpSltBank";
            this.grpSltBank.Size = new System.Drawing.Size(427, 59);
            this.grpSltBank.TabIndex = 0;
            this.grpSltBank.TabStop = false;
            this.grpSltBank.Text = "Select Bank";
            // 
            // rbtnJB
            // 
            this.rbtnJB.AutoSize = true;
            this.rbtnJB.Location = new System.Drawing.Point(18, 23);
            this.rbtnJB.Name = "rbtnJB";
            this.rbtnJB.Size = new System.Drawing.Size(76, 17);
            this.rbtnJB.TabIndex = 0;
            this.rbtnJB.TabStop = true;
            this.rbtnJB.Text = "Julius Baer";
            this.rbtnJB.UseVisualStyleBackColor = true;
            // 
            // rbtnLodh
            // 
            this.rbtnLodh.AutoSize = true;
            this.rbtnLodh.Location = new System.Drawing.Point(146, 25);
            this.rbtnLodh.Name = "rbtnLodh";
            this.rbtnLodh.Size = new System.Drawing.Size(94, 17);
            this.rbtnLodh.TabIndex = 1;
            this.rbtnLodh.TabStop = true;
            this.rbtnLodh.Text = "Lombard Odier";
            this.rbtnLodh.UseVisualStyleBackColor = true;
            // 
            // rbtnBNP
            // 
            this.rbtnBNP.AutoSize = true;
            this.rbtnBNP.Location = new System.Drawing.Point(304, 25);
            this.rbtnBNP.Name = "rbtnBNP";
            this.rbtnBNP.Size = new System.Drawing.Size(85, 17);
            this.rbtnBNP.TabIndex = 2;
            this.rbtnBNP.TabStop = true;
            this.rbtnBNP.Text = "BNP Paribas";
            this.rbtnBNP.UseVisualStyleBackColor = true;
            // 
            // grpRawData
            // 
            this.grpRawData.Controls.Add(this.btnExit);
            this.grpRawData.Controls.Add(this.btnUpload);
            this.grpRawData.Controls.Add(this.button2);
            this.grpRawData.Controls.Add(this.button1);
            this.grpRawData.Controls.Add(this.label1);
            this.grpRawData.Controls.Add(this.lblRawFile);
            this.grpRawData.Location = new System.Drawing.Point(13, 79);
            this.grpRawData.Name = "grpRawData";
            this.grpRawData.Size = new System.Drawing.Size(427, 182);
            this.grpRawData.TabIndex = 1;
            this.grpRawData.TabStop = false;
            this.grpRawData.Text = "Select Raw Data Files";
            // 
            // prgFileUpload
            // 
            this.prgFileUpload.Location = new System.Drawing.Point(13, 267);
            this.prgFileUpload.Name = "prgFileUpload";
            this.prgFileUpload.Size = new System.Drawing.Size(427, 15);
            this.prgFileUpload.TabIndex = 2;
            // 
            // OpnFileDialogBank
            // 
            this.OpnFileDialogBank.FileName = "OpnFileDialogBank";
            // 
            // lblRawFile
            // 
            this.lblRawFile.AutoSize = true;
            this.lblRawFile.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblRawFile.Location = new System.Drawing.Point(15, 31);
            this.lblRawFile.Name = "lblRawFile";
            this.lblRawFile.Size = new System.Drawing.Size(191, 13);
            this.lblRawFile.TabIndex = 0;
            this.lblRawFile.Text = "Select Bank Raw data file       : ";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(15, 75);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(193, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Select Position file                  : ";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(233, 31);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(165, 23);
            this.button1.TabIndex = 2;
            this.button1.Text = "Select Bank File";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(233, 75);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(165, 23);
            this.button2.TabIndex = 3;
            this.button2.Text = "Select Position File";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // btnUpload
            // 
            this.btnUpload.Location = new System.Drawing.Point(18, 150);
            this.btnUpload.Name = "btnUpload";
            this.btnUpload.Size = new System.Drawing.Size(75, 23);
            this.btnUpload.TabIndex = 4;
            this.btnUpload.Text = "Upload";
            this.btnUpload.UseVisualStyleBackColor = true;
            // 
            // btnExit
            // 
            this.btnExit.Location = new System.Drawing.Point(323, 150);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(75, 23);
            this.btnExit.TabIndex = 5;
            this.btnExit.Text = "Exit";
            this.btnExit.UseVisualStyleBackColor = true;
            // 
            // OpnFileDialogPosition
            // 
            this.OpnFileDialogPosition.FileName = "OpnFileDialogPosition";
            // 
            // RawFileUploader
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(450, 288);
            this.Controls.Add(this.prgFileUpload);
            this.Controls.Add(this.grpRawData);
            this.Controls.Add(this.grpSltBank);
            this.Name = "RawFileUploader";
            this.Text = "Upload Raw Data";
            this.grpSltBank.ResumeLayout(false);
            this.grpSltBank.PerformLayout();
            this.grpRawData.ResumeLayout(false);
            this.grpRawData.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox grpSltBank;
        private System.Windows.Forms.RadioButton rbtnBNP;
        private System.Windows.Forms.RadioButton rbtnLodh;
        private System.Windows.Forms.RadioButton rbtnJB;
        private System.Windows.Forms.GroupBox grpRawData;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnUpload;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblRawFile;
        private System.Windows.Forms.ProgressBar prgFileUpload;
        private System.Windows.Forms.OpenFileDialog OpnFileDialogBank;
        private System.Windows.Forms.OpenFileDialog OpnFileDialogPosition;
    }
}