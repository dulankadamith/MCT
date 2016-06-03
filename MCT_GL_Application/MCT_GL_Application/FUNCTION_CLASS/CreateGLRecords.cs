using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using System.Configuration;

namespace MCT_GL_Application.FUNCTION_CLASS
{
    public class CreateGLRecords
    {
        public String strConnStringOpr = ConfigurationSettings.AppSettings["CommonConnection"].ToString();
        

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE()
        {
            int reader1;
            try
            {
                    SqlConnection cn = new SqlConnection(strConnStringOpr);
                    SqlCommand cmd = new SqlCommand();

                    cmd.CommandText = "dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = cn;
                    cn.Open();
                    reader1 = cmd.ExecuteNonQuery();
                    cn.Close();
               
                if (reader1 > 1)
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

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE_COUPON()
        {
            int reader2;
            try
            {
                SqlConnection cn = new SqlConnection(strConnStringOpr);
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE_COUPON";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = cn;
                cn.Open();
                reader2 = cmd.ExecuteNonQuery();
                cn.Close();

                if (reader2 > 1)
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

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE_FOREX()
        {
            int reader3;
            try
            {
                SqlConnection cn = new SqlConnection(strConnStringOpr);
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE_FOREX";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = cn;
                cn.Open();
                reader3 = cmd.ExecuteNonQuery();
                cn.Close();

                if (reader3 > 1)
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

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE_MP()
        {
            int reader4;
            try
            {
                SqlConnection cn = new SqlConnection(strConnStringOpr);
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE_MP";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = cn;
                cn.Open();
                reader4 = cmd.ExecuteNonQuery();
                cn.Close();

                if (reader4 > 1)
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

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE_FORWARD()
        {
            int reader5;
            try
            {
                SqlConnection cn = new SqlConnection(strConnStringOpr);
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE_FORWARD";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = cn;
                cn.Open();
                reader5 = cmd.ExecuteNonQuery();
                cn.Close();

                if (reader5 > 1)
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

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH()
        {
            int reader6;
            try
            {
                SqlConnection cn = new SqlConnection(strConnStringOpr);
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = cn;
                cn.Open();
                reader6 = cmd.ExecuteNonQuery();
                cn.Close();

                if (reader6 > 1)
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

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FOREX()
        {
            int reader7;
            try
            {
                SqlConnection cn = new SqlConnection(strConnStringOpr);
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FOREX";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = cn;
                cn.Open();
                reader7 = cmd.ExecuteNonQuery();
                cn.Close();

                if (reader7 > 1)
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

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FTC_FPC()
        {
            int reader8;
            try
            {
                SqlConnection cn = new SqlConnection(strConnStringOpr);
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FTC_FPC";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = cn;
                cn.Open();
                reader8 = cmd.ExecuteNonQuery();
                cn.Close();

                if (reader8 > 1)
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

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_DCC_DTC()
        {
            int reader9;
            try
            {
                SqlConnection cn = new SqlConnection(strConnStringOpr);
                SqlCommand cmd = new SqlCommand();

                cmd.CommandText = "dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_DCC_DTC";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = cn;
                cn.Open();
                reader9 = cmd.ExecuteNonQuery();
                cn.Close();

                if (reader9 > 1)
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

        public bool GENERATE_GL_RECORDS_FROM_TEXT_FILE_BNP()
        {
            int reader10;
            try
            {
                SqlConnection cn = new SqlConnection(strConnStringOpr);
                SqlCommand cmd = new SqlCommand("dbo.GENERATE_GL_RECORDS_FROM_TEXT_FILE_BNP",cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                reader10 = cmd.ExecuteNonQuery();
                cn.Close();

                if (reader10 > 0)
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
    }
}
