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
    public class Validate_JB
    {
        public String strConnStringOpr = ConfigurationSettings.AppSettings["CommonConnection"].ToString();
        SqlDataReader reader;

        public bool Validate_JB_Records(DataTable DT)
        {
            DataTable JB_DBEW_Records;
            int[] SuccessRecordList = new int[DT.Rows.Count];
            int c,x;
            bool rtn_val = false;

            try
            {                

                #region inside JB For Loop
                for (c = 0; c < DT.Rows.Count; c++)
                {                  

                    decimal value;
                    string format1 = "yyyyMMdd", format2 = "yyyyMMdd";
                    DateTime dateTime;

                    #region DBEW 

                    if ((DT.Rows[c].ItemArray[3].ToString() != "DBEW"))
                    {
                        if ((DT.Rows[c].ItemArray[5].ToString() != "") && Check_BankAccInBankMap_BNP(DT.Rows[c].ItemArray[5].ToString()) == true) //Check Bank Account
                        {
                            
                                if ((DT.Rows[c].ItemArray[28].ToString() != "")) //Check transaction date
                                {
                                    if ((DateTime.TryParseExact(DT.Rows[c].ItemArray[28].ToString(), format1, CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTime))) //Check transaction date format
                                    {
                                        JB_DBEW_Records = Load_JB_DBEW_Records(DT.Rows[c].ItemArray[40].ToString());

                                        for (int y = 0; y < JB_DBEW_Records.Rows.Count; y++)
                                        {
                                            //=================================
                                            if ((JB_DBEW_Records.Rows[y].ItemArray[10].ToString() != "")) //Check Currency
                                            {
                                                if ((DT.Rows[c].ItemArray[21].ToString() != "") && (Decimal.TryParse(DT.Rows[c].ItemArray[21].ToString(), out value))
                                                    && (DT.Rows[c].ItemArray[25].ToString() != "") && (Decimal.TryParse(DT.Rows[c].ItemArray[25].ToString(), out value))) //Check transaction amount
                                                {
                                                    if (((JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "PB") || (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "PF") ||
                                                            (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "TK") || (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "NF") ||
                                                            (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "SB") || (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "EB") ||
                                                            (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "EA") || (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "ED") ||
                                                            (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "EF") || (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "IF") ||
                                                            (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "IC") || (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "ME") ||
                                                            (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "AH") || (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "MN") ||
                                                            (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "MT") || (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "CI") ||
                                                            (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "CG") || (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "AC") ||
                                                            (JB_DBEW_Records.Rows[y].ItemArray[18].ToString() == "MP")))//Check transaction Type
                                                    {
                                                        //Add Validated Record ID's
                                                        //SuccessRecordList[c] = Int16.Parse(DT.Rows[c].ItemArray[0].ToString());
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
                                                    MessageBox.Show("Couldn't be Null Quantity And Price :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                                    break;
                                                }
                                            }
                                            else
                                            {
                                                rtn_val = false;
                                                MessageBox.Show("Couldn't be Null in Currency :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                                break;
                                            }
                                            //=================================
                                        }
                                    }
                                    else
                                    {
                                        rtn_val = false;
                                        MessageBox.Show("Invalid Format in Transaction Date :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                        break;

                                    }
                                    //=============

                                }
                                else
                                {
                                    rtn_val = false;
                                    MessageBox.Show("Couldn't be Null in Transaction Date :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                    break;

                                }
                                //=============

                        }
                        else
                        {
                            rtn_val = false;
                            MessageBox.Show("Unable to Find Account Number In Raw :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                            break;
                        }
                    }
                    #endregion
                    #region KBEW

                    if ((DT.Rows[c].ItemArray[3].ToString() != "KBEW"))
                    {
                        if ((DT.Rows[c].ItemArray[5].ToString() != "") && Check_BankAccInBankMap_BNP(DT.Rows[c].ItemArray[5].ToString()) == true) //Check Bank Account
                        {
                            if ((DT.Rows[c].ItemArray[21].ToString() != "") && (Decimal.TryParse(DT.Rows[c].ItemArray[21].ToString(), out value))) //Check transaction amount
                            {
                                if ((DT.Rows[c].ItemArray[29].ToString() != "")) //Check transaction date
                                {
                                    if ((DateTime.TryParseExact(DT.Rows[c].ItemArray[28].ToString(), format2, CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTime))) //Check transaction date format
                                    {
                                        if ((DT.Rows[c].ItemArray[10].ToString() != "")) //Check Currency
                                            {
                                                if (((DT.Rows[c].ItemArray[18].ToString() == "PB") || (DT.Rows[c].ItemArray[18].ToString() == "PF") ||
                                                    (DT.Rows[c].ItemArray[18].ToString() == "TK") || (DT.Rows[c].ItemArray[18].ToString() == "NF") ||
                                                    (DT.Rows[c].ItemArray[18].ToString() == "SB") || (DT.Rows[c].ItemArray[18].ToString() == "EB") ||
                                                    (DT.Rows[c].ItemArray[18].ToString() == "EA") || (DT.Rows[c].ItemArray[18].ToString() == "ED") ||
                                                    (DT.Rows[c].ItemArray[18].ToString() == "EF") || (DT.Rows[c].ItemArray[18].ToString() == "IF") ||
                                                    (DT.Rows[c].ItemArray[18].ToString() == "IC") || (DT.Rows[c].ItemArray[18].ToString() == "ME") ||
                                                    (DT.Rows[c].ItemArray[18].ToString() == "AH") || (DT.Rows[c].ItemArray[18].ToString() == "MN") ||
                                                    (DT.Rows[c].ItemArray[18].ToString() == "MT") || (DT.Rows[c].ItemArray[18].ToString() == "CI") ||
                                                    (DT.Rows[c].ItemArray[18].ToString() == "CG") || (DT.Rows[c].ItemArray[18].ToString() == "AC") ||
                                                    (DT.Rows[c].ItemArray[18].ToString() == "MP") || (DT.Rows[c].ItemArray[18].ToString() == "  ")))//Check transaction Type
                                                {
                                                    //Add Validated Record ID's
                                                    //SuccessRecordList[c] = Int16.Parse(DT.Rows[c].ItemArray[0].ToString());
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
                            }
                            else
                            {
                                rtn_val = false;
                                MessageBox.Show("Couldn't be Null Transaction Amount :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                                break;
                            }

                        }
                        else
                        {
                            rtn_val = false;
                            MessageBox.Show("Unable to Find Account Number In Raw :" + DT.Rows[c].ItemArray[0].ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
                            break;
                        }
                    }

                    #endregion
                    SuccessRecordList[c] = Int16.Parse(DT.Rows[c].ItemArray[0].ToString());
                }

                #endregion

                
                if (DT.Rows.Count == c)
                {
                    DialogResult rslt = MessageBox.Show("JB Record Validation Successfully Completed. \nDo you want to Continue ?", "Finish.", MessageBoxButtons.YesNo, MessageBoxIcon.Information);
                    if (rslt == DialogResult.Yes)
                    {       
                        UpdateValidated_JB_RecordSet(SuccessRecordList);
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

        private bool UpdateValidated_JB_RecordSet(int[] recordList)
        {            

            try
            {                
                for (int i = 0; i < recordList.Length; i++)
                {

                    SqlConnection cn = new SqlConnection(strConnStringOpr);
                    SqlCommand cmd = new SqlCommand();

                    cmd.CommandText = "dbo.UpdateValidated_JB_RecordSet";
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

                    cmd.CommandText = "dbo.Fill_Temp_Validated_JB";
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

        public bool CleanTempValidatedTable_JB()
        {
            try
            {
                    SqlConnection cn = new SqlConnection(strConnStringOpr);
                    SqlCommand cmd = new SqlCommand();

                    cmd.CommandText = "dbo.CleanTempValidatedTable_JB";
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

        public bool Import_ValidatedRecords_To_RAW_DATA_JB(int ImportID)
        {
            try
            {
                    SqlConnection cn = new SqlConnection(strConnStringOpr);
                    SqlCommand cmd = new SqlCommand();

                    cmd.CommandText = "dbo.Import_ValidatedRecords_To_RAW_DATA_JB";
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
                    cmd.Parameters.Add("@BANK_REF", SqlDbType.VarChar).Value = BankID;
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

        public DataTable Load_JB_DBEW_Records(string LinkID)
        {
            DataTable dtTest = new DataTable();
            DataSet dsTest = new DataSet();

            try
            {
                SqlConnection conn = new SqlConnection(strConnStringOpr);
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("dbo.Get_JB_DBEW_Records", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@linkID", SqlDbType.VarChar).Value = LinkID;
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
    }
}
