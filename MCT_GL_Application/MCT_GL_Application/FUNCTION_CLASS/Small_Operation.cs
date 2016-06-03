using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace MCT_GL_Application.FUNCTION_CLASS
{
    
    public class Small_Operation
    {
       public String strConnStringOpr = ConfigurationSettings.AppSettings["CommonConnection"].ToString();

       public DataTable LoadBankTypes()
        {
            DataTable dtTest = new DataTable();
            DataSet dsTest = new DataSet();

            try
            {
                SqlConnection con = new SqlConnection(strConnStringOpr);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("dbo.Get_Investment_Bank_List",con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter sdaTest = new SqlDataAdapter(cmd);
                    sdaTest.Fill(dsTest);
                    //dsTest.Tables[0];
                    con.Close();
                }
                                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None,MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000); 
            }

            return dsTest.Tables[0];
        }

       public DataTable LoadGridData(string SpName)
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

       public DataTable LoadPositionDetails(DateTime FromDate, DateTime ToDate)
        {
            DataTable dtTest = new DataTable();
            DataSet dsTest = new DataSet();

            try
            {
                SqlConnection con = new SqlConnection(strConnStringOpr);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("dbo.Get_PositionDetails", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    //scCommand.Parameters.Add("@Name", SqlDbType.VarChar, 50).Value = txtName.Text;
                    cmd.Parameters.Add("@FromDate", SqlDbType.Date).Value = FromDate;
                    cmd.Parameters.Add("@ToDate", SqlDbType.Date).Value = ToDate;
                    SqlDataAdapter sdaTest = new SqlDataAdapter(cmd);
                    sdaTest.Fill(dsTest);
                    //dsTest.Tables[0];
                    con.Close();
                }
                                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None,MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000); 
            }

            return dsTest.Tables[0];
        }

       public DataTable LoadRawGLRecords()
       {
           DataTable dtTest = new DataTable();
           DataSet dsTest = new DataSet();

           try
           {
               SqlConnection con = new SqlConnection(strConnStringOpr);
               if (con.State == ConnectionState.Closed)
               {
                   con.Open();
                   SqlCommand cmd = new SqlCommand("dbo.Get_RawGLRecords", con);
                   cmd.CommandType = CommandType.StoredProcedure;
                   SqlDataAdapter sdaTest = new SqlDataAdapter(cmd);
                   sdaTest.Fill(dsTest);
                   con.Close();
               }

           }
           catch (Exception ex)
           {
               MessageBox.Show(ex.Message.ToString(), "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, (MessageBoxOptions)0x40000);
           }

           return dsTest.Tables[0];
       }

       public DataTable GetGLTransaction(string RefID)
       {
           DataTable dtTest = new DataTable();
           DataSet dsTest = new DataSet();

           try
           {
               SqlConnection con = new SqlConnection(strConnStringOpr);
               if (con.State == ConnectionState.Closed)
               {
                   con.Open();
                   SqlCommand cmd = new SqlCommand("dbo.GetGLTransaction", con);
                   cmd.CommandType = CommandType.StoredProcedure;
                   cmd.Parameters.Add("@REF_ID", SqlDbType.NVarChar).Value = RefID;
                   SqlDataAdapter sdaTest = new SqlDataAdapter(cmd);
                   sdaTest.Fill(dsTest);
                   con.Close();
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
