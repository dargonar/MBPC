namespace mbpc_wsclient
{
  partial class Form1
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
      this.dataGrid = new System.Windows.Forms.DataGridView();
      this.btnGo = new System.Windows.Forms.Button();
      this.dtFecha = new System.Windows.Forms.DateTimePicker();
      this.label1 = new System.Windows.Forms.Label();
      this.pgLoading = new System.Windows.Forms.ProgressBar();
      this.lblLoading = new System.Windows.Forms.Label();
      ((System.ComponentModel.ISupportInitialize)(this.dataGrid)).BeginInit();
      this.SuspendLayout();
      // 
      // dataGrid
      // 
      this.dataGrid.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                  | System.Windows.Forms.AnchorStyles.Left)
                  | System.Windows.Forms.AnchorStyles.Right)));
      this.dataGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this.dataGrid.Location = new System.Drawing.Point(12, 12);
      this.dataGrid.Name = "dataGrid";
      this.dataGrid.Size = new System.Drawing.Size(657, 339);
      this.dataGrid.TabIndex = 0;
      // 
      // btnGo
      // 
      this.btnGo.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
      this.btnGo.Location = new System.Drawing.Point(565, 357);
      this.btnGo.Name = "btnGo";
      this.btnGo.Size = new System.Drawing.Size(104, 25);
      this.btnGo.TabIndex = 1;
      this.btnGo.Text = "Ejecutar";
      this.btnGo.UseVisualStyleBackColor = true;
      this.btnGo.Click += new System.EventHandler(this.btnGo_Click);
      // 
      // dtFecha
      // 
      this.dtFecha.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
      this.dtFecha.Format = System.Windows.Forms.DateTimePickerFormat.Short;
      this.dtFecha.Location = new System.Drawing.Point(457, 360);
      this.dtFecha.Name = "dtFecha";
      this.dtFecha.Size = new System.Drawing.Size(85, 20);
      this.dtFecha.TabIndex = 2;
      // 
      // label1
      // 
      this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
      this.label1.AutoSize = true;
      this.label1.Location = new System.Drawing.Point(414, 364);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(37, 13);
      this.label1.TabIndex = 4;
      this.label1.Text = "Fecha";
      // 
      // pgLoading
      // 
      this.pgLoading.Anchor = System.Windows.Forms.AnchorStyles.Top;
      this.pgLoading.Location = new System.Drawing.Point(136, 176);
      this.pgLoading.Name = "pgLoading";
      this.pgLoading.Size = new System.Drawing.Size(408, 40);
      this.pgLoading.Style = System.Windows.Forms.ProgressBarStyle.Marquee;
      this.pgLoading.TabIndex = 5;
      this.pgLoading.Value = 1;
      this.pgLoading.Visible = false;
      // 
      // lblLoading
      // 
      this.lblLoading.Anchor = System.Windows.Forms.AnchorStyles.Top;
      this.lblLoading.AutoSize = true;
      this.lblLoading.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblLoading.Location = new System.Drawing.Point(138, 148);
      this.lblLoading.Name = "lblLoading";
      this.lblLoading.Size = new System.Drawing.Size(152, 25);
      this.lblLoading.TabIndex = 6;
      this.lblLoading.Text = "Cargando datos";
      this.lblLoading.Visible = false;
      // 
      // Form1
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(681, 392);
      this.Controls.Add(this.lblLoading);
      this.Controls.Add(this.pgLoading);
      this.Controls.Add(this.label1);
      this.Controls.Add(this.dtFecha);
      this.Controls.Add(this.btnGo);
      this.Controls.Add(this.dataGrid);
      this.Name = "Form1";
      this.Text = "MBPC WS Test";
      this.Load += new System.EventHandler(this.Form1_Load);
      ((System.ComponentModel.ISupportInitialize)(this.dataGrid)).EndInit();
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    private System.Windows.Forms.DataGridView dataGrid;
    private System.Windows.Forms.Button btnGo;
    private System.Windows.Forms.DateTimePicker dtFecha;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.ProgressBar pgLoading;
    private System.Windows.Forms.Label lblLoading;
  }
}

