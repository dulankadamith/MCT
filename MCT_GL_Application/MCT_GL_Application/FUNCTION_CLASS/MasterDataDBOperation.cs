using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Windows.Forms;

namespace MCT_GL_Application.FUNCTION_CLASS
{
    public class MasterDataDBOperation
    {
        public string conString = ConfigurationSettings.AppSettings["CommonConnection"].ToString();

        public int AddBankMap(string BankRefCode,string currency,string bankCode,string bankAccount,string IdentificationCode)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "dbo.Add_Bank_Map_Record";
            cmd.Parameters.Add("@BANK_REFERANCE", SqlDbType.NVarChar).Value = BankRefCode;
            cmd.Parameters.Add("@CURRENCY", SqlDbType.NVarChar).Value = currency;
            cmd.Parameters.Add("@BANK_CODE", SqlDbType.NVarChar).Value = bankCode;
            cmd.Parameters.Add("@BANK_ACCOUNT", SqlDbType.NVarChar).Value = bankAccount;
            cmd.Parameters.Add("@IDENTIFICATION_CODE", SqlDbType.NVarChar).Value = IdentificationCode;

            cmd.Connection = con;

            try
            {
                con.Open();
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }

            finally
            {
                con.Close();
                con.Dispose();
            }


            return result;
        }

        public int AddFEEMap(string BankRefCode, string fee, string description, string referanceId)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(conString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "dbo.Add_FEE_Map_Record";
            cmd.Parameters.Add("@BANK_CODE", SqlDbType.NVarChar).Value = BankRefCode;
            cmd.Parameters.Add("@FEE", SqlDbType.NVarChar).Value = fee;
            cmd.Parameters.Add("@DESCRIPTION", SqlDbType.NVarChar).Value = description;
            cmd.Parameters.Add("@REFERANCE_ID", SqlDbType.NVarChar).Value = referanceId;

            cmd.Connection = con;

            try
            {
                con.Open();
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }

            finally
            {
                con.Close();
                con.Dispose();
            }


            return result;
        }

        public DataTable BindGrid(string SQL)
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand(SQL, con))
                {
                    cmd.CommandType = CommandType.Text;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;
                            
                        }
                    }
                }
            }
        }

        public DataTable LoadBankList()
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Get_BankAccountList", con))
                {
                    cmd.CommandType = CommandType.Text;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;

                        }
                    }
                }
            }
        }

        public DataTable LoadCurrencyList()
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Get_CurrencyList", con))
                {
                    cmd.CommandType = CommandType.Text;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;

                        }
                    }
                }
            }
        }

        public DataTable LoadBankCodeList()
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Get_BankCodeList", con))
                {
                    cmd.CommandType = CommandType.Text;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;

                        }
                    }
                }
            }
        }

        public DataTable LoadFEECodeList()
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Get_FEEList", con))
                {
                    cmd.CommandType = CommandType.Text;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;

                        }
                    }
                }
            }
        }

    }
}
