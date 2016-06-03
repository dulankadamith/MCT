using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Windows.Forms;
using System.Globalization;

namespace MCT_GL_Application.FUNCTION_CLASS
{
    public class Validate_LODH
    {
        public String strConnStringOpr = ConfigurationSettings.AppSettings["CommonConnection"].ToString();
        SqlDataReader reader;

        public bool Validate_LODH_Records(DataTable DT)
        {
            int[] SuccessRecordList = new int[DT.Rows.Count];
            int c;
            bool rtn_val = false;

            try
            {
                for (c = 0; c < DT.Rows.Count; c++)
                {
                    #region inside LODH For Loop

                    decimal value;
                    string format = "yyyyMMdd";
                    DateTime dateTime;

                    if ((DT.Rows[c].ItemArray[3].ToString() != "") && Check_BankAccInBankMap_BNP(DT.Rows[c].ItemArray[3].ToString()) == true) //Check Bank Account
                    {
                        //if ((DT.Rows[c].ItemArray[20].ToString() != "") && (Decimal.TryParse(DT.Rows[c].ItemArray[20].ToString(), out value))) //Check transaction amount
                        //{
                            if ((DT.Rows[c].ItemArray[13].ToString() != "")) //Check transaction date
                            {
                                if ((DateTime.TryParseExact(DT.Rows[c].ItemArray[13].ToString(), format, CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTime))) //Check transaction date format
                                {

                                    if ((DT.Rows[c].ItemArray[26].ToString() != "")) //Check Currency
                                    {
                                        if ((((DT.Rows[c].ItemArray[11].ToString() == "OSR") || (DT.Rows[c].ItemArray[11].ToString() == "EMC") ||
                                                (DT.Rows[c].ItemArray[11].ToString() == "BOC") || (DT.Rows[c].ItemArray[11].ToString() == "OEA") ||
                                                (DT.Rows[c].ItemArray[11].ToString() == "OPF") || (DT.Rows[c].ItemArray[11].ToString() == "OEP"))
                                                && (DT.Rows[c].ItemArray[32].ToString() == "A") || (DT.Rows[c].ItemArray[32].ToString() == "F05") 
                                                || (DT.Rows[c].ItemArray[32].ToString() == "F01"))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "OCR") || (DT.Rows[c].ItemArray[11].ToString() == "EMC")
                                                || (DT.Rows[c].ItemArray[11].ToString() == "OER") || (DT.Rows[c].ItemArray[11].ToString() == "OEA")
                                                || (DT.Rows[c].ItemArray[11].ToString() == "OPF") || (DT.Rows[c].ItemArray[11].ToString() == "OEP"))
                                                && (DT.Rows[c].ItemArray[32].ToString() == "F"))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "EMC") || (DT.Rows[c].ItemArray[11].ToString() == "OCR")
                                                || (DT.Rows[c].ItemArray[11].ToString() == "OER") || (DT.Rows[c].ItemArray[11].ToString() == "OEA")
                                                || (DT.Rows[c].ItemArray[11].ToString() == "OPF") || (DT.Rows[c].ItemArray[11].ToString() == "OEP"))
                                                && (DT.Rows[c].ItemArray[32].ToString() == "F21") || (DT.Rows[c].ItemArray[32].ToString() == "F22")
                                                || (DT.Rows[c].ItemArray[32].ToString() == "F27") || (DT.Rows[c].ItemArray[32].ToString() == "F28"))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "OCR") || (DT.Rows[c].ItemArray[11].ToString() == "OER")
                                                || (DT.Rows[c].ItemArray[11].ToString() == "OEA") || (DT.Rows[c].ItemArray[11].ToString() == "OPF")
                                                || (DT.Rows[c].ItemArray[11].ToString() == "OEP"))
                                                && (DT.Rows[c].ItemArray[32].ToString() == "F23") || (DT.Rows[c].ItemArray[32].ToString() == "F24"))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "OOP") || (DT.Rows[c].ItemArray[11].ToString() == "BOC"))
                                                && (DT.Rows[c].ItemArray[32].ToString() == "M") || (DT.Rows[c].ItemArray[32].ToString() == "X"))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "BOC") || (DT.Rows[c].ItemArray[11].ToString() == "OER"))
                                                && ((DT.Rows[c].ItemArray[32].ToString() == "W") || (DT.Rows[c].ItemArray[32].ToString() == "O28")
                                                || (DT.Rows[c].ItemArray[32].ToString() == "029") || (DT.Rows[c].ItemArray[32].ToString() == "030")))
                                                ||
                                                ((DT.Rows[c].ItemArray[11].ToString() == "DCC"))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "DTC")) && (DT.Rows[c].ItemArray[32].ToString() == "DE"))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "OCG")) && (DT.Rows[c].ItemArray[32].ToString() == ""))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "OCD")) && (DT.Rows[c].ItemArray[6].ToString() == "CC"))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "OCD")) && (DT.Rows[c].ItemArray[6].ToString() == "DA")) // New Added
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "OSR")) && (DT.Rows[c].ItemArray[6].ToString() == "CC")) // New Added
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "OCI")) && (DT.Rows[c].ItemArray[6].ToString() == "CC")) // New Added
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "FPC")) && (DT.Rows[c].ItemArray[6].ToString() == "FP")) // New Added
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "ECR"))) // New Added
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "BOC")) && (DT.Rows[c].ItemArray[6].ToString() == "CC")) // New Added
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "OCI")) && (DT.Rows[c].ItemArray[32].ToString() == ""))
                                                ||
                                                (((DT.Rows[c].ItemArray[11].ToString() == "FPC") || (DT.Rows[c].ItemArray[11].ToString() == "FTC"))
                                                && ((DT.Rows[c].ItemArray[28].ToString() == "01") || (DT.Rows[c].ItemArray[28].ToString() == "04")
                                                || (DT.Rows[c].ItemArray[28].ToString() == "06") || (DT.Rows[c].ItemArray[28].ToString() == "05")
                                                || (DT.Rows[c].ItemArray[28].ToString() == "07") || (DT.Rows[c].ItemArray[28].ToString() == "08")
                                                || (DT.Rows[c].ItemArray[28].ToString() == "02") || (DT.Rows[c].ItemArray[28].ToString() == "03")
                                                || (DT.Rows[c].ItemArray[28].ToString() == "71") || (DT.Rows[c].ItemArray[28].ToString() == "31")))
                                                ||
                                                ((DT.Rows[c].ItemArray[11].ToString() == "VIR") || (DT.Rows[c].ItemArray[11].ToString() == "DDG"))
                                                || (DT.Rows[c].ItemArray[11].ToString() == "MAO"))//Check transaction Type
                                        {
                                            //Add Validated Record ID's
                                            SuccessRecordList[c] = Int16.Parse(DT.Rows[c].ItemArray[0].ToString());
                                            rtn_val = true;
                                        }
                                        else
                                        {
                                            rtn_val = false;
                                            MessageBox.Show("Unable to Identify Transaction Type :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                            break;
                                        }
                                    }
                                    else
                                    {
                                        rtn_val = false;
                                        MessageBox.Show("Couldn't be Null in Currency :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                        break;
                                    }
                                    //-------------------------------------
                                }
                                else
                                {
                                    rtn_val = false;
                                    MessageBox.Show("Invalid Format in Transaction Date :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                    break;

                                }

                            }
                            else
                            {
                                rtn_val = false;
                                MessageBox.Show("Couldn't be Null in Transaction Date :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                break;
                                
                            }
                        //}
                        //else
                        //{
                        //    rtn_val = false;
                        //    MessageBox.Show("Couldn't be Null in Amount :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                        //    break;
                        //}

                    }
                    else
                    {
                        rtn_val = false;
                        MessageBox.Show("Unable to Find Account Number In Raw :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                        break;
                    }

                    #endregion                  
                }

                if (DT.Rows.Count == c)
                {
                    DialogResult rslt = MessageBox.Show("LODH Record Validation Successfully Completed. \nDo you want to Continue ?", "Finish.", MessageBoxButtons.YesNo, MessageBoxIcon.Information);
                    if (rslt == DialogResult.Yes)
                    {
                        UpdateValidated_LODH_RecordSet(SuccessRecordList);
                        LoadValidatedRecordSetTo_Tmp_Validate_Table(SuccessRecordList);
                        rtn_val = true;
                        
                    }
                    else
                    {
                        rtn_val = false;
                    }
                }

                return rtn_val;
            }
            catch (Exception EX)
            {
                return false;
                MessageBox.Show(EX.Message, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                
            }
        }

        public DataTable Load_ValidatedTempDataToGrid(string SpName)
        {
            DataTable dtTest = new DataTable();
            DataSet dsTest = new DataSet();

            try
            {
                SqlConnection conn = new SqlConnection(strConnStringOpr);
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(SpName, conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter sdaTest = new SqlDataAdapter(cmd);
                    sdaTest.Fill(dsTest);
                    //dsTest.Tables[0];
                    conn.Close();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
            }

            return dsTest.Tables[0];
        }

        private bool UpdateValidated_LODH_RecordSet(int[] recordList)
        {            

            try
            {                
                for (int i = 0; i < recordList.Length; i++)
                {

                    SqlConnection cn = new SqlConnection(strConnStringOpr);
                    SqlCommand cmd = new SqlCommand();
                    
                    cmd.CommandText = "dbo.UpdateValidated_LODH_RecordSet";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = recordList[i];
                    cmd.Connection = cn;
                    cn.Open();
                    reader = cmd.ExecuteReader();
                    cn.Close();
                }

                if ((reader).RecordsAffected == 1)
                {

                    return true;
                }
                else
                {
                    return false;
                }
                
            }
            catch (Exception ex)
            {
                return false;
            }
           
        }

        private bool LoadValidatedRecordSetTo_Tmp_Validate_Table(int[] recordList)
        {
            try
            {
                for (int i = 0; i < recordList.Length; i++)
                {

                    SqlConnection cn = new SqlConnection(strConnStringOpr);
                    SqlCommand cmd = new SqlCommand();

                    cmd.CommandText = "dbo.Fill_Temp_Validated_LODH";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = recordList[i];
                    cmd.Connection = cn;
                    cn.Open();
                    reader = cmd.ExecuteReader();
                    cn.Close();
                }

                if ((reader).RecordsAffected == 1)
                {

                    return true;
                }
                else
                {
                    return false;
                }

            }
            catch (Exception ex)
            {
                return false;
            }
           
        }

        public bool CleanTempValidatedTable_LODH()
        {
            try
            {
                    SqlConnection cn = new SqlConnection(strConnStringOpr);
                    SqlCommand cmd = new SqlCommand();

                    cmd.CommandText = "dbo.CleanTempValidatedTable_LODH";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = cn;
                    cn.Open();
                    reader = cmd.ExecuteReader();
                    cn.Close();
                
                if ((reader).RecordsAffected == 1)
                {

                    return true;
                }
                else
                {
                    return false;
                }

            }    
            catch (Exception ex)
            {
                return false;
            }
           
        }

        public bool Import_ValidatedRecords_To_RAW_DATA_LODH(int ImportID)
        {
            try
            {
                    SqlConnection cn = new SqlConnection(strConnStringOpr);
                    SqlCommand cmd = new SqlCommand();

                    cmd.CommandText = "dbo.Import_ValidatedRecords_To_RAW_DATA_LODH";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = ImportID;
                    cmd.Connection = cn;
                    cn.Open();
                    reader = cmd.ExecuteReader();
                    cn.Close();
                
                if ((reader).RecordsAffected == 1)
                {

                    return true;
                }
                else
                {
                    return false;
                }
                
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool Check_BankAccInBankMap_BNP(string BankID)
        {
            DataTable dtTest = new DataTable();
            DataSet dsTest = new DataSet();
            bool rtn = false;

            try
            {
                SqlConnection conn = new SqlConnection(strConnStringOpr);
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("dbo.Check_Bank_Acc_BankMap_BNP", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@BANK_REF", SqlDbType.VarChar).Value = BankID.Substring(0,8);
                    SqlDataAdapter sdaTest = new SqlDataAdapter(cmd);
                    sdaTest.Fill(dsTest);
                    conn.Close();
                    if (dsTest.Tables[0].Rows.Count > 0)
                    {
                        rtn = true;
                    }
                    else
                    {
                        rtn = false;
                    }

                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                rtn = false;
            }

            return rtn; //dsTest.Tables[0];
        }

    }
}
