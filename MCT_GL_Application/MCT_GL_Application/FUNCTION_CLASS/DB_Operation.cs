using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.IO;
using System.Data.SqlClient;
using System.Data;

namespace MCT_GL_Application.FUNCTION_CLASS
{
    public class DB_Operation
    {

        String strConnString = ConfigurationSettings.AppSettings["CommonConnection"].ToString();
        public String CopyPath = ConfigurationSettings.AppSettings["CopyPath"].ToString();
        public String MovePath = ConfigurationSettings.AppSettings["MovePath"].ToString();


        string[] fileArray;
        bool rtnLodhVal;

        #region Common Methods

        public void PipeLine()
        {

           

            //DownFiles();

            // Move file from ftp location to server
            //ArrangeFileList(FtpPath);
            //ReadFileContaint(CopyPath);

            //ArrangeFileList_LODH(FtpPath);
            //ReadFileContaint_LODH(CopyPath);

            //ArrangeFileList_BNP(FtpPath);
            //ReadFileContaint_BNP(CopyPath);

            //==============================================================

            //MarketPrice_ArrangeFileList(FtpPath);
            //MarketPrice_ReadFileContaint(CopyPath);

            //MarketPrice_ArrangeFileList_LODH(FtpPath);
            //MarketPrice_ReadFileContaint_LODH(CopyPath);

            //MarketPrice_ArrangeFileList_BNP(FtpPath);
            //MarketPrice_ReadFileContaint_BNP(CopyPath);
        }

        private void Move(string CurrentLocation, string MoveLocation, string MoveFileName)
        {
            try
            {
                File.Move(CurrentLocation, MoveLocation + MoveFileName);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        private void MarketPrice_InsertRawData(string Bank, string Currency, string Referance, string QTY, string ClosingRate, string TOTAL, string RateDate, string MTD_Date)
        {

            Console.WriteLine("=============================================");
            Console.WriteLine("Bank :" + Bank + ",");
            Console.WriteLine("Currency :" + Currency + ",");
            Console.WriteLine("Referance :" + Referance + ",");
            Console.WriteLine("QTY :" + QTY.ToString() + ",");
            Console.WriteLine("ClosingRate :" + ClosingRate.ToString() + ",");
            Console.WriteLine("TOTAL :" + TOTAL.ToString());
            Console.WriteLine("TOTAL :" + RateDate.ToString());
            Console.WriteLine("Maturity Date :" + MTD_Date.ToString());
            Console.WriteLine("=============================================");

            string QTY_TMP, ClosingRate_TMP, TOTAL_TMP, MT_Date;

           
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();


            if (QTY == "NULL")
            {
                QTY_TMP = "0";
            }
            else
            {
                QTY_TMP = QTY;
            }
            if (ClosingRate == "NULL")
            {
                ClosingRate_TMP = "0";
            }
            else
            {
                ClosingRate_TMP = ClosingRate;
            }
            if (TOTAL == "NULL")
            {
                TOTAL_TMP = "0";
            }
            else
            {
                TOTAL_TMP = TOTAL;
            }
            if (MTD_Date == "")
            {
                MT_Date = "";
            }
            else
            {
                MT_Date = MTD_Date;
            }


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "dbo.Fill_Market_Price_Data";
            cmd.Parameters.Add("@BankCode", SqlDbType.VarChar).Value = Bank;
            cmd.Parameters.Add("@Currency", SqlDbType.VarChar).Value = Currency;
            cmd.Parameters.Add("@Referance", SqlDbType.VarChar).Value = Referance;
            cmd.Parameters.Add("@Quantity", SqlDbType.Decimal).Value = System.Convert.ToDecimal(QTY_TMP);
            cmd.Parameters.Add("@ClosingValue", SqlDbType.Decimal).Value = System.Convert.ToDecimal(ClosingRate_TMP);
            cmd.Parameters.Add("@TotalValue", SqlDbType.Decimal).Value = System.Convert.ToDecimal(TOTAL_TMP);
            cmd.Parameters.Add("@Date", SqlDbType.VarChar).Value = RateDate;
            cmd.Parameters.Add("@MT_Date", SqlDbType.VarChar).Value = MT_Date;

            cmd.Connection = con;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
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


        }

        #endregion

        #region JB GL Records

        public bool ArrangeFileList(string ftpPath)
        {
            try
            {
                string fileName = string.Empty;
                //string[] fileArray = Directory.GetFiles(ftpPath, "B*.stp", SearchOption.AllDirectories);

                //for (int i = 0; fileArray.Length > i; i++)
                //{
                fileName = ftpPath.Split('\\').Last();
                Move(ftpPath, CopyPath, fileName);
                return true;
                //}
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return false;
            }

        }

        public bool ReadFileContaint(string fileLocation)
        {
            try
            {
                int counter = 0;
                string line;
                string[] RArray;

                string fName = string.Empty;
                string[] fArray = Directory.GetFiles(fileLocation, "B*.stp", SearchOption.AllDirectories);

                for (int i = 0; fArray.Length > i; i++)
                {
                    fName = fArray[i].Split('\\').Last();

                    System.IO.StreamReader file = new System.IO.StreamReader(fileLocation + fName, true);
                    while ((line = file.ReadLine()) != null)
                    {
                        RArray = line.Split(';');
                        InsertRawData(fName, RArray[0], RArray[1], RArray[2], RArray[3], RArray[4], RArray[5], RArray[6], RArray[7], RArray[8], RArray[9], RArray[10], RArray[11], RArray[12], RArray[13], RArray[14],
                                        RArray[15], RArray[16], RArray[17], RArray[18], RArray[19], RArray[20], RArray[21], RArray[22], RArray[23], RArray[24], RArray[25], RArray[26], RArray[27], RArray[28], RArray[29], RArray[30],
                                        RArray[31], RArray[32], RArray[33], RArray[34], RArray[35], RArray[36], RArray[37], RArray[38], RArray[39], RArray[40], RArray[41], RArray[42], RArray[43], RArray[44], RArray[45], RArray[46],
                                        RArray[47], RArray[48], RArray[49], RArray[50], RArray[51], RArray[52], RArray[53], RArray[54], RArray[55], RArray[56], RArray[57], RArray[58], RArray[59], RArray[60], RArray[61], RArray[62],
                                        RArray[63], RArray[64], RArray[65], RArray[66], RArray[67], RArray[68], RArray[69], RArray[70], RArray[71], RArray[72], RArray[73], RArray[74], RArray[75], RArray[76], RArray[77], RArray[78],
                                        RArray[79], RArray[80], RArray[81], RArray[82], RArray[83], RArray[84], RArray[85], RArray[86], RArray[87], RArray[88], RArray[89], RArray[90], RArray[91], RArray[92], RArray[93], RArray[94],
                                        RArray[95], RArray[96], RArray[97], RArray[98], RArray[99], RArray[100], RArray[101], RArray[102], RArray[103], RArray[104], RArray[105], RArray[106]);
                        counter++;
                    }

                    file.Close();
                    Move(fileLocation + fName, MovePath, DateTime.Now.ToString("yyyyMMddHHmm") + "_" + fName);
                }

                //System.Console.ReadLine();
                return true;

            }
            catch (Exception ex)
            {
                return false;
            }

        }

        private void InsertRawData(string FileName, string A, string B, string C, string D, string E, string F, string G, string H, string I, string J, string K, string L, string M,
                            string N, string O, string P, string Q, string R, string S, string T, string U, string V, string W, string X, string Y, string Z,
                            string AA, string AB, string AC, string AD, string AE, string AF, string AG, string AH, string AI, string AJ, string AK, string AL, string AM,
                            string AN, string AO, string AP, string AQ, string AR, string SS, string AT, string AU, string AV, string AW, string AX, string AY, string AZ,
                            string BA, string BB, string BC, string BD, string BE, string BF, string BG, string BH, string BI, string BJ, string BK, string BL, string BM,
                            string BN, string BO, string BP, string BQ, string BR, string BS, string BT, string BU, string BV, string BW, string BX, string BY, string BZ,
                            string CA, string CB, string CC, string CD, string CE, string CF, string CG, string CH, string CI, string CJ, string CK, string CL, string CM,
                            string CN, string CO, string CP, string CQ, string CR, string CS, string CT, string CU, string CV, string CW, string CX, string CY, string CZ, string DA, string DB, string DC)
        {

            String strConnString = ConfigurationSettings.AppSettings["CommonConnection"].ToString();

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "dbo.Fill_Raw_Data";
            cmd.Parameters.Add("@FileName", SqlDbType.NVarChar).Value = FileName;
            cmd.Parameters.Add("@A", SqlDbType.NVarChar).Value = A;
            cmd.Parameters.Add("@B", SqlDbType.NVarChar).Value = B;
            cmd.Parameters.Add("@C", SqlDbType.NVarChar).Value = C;
            cmd.Parameters.Add("@D", SqlDbType.NVarChar).Value = D;
            cmd.Parameters.Add("@E", SqlDbType.NVarChar).Value = E;
            cmd.Parameters.Add("@F", SqlDbType.NVarChar).Value = F;
            cmd.Parameters.Add("@G", SqlDbType.NVarChar).Value = G;
            cmd.Parameters.Add("@H", SqlDbType.NVarChar).Value = H;
            cmd.Parameters.Add("@I", SqlDbType.NVarChar).Value = I;
            cmd.Parameters.Add("@J", SqlDbType.NVarChar).Value = J;
            cmd.Parameters.Add("@K", SqlDbType.NVarChar).Value = K;
            cmd.Parameters.Add("@L", SqlDbType.NVarChar).Value = L;
            cmd.Parameters.Add("@M", SqlDbType.NVarChar).Value = M;
            cmd.Parameters.Add("@N", SqlDbType.NVarChar).Value = N;
            cmd.Parameters.Add("@O", SqlDbType.NVarChar).Value = O;
            cmd.Parameters.Add("@P", SqlDbType.NVarChar).Value = P;
            cmd.Parameters.Add("@Q", SqlDbType.NVarChar).Value = Q;
            cmd.Parameters.Add("@R", SqlDbType.NVarChar).Value = R;
            cmd.Parameters.Add("@S", SqlDbType.NVarChar).Value = S;
            cmd.Parameters.Add("@T", SqlDbType.NVarChar).Value = T;
            cmd.Parameters.Add("@U", SqlDbType.NVarChar).Value = U;
            cmd.Parameters.Add("@V", SqlDbType.NVarChar).Value = V;
            cmd.Parameters.Add("@W", SqlDbType.NVarChar).Value = W;
            cmd.Parameters.Add("@X", SqlDbType.NVarChar).Value = X;
            cmd.Parameters.Add("@Y", SqlDbType.NVarChar).Value = Y;
            cmd.Parameters.Add("@Z", SqlDbType.NVarChar).Value = Z;
            cmd.Parameters.Add("@AA", SqlDbType.NVarChar).Value = AA;
            cmd.Parameters.Add("@AB", SqlDbType.NVarChar).Value = AB;
            cmd.Parameters.Add("@AC", SqlDbType.NVarChar).Value = AC;
            cmd.Parameters.Add("@AD", SqlDbType.NVarChar).Value = AD;
            cmd.Parameters.Add("@AE", SqlDbType.NVarChar).Value = AE;
            cmd.Parameters.Add("@AF", SqlDbType.NVarChar).Value = AF;
            cmd.Parameters.Add("@AG", SqlDbType.NVarChar).Value = AG;
            cmd.Parameters.Add("@AH", SqlDbType.NVarChar).Value = AH;
            cmd.Parameters.Add("@AI", SqlDbType.NVarChar).Value = AI;
            cmd.Parameters.Add("@AJ", SqlDbType.NVarChar).Value = AJ;
            cmd.Parameters.Add("@AK", SqlDbType.NVarChar).Value = AK;
            cmd.Parameters.Add("@AL", SqlDbType.NVarChar).Value = AL;
            cmd.Parameters.Add("@AM", SqlDbType.NVarChar).Value = AM;
            cmd.Parameters.Add("@AN", SqlDbType.NVarChar).Value = AN;
            cmd.Parameters.Add("@AO", SqlDbType.NVarChar).Value = AO;
            cmd.Parameters.Add("@AP", SqlDbType.NVarChar).Value = AP;
            cmd.Parameters.Add("@AQ", SqlDbType.NVarChar).Value = AQ;
            cmd.Parameters.Add("@AR", SqlDbType.NVarChar).Value = AR;
            cmd.Parameters.Add("@AS", SqlDbType.NVarChar).Value = SS;
            cmd.Parameters.Add("@AT", SqlDbType.NVarChar).Value = AT;
            cmd.Parameters.Add("@AU", SqlDbType.NVarChar).Value = AU;
            cmd.Parameters.Add("@AV", SqlDbType.NVarChar).Value = AV;
            cmd.Parameters.Add("@AW", SqlDbType.NVarChar).Value = AW;
            cmd.Parameters.Add("@AX", SqlDbType.NVarChar).Value = AX;
            cmd.Parameters.Add("@AY", SqlDbType.NVarChar).Value = AY;
            cmd.Parameters.Add("@AZ", SqlDbType.NVarChar).Value = AZ;
            cmd.Parameters.Add("@BA", SqlDbType.NVarChar).Value = BA;
            cmd.Parameters.Add("@BB", SqlDbType.NVarChar).Value = BB;
            cmd.Parameters.Add("@BC", SqlDbType.NVarChar).Value = BC;
            cmd.Parameters.Add("@BD", SqlDbType.NVarChar).Value = BD;
            cmd.Parameters.Add("@BE", SqlDbType.NVarChar).Value = BE;
            cmd.Parameters.Add("@BF", SqlDbType.NVarChar).Value = BF;
            cmd.Parameters.Add("@BG", SqlDbType.NVarChar).Value = BG;
            cmd.Parameters.Add("@BH", SqlDbType.NVarChar).Value = BH;
            cmd.Parameters.Add("@BI", SqlDbType.NVarChar).Value = BI;
            cmd.Parameters.Add("@BJ", SqlDbType.NVarChar).Value = BJ;
            cmd.Parameters.Add("@BK", SqlDbType.NVarChar).Value = BK;
            cmd.Parameters.Add("@BL", SqlDbType.NVarChar).Value = BL;
            cmd.Parameters.Add("@BM", SqlDbType.NVarChar).Value = BM;
            cmd.Parameters.Add("@BN", SqlDbType.NVarChar).Value = BN;
            cmd.Parameters.Add("@BO", SqlDbType.NVarChar).Value = BO;
            cmd.Parameters.Add("@BP", SqlDbType.NVarChar).Value = BP;
            cmd.Parameters.Add("@BQ", SqlDbType.NVarChar).Value = BQ;
            cmd.Parameters.Add("@BR", SqlDbType.NVarChar).Value = BR;
            cmd.Parameters.Add("@BS", SqlDbType.NVarChar).Value = BS;
            cmd.Parameters.Add("@BT", SqlDbType.NVarChar).Value = BT;
            cmd.Parameters.Add("@BU", SqlDbType.NVarChar).Value = BU;
            cmd.Parameters.Add("@BV", SqlDbType.NVarChar).Value = BV;
            cmd.Parameters.Add("@BW", SqlDbType.NVarChar).Value = BW;
            cmd.Parameters.Add("@BX", SqlDbType.NVarChar).Value = BX;
            cmd.Parameters.Add("@BY", SqlDbType.NVarChar).Value = BY;
            cmd.Parameters.Add("@BZ", SqlDbType.NVarChar).Value = BZ;
            cmd.Parameters.Add("@CA", SqlDbType.NVarChar).Value = CA;
            cmd.Parameters.Add("@CB", SqlDbType.NVarChar).Value = CB;
            cmd.Parameters.Add("@CC", SqlDbType.NVarChar).Value = CC;
            cmd.Parameters.Add("@CD", SqlDbType.NVarChar).Value = CD;
            cmd.Parameters.Add("@CE", SqlDbType.NVarChar).Value = CE;
            cmd.Parameters.Add("@CF", SqlDbType.NVarChar).Value = CF;
            cmd.Parameters.Add("@CG", SqlDbType.NVarChar).Value = CG;
            cmd.Parameters.Add("@CH", SqlDbType.NVarChar).Value = CH;
            cmd.Parameters.Add("@CI", SqlDbType.NVarChar).Value = CI;
            cmd.Parameters.Add("@CJ", SqlDbType.NVarChar).Value = CJ;
            cmd.Parameters.Add("@CK", SqlDbType.NVarChar).Value = CK;
            cmd.Parameters.Add("@CL", SqlDbType.NVarChar).Value = CL;
            cmd.Parameters.Add("@CM", SqlDbType.NVarChar).Value = CM;
            cmd.Parameters.Add("@CN", SqlDbType.NVarChar).Value = CN;
            cmd.Parameters.Add("@CO", SqlDbType.NVarChar).Value = CO;
            cmd.Parameters.Add("@CP", SqlDbType.NVarChar).Value = CP;
            cmd.Parameters.Add("@CQ", SqlDbType.NVarChar).Value = CQ;
            cmd.Parameters.Add("@CR", SqlDbType.NVarChar).Value = CR;
            cmd.Parameters.Add("@CS", SqlDbType.NVarChar).Value = CS;
            cmd.Parameters.Add("@CT", SqlDbType.NVarChar).Value = CT;
            cmd.Parameters.Add("@CU", SqlDbType.NVarChar).Value = CU;
            cmd.Parameters.Add("@CV", SqlDbType.NVarChar).Value = CV;
            cmd.Parameters.Add("@CW", SqlDbType.NVarChar).Value = CX;
            cmd.Parameters.Add("@CX", SqlDbType.NVarChar).Value = CX;
            cmd.Parameters.Add("@CY", SqlDbType.NVarChar).Value = CY;
            cmd.Parameters.Add("@CZ", SqlDbType.NVarChar).Value = CZ;
            cmd.Parameters.Add("@DA", SqlDbType.NVarChar).Value = DA;
            cmd.Parameters.Add("@DB", SqlDbType.NVarChar).Value = DB;
            cmd.Parameters.Add("@DC", SqlDbType.NVarChar).Value = DC;

            cmd.Connection = con;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
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

        }
        #endregion
        #region JB Market Price

        public bool MarketPrice_ArrangeFileList(string ftpPath)
        {
            try
            {
                string fileName = string.Empty;
                //string[] fileArray = Directory.GetFiles(ftpPath, "PO*.stp", SearchOption.AllDirectories);

                //for (int i = 0; fileArray.Length > i; i++)
                //{
                fileName = ftpPath.Split('\\').Last();
                Move(ftpPath, CopyPath, fileName);
                return true;
                //}
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return false;
            }

        }

        public bool MarketPrice_ReadFileContaint(string fileLocation)
        {
            
            try
            {
                int counter = 0;
                string line;
                string[] RArray;
                

                string fName = string.Empty;
                string[] fArray = Directory.GetFiles(fileLocation, "PO*.stp", SearchOption.AllDirectories);

                for (int i = 0; fArray.Length > i; i++)
                {
                    fName = fArray[i].Split('\\').Last();

                    System.IO.StreamReader file = new System.IO.StreamReader(fileLocation + fName, true);
                    while ((line = file.ReadLine()) != null)
                    {
                        RArray = line.Split('	');
                        //System.Console.WriteLine(RArray[counter].ToString());
                        MarketPrice_InsertRawData(RArray[1].ToString(), RArray[3].ToString(), RArray[8].ToString(), RArray[75].ToString(), RArray[76].ToString(), RArray[92].ToString(), RArray[4].ToString(), "");
                        counter++;
                    }

                    file.Close();
                    Move(fileLocation + fName, MovePath, DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + fName);
                    rtnLodhVal = true;
                }


                //System.Console.ReadLine();
                return rtnLodhVal;

            }
            catch (Exception ex)
            {
                return false;
            }

        }

        #endregion

        #region LODH Bank

        public bool ArrangeFileList_LODH(string ftpPath)
        {
            try
            {
                string fileName = string.Empty;
                //string[] fileArray = Directory.GetFiles(ftpPath, "30102_*_LOC.TXT", SearchOption.AllDirectories);

                //for (int i = 0; fileArray.Length > i; i++)
                //{
                fileName = ftpPath.Split('\\').Last();
                Move(ftpPath, CopyPath, fileName);
                return true;
                //}
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return false;
            }

        }

        public bool ReadFileContaint_LODH(string fileLocation)
        {
            try
            {
                int counter = 0;
                string line;
                string[] RArray;

                String strConnStringssss = ConfigurationSettings.AppSettings["ConStr"].ToString();
                string[] ConStrArray = strConnStringssss.Split(new char[] { ',' });

                string fName = string.Empty;
                string[] fArray = Directory.GetFiles(fileLocation, "30102_*_LOC.TXT", SearchOption.AllDirectories);
                int num;

                for (int i = 0; fArray.Length > i; i++)
                {
                    fName = fArray[i].Split('\\').Last();

                    System.IO.StreamReader file = new System.IO.StreamReader(fileLocation + fName, true);
                    while ((line = file.ReadLine()) != null)
                    {
                        RArray = line.Split('\t');
                        if (Int32.TryParse(RArray[0].Substring(0, 1), out num))
                        {

                            for (int x = 0; ConStrArray.Length > x; x++)
                            {

                                //Console.WriteLine(RArray[0].ToString() + "," + RArray[1].ToString() + "," + RArray[2].ToString() + "," + RArray[3].ToString() + "," + RArray[4].ToString() + "," + RArray[5].ToString());
                                InsertRawData_LODH(fName, RArray[0], RArray[1], RArray[2], RArray[3], RArray[4], RArray[5], RArray[6], RArray[7], RArray[8], RArray[9], RArray[10], RArray[11], RArray[12], RArray[13], RArray[14],
                                                RArray[15], RArray[16], RArray[17], RArray[18], RArray[19], RArray[20], RArray[21], RArray[22], RArray[23], RArray[24], RArray[25], RArray[26], RArray[27], RArray[28], RArray[29]
                                                , 30 < RArray.Length ? RArray[30] : "NULL"
                                                , 31 < RArray.Length ? RArray[31] : "NULL"
                                                , 32 < RArray.Length ? RArray[32] : "NULL"
                                                , 33 < RArray.Length ? RArray[33] : "NULL"
                                                , 34 < RArray.Length ? RArray[34] : "NULL"
                                                , 35 < RArray.Length ? RArray[35] : "NULL"
                                                , 36 < RArray.Length ? RArray[36] : "NULL"
                                                , 37 < RArray.Length ? RArray[37] : "NULL"
                                                , 38 < RArray.Length ? RArray[38] : "NULL"
                                                , 39 < RArray.Length ? RArray[39] : "NULL"
                                                , 40 < RArray.Length ? RArray[40] : "NULL"
                                                , 41 < RArray.Length ? RArray[41] : "NULL"
                                                , 42 < RArray.Length ? RArray[42] : "NULL"
                                                , 43 < RArray.Length ? RArray[43] : "NULL"
                                                , 44 < RArray.Length ? RArray[44] : "NULL"
                                                , 45 < RArray.Length ? RArray[45] : "NULL"
                                                , 46 < RArray.Length ? RArray[46] : "NULL"
                                                , 47 < RArray.Length ? RArray[47] : "NULL"
                                                , 48 < RArray.Length ? RArray[48] : "NULL"
                                                , 49 < RArray.Length ? RArray[49] : "NULL"
                                                , 50 < RArray.Length ? RArray[50] : "NULL"
                                                , 51 < RArray.Length ? RArray[51] : "NULL"
                                                , 52 < RArray.Length ? RArray[52] : "NULL"
                                                , ConStrArray[x].ToString());
                            }

                        }
                        counter++;
                    }

                    file.Close();
                    Move(fileLocation + fName, MovePath, DateTime.Now.ToString("yyyyMMddHHmm") + "_" + fName);
                }

                //System.Console.ReadLine();
                return true;

            }
            catch (Exception ex)
            {
                return false;
            }

        }

        private void InsertRawData_LODH(string FileName, string A, string B, string C, string D, string E, string F, string G, string H, string I, string J, string K, string L, string M,
                          string N, string O, string P, string Q, string R, string S, string T, string U, string V, string W, string X, string Y, string Z,
                          string AA, string AB, string AC, string AD, string AE, string AF, string AG, string AH, string AI, string AJ, string AK, string AL, string AM,
                          string AN, string AO, string AP, string AQ, string AR, string SS, string AT, string AU, string AV, string AW, string AX, string AY, string AZ,
                          string BA, string strConnString)
        {

            //String strConnString = ConfigurationSettings.AppSettings["ConStr"].ToString();

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "dbo.Fill_Raw_Data_LODH";
            cmd.Parameters.Add("@FileName", SqlDbType.NVarChar).Value = FileName;
            cmd.Parameters.Add("@A", SqlDbType.NVarChar).Value = "NULL" != A ? A : " ";
            cmd.Parameters.Add("@B", SqlDbType.NVarChar).Value = "NULL" != B ? B : " ";
            cmd.Parameters.Add("@C", SqlDbType.NVarChar).Value = "NULL" != C ? C : " ";
            cmd.Parameters.Add("@D", SqlDbType.NVarChar).Value = "NULL" != D ? D : " ";
            cmd.Parameters.Add("@E", SqlDbType.NVarChar).Value = "NULL" != E ? E : " ";
            cmd.Parameters.Add("@F", SqlDbType.NVarChar).Value = "NULL" != F ? F : " ";
            cmd.Parameters.Add("@G", SqlDbType.NVarChar).Value = "NULL" != G ? G : " ";
            cmd.Parameters.Add("@H", SqlDbType.NVarChar).Value = "NULL" != H ? H : " ";
            cmd.Parameters.Add("@I", SqlDbType.NVarChar).Value = "NULL" != I ? I : " ";
            cmd.Parameters.Add("@J", SqlDbType.NVarChar).Value = "NULL" != J ? J : " ";
            cmd.Parameters.Add("@K", SqlDbType.NVarChar).Value = "NULL" != K ? K : " ";
            cmd.Parameters.Add("@L", SqlDbType.NVarChar).Value = "NULL" != L ? L : " ";
            cmd.Parameters.Add("@M", SqlDbType.NVarChar).Value = "NULL" != M ? M : " ";
            cmd.Parameters.Add("@N", SqlDbType.NVarChar).Value = "NULL" != N ? N : " ";
            cmd.Parameters.Add("@O", SqlDbType.NVarChar).Value = "NULL" != O ? O : " ";
            cmd.Parameters.Add("@P", SqlDbType.NVarChar).Value = "NULL" != P ? P : " ";
            cmd.Parameters.Add("@Q", SqlDbType.NVarChar).Value = "NULL" != Q ? Q : " ";
            cmd.Parameters.Add("@R", SqlDbType.NVarChar).Value = "NULL" != R ? R : " ";
            cmd.Parameters.Add("@S", SqlDbType.NVarChar).Value = "NULL" != S ? S : " ";
            cmd.Parameters.Add("@T", SqlDbType.NVarChar).Value = "NULL" != T ? T : " ";
            cmd.Parameters.Add("@U", SqlDbType.NVarChar).Value = "NULL" != U ? U : " ";
            cmd.Parameters.Add("@V", SqlDbType.NVarChar).Value = "NULL" != V ? V : " ";
            cmd.Parameters.Add("@W", SqlDbType.NVarChar).Value = "NULL" != W ? W : " ";
            cmd.Parameters.Add("@X", SqlDbType.NVarChar).Value = "NULL" != X ? X : " ";
            cmd.Parameters.Add("@Y", SqlDbType.NVarChar).Value = "NULL" != Y ? Y : " ";
            cmd.Parameters.Add("@Z", SqlDbType.NVarChar).Value = "NULL" != Z ? Z : " ";
            cmd.Parameters.Add("@AA", SqlDbType.NVarChar).Value = "NULL" != AA ? AA : " ";
            cmd.Parameters.Add("@AB", SqlDbType.NVarChar).Value = "NULL" != AB ? AB : " ";
            cmd.Parameters.Add("@AC", SqlDbType.NVarChar).Value = "NULL" != AC ? AC : " ";
            cmd.Parameters.Add("@AD", SqlDbType.NVarChar).Value = "NULL" != AD ? AD : " ";
            cmd.Parameters.Add("@AE", SqlDbType.NVarChar).Value = "NULL" != AE ? AE : " ";
            cmd.Parameters.Add("@AF", SqlDbType.NVarChar).Value = "NULL" != AF ? AF : " ";
            cmd.Parameters.Add("@AG", SqlDbType.NVarChar).Value = "NULL" != AG ? AG : " ";
            cmd.Parameters.Add("@AH", SqlDbType.NVarChar).Value = "NULL" != AH ? AH : " ";
            cmd.Parameters.Add("@AI", SqlDbType.NVarChar).Value = "NULL" != AI ? AI : " ";
            cmd.Parameters.Add("@AJ", SqlDbType.NVarChar).Value = "NULL" != AJ ? AJ : " ";
            cmd.Parameters.Add("@AK", SqlDbType.NVarChar).Value = "NULL" != AK ? AK : " ";
            cmd.Parameters.Add("@AL", SqlDbType.NVarChar).Value = "NULL" != AL ? AL : " ";
            cmd.Parameters.Add("@AM", SqlDbType.NVarChar).Value = "NULL" != AM ? AM : " ";
            cmd.Parameters.Add("@AN", SqlDbType.NVarChar).Value = "NULL" != AN ? AN : " ";
            cmd.Parameters.Add("@AO", SqlDbType.NVarChar).Value = "NULL" != AO ? AO : " ";
            cmd.Parameters.Add("@AP", SqlDbType.NVarChar).Value = "NULL" != AP ? AP : " ";
            cmd.Parameters.Add("@AQ", SqlDbType.NVarChar).Value = "NULL" != AQ ? AQ : " ";
            cmd.Parameters.Add("@AR", SqlDbType.NVarChar).Value = "NULL" != AR ? AR : " ";
            cmd.Parameters.Add("@AS", SqlDbType.NVarChar).Value = "NULL" != SS ? SS : " ";
            cmd.Parameters.Add("@AT", SqlDbType.NVarChar).Value = "NULL" != AT ? AT : " ";
            cmd.Parameters.Add("@AU", SqlDbType.NVarChar).Value = "NULL" != AU ? AU : " ";
            cmd.Parameters.Add("@AV", SqlDbType.NVarChar).Value = "NULL" != AV ? AV : " ";
            cmd.Parameters.Add("@AW", SqlDbType.NVarChar).Value = "NULL" != AW ? AW : " ";
            cmd.Parameters.Add("@AX", SqlDbType.NVarChar).Value = "NULL" != AX ? AX : " ";
            cmd.Parameters.Add("@AY", SqlDbType.NVarChar).Value = "NULL" != AY ? AY : " ";
            cmd.Parameters.Add("@AZ", SqlDbType.NVarChar).Value = "NULL" != AZ ? AZ : " ";
            cmd.Parameters.Add("@BA", SqlDbType.NVarChar).Value = "NULL" != BA ? BA : " ";

            cmd.Connection = con;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
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

        }

        #endregion
        #region LODH Market Price

        public bool MarketPrice_ArrangeFileList_LODH(string ftpPath)
        {
            try
            {
                string fileName = string.Empty;
                //string[] fileArray = Directory.GetFiles(ftpPath, "30102POS*.txt", SearchOption.AllDirectories);

                //for (int i = 0; fileArray.Length > i; i++)
                //{
                fileName = ftpPath.Split('\\').Last();
                Move(ftpPath, CopyPath, fileName);
                return true;
                //}

            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return false;
            }

        }

        public bool MarketPrice_ReadFileContaint_LODH(string fileLocation)
        {
            try
            {
                int counter = 0;
                string line;
                string[] RArray;

                string fName = string.Empty;
                string[] fArray = Directory.GetFiles(fileLocation, "30102POS*.txt", SearchOption.AllDirectories);
                int num;
                string tempDate;

                for (int i = 0; fArray.Length > i; i++)
                {
                    fName = fArray[i].Split('\\').Last();

                    System.IO.StreamReader file = new System.IO.StreamReader(fileLocation + fName, true);
                    while ((line = file.ReadLine()) != null)
                    {
                        RArray = line.Split(';');

                        if (Int32.TryParse(RArray[0].Substring(0, 1), out num))
                        {
                            string[] tempsplit = RArray[56].Split('.');
                            string[] tempMTD = RArray[57].Split('.');
                            if (tempMTD.Length > 1)
                            {
                                //MarketPrice_InsertRawData(RArray[315].ToString(), RArray[191].ToString(), RArray[151].ToString(), "0", RArray[50].ToString(), "0", (tempsplit[2] + tempsplit[1] + tempsplit[0]), (tempMTD[2] + tempMTD[1] + tempMTD[0]));
                                MarketPrice_InsertRawData(RArray[315].ToString(), RArray[62].ToString(), RArray[151].ToString(), "0", RArray[50].ToString(), "0", RArray[0].ToString(), (tempMTD[2] + tempMTD[1] + tempMTD[0]));
                            }
                            else
                            {
                                //MarketPrice_InsertRawData(RArray[315].ToString(), RArray[191].ToString(), RArray[151].ToString(), "0", RArray[50].ToString(), "0", (tempsplit[2] + tempsplit[1] + tempsplit[0]), "");
                                MarketPrice_InsertRawData(RArray[315].ToString(), RArray[62].ToString(), RArray[151].ToString(), "0", RArray[50].ToString(), "0", RArray[0].ToString(), "");
                            }
                        }
                        counter++;
                    }

                    file.Close();
                    Move(fileLocation + fName, MovePath, DateTime.Now.ToString("yyyyMMddHHmm") + "_" + fName);
                }


                //System.Console.ReadLine();
                return true;

            }
            catch (Exception ex)
            {
                return false;
            }

        }


        #endregion

        #region BNP PARIBAS BANK

        public bool ArrangeFileList_BNP(string ftpPath)
        {

            try
            {
                string fileName = string.Empty;
                 //  Directory.GetFiles(ftpPath, "DIG2_ope_*.CSV", SearchOption.AllDirectories);
                //fileArray[0] = ftpPath; 

                //for (int i = 0; fileArray.Length > i; i++)
                //{
                    fileName = ftpPath.Split('\\').Last();
                    Move(ftpPath, CopyPath, fileName);
                    return true;
                //}
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return false;
            }

        }

        public bool ReadFileContaint_BNP(string fileLocation)
        {
            try
            {
                int counter = 0;
                string line;
                string[] RArray;

                String strConnStringssss = ConfigurationSettings.AppSettings["ConStr2"].ToString();
                string[] ConStrArray = strConnStringssss.Split(new char[] { ',' });

                string fName = string.Empty;
                string[] fArray = Directory.GetFiles(fileLocation, "DIG2_ope_*.CSV", SearchOption.AllDirectories);
                int num;

                for (int i = 0; fArray.Length > i; i++)
                {
                    fName = fArray[i].Split('\\').Last();

                    System.IO.StreamReader file = new System.IO.StreamReader(fileLocation + fName, true);
                    while ((line = file.ReadLine()) != null)
                    {
                        RArray = line.Split(';');
                        if (Int32.TryParse(RArray[0].Substring(0, 1), out num))
                        {

                            for (int x = 0; ConStrArray.Length > x; x++)
                            {

                                //Console.WriteLine(RArray[0].ToString() + "," + RArray[1].ToString() + "," + RArray[2].ToString() + "," + RArray[3].ToString() + "," + RArray[4].ToString() + "," + RArray[5].ToString());
                                InsertRawData_BNP(fName, RArray[0], RArray[1], RArray[2], RArray[3], RArray[4], RArray[5], RArray[6], RArray[7], RArray[8], RArray[9], RArray[10], RArray[11], RArray[12], RArray[13], RArray[14],
                                                RArray[15], RArray[16], RArray[17], RArray[18], RArray[19], RArray[20], RArray[21], RArray[22], RArray[23], RArray[24], RArray[25], RArray[26], RArray[27], RArray[28], RArray[29]
                                                , 30 < RArray.Length ? RArray[30] : "NULL"
                                                , 31 < RArray.Length ? RArray[31] : "NULL"
                                                , 32 < RArray.Length ? RArray[32] : "NULL"
                                                , 33 < RArray.Length ? RArray[33] : "NULL"
                                                , 34 < RArray.Length ? RArray[34] : "NULL"
                                                , 35 < RArray.Length ? RArray[35] : "NULL"
                                                , 36 < RArray.Length ? RArray[36] : "NULL"
                                                , 37 < RArray.Length ? RArray[37] : "NULL"
                                                , 38 < RArray.Length ? RArray[38] : "NULL"
                                                , 39 < RArray.Length ? RArray[39] : "NULL"
                                                , 40 < RArray.Length ? RArray[40] : "NULL"
                                                , 41 < RArray.Length ? RArray[41] : "NULL"
                                                , 42 < RArray.Length ? RArray[42] : "NULL"
                                                , 43 < RArray.Length ? RArray[43] : "NULL"
                                                , 44 < RArray.Length ? RArray[44] : "NULL"
                                                , 45 < RArray.Length ? RArray[45] : "NULL"
                                                , 46 < RArray.Length ? RArray[46] : "NULL"
                                                , 47 < RArray.Length ? RArray[47] : "NULL"
                                                , 48 < RArray.Length ? RArray[48] : "NULL"
                                                , 49 < RArray.Length ? RArray[49] : "NULL"
                                                , 50 < RArray.Length ? RArray[50] : "NULL"
                                                , 51 < RArray.Length ? RArray[51] : "NULL"
                                                , 52 < RArray.Length ? RArray[52] : "NULL"
                                                , 53 < RArray.Length ? RArray[53] : "NULL"
                                                , 54 < RArray.Length ? RArray[54] : "NULL"
                                                , 55 < RArray.Length ? RArray[55] : "NULL"
                                                , 56 < RArray.Length ? RArray[56] : "NULL"
                                                , 57 < RArray.Length ? RArray[57] : "NULL"
                                                , 58 < RArray.Length ? RArray[58] : "NULL"
                                                , 59 < RArray.Length ? RArray[59] : "NULL"
                                                , 60 < RArray.Length ? RArray[60] : "NULL"
                                                , 61 < RArray.Length ? RArray[61] : "NULL"
                                                , 62 < RArray.Length ? RArray[62] : "NULL"
                                                , 63 < RArray.Length ? RArray[63] : "NULL"
                                                , 64 < RArray.Length ? RArray[64] : "NULL"
                                                , 65 < RArray.Length ? RArray[65] : "NULL"
                                                , 66 < RArray.Length ? RArray[66] : "NULL"
                                                , 67 < RArray.Length ? RArray[67] : "NULL"
                                                , 68 < RArray.Length ? RArray[68] : "NULL"
                                                , 69 < RArray.Length ? RArray[69] : "NULL"
                                                , 70 < RArray.Length ? RArray[70] : "NULL"
                                                , 71 < RArray.Length ? RArray[71] : "NULL"
                                                , 72 < RArray.Length ? RArray[72] : "NULL"
                                                , 73 < RArray.Length ? RArray[73] : "NULL"
                                                , ConStrArray[x].ToString());
                            }

                        }
                        counter++;
                    }

                    file.Close();
                    Move(fileLocation + fName, MovePath, DateTime.Now.ToString("yyyyMMddHHmm") + "_" + fName);
                    
                }

                //System.Console.ReadLine();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        }

        private void InsertRawData_BNP(string FileName, string A, string B, string C, string D, string E, string F, string G, string H, string I, string J, string K, string L, string M,
                          string N, string O, string P, string Q, string R, string S, string T, string U, string V, string W, string X, string Y, string Z,
                          string AA, string AB, string AC, string AD, string AE, string AF, string AG, string AH, string AI, string AJ, string AK, string AL, string AM,
                          string AN, string AO, string AP, string AQ, string AR, string SS, string AT, string AU, string AV, string AW, string AX, string AY, string AZ,
                          string BA, string BB, string BC, string BD, string BE, string BF, string BG, string BH, string BI, string BJ, string BK, string BL, string BM,
                          string BN, string BO, string BP, string BQ, string BR, string BS, string BT, string BU, string BV, string strConnString)
        {

            //String strConnString = ConfigurationSettings.AppSettings["ConStr"].ToString();

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "dbo.Fill_Raw_Data_BNP";
            cmd.Parameters.Add("@FileName", SqlDbType.NVarChar).Value = FileName;
            cmd.Parameters.Add("@A", SqlDbType.NVarChar).Value = "NULL" != A ? A : " ";
            cmd.Parameters.Add("@B", SqlDbType.NVarChar).Value = "NULL" != B ? B : " ";
            cmd.Parameters.Add("@C", SqlDbType.NVarChar).Value = "NULL" != C ? C : " ";
            cmd.Parameters.Add("@D", SqlDbType.NVarChar).Value = "NULL" != D ? D : " ";
            cmd.Parameters.Add("@E", SqlDbType.NVarChar).Value = "NULL" != E ? E : " ";
            cmd.Parameters.Add("@F", SqlDbType.NVarChar).Value = "NULL" != F ? F : " ";
            cmd.Parameters.Add("@G", SqlDbType.NVarChar).Value = "NULL" != G ? G : " ";
            cmd.Parameters.Add("@H", SqlDbType.NVarChar).Value = "NULL" != H ? H : " ";
            cmd.Parameters.Add("@I", SqlDbType.NVarChar).Value = "NULL" != I ? I : " ";
            cmd.Parameters.Add("@J", SqlDbType.NVarChar).Value = "NULL" != J ? J : " ";
            cmd.Parameters.Add("@K", SqlDbType.NVarChar).Value = "NULL" != K ? K : " ";
            cmd.Parameters.Add("@L", SqlDbType.NVarChar).Value = "NULL" != L ? L : " ";
            cmd.Parameters.Add("@M", SqlDbType.NVarChar).Value = "NULL" != M ? M : " ";
            cmd.Parameters.Add("@N", SqlDbType.NVarChar).Value = "NULL" != N ? N : " ";
            cmd.Parameters.Add("@O", SqlDbType.NVarChar).Value = "NULL" != O ? O : " ";
            cmd.Parameters.Add("@P", SqlDbType.NVarChar).Value = "NULL" != P ? P : " ";
            cmd.Parameters.Add("@Q", SqlDbType.NVarChar).Value = "NULL" != Q ? Q : " ";
            cmd.Parameters.Add("@R", SqlDbType.NVarChar).Value = "NULL" != R ? R : " ";
            cmd.Parameters.Add("@S", SqlDbType.NVarChar).Value = "NULL" != S ? S : " ";
            cmd.Parameters.Add("@T", SqlDbType.NVarChar).Value = "NULL" != T ? T : " ";
            cmd.Parameters.Add("@U", SqlDbType.NVarChar).Value = "NULL" != U ? U : " ";
            cmd.Parameters.Add("@V", SqlDbType.NVarChar).Value = "NULL" != V ? V : " ";
            cmd.Parameters.Add("@W", SqlDbType.NVarChar).Value = "NULL" != W ? W : " ";
            cmd.Parameters.Add("@X", SqlDbType.NVarChar).Value = "NULL" != X ? X : " ";
            cmd.Parameters.Add("@Y", SqlDbType.NVarChar).Value = "NULL" != Y ? Y : " ";
            cmd.Parameters.Add("@Z", SqlDbType.NVarChar).Value = "NULL" != Z ? Z : " ";
            cmd.Parameters.Add("@AA", SqlDbType.NVarChar).Value = "NULL" != AA ? AA : " ";
            cmd.Parameters.Add("@AB", SqlDbType.NVarChar).Value = "NULL" != AB ? AB : " ";
            cmd.Parameters.Add("@AC", SqlDbType.NVarChar).Value = "NULL" != AC ? AC : " ";
            cmd.Parameters.Add("@AD", SqlDbType.NVarChar).Value = "NULL" != AD ? AD : " ";
            cmd.Parameters.Add("@AE", SqlDbType.NVarChar).Value = "NULL" != AE ? AE : " ";
            cmd.Parameters.Add("@AF", SqlDbType.NVarChar).Value = "NULL" != AF ? AF : " ";
            cmd.Parameters.Add("@AG", SqlDbType.NVarChar).Value = "NULL" != AG ? AG : " ";
            cmd.Parameters.Add("@AH", SqlDbType.NVarChar).Value = "NULL" != AH ? AH : " ";
            cmd.Parameters.Add("@AI", SqlDbType.NVarChar).Value = "NULL" != AI ? AI : " ";
            cmd.Parameters.Add("@AJ", SqlDbType.NVarChar).Value = "NULL" != AJ ? AJ : " ";
            cmd.Parameters.Add("@AK", SqlDbType.NVarChar).Value = "NULL" != AK ? AK : " ";
            cmd.Parameters.Add("@AL", SqlDbType.NVarChar).Value = "NULL" != AL ? AL : " ";
            cmd.Parameters.Add("@AM", SqlDbType.NVarChar).Value = "NULL" != AM ? AM : " ";
            cmd.Parameters.Add("@AN", SqlDbType.NVarChar).Value = "NULL" != AN ? AN : " ";
            cmd.Parameters.Add("@AO", SqlDbType.NVarChar).Value = "NULL" != AO ? AO : " ";
            cmd.Parameters.Add("@AP", SqlDbType.NVarChar).Value = "NULL" != AP ? AP : " ";
            cmd.Parameters.Add("@AQ", SqlDbType.NVarChar).Value = "NULL" != AQ ? AQ : " ";
            cmd.Parameters.Add("@AR", SqlDbType.NVarChar).Value = "NULL" != AR ? AR : " ";
            cmd.Parameters.Add("@AS", SqlDbType.NVarChar).Value = "NULL" != SS ? SS : " ";
            cmd.Parameters.Add("@AT", SqlDbType.NVarChar).Value = "NULL" != AT ? AT : " ";
            cmd.Parameters.Add("@AU", SqlDbType.NVarChar).Value = "NULL" != AU ? AU : " ";
            cmd.Parameters.Add("@AV", SqlDbType.NVarChar).Value = "NULL" != AV ? AV : " ";
            cmd.Parameters.Add("@AW", SqlDbType.NVarChar).Value = "NULL" != AW ? AW : " ";
            cmd.Parameters.Add("@AX", SqlDbType.NVarChar).Value = "NULL" != AX ? AX : " ";
            cmd.Parameters.Add("@AY", SqlDbType.NVarChar).Value = "NULL" != AY ? AY : " ";
            cmd.Parameters.Add("@AZ", SqlDbType.NVarChar).Value = "NULL" != AZ ? AZ : " ";
            cmd.Parameters.Add("@BA", SqlDbType.NVarChar).Value = "NULL" != BA ? BA : " ";
            cmd.Parameters.Add("@BB", SqlDbType.NVarChar).Value = "NULL" != BB ? BB : " ";
            cmd.Parameters.Add("@BC", SqlDbType.NVarChar).Value = "NULL" != BC ? BC : " ";
            cmd.Parameters.Add("@BD", SqlDbType.NVarChar).Value = "NULL" != BD ? BD : " ";
            cmd.Parameters.Add("@BE", SqlDbType.NVarChar).Value = "NULL" != BE ? BE : " ";
            cmd.Parameters.Add("@BF", SqlDbType.NVarChar).Value = "NULL" != BF ? BF : " ";
            cmd.Parameters.Add("@BG", SqlDbType.NVarChar).Value = "NULL" != BG ? BG : " ";
            cmd.Parameters.Add("@BH", SqlDbType.NVarChar).Value = "NULL" != BH ? BH : " ";
            cmd.Parameters.Add("@BI", SqlDbType.NVarChar).Value = "NULL" != BI ? BI : " ";
            cmd.Parameters.Add("@BJ", SqlDbType.NVarChar).Value = "NULL" != BJ ? BJ : " ";
            cmd.Parameters.Add("@BK", SqlDbType.NVarChar).Value = "NULL" != BK ? BK : " ";
            cmd.Parameters.Add("@BL", SqlDbType.NVarChar).Value = "NULL" != BL ? BL : " ";
            cmd.Parameters.Add("@BM", SqlDbType.NVarChar).Value = "NULL" != BM ? BM : " ";
            cmd.Parameters.Add("@BN", SqlDbType.NVarChar).Value = "NULL" != BN ? BN : " ";
            cmd.Parameters.Add("@BO", SqlDbType.NVarChar).Value = "NULL" != BO ? BO : " ";
            cmd.Parameters.Add("@BP", SqlDbType.NVarChar).Value = "NULL" != BP ? BP : " ";
            cmd.Parameters.Add("@BQ", SqlDbType.NVarChar).Value = "NULL" != BQ ? BQ : " ";
            cmd.Parameters.Add("@BR", SqlDbType.NVarChar).Value = "NULL" != BR ? BR : " ";
            cmd.Parameters.Add("@BS", SqlDbType.NVarChar).Value = "NULL" != BS ? BS : " ";
            cmd.Parameters.Add("@BT", SqlDbType.NVarChar).Value = "NULL" != BT ? BT : " ";
            cmd.Parameters.Add("@BU", SqlDbType.NVarChar).Value = "NULL" != BU ? BU : " ";
            cmd.Parameters.Add("@BV", SqlDbType.NVarChar).Value = "NULL" != BV ? BV : " ";

            cmd.Connection = con;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
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

        }

        #endregion
        #region BNP Market Price

        public bool MarketPrice_ArrangeFileList_BNP(string ftpPath)
        {
            try
            {
                string fileName = string.Empty;
                //string[] fileArray = Directory.GetFiles(ftpPath, "DIG2_pos*.csv", SearchOption.AllDirectories);

                //for (int i = 0; fileArray.Length > i; i++)
                //{
                    fileName = ftpPath.Split('\\').Last();
                    Move(ftpPath, CopyPath, fileName);
                    return true;
                //}
                
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return false;
            }

        }

        public bool MarketPrice_ReadFileContaint_BNP(string fileLocation)
        {
            try
            {
                int counter = 0;
                string line;
                string[] RArray;

                string fName = string.Empty;
                string[] fArray = Directory.GetFiles(fileLocation, "DIG2_pos*.csv", SearchOption.AllDirectories);
                int num;
                string tempDate, tempRef;

                for (int i = 0; fArray.Length > i; i++)
                {
                    fName = fArray[i].Split('\\').Last();

                    System.IO.StreamReader file = new System.IO.StreamReader(fileLocation + fName, true);
                    while ((line = file.ReadLine()) != null)
                    {
                        RArray = line.Split(';');

                        if (Int32.TryParse(RArray[0].Substring(0, 1), out num))
                        {
                            string[] tempsplit = RArray[14].Split('/');
                            //Console.WriteLine("REF :" + RArray[3].Substring(0, 7).ToString() + ",");
                            if (RArray[3].ToString().Length >= 7)
                            {
                                tempRef = RArray[3].Substring(0, 7).ToString();
                            }
                            else
                            {
                                tempRef = RArray[3].ToString();
                            }


                            MarketPrice_InsertRawData(RArray[0].ToString(), RArray[5].ToString(), tempRef, "0", RArray[13].ToString(), "0", (tempsplit[2] + tempsplit[1] + tempsplit[0]), "");
                        }
                        counter++;
                    }

                    file.Close();
                    Move(fileLocation + fName, MovePath, DateTime.Now.ToString("yyyyMMddHHmm") + "_" + fName);
                }


                //System.Console.ReadLine();
                return true;

            }
            catch (Exception ex)
            {
                return false;
            }

        }



        #endregion
    }
}
