USE CCCDAT
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_MP]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_MP]
AS
BEGIN	
	DECLARE @RW_Count_ID int
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(50)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,10)
	DECLARE @Price decimal(18,10)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(25,10)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE date
	DECLARE @Reversal_Status varchar(10)
	DECLARE @MTD_DATE Date
	DECLARE @REF varchar(50)
	DECLARE @VALUE decimal(25,10)
	DECLARE @FEE varchar(10)
	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,10)
	DECLARE @RCount int
	DECLARE @TRDATE date
	DECLARE @CHK_Account nvarchar(50)
	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,10)
	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,10)
	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,10)
	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,10)
	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,10)
	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,10)
	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,10)
	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,10)
	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,10)
	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,10)
	DECLARE @CHARGE_TAX_REF varchar(50)
	DECLARE @CHARGE_TAX_VALUE Decimal(18,10)
	DECLARE @VALUE_01 Decimal(18,10)
	DECLARE @VALUE_02 Decimal(18,10)
	DECLARE @VALUE_03 Decimal(18,10)
	DECLARE @VALUE_04 Decimal(18,10)
	DECLARE @VALUE_05 Decimal(18,10)
	DECLARE @VALUE_06 Decimal(18,10)
	DECLARE @VALUE_07 Decimal(18,10)
	DECLARE @VALUE_08 Decimal(18,10)
	DECLARE @VALUE_09 Decimal(18,10)
	DECLARE @VALUE_10 Decimal(18,10)
	DECLARE @VALUE_TAX Decimal(18,10)	
	DECLARE @VALUE_EX Decimal(25,10)
	DECLARE @F_VALUE_EX Decimal(25,10)
	DECLARE @VALUE_EXCHANGE_GAIN_LOSS Decimal(25,10)
	DECLARE @FINAL_VALUE_EX Decimal(25,10)
	DECLARE @GL_ACC_IDENTIFIER varchar(10)
	DECLARE @FWD_ACC_NUMBER varchar(50)
	DECLARE @KBEW_ID int	
	DECLARE @E_Column varchar(20)
	DECLARE @CONVERT_VALUE_01 Decimal(18,10)	
	DECLARE @EX_ACCOUNT varchar(50)
	DECLARE @EX_DIFF decimal(18,10)


	--=========================================================
	DECLARE @Account2 nvarchar(50)
	DECLARE @SecurityNumber2 nvarchar(50)
	DECLARE @Quantity2 decimal(18,10)
	DECLARE @Price2 decimal(18,10)
	DECLARE @Currency2 nvarchar(50)
	DECLARE @TransactionDate2 date
	DECLARE @Description12 nvarchar(250) -- need to select transaction record
	DECLARE @Description22 nvarchar(250)
	DECLARE @LinkedNumber2 nvarchar(150)	
	DECLARE @DebitCreditStatus2 nvarchar(10)	
	DECLARE @TransactionAmout2 decimal(25,10)
	DECLARE @ValueRECDesc2 varchar(50)
	DECLARE @valueRECCode2 varchar(50)
	DECLARE @BankCode2 varchar(50)
	DECLARE @TOP2 varchar(50) 
	DECLARE @Comments2 nvarchar(250)
	DECLARE @TRX_DATE2 date
	DECLARE @Reversal_Status2 varchar(10)
	DECLARE @MTD_DATE2 Date
	DECLARE @REF2 varchar(50)
	DECLARE @VALUE2 decimal(25,10)
	DECLARE @FEE2 varchar(10)
	DECLARE @TRDATE2 date
	DECLARE @CHK_Account2 nvarchar(50)
	DECLARE @CHARGE_01_REF2 varchar(50)
	DECLARE @CHARGE_01_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_02_REF2 varchar(50)
	DECLARE @CHARGE_02_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_03_REF2 varchar(50)
	DECLARE @CHARGE_03_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_04_REF2 varchar(50)
	DECLARE @CHARGE_04_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_05_REF2 varchar(50)
	DECLARE @CHARGE_05_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_06_REF2 varchar(50)
	DECLARE @CHARGE_06_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_07_REF2 varchar(50)
	DECLARE @CHARGE_07_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_08_REF2 varchar(50)
	DECLARE @CHARGE_08_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_09_REF2 varchar(50)
	DECLARE @CHARGE_09_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_10_REF2 varchar(50)
	DECLARE @CHARGE_10_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_TAX_REF2 varchar(50)
	DECLARE @CHARGE_TAX_VALUE2 Decimal(18,10)
	DECLARE @VALUE2_01 Decimal(18,10)
	DECLARE @VALUE2_02 Decimal(18,10)
	DECLARE @VALUE2_03 Decimal(18,10)
	DECLARE @VALUE2_04 Decimal(18,10)
	DECLARE @VALUE2_05 Decimal(18,10)
	DECLARE @VALUE2_06 Decimal(18,10)
	DECLARE @VALUE2_07 Decimal(18,10)
	DECLARE @VALUE2_08 Decimal(18,10)
	DECLARE @VALUE2_09 Decimal(18,10)
	DECLARE @VALUE2_10 Decimal(18,10)
	DECLARE @VALUE_TAX2 Decimal(18,10)
	DECLARE @VALUE2_EX Decimal(25,10)
	DECLARE @VALUE_EXCHANGE_GAIN_LOSS_2 Decimal(25,10)
	DECLARE @FINAL_VALUE_EX_2 Decimal(25,10)
	DECLARE @GL_ACC_IDENTIFIER2 varchar(10)
	DECLARE @FWD_ACC_NUMBER2 varchar(50)
	DECLARE @KBEW_ID2 int
	DECLARE @RowsToProcess2  int
	DECLARE @CurrentRow2     int
	DECLARE @SelectCol12     int
	DECLARE @CONVERT_VALUE_02 Decimal(18,10)	
	--BEGIN TRY
	--================================ Start TRY ====================================
	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50),TRDate date )  
	INSERT into @table1 (col1,AccID,TRDate) SELECT  min(ID),C,CAST(Z  AS DATE) FROM [dbo].[RAW_DATA] WHERE (P = 'MP') AND A = 'KBEW' AND status = 0 GROUP BY P,Z,C,T  ORDER BY CAST(Z  AS DATE) ASC --GROUP BY P,AK,Z,C
	SET @RowsToProcess=@@ROWCOUNT
	SET @CurrentRow=0
	WHILE @CurrentRow<@RowsToProcess
	BEGIN
    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@CHK_Account = AccID,@TRDATE = TRDate FROM @table1 WHERE RowID=@CurrentRow	
	
	IF((RTrim(dbo.Get_Map_Company_From_Bank_Account(@CHK_Account)) = 'CORYELL'))
	BEGIN
	--==============================================================================

	SET @IncVal = @IncVal + dbo.RandFn()

	--==============================================================================
		SET   @TransactionAmout = 0
		SET   @DebitCreditStatus = ''
		SET   @Reversal_Status  = ''
		SET   @Description = ''
		SET   @Description2 = ''
		SET   @Comments = ''
		SET   @ValueRECDesc = ''
		SET   @valueRECCode = ''
		SET   @BankCode = ''
		SET   @FEE = ''
		SET   @MTD_DATE = ''		
		SET   @CHARGE_01_REF  = ''
		SET   @CHARGE_01_VALUE  = 0 
		SET   @CHARGE_02_REF  = ''
		SET   @CHARGE_02_VALUE  = 0
		SET   @CHARGE_03_REF  = ''
		SET   @CHARGE_03_VALUE  = 0
		SET   @CHARGE_04_REF  = ''
		SET   @CHARGE_04_VALUE  = 0
		SET   @CHARGE_05_REF  = ' '
		SET   @CHARGE_05_VALUE  =  0
		SET   @CHARGE_06_REF  = ''
		SET   @CHARGE_06_VALUE  =  0
		SET   @CHARGE_07_REF  = ''
		SET   @CHARGE_07_VALUE  =  0
		SET   @CHARGE_08_REF  = ''
		SET   @CHARGE_08_VALUE  =  0
		SET   @CHARGE_09_REF  = ''
		SET   @CHARGE_09_VALUE  =  0
		SET   @CHARGE_10_REF  = ''
		SET   @CHARGE_10_VALUE  =  0	
		SET   @CHARGE_TAX_REF2 = 0
	    SET   @CHARGE_TAX_VALUE2 = 0	
		SET   @KBEW_ID = 00
		SET   @GL_ACC_IDENTIFIER = ''
		SET   @VALUE_EXCHANGE_GAIN_LOSS = 0
		SET   @VALUE_EX = 0
		SET   @CONVERT_VALUE_01 = 0

		
		SET   @TransactionAmout2 = 0
		SET   @DebitCreditStatus2 = ''
		SET   @Reversal_Status2  = ''
		SET   @Description12 = ''
		SET   @Description22 = ''
		SET   @Comments2 = ''
		SET   @ValueRECDesc2 = ''
		SET   @valueRECCode2 = ''
		SET   @BankCode2 = ''
		SET   @FEE2 = ''
		SET   @MTD_DATE2 = ''		
		SET   @CHARGE_01_REF2  = ''
		SET   @CHARGE_01_VALUE2  = 0 
		SET   @CHARGE_02_REF2  = ''
		SET   @CHARGE_02_VALUE2  = 0
		SET   @CHARGE_03_REF2  = ''
		SET   @CHARGE_03_VALUE2  = 0
		SET   @CHARGE_04_REF2  = ''
		SET   @CHARGE_04_VALUE2  = 0
		SET   @CHARGE_05_REF2  = ' '
		SET   @CHARGE_05_VALUE2  =  0
		SET   @CHARGE_06_REF2  = ''
		SET   @CHARGE_06_VALUE2  =  0
		SET   @CHARGE_07_REF2  = ''
		SET   @CHARGE_07_VALUE2  =  0
		SET   @CHARGE_08_REF2  = ''
		SET   @CHARGE_08_VALUE2  =  0
		SET   @CHARGE_09_REF2  = ''
		SET   @CHARGE_09_VALUE2  =  0
		SET   @CHARGE_10_REF2  = ''
		SET   @CHARGE_10_VALUE2  =  0	
		SET   @CHARGE_TAX_REF2 = 0
	    SET   @CHARGE_TAX_VALUE2 = 0	
		SET   @KBEW_ID2 = 00
		SET   @GL_ACC_IDENTIFIER2 = ''
		SET   @VALUE_EXCHANGE_GAIN_LOSS_2 = 0
		SET   @VALUE2_EX = 0
		SET   @CONVERT_VALUE_02 = 0

		--===================================START VALUE SET 01 =====================================================
		--=====================================VALUE SET 01==============================================================

		SELECT @Account = C
				,@SecurityNumber = I
				,@Quantity = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
				,@Price = CASE WHEN (W != ' ') THEN CAST(W  AS Decimal(18,8)) ELSE 0 END
				,@Currency = CASE WHEN ( H != '') THEN CAST(H  AS nvarchar(50)) ELSE '_' END
				,@TransactionDate = CASE WHEN (AA != '00000000') THEN CAST( AA AS DATE)  END
				,@TRX_DATE =  CASE WHEN (Z != '00000000') THEN CAST(Z  AS DATE)  END
				,@LinkedNumber = AK
				,@TransactionAmout = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
				,@DebitCreditStatus = T
				,@Reversal_Status  = U
				,@Description = CASE WHEN (AD != '') THEN CAST(AD AS NVARCHAR(MAX)) ELSE '_' END
				,@Description2 = CASE WHEN (AC != '') THEN CAST(AC AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments = CASE WHEN (AB != '') THEN CAST(AB AS NVARCHAR(MAX))+ ' - ' + CAST(AK AS NVARCHAR(MAX)) ELSE '_' END
				,@ValueRECDesc = A
				,@valueRECCode = CASE WHEN (P != '') THEN CAST(P AS NVARCHAR(MAX)) ELSE '_' END 
				,@BankCode = C
				,@FEE = 'INVST'
				,@MTD_DATE = '1900-01-01'
				,@GL_ACC_IDENTIFIER = CASE WHEN (E != '') THEN CAST(E AS NVARCHAR(10)) ELSE '_' END 
				,@E_Column = E

				,@CHARGE_01_REF  = BF
				,@CHARGE_01_VALUE  = CASE WHEN (BG != '') THEN  CAST(BG AS Decimal(18,10)) ELSE 0 END
 
				,@CHARGE_02_REF  = BH
				,@CHARGE_02_VALUE  = CASE WHEN (BI != '') THEN  CAST(BI AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_03_REF  = BJ
				,@CHARGE_03_VALUE  = CASE WHEN (BK != '') THEN   CAST(BK AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_04_REF  = BL
				,@CHARGE_04_VALUE  =  CASE WHEN (BM != '') THEN  CAST(BM AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_05_REF  = BN
				,@CHARGE_05_VALUE  =  CASE WHEN (BO != '') THEN  CAST(BO AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_06_REF  = BP
				,@CHARGE_06_VALUE  =  CASE WHEN (BQ != '') THEN  CAST(BQ AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_07_REF  = BR
				,@CHARGE_07_VALUE  =  CASE WHEN (BS != '') THEN  CAST(BS AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_08_REF  = BT
				,@CHARGE_08_VALUE  =  CASE WHEN (BU != '') THEN  CAST(BU AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_09_REF  = BV
				,@CHARGE_09_VALUE  =  CASE WHEN (BW != '') THEN  CAST(BW AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_10_REF  = BX
				,@CHARGE_10_VALUE  =  CASE WHEN ([BY] != '') THEN  CAST([BY] AS Decimal(18,10)) ELSE 0 END
			
				,@CHARGE_TAX_REF  = '333333'
				,@CHARGE_TAX_VALUE  =  CASE WHEN (AJ != '') THEN  CAST(AJ AS Decimal(18,10)) ELSE 0 END

				,@KBEW_ID = ID

	       FROM dbo.RAW_DATA 
	      WHERE ID = @SelectCol1

		  SELECT @SelectCol1 AS F_RW_ID,ID,CAST(Z AS date),Status,ID,AK,A,P,H,* 
		  FROM dbo.RAW_DATA 
	      WHERE ID = @SelectCol1

	   --=====================================VALUE SET 02==============================================================

	    SELECT @Account2 = C
		      ,@SecurityNumber2 = I
		      ,@Quantity2 = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
		      ,@Price2 = CASE WHEN (W != ' ') THEN CAST(W  AS Decimal(18,8)) ELSE 0 END
		      ,@Currency2 = CASE WHEN ( Y != '') THEN CAST(Y  AS nvarchar(50)) ELSE '_' END
		      ,@TransactionDate2 = CASE WHEN (AA != '00000000') THEN CAST( AA AS DATE)  END
		      ,@TRX_DATE2 =  CASE WHEN (Z != '00000000') THEN CAST(Z  AS DATE)  END
		      ,@LinkedNumber2 = AK
	          ,@TransactionAmout2 = CAST((CASE WHEN @Quantity2 = 0 THEN 1 ELSE @Quantity2 END * @Price2) AS Decimal(25,10))  --CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END 
			  ,@DebitCreditStatus2 = T
			  ,@Reversal_Status2  = U
			  ,@Description12 = CASE WHEN (AD != '') THEN CAST(AD AS NVARCHAR(MAX)) ELSE '_' END
			  ,@Description22 = CASE WHEN (AC != '') THEN CAST(AC AS NVARCHAR(MAX)) ELSE '_' END
			  ,@Comments2 = CASE WHEN (AB != '') THEN CAST(AB AS NVARCHAR(MAX)) ELSE '_' END
			  ,@ValueRECDesc2 = A
			  ,@valueRECCode2 = CASE WHEN (P != '') THEN CAST(P AS NVARCHAR(MAX)) ELSE '_' END 
			  ,@BankCode2 = C
			  ,@FEE2 = 'INVST'
			  ,@MTD_DATE2 = '1900-01-01'
			  ,@GL_ACC_IDENTIFIER2 = CASE WHEN (E != '') THEN CAST(E AS NVARCHAR(10)) ELSE '_' END 
		
			  ,@CHARGE_01_REF2  = BF
			  ,@CHARGE_01_VALUE2  = CASE WHEN (BG != '') THEN  CAST(BG AS Decimal(18,10)) ELSE 0 END
 
			  ,@CHARGE_02_REF2  = BH
			  ,@CHARGE_02_VALUE2  = CASE WHEN (BI != '') THEN  CAST(BI AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_03_REF2  = BJ
			  ,@CHARGE_03_VALUE2  = CASE WHEN (BK != '') THEN   CAST(BK AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_04_REF2  = BL
			  ,@CHARGE_04_VALUE2  =  CASE WHEN (BM != '') THEN  CAST(BM AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_05_REF2  = BN
			  ,@CHARGE_05_VALUE2  =  CASE WHEN (BO != '') THEN  CAST(BO AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_06_REF2  = BP
			  ,@CHARGE_06_VALUE2  =  CASE WHEN (BQ != '') THEN  CAST(BQ AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_07_REF2  = BR
			  ,@CHARGE_07_VALUE2  =  CASE WHEN (BS != '') THEN  CAST(BS AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_08_REF2  = BT
			  ,@CHARGE_08_VALUE2  =  CASE WHEN (BU != '') THEN  CAST(BU AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_09_REF2  = BV
			  ,@CHARGE_09_VALUE2  =  CASE WHEN (BW != '') THEN  CAST(BW AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_10_REF2  = BX
			  ,@CHARGE_10_VALUE2  =  CASE WHEN ([BY] != '') THEN  CAST([BY] AS Decimal(18,10)) ELSE 0 END
		
			  ,@CHARGE_TAX_REF2  = '333333'
		      ,@CHARGE_TAX_VALUE2  =  CASE WHEN (AJ != '') THEN  CAST(AJ AS Decimal(18,10)) ELSE 0 END

			  ,@KBEW_ID2 = ID

	     FROM dbo.RAW_DATA 
	    WHERE ID != @SelectCol1
			  AND AK = @LinkedNumber
			  AND A = 'DBEW'
			  --AND P = @valueRECCode
			  --AND H != @Currency
			  AND status = 0

		  SELECT @SelectCol1 AS F_RW_ID,ID,CAST(Z AS date),Status,AK,A,P,H,* 		  
	     FROM dbo.RAW_DATA 
	    WHERE ID != @SelectCol1
			  AND AK = @LinkedNumber
			  AND A = 'DBEW'
			  --AND P = @valueRECCode
			  --AND H != @Currency
			  AND status = 0


	--===============================================================================================================

	SET @REF =  SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber))
	SET @REF2 =  SUBSTRING(@SecurityNumber2, PATINDEX('%[^0]%', @SecurityNumber2+'.'), LEN(@SecurityNumber2))	

	SELECT @CONVERT_VALUE_01 = dbo.Get_EXCHANGE_RATE_FOREX(@Currency,@TRX_DATE)
	SELECT @CONVERT_VALUE_02 = dbo.Get_EXCHANGE_RATE_FOREX(@Currency2,@TRX_DATE)

	Print '@@@CONVERT_VALUE_01    :'+CAST(@CONVERT_VALUE_01 AS VARCHAR)
	Print '@@@CONVERT_VALUE_02    :'+CAST(@CONVERT_VALUE_02 AS VARCHAR)

	Print '@@@@TransactionAmout    :'+CAST(@TransactionAmout AS VARCHAR)
	Print '@@@@TransactionAmout2    :'+CAST(@TransactionAmout2 AS VARCHAR)

	---======================================= INVEQ BLOCK ==========================================================
	
	IF(@TransactionAmout <> 0 AND @TransactionAmout2 <> 0)
	BEGIN

	--print '@@Account2       :'+cast(@Account2 as VARCHAR)
	--============================================= FIRST LINE ======================================================
	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	
	
	--print '@@Account2       :'+cast(@Account2 as VARCHAR)	
	
	--main 
    IF(@Account != '')
		BEGIN
		    
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

				
		IF(@DebitCreditStatus2 = 'S')
		BEGIN
			SET @VALUE2 = ((@TransactionAmout2 +@CHARGE_01_VALUE2+@CHARGE_02_VALUE2+@CHARGE_03_VALUE2+@CHARGE_04_VALUE2+@CHARGE_05_VALUE2+@CHARGE_06_VALUE2+@CHARGE_07_VALUE2+@CHARGE_08_VALUE2+@CHARGE_09_VALUE2+@CHARGE_10_VALUE2+@CHARGE_TAX_VALUE2) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus2 = 'H')		
		BEGIN
			SET @VALUE2 = (@TransactionAmout2 +@CHARGE_01_VALUE2+@CHARGE_02_VALUE2+@CHARGE_03_VALUE2+@CHARGE_04_VALUE2+@CHARGE_05_VALUE2+@CHARGE_06_VALUE2+@CHARGE_07_VALUE2+@CHARGE_08_VALUE2+@CHARGE_09_VALUE2+@CHARGE_10_VALUE2+@CHARGE_TAX_VALUE2)		
		END	


		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE]
           ,[TRNX_TYPE]
           ,[Description_2]
           ,[Amount_2]
           ,[Currency_2])
     VALUES
           (@TRX_DATE
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price2
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,dbo.Get_Bank_Account(@BankCode2,@Currency2)
           ,'220008'+@Currency
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE
		   ,@MTD_DATE
		   ,'F'
		   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
		   ,@VALUE2
		   ,@Currency2)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID2

		END

	--01st charge
	IF(@CHARGE_01_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  01st charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_01_REF)
			   ,'220008'+@Currency
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_01
			   ,@Currency2)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  02nd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1)  AS Decimal(18,10))		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_02_REF)
			   ,'220008'+@Currency
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_02
			   ,@Currency2)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE <> 0)
	BEGIN
		
	    print 'INSIDE  03rd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
				
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10)) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_03_REF)
			   ,'220008'+@Currency
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_03
			   ,@Currency2)


	END

	--04th charge
	IF(@CHARGE_04_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  04h charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_Bank_Account(@BankCode2,@Currency2)
			   ,'220008'+@Currency
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_04
			   ,@Currency2)

	END

	--05th charge
	IF(@CHARGE_05_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  05th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_Bank_Account(@BankCode2,@Currency2)
			   ,'220008'+@Currency
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_05
			   ,@Currency2)

	END

	--06th charge
	IF(@CHARGE_06_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  06th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)   AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_Bank_Account(@BankCode2,@Currency2)
			   ,'220008'+@Currency
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_06
			   ,@Currency2)

	END

	--07th charge
	IF(@CHARGE_07_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  07th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_Bank_Account(@BankCode2,@Currency2)
			   ,'220008'+@Currency
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_07
			   ,@Currency2)


	END

	--08th charge
	IF(@CHARGE_08_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  08th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_Bank_Account(@BankCode2,@Currency2)
			   ,'220008'+@Currency
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_08
			   ,@Currency2)


	END

	--09th charge
	IF(@CHARGE_09_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  09th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_Bank_Account(@BankCode2,@Currency2)
			   ,'220008'+@Currency
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_09
			   ,@Currency2)


	END

	--10th charge
	IF(@CHARGE_10_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  10th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_Bank_Account(@BankCode2,@Currency2)
			   ,'220008'+@Currency
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
		       ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_10
			   ,@Currency2)

	END

	--TAX charge
	IF(@CHARGE_TAX_VALUE <> 0)
	BEGIN
				
		print 'INSIDE  TAX charge      :'+cast(@SelectCol1 as VARCHAR)
		
		print 'Inside TAX'
		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price2
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,'620049'
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_TAX
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE_TAX2
			   ,@Currency2)

	END	

	
	--EXCHANGE
	IF(@CONVERT_VALUE_01 <> 0 OR @CONVERT_VALUE_02 <> 0)
	BEGIN
			
		SET @RCount = @RCount + 1
		
		SET @EX_DIFF = @CONVERT_VALUE_01 - @CONVERT_VALUE_02

		print '@EX_DIFF      :'+CAST(@EX_DIFF AS VARCHAR)
		IF(@EX_DIFF <> 0)
		BEGIN

		SET @VALUE_EX = ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02)
		--SET  = ABS(@F_VALUE_EX)

		print 'ABS(@VALUE * @CONVERT_VALUE_01)      :'+CAST(ABS(@VALUE * @CONVERT_VALUE_01) AS VARCHAR)
		print 'ABS(@VALUE2 * @CONVERT_VALUE_02)      :'+CAST(ABS(@VALUE2 * @CONVERT_VALUE_02) AS VARCHAR)
		print 'ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02)      :'+CAST(ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02) AS VARCHAR)
		print '@VALUE_EX      :'+CAST(@VALUE_EX AS VARCHAR)


	    IF((ABS(@VALUE * @CONVERT_VALUE_01) > ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX > 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE  @DebitCreditStatus = S  :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX)	
				SET @FINAL_VALUE_EX_2 = 0
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX > 0 @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX * -1)	
				SET @FINAL_VALUE_EX_2 = 0
			END
		END
		ELSE IF(( ABS(@VALUE * @CONVERT_VALUE_01) > ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX < 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = s :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0	
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX * -1)
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN	
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0	
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX)
			END	
		END	
		--======================================================================================================
		ELSE IF((ABS(@VALUE * @CONVERT_VALUE_01) < ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX > 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX > 0  @DebitCreditStatus = S :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX)
				SET @FINAL_VALUE_EX_2 = 0	
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX > 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX * -1)
				SET @FINAL_VALUE_EX_2 = 0	
			END	
		END
		ELSE IF((ABS(@VALUE * @CONVERT_VALUE_01) < ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX < 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = S :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX)
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX* -1 )
			END	
		END
		--======================================================================================================

					
		IF(@VALUE_EX < 0)
		BEGIN
			SET @EX_ACCOUNT = '780001'
		END	
		
		IF(@VALUE_EX > 0)
		BEGIN
			SET @EX_ACCOUNT = '680001'			
		END	



		Print '@@@EX_ACCOUNT    :'+CAST(@EX_ACCOUNT AS VARCHAR)
		 
		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TRX_DATE
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@EX_ACCOUNT
			   ,@EX_ACCOUNT
			   ,@FINAL_VALUE_EX
			   ,'USD'
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@FINAL_VALUE_EX_2
			   ,'USD')
		
		END
	END	
	

	END -- CHECK Both 2 values are NOT = 0

	END 
	
	END -- BANK ACCOUNT


	--END TRY
	----================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FTC_FPC]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FTC_FPC]
AS
BEGIN	
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(255)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,10)
	DECLARE @Price decimal(18,10)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate Date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(18,10)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE Date
	DECLARE @MTD_DATE Date
	DECLARE @AccID varchar(50)
	DECLARE @TransactionTypeIdentification nvarchar(50)
	DECLARE @ReversalIdentification nvarchar(50)
	DECLARE @UNIT_PRICE_STATUS nvarchar(50)
	DECLARE @TEMP_QUANTITY Decimal(18,10)
	DECLARE @AmountTransaction decimal(18,10)
	DECLARE @DepositType VARCHAR(10)
	DECLARE @REF varchar(50)
	DECLARE @VALUE decimal(25,10)
	DECLARE @FEE varchar(10)
	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,10)
	DECLARE @RCount int
	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,10)
	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,10)
	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,10)
	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,10)
	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,10)
	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,10)
	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,10)
	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,10)
	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,10)
	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,10)
	DECLARE @VALUE_01 Decimal(18,10)
	DECLARE @VALUE_02 Decimal(18,10)
	DECLARE @VALUE_03 Decimal(18,10)
	DECLARE @VALUE_04 Decimal(18,10)
	DECLARE @VALUE_05 Decimal(18,10)
	DECLARE @VALUE_06 Decimal(18,10)
	DECLARE @VALUE_07 Decimal(18,10)
	DECLARE @VALUE_08 Decimal(18,10)
	DECLARE @VALUE_09 Decimal(18,10)
	DECLARE @VALUE_10 Decimal(18,10)
	DECLARE @LODH_BANK_ACCOUNT Varchar(50)	
	DECLARE @F_QUANTITY Decimal(18,10)
	--BEGIN TRY
	--================================ Start TRY ====================================
	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50) )  

	INSERT into @table1 (col1,AccID) SELECT ID,A from [dbo].[RAW_DATA_LODH] where (I = 'FPC' OR I = 'FTC') AND AG != 0 AND status = 0 order BY CAST(M AS DATE) ASC

	SET @RowsToProcess=@@ROWCOUNT
	SET @CurrentRow=0

	WHILE @CurrentRow<@RowsToProcess
	BEGIN

    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@AccID = AccID FROM @table1 WHERE RowID=@CurrentRow	
	SET @IncVal = @IncVal + dbo.RandFn()

	SET @TEMP_QUANTITY = 0
	SET @Quantity = 0
	SET @Price = 0

	print '@AccID  :'+cast(@AccID as varchar)	

	IF(dbo.Get_Map_Company_From_Bank_Account(LEFT(@AccID,8)) = 'CORYELL')
	BEGIN
		
		  SELECT @Account = CASE WHEN (A != ' ') THEN CAST(A AS nvarchar) ELSE '_' END
				,@Price =   CASE WHEN (W != '') THEN CAST(W AS Decimal(18,10)) ELSE 0 END
				,@TEMP_QUANTITY = CASE WHEN (V != '') THEN CAST(V AS Decimal(18,10)) ELSE 0 END
				,@AmountTransaction = CASE WHEN (R != '') THEN CAST(R AS Decimal(18,10)) ELSE 0 END
				,@Currency = CASE WHEN ( X != ' ') THEN  X ELSE '_' END
				,@TransactionDate = CASE WHEN ( L != ' ') THEN CAST(L AS date) ELSE '_' END
				,@TRX_DATE = CASE WHEN ( K != ' ') THEN CAST(K AS date)  ELSE '' END
				,@MTD_DATE = CASE WHEN ( N != ' ') THEN CAST(N AS date)  ELSE '' END
				,@DebitCreditStatus = CASE WHEN (O  != ' ') THEN O  ELSE '_' END
				,@Description = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@valueRECCode = CASE WHEN (I != ' ') THEN I ELSE '_' END      ------------------------------------------------------------> Category Criteria
				,@TransactionTypeIdentification = CASE WHEN (AD != ' ') THEN AD ELSE '_' END       -----------------------------------------> Category Criteria
				,@ReversalIdentification = CASE WHEN (P != ' ') THEN P ELSE '_' END
				,@FEE = ''
				,@SecurityNumber = CASE WHEN (AB != '') THEN AB ELSE '_' END
				,@UNIT_PRICE_STATUS = AE
				,@DepositType = CASE WHEN (Z != '') THEN CAST(Z AS NVARCHAR(10)) ELSE '' END

				,@CHARGE_01_REF  = 'STD'
				,@CHARGE_01_VALUE  = CASE WHEN (AR != '') THEN  CAST(AR AS Decimal(18,10)) ELSE 0 END
 
				,@CHARGE_02_REF  = 'INT'
				,@CHARGE_02_VALUE  = CASE WHEN ([AS] != '') THEN  CAST([AS] AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_03_REF  = 'TAX' --TAX
				,@CHARGE_03_VALUE  = CASE WHEN (AT != '') THEN   CAST(AT AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_04_REF  = 'BRK'
				,@CHARGE_04_VALUE  =  CASE WHEN (AU != '') THEN  CAST(AU AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_05_REF  = 'BRK'
				,@CHARGE_05_VALUE  =  CASE WHEN (AV != '') THEN  CAST(AV AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_06_REF  = 'TAX' --TAX
				,@CHARGE_06_VALUE  =  CASE WHEN (AW != '') THEN  CAST(AW AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_07_REF  = 'TAX' --TAX
				,@CHARGE_07_VALUE  =  CASE WHEN (AX != '') THEN  CAST(AX AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_08_REF  = 'OTH'
				,@CHARGE_08_VALUE  =  CASE WHEN (AY != '') THEN  CAST(AY AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_09_REF  = 'OTH'
				,@CHARGE_09_VALUE  =  CASE WHEN (AZ != '') THEN  CAST(AZ AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_10_REF  = 'OTH'
				,@CHARGE_10_VALUE  = CASE WHEN (BA != '') THEN  CAST(BA AS Decimal(18,10)) ELSE 0 END
	  
			FROM dbo.RAW_DATA_LODH 
			WHERE ID = @SelectCol1


			--print '@@@@Account  *********************************:'+ cast(@Account as varchar)
			--print '@@Quantity  *********************************:'+ cast(@Quantity as varchar)

		SET @REF =  CASE WHEN (@SecurityNumber != '_') THEN SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber)) ELSE '' END

		IF(@UNIT_PRICE_STATUS = '00')
		BEGIN
			SET @Quantity = CASE WHEN (@TEMP_QUANTITY != 0) THEN  (@TEMP_QUANTITY) ELSE 0 END
		END
		ELSE IF(@UNIT_PRICE_STATUS = '01')
		BEGIN
			SET @Quantity = CASE WHEN (@TEMP_QUANTITY != 0) THEN  (@TEMP_QUANTITY/100) ELSE 0 END
		END

		SET @F_QUANTITY = CASE WHEN (@Quantity = 0) THEN 1 ELSE @Quantity END
		
		SET @TransactionAmout = CASE WHEN (@Price != 0) AND (@F_QUANTITY != 0)  THEN  (@Price * @F_QUANTITY) ELSE 0 END
		
		print '@TransactionAmout          : '+CAST(@TransactionAmout AS VARCHAR)
	
		IF(@valueRECCode = 'FPC')    ----------------------------- > CALL
		BEGIN
		
		--print '@@@@Account INSIDE OSR *********************************:'+ cast(@Account as varchar)
	
		set @FEE = 'INI'
		SET @IncVal = @IncVal + dbo.RandFn()

		IF(LEFT(@Account,8) = '48425 A0')
		BEGIN
			SET @LODH_BANK_ACCOUNT = '511115'
		END
		ELSE
		BEGIN
			SET @LODH_BANK_ACCOUNT = '511114'
		END


		IF(@DebitCreditStatus = 'D')
		BEGIN		
			SET @TOP = 'BUY'
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @TOP = 'SELL'
		END	

		IF(@DepositType = '01' OR @DepositType = '04' OR @DepositType = '06' )---------------------> INCREASE 
		BEGIN 

			--main
		    IF(@Account != '')
	        BEGIN
	
			SET @RCount = 1

			--IF(@DebitCreditStatus = 'D')
			--BEGIN
			SET @VALUE = (@AmountTransaction * -1) 		
			--END	
			--ELSE IF(@DebitCreditStatus = 'C')		
			--BEGIN
			--	SET @VALUE = @TransactionAmout		
			--END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,'511214'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			   UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END
		
		END
		ELSE IF(@DepositType = '05' OR @DepositType = '07' OR @DepositType = '08' )---------------------> DECREASE
		BEGIN 
				
	    --main
		IF(@Account != '')
		BEGIN
	
			SET @RCount = 1

			--IF(@DebitCreditStatus = 'D')
			--BEGIN
			--	SET @VALUE = (@TransactionAmout * -1) 		
			--END	
			--ELSE IF(@DebitCreditStatus = 'C')		
			--BEGIN
				SET @VALUE = @AmountTransaction		
			--END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,'511214'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

		END
		ELSE IF(@DepositType = '02')---------------------> INCOME
		BEGIN 
				
			--main
		    IF(@Account != '')
			BEGIN	

			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = ((@AmountTransaction + @CHARGE_01_VALUE + @CHARGE_02_VALUE + @CHARGE_03_VALUE + @CHARGE_04_VALUE + @CHARGE_05_VALUE + @CHARGE_06_VALUE + @CHARGE_07_VALUE + @CHARGE_08_VALUE + @CHARGE_09_VALUE + @CHARGE_10_VALUE ) * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = (@AmountTransaction + @CHARGE_01_VALUE + @CHARGE_02_VALUE + @CHARGE_03_VALUE + @CHARGE_04_VALUE + @CHARGE_05_VALUE + @CHARGE_06_VALUE + @CHARGE_07_VALUE + @CHARGE_08_VALUE + @CHARGE_09_VALUE + @CHARGE_10_VALUE )		
			END	

			print '@SelectCol1         :'+CAST(@SelectCol1 AS VARCHAR)
			print '===================================================================='
			print '@@TransactionDate         :'+CAST(@TransactionDate AS VARCHAR)
			print '@@Description         :'+CAST(@Description AS VARCHAR)
			print '@BNK_CODE         :'+CAST(dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode) AS VARCHAR)
			print '@@FEE         :'+CAST(@FEE AS VARCHAR)
			print '@@Price         :'+CAST(@Price AS VARCHAR)
			print '@@Quantity         :'+CAST(@Quantity AS VARCHAR)
			print '@@REF         :'+CAST(@REF AS VARCHAR)
			print '@@TOP         :'+CAST(@TOP AS VARCHAR)
			print '@@FEE         :'+CAST(@FEE AS VARCHAR)
			print '770102'
			print '@ACC         :'+CAST(dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode) AS VARCHAR)
			print '@@VALUE         :'+CAST(@VALUE AS VARCHAR)
			print '@@Currency         :'+CAST(@Currency AS VARCHAR)
			print '@SEC ID         :'+CAST(CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2) AS VARCHAR)
			print '@@RCount         :'+CAST(@RCount AS VARCHAR)
			print '0'
			print '@@Comments         :'+CAST(@Comments AS VARCHAR)
			print '@@TRX_DATE         :'+CAST(@TRX_DATE AS VARCHAR)
			print '@@MTD_DATE         :'+CAST(@MTD_DATE AS VARCHAR)
			print '===================================================================='

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,'770102'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

		END

		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	    --02nd charge
	    IF(@CHARGE_02_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
     	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END



	END
	    ELSE IF(@valueRECCode = 'FTC')    ----------------------------- > FD
	    BEGIN
	
		print '@@@@Account INSIDE OSR *********************************:'+ cast(@Account as varchar)
	
		set @FEE = 'INI'
		SET @IncVal = @IncVal + dbo.RandFn()

		IF(LEFT(@Account,8) = '48425 A0')
		BEGIN
			SET @LODH_BANK_ACCOUNT = '511115'
		END
		ELSE
		BEGIN
			SET @LODH_BANK_ACCOUNT = '511114'
		END


		IF(@DebitCreditStatus = 'D')
		BEGIN		
			SET @TOP = 'BUY'
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @TOP = 'SELL'
		END	

		IF(@DepositType = '01' OR @DepositType = '04' OR @DepositType = '06' )---------------------> INCOME
		BEGIN 
		    
		   --main
		   IF(@Account != '')
		   BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,'511314'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END
		
		END
		ELSE IF(@DepositType = '05' OR @DepositType = '07' OR @DepositType = '08' )---------------------> INCOME
		BEGIN	
				
			--main
		    IF(@Account != '')
			BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,'511314'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

		END
		ELSE IF(@DepositType = '02')---------------------> INCOME
		BEGIN	
				
			--main
		    IF(@Account != '')
			BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = ((@TransactionAmout + @CHARGE_01_VALUE + @CHARGE_02_VALUE + @CHARGE_03_VALUE + @CHARGE_04_VALUE + @CHARGE_05_VALUE + @CHARGE_06_VALUE + @CHARGE_07_VALUE + @CHARGE_08_VALUE + @CHARGE_09_VALUE + @CHARGE_10_VALUE ) * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = (@TransactionAmout + @CHARGE_01_VALUE + @CHARGE_02_VALUE + @CHARGE_03_VALUE + @CHARGE_04_VALUE + @CHARGE_05_VALUE + @CHARGE_06_VALUE + @CHARGE_07_VALUE + @CHARGE_08_VALUE + @CHARGE_09_VALUE + @CHARGE_10_VALUE )		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,'770102'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

		END


		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	    --02nd charge
	    IF(@CHARGE_02_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
     	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END


	END
    
	END

	END --end in while



	--END TRY
	--================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FOREX]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_FOREX]
AS
BEGIN	
	--=================================== SECOND LINE VARIABLE =============================================
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(255)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,10)
	DECLARE @Price decimal(18,10)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate Date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(18,10)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE Date
	DECLARE @MTD_DATE Date
	DECLARE @AccID varchar(50)
	DECLARE @TransactionTypeIdentification nvarchar(50)
	DECLARE @ReversalIdentification nvarchar(50)
	DECLARE @UNIT_PRICE_STATUS nvarchar(50)
	DECLARE @TEMP_QUANTITY Decimal(18,10)
	DECLARE @AmountTransaction decimal(18,10)
	DECLARE @DepositType VARCHAR(10)
	DECLARE @REF varchar(50)
	DECLARE @VALUE decimal(25,10)
	DECLARE @FEE varchar(10)
	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,10)
	DECLARE @RCount int
	DECLARE @CHK_Account varchar(50)
	DECLARE @TRDATE date
	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,10)
	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,10)
	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,10)
	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,10)
	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,10)
	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,10)
	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,10)
	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,10)
	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,10)
	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,10)
	DECLARE @VALUE_01 Decimal(18,10)
	DECLARE @VALUE_02 Decimal(18,10)
	DECLARE @VALUE_03 Decimal(18,10)
	DECLARE @VALUE_04 Decimal(18,10)
	DECLARE @VALUE_05 Decimal(18,10)
	DECLARE @VALUE_06 Decimal(18,10)
	DECLARE @VALUE_07 Decimal(18,10)
	DECLARE @VALUE_08 Decimal(18,10)
	DECLARE @VALUE_09 Decimal(18,10)
	DECLARE @VALUE_10 Decimal(18,10)	
	DECLARE @D_COLUMN varchar(10)
	DECLARE @LINK_ID varchar(50)

	--=================================== SECOND LINE VARIABLE =============================================
	DECLARE @DBEWorKBEW2 nvarchar(50)
	DECLARE @Account2 nvarchar(255)
	DECLARE @SecurityNumber2 nvarchar(50)
	DECLARE @Quantity2 decimal(18,10)
	DECLARE @Price2 decimal(18,10)
	DECLARE @Currency2 nvarchar(50)
	DECLARE @TransactionDate2 Date
	DECLARE @Description12 nvarchar(250) -- need to select transaction record
	DECLARE @Description22 nvarchar(250)
	DECLARE @LinkedNumber2 nvarchar(150)	
	DECLARE @DebitCreditStatus2 nvarchar(10)	
	DECLARE @TransactionAmout2 decimal(18,10)
	DECLARE @ValueRECDesc2 varchar(50)
	DECLARE @valueRECCode2 varchar(50)
	DECLARE @BankCode2 varchar(50)
	DECLARE @TOP2 varchar(50) 
	DECLARE @Comments2 nvarchar(250)
	DECLARE @TRX_DATE2 Date
	DECLARE @MTD_DATE2 Date
	DECLARE @AccID2 varchar(50)
	DECLARE @TransactionTypeIdentification2 nvarchar(50)
	DECLARE @ReversalIdentification2 nvarchar(50)
	DECLARE @UNIT_PRICE_STATUS2 nvarchar(50)
	DECLARE @TEMP_QUANTITY2 Decimal(18,10)
	DECLARE @AmountTransaction2 decimal(18,10)
	DECLARE @DepositType2 VARCHAR(10)
	DECLARE @REF2 varchar(50)
	DECLARE @VALUE2 decimal(25,10)
	DECLARE @FEE2 varchar(10)
	DECLARE @RowsToProcess2  int
	DECLARE @CurrentRow2     int
	DECLARE @SelectCol12     int
	DECLARE @IncVal2 decimal(18,10)
	DECLARE @RCount2 int
	DECLARE @CHARGE_01_REF2 varchar(50)
	DECLARE @CHARGE_01_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_02_REF2 varchar(50)
	DECLARE @CHARGE_02_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_03_REF2 varchar(50)
	DECLARE @CHARGE_03_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_04_REF2 varchar(50)
	DECLARE @CHARGE_04_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_05_REF2 varchar(50)
	DECLARE @CHARGE_05_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_06_REF2 varchar(50)
	DECLARE @CHARGE_06_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_07_REF2 varchar(50)
	DECLARE @CHARGE_07_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_08_REF2 varchar(50)
	DECLARE @CHARGE_08_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_09_REF2 varchar(50)
	DECLARE @CHARGE_09_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_10_REF2 varchar(50)
	DECLARE @CHARGE_10_VALUE2 Decimal(18,10)
	DECLARE @VALUE2_01 Decimal(18,10)
	DECLARE @VALUE2_02 Decimal(18,10)
	DECLARE @VALUE2_03 Decimal(18,10)
	DECLARE @VALUE2_04 Decimal(18,10)
	DECLARE @VALUE2_05 Decimal(18,10)
	DECLARE @VALUE2_06 Decimal(18,10)
	DECLARE @VALUE2_07 Decimal(18,10)
	DECLARE @VALUE2_08 Decimal(18,10)
	DECLARE @VALUE2_09 Decimal(18,10)
	DECLARE @VALUE2_10 Decimal(18,10)
	DECLARE @D_COLUMN2 varchar(10)
	DECLARE @SECOND_RW_ID INT
	DECLARE @LODH_BANK_ACCOUNT Varchar(50)

	DECLARE @CONVERT_VALUE_01 decimal(18,10)
	DECLARE @CONVERT_VALUE_02 decimal(18,10)
	DECLARE @EX_DIFF  decimal(18,10)
	DECLARE @VALUE_EX decimal(25,10)
	DECLARE @FINAL_VALUE_EX  decimal(25,10)
	DECLARE @FINAL_VALUE_EX_2  decimal(25,10)
	DECLARE @EX_ACCOUNT Varchar(50)

	--===================================================================================================================
	--BEGIN TRY
	--================================ Start TRY ====================================
	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50))  
	INSERT into @table1 (col1,AccID) SELECT min(ID),LEFT(A,8)  from [dbo].[RAW_DATA_LODH] where (I = 'DCC' OR I = 'DTC') AND D != 'MA' AND status = 0 GROUP BY LEFT(A,8),I,D,M  order BY CAST(M AS DATE) ASC
	SET @RowsToProcess=@@ROWCOUNT
	SET @CurrentRow=0
	WHILE @CurrentRow<@RowsToProcess
	BEGIN
    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@CHK_Account = AccID FROM @table1 WHERE RowID=@CurrentRow	
	
	IF((RTrim(dbo.Get_Map_Company_From_Bank_Account(@CHK_Account)) = 'CORYELL'))
	BEGIN
	--==============================================================================

	SET @IncVal = @IncVal + dbo.RandFn()

	--==============================================================================
		SET   @TransactionAmout = 0
		SET   @DebitCreditStatus = ''
		SET   @Description = ''
		SET   @Description2 = ''
		SET   @Comments = ''
		SET   @ValueRECDesc = ''
		SET   @valueRECCode = ''
		SET   @BankCode = ''
		SET   @FEE = ''
		SET   @MTD_DATE = ''		
		SET   @CHARGE_01_REF  = ''
		SET   @CHARGE_01_VALUE  = 0 
		SET   @CHARGE_02_REF  = ''
		SET   @CHARGE_02_VALUE  = 0
		SET   @CHARGE_03_REF  = ''
		SET   @CHARGE_03_VALUE  = 0
		SET   @CHARGE_04_REF  = ''
		SET   @CHARGE_04_VALUE  = 0
		SET   @CHARGE_05_REF  = ' '
		SET   @CHARGE_05_VALUE  =  0
		SET   @CHARGE_06_REF  = ''
		SET   @CHARGE_06_VALUE  =  0
		SET   @CHARGE_07_REF  = ''
		SET   @CHARGE_07_VALUE  =  0
		SET   @CHARGE_08_REF  = ''
		SET   @CHARGE_08_VALUE  =  0
		SET   @CHARGE_09_REF  = ''
		SET   @CHARGE_09_VALUE  =  0
		SET   @CHARGE_10_REF  = ''
		SET   @CHARGE_10_VALUE  =  0	
		
		SET   @TransactionAmout2 = 0
		SET   @DebitCreditStatus2 = ''
		SET   @Description12 = ''
		SET   @Description22 = ''
		SET   @Comments2 = ''
		SET   @ValueRECDesc2 = ''
		SET   @valueRECCode2 = ''
		SET   @BankCode2 = ''
		SET   @FEE2 = ''
		SET   @MTD_DATE2 = ''		
		SET   @CHARGE_01_REF2  = ''
		SET   @CHARGE_01_VALUE2  = 0 
		SET   @CHARGE_02_REF2  = ''
		SET   @CHARGE_02_VALUE2  = 0
		SET   @CHARGE_03_REF2  = ''
		SET   @CHARGE_03_VALUE2  = 0
		SET   @CHARGE_04_REF2  = ''
		SET   @CHARGE_04_VALUE2  = 0
		SET   @CHARGE_05_REF2  = ' '
		SET   @CHARGE_05_VALUE2  =  0
		SET   @CHARGE_06_REF2  = ''
		SET   @CHARGE_06_VALUE2  =  0
		SET   @CHARGE_07_REF2  = ''
		SET   @CHARGE_07_VALUE2  =  0
		SET   @CHARGE_08_REF2  = ''
		SET   @CHARGE_08_VALUE2  =  0
		SET   @CHARGE_09_REF2  = ''
		SET   @CHARGE_09_VALUE2  =  0
		SET   @CHARGE_10_REF2  = ''
		SET   @CHARGE_10_VALUE2  =  0	

		--===================================START VALUE SET 01 =====================================================
		--============================================FIRST RECORD SET=========================================================================================

		  SELECT @Account = CASE WHEN (A != ' ') THEN CAST(A AS nvarchar) ELSE '_' END
				,@Price =   CASE WHEN (W != '') THEN CAST(W AS Decimal(18,10)) ELSE 0 END
				,@TEMP_QUANTITY = CASE WHEN (V != '') THEN CAST(V AS Decimal(18,10)) ELSE 0 END
				,@AmountTransaction = CASE WHEN (R != '') THEN CAST(R AS Decimal(18,10)) ELSE 0 END
				,@Currency = CASE WHEN ( X != ' ') THEN  X ELSE '_' END
				,@TransactionDate = CASE WHEN ( L != ' ') THEN CAST(L AS date) ELSE '_' END
				,@TRX_DATE = CASE WHEN ( K != ' ') THEN CAST(K AS date)  ELSE '' END
				,@MTD_DATE = CASE WHEN ( N != ' ') THEN CAST(N AS date)  ELSE '' END
				,@DebitCreditStatus = CASE WHEN (O  != ' ') THEN O  ELSE '_' END
				,@Description = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@valueRECCode = CASE WHEN (I != ' ') THEN I ELSE '_' END      ------------------------------------------------------------> Category Criteria
				,@TransactionTypeIdentification = CASE WHEN (AD != ' ') THEN AD ELSE '_' END       -----------------------------------------> Category Criteria
				,@ReversalIdentification = CASE WHEN (P != ' ') THEN P ELSE '_' END
				,@FEE = ''
				,@SecurityNumber = CASE WHEN (AB != '') THEN AB ELSE '_' END
				,@UNIT_PRICE_STATUS = AE
				,@DepositType = Z
				,@D_COLUMN = CASE WHEN (D != '') THEN D ELSE '_' END
				,@LINK_ID = AL

				,@CHARGE_01_REF  = 'STD'
				,@CHARGE_01_VALUE  = CASE WHEN (AR != '') THEN  CAST(AR AS Decimal(18,10)) ELSE 0 END
 
				,@CHARGE_02_REF  = 'INT'
				,@CHARGE_02_VALUE  = CASE WHEN ([AS] != '') THEN  CAST([AS] AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_03_REF  = 'OTH' --TAX
				,@CHARGE_03_VALUE  = CASE WHEN (AT != '') THEN   CAST(AT AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_04_REF  = 'BRK'
				,@CHARGE_04_VALUE  =  CASE WHEN (AU != '') THEN  CAST(AU AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_05_REF  = 'BRK'
				,@CHARGE_05_VALUE  =  CASE WHEN (AV != '') THEN  CAST(AV AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_06_REF  = 'OTH' --TAX
				,@CHARGE_06_VALUE  =  CASE WHEN (AW != '') THEN  CAST(AW AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_07_REF  = 'OTH' --TAX
				,@CHARGE_07_VALUE  =  CASE WHEN (AX != '') THEN  CAST(AX AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_08_REF  = 'OTH'
				,@CHARGE_08_VALUE  =  CASE WHEN (AY != '') THEN  CAST(AY AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_09_REF  = 'OTH'
				,@CHARGE_09_VALUE  =  CASE WHEN (AZ != '') THEN  CAST(AZ AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_10_REF  = 'OTH'
				,@CHARGE_10_VALUE  = CASE WHEN (BA != '') THEN  CAST(BA AS Decimal(18,10)) ELSE 0 END
	  
			FROM dbo.RAW_DATA_LODH 
			WHERE ID = @SelectCol1

			--SELECT * 
			--FROM dbo.RAW_DATA_LODH 
			--WHERE ID = @SelectCol1


	   --============================================SECOND RECORD SET=========================================================================================
		  
		  SELECT @Account2 = CASE WHEN (A != ' ') THEN CAST(A AS nvarchar) ELSE '_' END
				,@Price2 =   CASE WHEN (W != '') THEN CAST(W AS Decimal(18,10)) ELSE 0 END
				,@TEMP_QUANTITY2 = CASE WHEN (V != '') THEN CAST(V AS Decimal(18,10)) ELSE 0 END
				,@AmountTransaction2 = CASE WHEN (R != '') THEN CAST(R AS Decimal(18,10)) ELSE 0 END
				,@Currency2 = CASE WHEN ( X != ' ') THEN  X ELSE '_' END
				,@TransactionDate2 = CASE WHEN ( L != ' ') THEN CAST(L AS date) ELSE '_' END
				,@TRX_DATE2 = CASE WHEN ( K != ' ') THEN CAST(K AS date)  ELSE '' END
				,@MTD_DATE2 = CASE WHEN ( N != ' ') THEN CAST(N AS date)  ELSE '' END
				,@DebitCreditStatus2 = CASE WHEN (O  != ' ') THEN O  ELSE '_' END
				,@Description2 = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments2 = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@valueRECCode2 = CASE WHEN (I != ' ') THEN I ELSE '_' END      ------------------------------------------------------------> Category Criteria
				,@TransactionTypeIdentification2 = CASE WHEN (AD != ' ') THEN AD ELSE '_' END       -----------------------------------------> Category Criteria
				,@ReversalIdentification2 = CASE WHEN (P != ' ') THEN P ELSE '_' END
				,@FEE2 = ''
				,@SecurityNumber2 = CASE WHEN (AB != '') THEN AB ELSE '_' END
				,@UNIT_PRICE_STATUS2 = AE
				,@DepositType2 = Z
				,@D_COLUMN2 = CASE WHEN (D != '') THEN D ELSE '_' END

				,@CHARGE_01_REF2  = 'STD'
				,@CHARGE_01_VALUE2  = CASE WHEN (AR != '') THEN  CAST(AR AS Decimal(18,10)) ELSE 0 END
 
				,@CHARGE_02_REF2  = 'INT'
				,@CHARGE_02_VALUE2  = CASE WHEN ([AS] != '') THEN  CAST([AS] AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_03_REF2  = 'OTH' --TAX
				,@CHARGE_03_VALUE2  = CASE WHEN (AT != '') THEN   CAST(AT AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_04_REF2  = 'BRK'
				,@CHARGE_04_VALUE2  =  CASE WHEN (AU != '') THEN  CAST(AU AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_05_REF2  = 'BRK'
				,@CHARGE_05_VALUE2  =  CASE WHEN (AV != '') THEN  CAST(AV AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_06_REF2  = 'OTH' --TAX
				,@CHARGE_06_VALUE2  =  CASE WHEN (AW != '') THEN  CAST(AW AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_07_REF2  = 'OTH' --TAX
				,@CHARGE_07_VALUE2  =  CASE WHEN (AX != '') THEN  CAST(AX AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_08_REF2  = 'OTH'
				,@CHARGE_08_VALUE2  =  CASE WHEN (AY != '') THEN  CAST(AY AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_09_REF2  = 'OTH'
				,@CHARGE_09_VALUE2  =  CASE WHEN (AZ != '') THEN  CAST(AZ AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_10_REF2  = 'OTH'
				,@CHARGE_10_VALUE2  = CASE WHEN (BA != '') THEN  CAST(BA AS Decimal(18,10)) ELSE 0 END
				
				,@SECOND_RW_ID = ID

			FROM dbo.RAW_DATA_LODH
			WHERE  ID != @SelectCol1
				  AND status = 0
				  AND LEFT(A,8) = LEFT(@Account,8)
				  AND AL = @LINK_ID 
				  AND D = @D_COLUMN
				  AND CAST(L AS date) = CAST(@TransactionDate AS VARCHAR)

			--SELECT * 
			--FROM dbo.RAW_DATA_LODH
			--WHERE  ID != @SelectCol1
			--	  AND status = 0
			--	  AND LEFT(A,8) = LEFT(@Account,8)
			--	  AND AL = @LINK_ID 
			--	  --AND AB = @SecurityNumber
			--	  AND CAST(L AS date) = CAST(@TransactionDate AS VARCHAR)

	   --===============================================================================================================

	SET @REF =  SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber))
	SET @REF2 =  SUBSTRING(@SecurityNumber2, PATINDEX('%[^0]%', @SecurityNumber2+'.'), LEN(@SecurityNumber2))	

	SELECT @CONVERT_VALUE_01 = dbo.Get_EXCHANGE_RATE_FOREX(@Currency,@TRX_DATE)
	SELECT @CONVERT_VALUE_02 = dbo.Get_EXCHANGE_RATE_FOREX(@Currency2,@TRX_DATE)

	SET @Quantity = @TEMP_QUANTITY
	SET @Quantity2 = @TEMP_QUANTITY2

	Print '@@@CONVERT_VALUE_01    :'+CAST(@CONVERT_VALUE_01 AS VARCHAR)
	Print '@@@CONVERT_VALUE_02    :'+CAST(@CONVERT_VALUE_02 AS VARCHAR)

	---======================================= INVEQ BLOCK ==========================================================
	
	--IF(@valueRECCode = 'EA' OR @valueRECCode = 'EA')
	--BEGIN

	--print '@@Account2       :'+cast(@Account2 as VARCHAR)
	--============================================= FIRST LINE ======================================================
	IF(@DebitCreditStatus = 'C')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'D')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	
		
		--main
		IF(@Account != '')
		BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'C')
		BEGIN
			SET @VALUE = ((@AmountTransaction +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'D')		
		BEGIN
			SET @VALUE = (@AmountTransaction +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE)		
		END	

				
		IF(@DebitCreditStatus2 = 'C')
		BEGIN
			SET @VALUE2 = ((@AmountTransaction2 +@CHARGE_01_VALUE2+@CHARGE_02_VALUE2+@CHARGE_03_VALUE2+@CHARGE_04_VALUE2+@CHARGE_05_VALUE2+@CHARGE_06_VALUE2+@CHARGE_07_VALUE2+@CHARGE_08_VALUE2+@CHARGE_09_VALUE2+@CHARGE_10_VALUE2) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus2 = 'D')		
		BEGIN
			SET @VALUE2 = (@AmountTransaction2 +@CHARGE_01_VALUE2+@CHARGE_02_VALUE2+@CHARGE_03_VALUE2+@CHARGE_04_VALUE2+@CHARGE_05_VALUE2+@CHARGE_06_VALUE2+@CHARGE_07_VALUE2+@CHARGE_08_VALUE2+@CHARGE_09_VALUE2+@CHARGE_10_VALUE2)		
		END	

		print '@VALUE     :'+CAST(@VALUE AS VARCHAR)
		print '@VALUE2     :'+CAST(@VALUE2 AS VARCHAR)

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
			VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency2,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2
			   ,@Currency2)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_01
			   ,@Currency2)


	END

	    --02nd charge
	    IF(@CHARGE_02_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_02
			   ,@Currency2)

	END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_03
			   ,@Currency2)


	END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_04
			   ,@Currency2)

	END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_05
			   ,@Currency2)

	END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_06
			   ,@Currency2)

	END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_07
			   ,@Currency2)


	END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
     	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_08
			   ,@Currency2)


	END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_09
			   ,@Currency2)


	END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE
			   ,'F'
			   ,@Description2
			   ,@VALUE2_10
			   ,@Currency2)

	END
	
	    --EXCHANGE
	    IF(@CONVERT_VALUE_01 <> 0 OR @CONVERT_VALUE_02 <> 0)
	    BEGIN
			
		SET @RCount = @RCount + 1
		
		SET @EX_DIFF = @CONVERT_VALUE_01 - @CONVERT_VALUE_02

		SET @VALUE_EX = ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02)
		--SET  = ABS(@F_VALUE_EX)

		print 'ABS(@VALUE * @CONVERT_VALUE_01)      :'+CAST(ABS(@VALUE * @CONVERT_VALUE_01) AS VARCHAR)
		print 'ABS(@VALUE2 * @CONVERT_VALUE_02)      :'+CAST(ABS(@VALUE2 * @CONVERT_VALUE_02) AS VARCHAR)
		print 'ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02)      :'+CAST(ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02) AS VARCHAR)
		print '@VALUE_EX      :'+CAST(@VALUE_EX AS VARCHAR)


	    IF((ABS(@VALUE * @CONVERT_VALUE_01) > ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX > 0))
		BEGIN
			IF(@DebitCreditStatus = 'C')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE  @DebitCreditStatus = S  :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX)	
				SET @FINAL_VALUE_EX_2 = 0
			END
			ELSE IF(@DebitCreditStatus = 'D')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX > 0 @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX * -1)	
				SET @FINAL_VALUE_EX_2 = 0
			END
		END
		ELSE IF(( ABS(@VALUE * @CONVERT_VALUE_01) > ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX < 0))
		BEGIN
			IF(@DebitCreditStatus = 'C')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = s :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0	
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX * -1)
			END
			ELSE IF(@DebitCreditStatus = 'D')
			BEGIN	
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0	
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX)
			END	
		END	--===========================================================================================
		ELSE IF((ABS(@VALUE * @CONVERT_VALUE_01) < ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX > 0))
		BEGIN
			IF(@DebitCreditStatus = 'C')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX > 0  @DebitCreditStatus = S :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX)
				SET @FINAL_VALUE_EX_2 = 0	
			END
			ELSE IF(@DebitCreditStatus = 'D')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX > 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX * -1)
				SET @FINAL_VALUE_EX_2 = 0	
			END	
		END
		ELSE IF((ABS(@VALUE * @CONVERT_VALUE_01) < ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX < 0))
		BEGIN
			IF(@DebitCreditStatus = 'C')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = S :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX)
			END
			ELSE IF(@DebitCreditStatus = 'D')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX* -1 )
			END	
		END
		


					
		IF(@VALUE_EX < 0)
		BEGIN
			SET @EX_ACCOUNT = '780001'
		END	
		
		IF(@VALUE_EX > 0)
		BEGIN
			SET @EX_ACCOUNT = '680001'			
		END	



		Print '@@@EX_ACCOUNT    :'+CAST(@EX_ACCOUNT AS VARCHAR)
		 
		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TRX_DATE
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INI'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INI'
			   ,@EX_ACCOUNT
			   ,@EX_ACCOUNT
			   ,@FINAL_VALUE_EX
			   ,'USD'
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,@Description2
			   ,@FINAL_VALUE_EX_2
			   ,'USD')

	END	
	

	END --end in while

	END


	--END TRY
	----================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_DCC_DTC]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH_DCC_DTC]
AS
BEGIN	
    
	--=================================== SECOND LINE VARIABLE =============================================
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(255)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,10)
	DECLARE @Price decimal(18,10)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate Date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(18,10)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE Date
	DECLARE @MTD_DATE Date
	DECLARE @AccID varchar(50)
	DECLARE @TransactionTypeIdentification nvarchar(50)
	DECLARE @ReversalIdentification nvarchar(50)
	DECLARE @UNIT_PRICE_STATUS nvarchar(50)
	DECLARE @TEMP_QUANTITY Decimal(18,10)
	DECLARE @AmountTransaction decimal(18,0)
	DECLARE @DepositType VARCHAR(10)
	DECLARE @REF varchar(50)
	DECLARE @VALUE decimal(25,10)
	DECLARE @FEE varchar(10)
	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,10)
	DECLARE @RCount int
	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,10)
	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,10)
	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,10)
	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,10)
	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,10)
	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,10)
	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,10)
	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,10)
	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,10)
	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,10)
	DECLARE @VALUE_01 Decimal(18,10)
	DECLARE @VALUE_02 Decimal(18,10)
	DECLARE @VALUE_03 Decimal(18,10)
	DECLARE @VALUE_04 Decimal(18,10)
	DECLARE @VALUE_05 Decimal(18,10)
	DECLARE @VALUE_06 Decimal(18,10)
	DECLARE @VALUE_07 Decimal(18,10)
	DECLARE @VALUE_08 Decimal(18,10)
	DECLARE @VALUE_09 Decimal(18,10)
	DECLARE @VALUE_10 Decimal(18,10)	
	DECLARE @D_COLUMN varchar(10)
	DECLARE @LINK_ID varchar(50)

	--=================================== SECOND LINE VARIABLE =============================================
	DECLARE @DBEWorKBEW2 nvarchar(50)
	DECLARE @Account2 nvarchar(255)
	DECLARE @SecurityNumber2 nvarchar(50)
	DECLARE @Quantity2 decimal(18,10)
	DECLARE @Price2 decimal(18,10)
	DECLARE @Currency2 nvarchar(50)
	DECLARE @TransactionDate2 Date
	DECLARE @Description12 nvarchar(250) -- need to select transaction record
	DECLARE @Description22 nvarchar(250)
	DECLARE @LinkedNumber2 nvarchar(150)	
	DECLARE @DebitCreditStatus2 nvarchar(10)	
	DECLARE @TransactionAmout2 decimal(18,10)
	DECLARE @ValueRECDesc2 varchar(50)
	DECLARE @valueRECCode2 varchar(50)
	DECLARE @BankCode2 varchar(50)
	DECLARE @TOP2 varchar(50) 
	DECLARE @Comments2 nvarchar(250)
	DECLARE @TRX_DATE2 Date
	DECLARE @MTD_DATE2 Date
	DECLARE @AccID2 varchar(50)
	DECLARE @TransactionTypeIdentification2 nvarchar(50)
	DECLARE @ReversalIdentification2 nvarchar(50)
	DECLARE @UNIT_PRICE_STATUS2 nvarchar(50)
	DECLARE @TEMP_QUANTITY2 Decimal(18,10)
	DECLARE @AmountTransaction2 decimal(18,0)
	DECLARE @DepositType2 VARCHAR(10)
	DECLARE @REF2 varchar(50)
	DECLARE @VALUE2 decimal(25,10)
	DECLARE @FEE2 varchar(10)
	DECLARE @RowsToProcess2  int
	DECLARE @CurrentRow2     int
	DECLARE @SelectCol12     int
	DECLARE @IncVal2 decimal(18,10)
	DECLARE @RCount2 int
	DECLARE @CHARGE_01_REF2 varchar(50)
	DECLARE @CHARGE_01_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_02_REF2 varchar(50)
	DECLARE @CHARGE_02_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_03_REF2 varchar(50)
	DECLARE @CHARGE_03_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_04_REF2 varchar(50)
	DECLARE @CHARGE_04_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_05_REF2 varchar(50)
	DECLARE @CHARGE_05_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_06_REF2 varchar(50)
	DECLARE @CHARGE_06_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_07_REF2 varchar(50)
	DECLARE @CHARGE_07_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_08_REF2 varchar(50)
	DECLARE @CHARGE_08_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_09_REF2 varchar(50)
	DECLARE @CHARGE_09_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_10_REF2 varchar(50)
	DECLARE @CHARGE_10_VALUE2 Decimal(18,10)
	DECLARE @VALUE2_01 Decimal(18,10)
	DECLARE @VALUE2_02 Decimal(18,10)
	DECLARE @VALUE2_03 Decimal(18,10)
	DECLARE @VALUE2_04 Decimal(18,10)
	DECLARE @VALUE2_05 Decimal(18,10)
	DECLARE @VALUE2_06 Decimal(18,10)
	DECLARE @VALUE2_07 Decimal(18,10)
	DECLARE @VALUE2_08 Decimal(18,10)
	DECLARE @VALUE2_09 Decimal(18,10)
	DECLARE @VALUE2_10 Decimal(18,10)
	DECLARE @D_COLUMN2 varchar(10)
	DECLARE @SECOND_RW_ID INT
	DECLARE @LODH_BANK_ACCOUNT Varchar(50)

	--===================================================================================================================

	--BEGIN TRY
	--================================ Start TRY ====================================
	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50) ) 
	INSERT into @table1 (col1,AccID) SELECT min(ID),LEFT(A,8)  from [dbo].[RAW_DATA_LODH] where (I = 'DCC' OR I = 'DTC') AND D != 'MA' AND status = 0 GROUP BY LEFT(A,8),I,D,M  order BY CAST(M AS DATE) ASC

	SET @RowsToProcess=@@ROWCOUNT
	SET @CurrentRow=0

	WHILE @CurrentRow<@RowsToProcess
	BEGIN
    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@AccID = AccID FROM @table1 WHERE RowID=@CurrentRow	

	SET @IncVal = @IncVal + dbo.RandFn()

	SET @TEMP_QUANTITY = 0
	SET @Quantity = 0
	SET @Price = 0


	IF(dbo.Get_Map_Company_From_Bank_Account(LEFT(@AccID,8)) = 'CORYELL')
	BEGIN
		--============================================FIRST RECORD SET=========================================================================================

		  SELECT @Account = CASE WHEN (A != ' ') THEN CAST(A AS nvarchar) ELSE '_' END
				,@Price =   CASE WHEN (W != '') THEN CAST(W AS Decimal(18,10)) ELSE 0 END
				,@TEMP_QUANTITY = CASE WHEN (V != '') THEN CAST(V AS Decimal(18,10)) ELSE 0 END
				,@AmountTransaction = CASE WHEN (R != '') THEN CAST(R AS Decimal(18,10)) ELSE 0 END
				,@Currency = CASE WHEN ( X != ' ') THEN  X ELSE '_' END
				,@TransactionDate = CASE WHEN ( L != ' ') THEN CAST(L AS date) ELSE '_' END
				,@TRX_DATE = CASE WHEN ( K != ' ') THEN CAST(K AS date)  ELSE '' END
				,@MTD_DATE = CASE WHEN ( N != ' ') THEN CAST(N AS date)  ELSE '' END
				,@DebitCreditStatus = CASE WHEN (O  != ' ') THEN O  ELSE '_' END
				,@Description = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@valueRECCode = CASE WHEN (I != ' ') THEN I ELSE '_' END      ------------------------------------------------------------> Category Criteria
				,@TransactionTypeIdentification = CASE WHEN (AD != ' ') THEN AD ELSE '_' END       -----------------------------------------> Category Criteria
				,@ReversalIdentification = CASE WHEN (P != ' ') THEN P ELSE '_' END
				,@FEE = 'set inside trnx type'
				,@SecurityNumber = CASE WHEN (AB != '') THEN AB ELSE '_' END
				,@UNIT_PRICE_STATUS = AE
				,@DepositType = Z
				,@D_COLUMN = CASE WHEN (D != '') THEN D ELSE '_' END
				,@LINK_ID = AL

				,@CHARGE_01_REF  = 'STD'
				,@CHARGE_01_VALUE  = CASE WHEN (AR != '') THEN  CAST(AR AS Decimal(18,10)) ELSE 0 END
 
				,@CHARGE_02_REF  = 'INT'
				,@CHARGE_02_VALUE  = CASE WHEN ([AS] != '') THEN  CAST([AS] AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_03_REF  = 'OTH' --TAX
				,@CHARGE_03_VALUE  = CASE WHEN (AT != '') THEN   CAST(AT AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_04_REF  = 'BRK'
				,@CHARGE_04_VALUE  =  CASE WHEN (AU != '') THEN  CAST(AU AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_05_REF  = 'BRK'
				,@CHARGE_05_VALUE  =  CASE WHEN (AV != '') THEN  CAST(AV AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_06_REF  = 'OTH' --TAX
				,@CHARGE_06_VALUE  =  CASE WHEN (AW != '') THEN  CAST(AW AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_07_REF  = 'OTH' --TAX
				,@CHARGE_07_VALUE  =  CASE WHEN (AX != '') THEN  CAST(AX AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_08_REF  = 'OTH'
				,@CHARGE_08_VALUE  =  CASE WHEN (AY != '') THEN  CAST(AY AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_09_REF  = 'OTH'
				,@CHARGE_09_VALUE  =  CASE WHEN (AZ != '') THEN  CAST(AZ AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_10_REF  = 'OTH'
				,@CHARGE_10_VALUE  = CASE WHEN (BA != '') THEN  CAST(BA AS Decimal(18,10)) ELSE 0 END
	  
			FROM dbo.RAW_DATA_LODH 
			WHERE ID = @SelectCol1
			      AND status = 0

			--SELECT *
			--FROM dbo.RAW_DATA_LODH 
			--WHERE ID = @SelectCol1
			--      AND status = 0
          
		--============================================END FIRST RECORD SET=====================================================================================

		--============================================SECOND RECORD SET=========================================================================================
		  
		  SELECT @Account2 = CASE WHEN (A != ' ') THEN CAST(A AS nvarchar) ELSE '_' END
				,@Price2 =   CASE WHEN (W != '') THEN CAST(W AS Decimal(18,10)) ELSE 0 END
				,@TEMP_QUANTITY2 = CASE WHEN (V != '') THEN CAST(V AS Decimal(18,10)) ELSE 0 END
				,@AmountTransaction2 = CASE WHEN (R != '') THEN CAST(R AS Decimal(18,10)) ELSE 0 END
				,@Currency2 = CASE WHEN ( X != ' ') THEN  X ELSE '_' END
				,@TransactionDate2 = CASE WHEN ( L != ' ') THEN CAST(L AS date) ELSE '_' END
				,@TRX_DATE2 = CASE WHEN ( K != ' ') THEN CAST(K AS date)  ELSE '' END
				,@MTD_DATE2 = CASE WHEN ( N != ' ') THEN CAST(N AS date)  ELSE '' END
				,@DebitCreditStatus2 = CASE WHEN (O  != ' ') THEN O  ELSE '_' END
				,@Description2 = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments2 = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@valueRECCode2 = CASE WHEN (I != ' ') THEN I ELSE '_' END      ------------------------------------------------------------> Category Criteria
				,@TransactionTypeIdentification2 = CASE WHEN (AD != ' ') THEN AD ELSE '_' END       -----------------------------------------> Category Criteria
				,@ReversalIdentification2 = CASE WHEN (P != ' ') THEN P ELSE '_' END
				,@FEE2 = 'set inside trnx type'
				,@SecurityNumber2 = CASE WHEN (AB != '') THEN AB ELSE '_' END
				,@UNIT_PRICE_STATUS2 = AE
				,@DepositType2 = Z
				,@D_COLUMN2 = CASE WHEN (D != '') THEN D ELSE '_' END

				,@CHARGE_01_REF2  = 'STD'
				,@CHARGE_01_VALUE2  = CASE WHEN (AR != '') THEN  CAST(AR AS Decimal(18,10)) ELSE 0 END
 
				,@CHARGE_02_REF2  = 'INT'
				,@CHARGE_02_VALUE2  = CASE WHEN ([AS] != '') THEN  CAST([AS] AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_03_REF2  = 'OTH' --TAX
				,@CHARGE_03_VALUE2  = CASE WHEN (AT != '') THEN   CAST(AT AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_04_REF2  = 'BRK'
				,@CHARGE_04_VALUE2  =  CASE WHEN (AU != '') THEN  CAST(AU AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_05_REF2  = 'BRK'
				,@CHARGE_05_VALUE2  =  CASE WHEN (AV != '') THEN  CAST(AV AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_06_REF2  = 'OTH' --TAX
				,@CHARGE_06_VALUE2  =  CASE WHEN (AW != '') THEN  CAST(AW AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_07_REF2  = 'OTH' --TAX
				,@CHARGE_07_VALUE2  =  CASE WHEN (AX != '') THEN  CAST(AX AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_08_REF2  = 'OTH'
				,@CHARGE_08_VALUE2  =  CASE WHEN (AY != '') THEN  CAST(AY AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_09_REF2  = 'OTH'
				,@CHARGE_09_VALUE2  =  CASE WHEN (AZ != '') THEN  CAST(AZ AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_10_REF2  = 'OTH'
				,@CHARGE_10_VALUE2  = CASE WHEN (BA != '') THEN  CAST(BA AS Decimal(18,10)) ELSE 0 END
				
				,@SECOND_RW_ID = ID

			FROM dbo.RAW_DATA_LODH
			WHERE  ID != @SelectCol1
				  AND status = 0
				  AND LEFT(A,8) = LEFT(@Account,8)
				  AND AL = @LINK_ID 
				  --AND AB = @SecurityNumber
				  AND CAST(L AS date) = CAST(@TransactionDate AS VARCHAR)

			
			--SELECT *
			--FROM dbo.RAW_DATA_LODH
			--WHERE  ID != @SelectCol1
			--	  AND LEFT(A,8) = LEFT(@Account,8)
			--	  AND AL = @LINK_ID 
			--	  --AND AB = @SecurityNumber
			--	  AND CAST(L AS date) = CAST(@TransactionDate AS VARCHAR)
			--	  AND status = 0


		SET @REF =  CASE WHEN (@SecurityNumber != '_') THEN SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber)) ELSE '' END
		SET @REF2 =  CASE WHEN (@SecurityNumber2 != '_') THEN SUBSTRING(@SecurityNumber2, PATINDEX('%[^0]%', @SecurityNumber2+'.'), LEN(@SecurityNumber2)) ELSE '' END

		--============================================END SECOND RECORD SET=====================================================================================

		IF(@UNIT_PRICE_STATUS = '00')
		BEGIN
			SET @Quantity = CASE WHEN (@TEMP_QUANTITY != 0) THEN  (@TEMP_QUANTITY) ELSE 0 END
		END
		ELSE IF(@UNIT_PRICE_STATUS = '01')
		BEGIN
			SET @Quantity = CASE WHEN (@TEMP_QUANTITY != 0) THEN  (@TEMP_QUANTITY/100) ELSE 0 END
		END
		ELSE IF(@UNIT_PRICE_STATUS = '')
		BEGIN
			SET @Quantity = 0
		END

		IF(@UNIT_PRICE_STATUS2 = '00')
		BEGIN
			SET @Quantity2 = CASE WHEN (@TEMP_QUANTITY2 != 0) THEN  (@TEMP_QUANTITY2) ELSE 0 END
		END
		ELSE IF(@UNIT_PRICE_STATUS2 = '01')
		BEGIN
			SET @Quantity2 = CASE WHEN (@TEMP_QUANTITY2 != 0) THEN  (@TEMP_QUANTITY2/100) ELSE 0 END
		END
		ELSE IF(@UNIT_PRICE_STATUS2 = '')
		BEGIN
			SET @Quantity2 = 0
		END

		SET @TransactionAmout = @AmountTransaction
		SET @TransactionAmout2 = @AmountTransaction2
	
		IF(@Currency != '' OR @Currency2 != '')
		BEGIN

		IF(@valueRECCode = 'DCC')    ----------------------------- > FOREX
		BEGIN

		print '@IncVal       :'+CAST(@IncVal AS VARCHAR)
		print 'INSIDE FOREX DCC  FIRST LINE    ":'+CAST(@SelectCol1 AS VARCHAR) +'    '+ CAST(@SECOND_RW_ID AS VARCHAR)
		--============================================== START FIRST LINE SET ==========================================================================
		
		set @FEE = 'FOREX'				

		IF(@DebitCreditStatus = 'D')
		BEGIN		
			SET @TOP = 'BUY'
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @TOP = 'SELL'
		END	

		--main
		IF(@Account != '')
		BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,'800001'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	    --02nd charge
	    IF(@CHARGE_02_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
     	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END
		
		--============================================== END FIRST LINE SET ==========================================================================

		--============================================== START SECOND LINE SET =======================================================================
		print 'INSIDE FOREX DCC  SECOND LINE    ":'+CAST(@SelectCol1 AS VARCHAR) +'    '+ CAST(@SECOND_RW_ID AS VARCHAR)

		set @FEE2 = 'FOREX'

		IF(@DebitCreditStatus2 = 'D')
		BEGIN		
			SET @TOP2 = 'BUY'
		END	
		ELSE IF(@DebitCreditStatus2 = 'C')		
		BEGIN
			SET @TOP2 = 'SELL'
		END
				
						
		--main
		IF(@Account2 != '')
		BEGIN
	
			SET @RCount = @RCount + 1

			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2 = (@TransactionAmout2 * -1) 		
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2 = @TransactionAmout2	
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@FEE2
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,@FEE2
			   ,'800001'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
			   ,@TRX_DATE2
			   ,@MTD_DATE2)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SECOND_RW_ID

			END

		--01st charge
		IF(@CHARGE_01_VALUE2 != 0)
		BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_01 = CAST((@CHARGE_01_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_01 = CAST((@CHARGE_01_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_01 = CAST((@CHARGE_01_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_01 = CAST((@CHARGE_01_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'STD'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_01
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)


	END

	    --02nd charge
	    IF(@CHARGE_02_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_02 = CAST((@CHARGE_02_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_02 = CAST((@CHARGE_02_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_02 = CAST((@CHARGE_02_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_02 = CAST((@CHARGE_02_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'INT'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_02
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--03rd charge
		IF(@CHARGE_03_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_03 = CAST((@CHARGE_03_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_03 = CAST((@CHARGE_03_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_03 = CAST((@CHARGE_03_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_03 = CAST((@CHARGE_03_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'  --TAX
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_03
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)


	END

		--04th charge
		IF(@CHARGE_04_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_04 = CAST((@CHARGE_04_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_04 = CAST((@CHARGE_04_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_04 = CAST((@CHARGE_04_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_04 = CAST((@CHARGE_04_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'BRK'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_04
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--05th charge
		IF(@CHARGE_05_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_05 = CAST((@CHARGE_05_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_05 = CAST((@CHARGE_05_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_05 = CAST((@CHARGE_05_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_05 = CAST((@CHARGE_05_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'BRK'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_05
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--06th charge
		IF(@CHARGE_06_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_06 = CAST((@CHARGE_06_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_06 = CAST((@CHARGE_06_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_06 = CAST((@CHARGE_06_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_06 = CAST((@CHARGE_06_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'  --TAX
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_06
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--07th charge
		IF(@CHARGE_07_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_07 = CAST((@CHARGE_07_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_07 = CAST((@CHARGE_07_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_07 = CAST((@CHARGE_07_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_07 = CAST((@CHARGE_07_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'  --TAX
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_07
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 ,@MTD_DATE2)


	END

		--08th charge
		IF(@CHARGE_08_VALUE2 != 0)
     	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_08 = CAST((@CHARGE_08_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_08 = CAST((@CHARGE_08_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_08 = CAST((@CHARGE_08_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_08 = CAST((@CHARGE_08_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_08
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 ,@MTD_DATE2)


	END

		--09th charge
		IF(@CHARGE_09_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_09 = CAST((@CHARGE_09_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_09 = CAST((@CHARGE_09_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_09 = CAST((@CHARGE_09_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_09 = CAST((@CHARGE_09_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_09
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 ,@MTD_DATE2)


	END

		--10th charge
		IF(@CHARGE_10_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_10 = CAST((@CHARGE_10_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_10 = CAST((@CHARGE_10_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_10 = CAST((@CHARGE_10_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_10 = CAST((@CHARGE_10_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_10
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--============================================== END SECOND LINE SET =======================================================================
		END

	    IF(@valueRECCode = 'DTC' AND @D_COLUMN = 'DE')    ----------------------------- > FORWARD
	    BEGIN
		
		print 'INSIDE FORWARD DTC  FIRST LINE    ":'+CAST(@Account AS VARCHAR) +'    '+ CAST(@SelectCol1 AS VARCHAR)	
		print 'INSIDE FORWARD DTC  FIRST LINE WITH VALUERECCODE    ":'+CAST(@valueRECCode AS VARCHAR) +'    '+ CAST(@D_COLUMN AS VARCHAR)	
		--============================================== START FIRST LINE SET ==========================================================================

		set @FEE = 'FORWARD'

		IF(LEFT(@Account,8) = '48425 A0')
		BEGIN
			SET @LODH_BANK_ACCOUNT = '511115'
		END
		ELSE
		BEGIN
			SET @LODH_BANK_ACCOUNT = '511114'
		END


		IF(@DebitCreditStatus = 'D')
		BEGIN		
			SET @TOP = 'BUY'
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @TOP = 'SELL'
		END	

		--main
		IF(@Account != '')
		BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,@LODH_BANK_ACCOUNT+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	    --02nd charge
	    IF(@CHARGE_02_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
     	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END
		
		--============================================== END FIRST LINE SET ==========================================================================

		--============================================== START SECOND LINE SET =======================================================================
				
		set @FEE2 = 'FORWARD'

		IF(@DebitCreditStatus2 = 'D')
		BEGIN		
			SET @TOP2 = 'BUY'
		END	
		ELSE IF(@DebitCreditStatus2 = 'C')		
		BEGIN
			SET @TOP2 = 'SELL'
		END
				
		
		--main
		IF(@Account2 != '')
		BEGIN
	
			SET @RCount = @RCount + 1

			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2 = (@TransactionAmout2 * -1) 		
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2 = @TransactionAmout2	
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@FEE2
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,@FEE2
			   ,@LODH_BANK_ACCOUNT+@Currency2
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
			   ,@TRX_DATE2
			   ,@MTD_DATE2)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SECOND_RW_ID

			END

		--01st charge
		IF(@CHARGE_01_VALUE2 != 0)
		BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_01 = CAST((@CHARGE_01_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_01 = CAST((@CHARGE_01_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_01 = CAST((@CHARGE_01_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_01 = CAST((@CHARGE_01_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'STD'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_01
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)


	END

	    --02nd charge
	    IF(@CHARGE_02_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_02 = CAST((@CHARGE_02_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_02 = CAST((@CHARGE_02_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_02 = CAST((@CHARGE_02_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_02 = CAST((@CHARGE_02_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'INT'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_02
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--03rd charge
		IF(@CHARGE_03_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_03 = CAST((@CHARGE_03_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_03 = CAST((@CHARGE_03_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_03 = CAST((@CHARGE_03_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_03 = CAST((@CHARGE_03_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'  --TAX
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_03
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)


	END

		--04th charge
		IF(@CHARGE_04_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_04 = CAST((@CHARGE_04_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_04 = CAST((@CHARGE_04_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_04 = CAST((@CHARGE_04_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_04 = CAST((@CHARGE_04_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'BRK'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_04
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--05th charge
		IF(@CHARGE_05_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_05 = CAST((@CHARGE_05_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_05 = CAST((@CHARGE_05_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_05 = CAST((@CHARGE_05_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_05 = CAST((@CHARGE_05_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'BRK'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_05
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--06th charge
		IF(@CHARGE_06_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_06 = CAST((@CHARGE_06_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_06 = CAST((@CHARGE_06_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_06 = CAST((@CHARGE_06_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_06 = CAST((@CHARGE_06_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'  --TAX
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_06
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--07th charge
		IF(@CHARGE_07_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_07 = CAST((@CHARGE_07_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_07 = CAST((@CHARGE_07_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_07 = CAST((@CHARGE_07_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_07 = CAST((@CHARGE_07_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'  --TAX
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'  --TAX
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_07
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 ,@MTD_DATE2)


	END

		--08th charge
		IF(@CHARGE_08_VALUE2 != 0)
     	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_08 = CAST((@CHARGE_08_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_08 = CAST((@CHARGE_08_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_08 = CAST((@CHARGE_08_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_08 = CAST((@CHARGE_08_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_08
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 ,@MTD_DATE2)


	END

		--09th charge
		IF(@CHARGE_09_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_09 = CAST((@CHARGE_09_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_09 = CAST((@CHARGE_09_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_09 = CAST((@CHARGE_09_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_09 = CAST((@CHARGE_09_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_09
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 ,@MTD_DATE2)


	END

		--10th charge
		IF(@CHARGE_10_VALUE2 != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification2 = '_')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_10 = CAST((@CHARGE_10_VALUE2 * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_10 = CAST((@CHARGE_10_VALUE2 * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification2 = 'R')
		BEGIN
			IF(@DebitCreditStatus2 = 'D')
			BEGIN
				SET @VALUE2_10 = CAST((@CHARGE_10_VALUE2) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus2 = 'C')		
			BEGIN
				SET @VALUE2_10 = CAST((@CHARGE_10_VALUE2 ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate2
			   ,@Description2
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,'OTH'
			   ,@Price2
			   ,@Quantity2 
			   ,@REF2
			   ,@TOP2
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account2,8),@Currency2,@VALUERECCode2)
			   ,@VALUE2_10
			   ,@Currency2
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments2
		       ,@TRX_DATE2 
			   ,@MTD_DATE2)

	END

		--============================================== END SECOND LINE SET =======================================================================
	END

	END

	END --end in while
	
	END


	--END TRY
	--================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_LODH]
AS
BEGIN	
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(255)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,10)
	DECLARE @Price decimal(18,10)
	DECLARE @TEMP_PRICE  decimal(18,10)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate Date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(25,10)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE Date
	DECLARE @MTD_DATE Date
	DECLARE @AccID varchar(50)
	DECLARE @TransactionTypeIdentification nvarchar(50)
	DECLARE @ReversalIdentification nvarchar(50)
	DECLARE @UNIT_PRICE_STATUS nvarchar(50)
	DECLARE @TEMP_QUANTITY Decimal(18,10)
	DECLARE @AmountTransaction decimal(18,10)
	DECLARE @REF varchar(50)
	DECLARE @VALUE decimal(25,10)
	DECLARE @FEE varchar(10)
	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,10)
	DECLARE @RCount int
	DECLARE @INV_Account varchar(50)
	DECLARE @D_Column varchar(10)
	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,10)
	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,10)
	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,10)
	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,10)
	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,10)
	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,10)
	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,10)
	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,10)
	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,10)
	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,10)
	DECLARE @VALUE_01 Decimal(18,10)
	DECLARE @VALUE_02 Decimal(18,10)
	DECLARE @VALUE_03 Decimal(18,10)
	DECLARE @VALUE_04 Decimal(18,10)
	DECLARE @VALUE_05 Decimal(18,10)
	DECLARE @VALUE_06 Decimal(18,10)
	DECLARE @VALUE_07 Decimal(18,10)
	DECLARE @VALUE_08 Decimal(18,10)
	DECLARE @VALUE_09 Decimal(18,10)
	DECLARE @VALUE_10 Decimal(18,10)	
	--BEGIN TRY
	--================================ Start TRY ====================================
	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50) )  

	INSERT into @table1 (col1,AccID) select ID,A from [dbo].[RAW_DATA_LODH] where D != 'MA' AND I != 'MAO' AND status = 0 AND X != '' order BY CAST(M AS DATE) ASC --GROUP BY ID,A   	

	SET @RowsToProcess=@@ROWCOUNT
	SET @CurrentRow=0

	WHILE @CurrentRow<@RowsToProcess
	BEGIN

    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@AccID = AccID FROM @table1 WHERE RowID=@CurrentRow	
	SET @IncVal = @IncVal + dbo.RandFn()

	SET  @TEMP_QUANTITY = 0
	SET  @Quantity = 0
	SET  @Price = 0
	SET  @FEE = ''
	SET  @TransactionDate = ''
	SET  @Description = ''
	SET  @Account = ''
	SET  @Currency = ''
	SET  @valueRECCode = ''
	SET  @REF = ''
	SET  @TOP = ''
	SET  @FEE = ''
	SET  @Account = ''
	SET  @valueRECCode = ''
	SET  @VALUE = 0
	SET  @Comments = ''
	SET  @TRX_DATE = ''
	SET  @MTD_DATE = ''
	SET  @TEMP_PRICE = 0

	--print '@AccID  :'+cast(@AccID as varchar)	

	IF(dbo.Get_Map_Company_From_Bank_Account(LEFT(@AccID,8)) = 'CORYELL')
		BEGIN
		

	      SELECT @Account = CASE WHEN (A != ' ') THEN CAST(A AS nvarchar) ELSE '_' END
				,@TEMP_PRICE =   CASE WHEN (W != '') THEN CAST(W AS Decimal(18,10)) ELSE 0 END
				,@TEMP_QUANTITY = CASE WHEN (V != '') THEN CAST(V AS Decimal(18,10)) ELSE 0 END
				,@AmountTransaction = CASE WHEN (R != '') THEN CAST(R AS Decimal(18,10)) ELSE 0 END
				,@Currency = CASE WHEN ( X != ' ') THEN  X ELSE '_' END
				,@TransactionDate = CASE WHEN ( L != ' ') THEN CAST(L AS date) ELSE '_' END
				,@TRX_DATE = CASE WHEN ( K != ' ') THEN CAST(K AS date)  ELSE '_' END
				,@MTD_DATE = CASE WHEN ( N != ' ') THEN CAST(N AS date)  ELSE '' END
				,@DebitCreditStatus = CASE WHEN (O  != ' ') THEN O  ELSE '_' END
				,@Description = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments = CASE WHEN (H != ' ') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
				,@valueRECCode = CASE WHEN (I != ' ') THEN I ELSE '_' END      ------------------------------------------------------------> Category Criteria
				,@TransactionTypeIdentification = CASE WHEN (AD != ' ') THEN CAST(AD AS NVARCHAR(8)) ELSE '_' END       -----------------------------------------> Category Criteria
				,@ReversalIdentification = CASE WHEN (P != ' ') THEN P ELSE '_' END
				,@FEE = ' '
				,@SecurityNumber = CASE WHEN (AB != '') THEN AB ELSE '_' END
				,@UNIT_PRICE_STATUS = AE
				,@D_Column =  CASE WHEN (D != '') THEN D ELSE '_' END

				,@CHARGE_01_REF  = 'STD'
				,@CHARGE_01_VALUE  = CASE WHEN (AR != '') THEN  CAST(AR AS Decimal(18,10)) ELSE 0 END
 
				,@CHARGE_02_REF  = 'INT'
				,@CHARGE_02_VALUE  = CASE WHEN ([AS] != '') THEN  CAST([AS] AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_03_REF  = 'TAX' --TAX
				,@CHARGE_03_VALUE  = CASE WHEN (AT != '') THEN   CAST(AT AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_04_REF  = 'BRK'
				,@CHARGE_04_VALUE  =  CASE WHEN (AU != '') THEN  CAST(AU AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_05_REF  = 'BRK'
				,@CHARGE_05_VALUE  =  CASE WHEN (AV != '') THEN  CAST(AV AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_06_REF  = 'TAX' --TAX
				,@CHARGE_06_VALUE  =  CASE WHEN (AW != '') THEN  CAST(AW AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_07_REF  = 'TAX' --TAX
				,@CHARGE_07_VALUE  =  CASE WHEN (AX != '') THEN  CAST(AX AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_08_REF  = 'OTH'
				,@CHARGE_08_VALUE  =  CASE WHEN (AY != '') THEN  CAST(AY AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_09_REF  = 'OTH'
				,@CHARGE_09_VALUE  =  CASE WHEN (AZ != '') THEN  CAST(AZ AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_10_REF  = 'OTH'
				,@CHARGE_10_VALUE  = CASE WHEN (BA != '') THEN  CAST(BA AS Decimal(18,10)) ELSE 0 END
	  
			FROM dbo.RAW_DATA_LODH 
			WHERE ID = @SelectCol1


    SET @REF =  CASE WHEN (@SecurityNumber != '_') THEN SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber)) ELSE '' END

	IF(@UNIT_PRICE_STATUS = '00')
	BEGIN
		SET @Price = CASE WHEN (@TEMP_PRICE != 0) THEN  (@TEMP_PRICE) ELSE 0 END
		--SET @Quantity = CASE WHEN (@TEMP_QUANTITY != 0) THEN  (@TEMP_QUANTITY) ELSE 0 END
	END
	ELSE IF(@UNIT_PRICE_STATUS = '01')
	BEGIN
		SET @Price = CASE WHEN (@TEMP_PRICE != 0) THEN  (@TEMP_PRICE/100) ELSE 0 END
		--SET @Quantity = CASE WHEN (@TEMP_QUANTITY != 0) THEN  (@TEMP_QUANTITY/100) ELSE 0 END
	END

	SET @Quantity = CASE WHEN (@TEMP_QUANTITY != 0) THEN  (@TEMP_QUANTITY) ELSE 0 END
	SET @TransactionAmout = CASE WHEN (@Price != 0) AND (@Quantity != 0) THEN  (@Price * @Quantity) ELSE 0 END
	
	

	--=================================================================================================================
    IF((@valueRECCode = 'OSR' OR @valueRECCode = 'EMC' OR @valueRECCode = 'BOC' OR @valueRECCode = 'OEA' OR @valueRECCode = 'OPF' OR @valueRECCode = 'OEP' OR @valueRECCode = 'OCR' OR @valueRECCode = 'OER' OR @valueRECCode = 'OOP'))---------------------> Equity TYPE
	BEGIN 
	
		
	SET @IncVal = @IncVal + dbo.RandFn()
	
	IF(@DebitCreditStatus = 'D')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'C')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--========================================================
	IF(((LEFT(@TransactionTypeIdentification,1) = 'A' OR @TransactionTypeIdentification = 'F05' OR @TransactionTypeIdentification = 'F01')))
	BEGIN
		
		IF(@valueRECCode = 'OSR' AND @DebitCreditStatus = 'D')
		BEGIN
			print 'RAW_ID  INSIDE OSR AND D INVEQ     :'+CAST(@SelectCol1 AS VARCHAR)
			set @FEE = 'INVEQ'
			SET @INV_Account = '220001'+@Currency

			--=============================================================================

			--main
	        IF(@Account != '')
	        BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INVEQ'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INVEQ'
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

			 

		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

			SET @RCount = @RCount + 1
		
			print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'STD'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'STD'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_01
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--02nd charge
		IF(@CHARGE_02_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'INT'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'INT'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_02
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
				
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_03
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_04
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_05
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_06
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_07
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_08
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_09
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
				END	
			END


			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_10
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--=============================================================================
			
		END
		ELSE IF(@valueRECCode = 'OSR' AND @DebitCreditStatus = 'C')-------------------->DIVIDENT INCOME
		BEGIN

		print 'RAW_ID  INSIDE OSR DIV     :'+CAST(@SelectCol1 AS VARCHAR)

		set @FEE = 'DIV'
		SET @IncVal = @IncVal + dbo.RandFn()

		print 'INSIDE OSR AND C  Fee value  :'+@FEE
		--=====================
		IF(@DebitCreditStatus = 'D')
		BEGIN		
			SET @TOP = 'PROFIT'
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @TOP = 'PROFIT'
		END	

		--main
		IF(@Account != '')
	    BEGIN

		SET @RCount = 1

		IF(@DebitCreditStatus = 'D')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
     VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,'DIV'
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,'DIV'
           ,'770004'
           ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE 
		   ,@MTD_DATE)

		UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

		END
	
		--01st charge
		IF(@CHARGE_01_VALUE != 0)
     	BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

		--02nd charge
		IF(@CHARGE_02_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
	    BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
    	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END


		--=====================

		END
		ELSE IF(@valueRECCode != 'OSR')
		BEGIN
			print 'RAW_ID   INSIDE INVEQ    :'+CAST(@SelectCol1 AS VARCHAR)	
			SET @FEE = 'INVEQ'	
			SET @INV_Account = '220001'+@Currency				
		    
			--=============================================================================

			--main
	        IF(@Account != '')
	        BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INVEQ'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INVEQ'
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

			

		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

			SET @RCount = @RCount + 1
		
			print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'STD'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'STD'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_01
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--02nd charge
		IF(@CHARGE_02_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'INT'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'INT'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_02
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
				
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_03
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_04
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_05
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_06
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_07
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_08
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_09
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
				END	
			END


			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220001'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_10
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

			--=============================================================================
		END	

	END
	ELSE IF((LEFT(@TransactionTypeIdentification,1) = 'O' OR @TransactionTypeIdentification = 'D04' OR @TransactionTypeIdentification = 'F02'  OR @TransactionTypeIdentification = 'F06'))
	BEGIN 
		--set @FEE = 'INVBD'
		
		IF((@TransactionTypeIdentification != 'O28' OR @TransactionTypeIdentification != 'O29' OR @TransactionTypeIdentification != 'O30'))
		BEGIN
			print 'RAW_ID  INSIDE INVBD     :'+CAST(@SelectCol1 AS VARCHAR)
			SET @INV_Account = '220002'+@Currency	
			set @FEE = 'INVBD'
			
		   --=============================================================================

			--main
	        IF(@Account != '')
	        BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INVBD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INVBD'
			   ,'220002'+@Currency	
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

			
		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

			SET @RCount = @RCount + 1
		
			print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'STD'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'STD'
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_01
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--02nd charge
		IF(@CHARGE_02_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'INT'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'INT'
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_02
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
				
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_03
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_04
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_05
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_06
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_07
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_08
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_09
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
				END	
			END


			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220002'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_10
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END
		--=============================================================================		
		END

	END
	ELSE IF(@TransactionTypeIdentification IN ('A01','A02','A03','A04','A05','A06','A07','A08','A09','A10','A11','A12','A13','A14','A15','A16','A17','A18','A19','A20','A21','D01','D02','D03',
		'D04','D05','D06','D07','D08','D09','D11','D12','D13','D14','D15','D16','F03','F04','F15','F16','F17','F18','F19','F20','F25','F26','F29','M01','M02','M03',
		'M04','M05','M06','M07','M08','M09','M10','M11','M12','M13','M14','M15','M16','M17','M18','M19','M20','M21','M22','O01','O14','O15','O16','O17','O18','O19',
		'O20','O21','O22','O23','O24','O25','O26','O27','O28','O29','O30','O31','O32','O33','O34','O35','P01','P02','P03','P04','P05','W01','W02','W03','W04','W05',
		'W06','W07','W08','W09','X01','F07','F08','F09','F10','F11','F12','F13','F14','O02','O03','O04','O05','O06','O07','O08','O09','O10','O11','O12','O13','X02',
		'X03','X04','X05','X06','X07','X08','X09','X10','X11','X12','X13','X14','X15','X16','X17','X18','X19','F23'))
	BEGIN 
		
		IF((@TransactionTypeIdentification != 'F21' OR @TransactionTypeIdentification != 'F22' OR @TransactionTypeIdentification != 'F24' OR @TransactionTypeIdentification != 'F27'  OR @TransactionTypeIdentification != 'F28'
		    OR @TransactionTypeIdentification != 'F01' OR @TransactionTypeIdentification != 'F02' OR @TransactionTypeIdentification != 'F05' OR @TransactionTypeIdentification != 'F06' OR @TransactionTypeIdentification != 'F23'))
		BEGIN
			print 'RAW_ID  INSIDE INVFN     :'+CAST(@SelectCol1 AS VARCHAR)
			SET @FEE = 'INVFN'
			SET @INV_Account = '220004'+@Currency

		    --=============================================================================

			--main
	        IF(@Account != '')
	        BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INVFN'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INVFN'
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

			
		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

			SET @RCount = @RCount + 1
		
			print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'STD'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'STD'
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_01
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--02nd charge
		IF(@CHARGE_02_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'INT'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'INT'
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_02
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
				
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_03
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_04
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_05
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_06
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_07
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_08
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_09
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
				END	
			END


			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220004'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_10
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

			--=============================================================================	
		END

	END
	ELSE IF(((@TransactionTypeIdentification = 'F21' OR @TransactionTypeIdentification = 'F22' OR @TransactionTypeIdentification = 'F27'  OR @TransactionTypeIdentification = 'F28')) )
	BEGIN
		print 'RAW_ID  INSIDE INVHF     :'+CAST(@SelectCol1 AS VARCHAR)
		set @FEE = 'INVHF'
		SET @INV_Account = '220005'+@Currency

		    --=============================================================================

			--main
	        IF(@Account != '')
	        BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INVHF'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INVHF'
			   ,'220005'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

			
		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

			SET @RCount = @RCount + 1
		
			print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'STD'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'STD'
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_01
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--02nd charge
		IF(@CHARGE_02_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'INT'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'INT'
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_02
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
				
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_03
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_04
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_05
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_06
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_07
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_08
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_09
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
				END	
			END


			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220005'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_10
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

			--=============================================================================	
		
	END
	ELSE IF((@TransactionTypeIdentification != 'F23' OR @TransactionTypeIdentification = 'F24') AND (LEFT(@TransactionTypeIdentification,1) != 'M' OR LEFT(@TransactionTypeIdentification,1) != 'X'))
	BEGIN
	    print 'RAW_ID   INSIDE INVPE    :'+CAST(@SelectCol1 AS VARCHAR)
		set @FEE = 'INVPE'
		SET @INV_Account = '220007'+@Currency

		    --=============================================================================

			--main
	        IF(@Account != '')
	        BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INVPE'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INVPE'
			   ,'220007'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

			
		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

			SET @RCount = @RCount + 1
		
			print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'STD'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'STD'
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_01
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--02nd charge
		IF(@CHARGE_02_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'INT'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'INT'
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_02
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
				
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_03
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_04
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_05
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_06
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_07
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_08
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_09
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
				END	
			END


			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220007'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_10
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END
			--=============================================================================	
		
	END
	ELSE IF((LEFT(@TransactionTypeIdentification,1) = 'M' OR LEFT(@TransactionTypeIdentification,1) = 'X'))
	BEGIN
	    print 'RAW_ID  INSIDE INVOT     :'+CAST(@SelectCol1 AS VARCHAR)
		set @FEE = 'INVOT'
		SET @INV_Account = '220009'+@Currency
		
		    --=============================================================================

			--main
	        IF(@Account != '')
	        BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INVOT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INVOT'
			   ,'220009'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

			
		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

			SET @RCount = @RCount + 1
		
			print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'STD'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'STD'
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_01
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--02nd charge
		IF(@CHARGE_02_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'INT'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'INT'
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_02
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
				
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_03
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_04
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_05
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_06
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_07
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_08
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_09
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
				END	
			END


			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220009'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_10
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

			--=============================================================================	
	END
	ELSE IF((LEFT(@TransactionTypeIdentification,1) = 'W' OR @TransactionTypeIdentification = 'O28' OR @TransactionTypeIdentification = 'O29' OR @TransactionTypeIdentification = 'O30'))
	BEGIN
		print 'RAW_ID  INSIDE INVSP     :'+CAST(@SelectCol1 AS VARCHAR)
		set @FEE = 'INVSP'
		SET @INV_Account = '220006'+@Currency
		
		    --=============================================================================

			--main
	        IF(@Account != '')
	        BEGIN
	
			SET @RCount = 1

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE = (@TransactionAmout * -1) 		
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE = @TransactionAmout		
			END	

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INVSP'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INVSP'
			   ,'220006'+@Currency
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

			END

			
		--01st charge
		IF(@CHARGE_01_VALUE != 0)
		BEGIN

			SET @RCount = @RCount + 1
		
			print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'STD'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'STD'
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_01
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--02nd charge
		IF(@CHARGE_02_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1

			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'INT'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'INT'
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_02
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--03rd charge
		IF(@CHARGE_03_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
				
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_03
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)


		END

		--04th charge
		IF(@CHARGE_04_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END 
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_04
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--05th charge
		IF(@CHARGE_05_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'BRK'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'BRK'
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_05
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--06th charge
		IF(@CHARGE_06_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE  IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE]
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_06
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE
				   ,@MTD_DATE)

		END

		--07th charge
		IF(@CHARGE_07_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'TAX'  --TAX
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'TAX'  --TAX
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_07
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--08th charge
		IF(@CHARGE_08_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_08
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--09th charge
		IF(@CHARGE_09_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
				END	
			END

			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_09
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

		--10th charge
		IF(@CHARGE_10_VALUE != 0)
		BEGIN
		
			SET @RCount = @RCount + 1
						
			IF(@ReversalIdentification = '_')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
				END	
			END
			ELSE IF(@ReversalIdentification = 'R')
			BEGIN
				IF(@DebitCreditStatus = 'D')
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
				END	
				ELSE IF(@DebitCreditStatus = 'C')		
				BEGIN
					SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
				END	
			END


			INSERT INTO [dbo].[RAWGLARECORDS]
				   (DOE
				   ,[Description]
				   ,[BNK]
				   ,[FEE]
				   ,[PRC]
				   ,[QTY]
				   ,[REF]
				   ,[TOP]
				   ,[REF_DES]
				   ,[DebitAccount]
				   ,[CreditAccount]
				   ,[Value]
				   ,[Currency]
				   ,[REF_ID]
				   ,[Proirity]
				   ,[Status]
				   ,[Comment]
				   ,[TRX_DATE] 
				   ,[MTD_DATE])
			 VALUES
				   (@TransactionDate
				   ,@Description
				   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,'OTH'
				   ,@Price
				   ,@Quantity 
				   ,@REF
				   ,@TOP
				   ,'OTH'
				   ,'220006'+@Currency
				   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
				   ,@VALUE_10
				   ,@Currency
				   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
				   ,@RCount
				   ,0
				   ,@Comments
				   ,@TRX_DATE 
				   ,@MTD_DATE)


		END

			--=============================================================================	
	END
	--========================================================
	END
	ELSE IF(@valueRECCode = 'OCG')---------------------> CAPITAL Gain
	BEGIN 
	
	set @FEE = 'CAP'
	SET @IncVal = @IncVal + dbo.RandFn()


	IF(@DebitCreditStatus = 'D')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'C')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'D')
		BEGIN
			SET @VALUE = (@AmountTransaction * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @VALUE = @AmountTransaction		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
     VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'770001'
           ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE
		   ,@MTD_DATE)

		UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

		END
	
	--01st charge
	IF(@CHARGE_01_VALUE != 0)
	BEGIN

		SET @RCount = @RCount + 1
		
		print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE != 0)	 
	 BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END 
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END 
		ELSE  IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE  IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	END
	ELSE IF(@valueRECCode = 'OCD' AND @D_Column = 'DA' AND @TransactionTypeIdentification = 'A06')--------------------> Devident Income DIV
	BEGIN 

	set @FEE = 'DIV'
	SET @IncVal = @IncVal + dbo.RandFn()

	----============================================================================================================
	--print '@@ReversalIdentification  *********************************:'+ cast(@ReversalIdentification as varchar)
	--print '@@CHARGE_01_VALUE  *********************************:'+ cast(@CHARGE_01_VALUE as varchar)
	--print '@@CHARGE_02_VALUE  *********************************:'+ cast(@CHARGE_02_VALUE as varchar)
	--print '@@CHARGE_03_VALUE  *********************************:'+ cast(@CHARGE_03_VALUE as varchar)
	--print '@@CHARGE_04_VALUE  *********************************:'+ cast(@CHARGE_04_VALUE as varchar)
	--print '@@CHARGE_05_VALUE  *********************************:'+ cast(@CHARGE_05_VALUE as varchar)
	--print '@@CHARGE_06_VALUE  *********************************:'+ cast(@CHARGE_06_VALUE as varchar)
	--print '@@CHARGE_07_VALUE  *********************************:'+ cast(@CHARGE_07_VALUE as varchar)
	--print '@@CHARGE_08_VALUE  *********************************:'+ cast(@CHARGE_08_VALUE as varchar)
	--print '@@CHARGE_09_VALUE  *********************************:'+ cast(@CHARGE_09_VALUE as varchar)
	--print '@@CHARGE_10_VALUE  *********************************:'+ cast(@CHARGE_10_VALUE as varchar)
	
	----============================================================================================================
	
	--=====================
	IF(@DebitCreditStatus = 'D')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'C')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'D')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
     VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,'DIV'
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,'DIV'
           ,'770004'
           ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE ,@MTD_DATE)

		UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

		END
	
	--01st charge
	IF(@CHARGE_01_VALUE != 0)
	BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN

			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
		    IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END


	--=====================

	END
	ELSE IF(@valueRECCode = 'OCI')--------------------> Coupon CPN
	BEGIN 

	set @FEE = 'CPN'
	SET @IncVal = @IncVal + dbo.RandFn()

	--=====================
	IF(@DebitCreditStatus = 'D')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'C')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'D')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
     VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'770005'
           ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE 
		   ,@MTD_DATE)

		UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

		END
	
	--01st charge
	IF(@CHARGE_01_VALUE != 0)
	BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END


	--=====================

	END	
	ELSE IF(@valueRECCode = 'VIR')--------------------> INCOMMING CASH
	BEGIN 

	set @FEE = 'TRB'
	SET @IncVal = @IncVal + dbo.RandFn()

	--=====================
	IF(@DebitCreditStatus = 'D')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'C')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'D')
		BEGIN
			SET @VALUE = (@AmountTransaction * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @VALUE = @AmountTransaction		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
     VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'770007'
           ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE 
		   ,@MTD_DATE)

		UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

		END
	
	--01st charge
	IF(@CHARGE_01_VALUE != 0)
	BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END


	--=====================

	END	
	ELSE IF(@valueRECCode = 'DDG')--------------------> 
	BEGIN 

	set @FEE = 'DDG'
	SET @IncVal = @IncVal + dbo.RandFn()

	--=====================
	IF(@DebitCreditStatus = 'D')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'C')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'D')
		BEGIN
			SET @VALUE = (@AmountTransaction * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @VALUE = @AmountTransaction		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
     VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'620037'
           ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE 
		   ,@MTD_DATE)

		UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

		END
	
	--01st charge
	IF(@CHARGE_01_VALUE != 0)
	BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END


	--=====================

	END
	ELSE IF(@valueRECCode = 'ECR')--------------------> 
	BEGIN 

	set @FEE = 'DDG'
	SET @IncVal = @IncVal + dbo.RandFn()

	--=====================
	IF(@DebitCreditStatus = 'D')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'C')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'D')
		BEGIN
			SET @VALUE = (@AmountTransaction * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'C')		
		BEGIN
			SET @VALUE = @AmountTransaction		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
     VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'620041'
           ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE 
		   ,@MTD_DATE)

		UPDATE dbo.RAW_DATA_LODH SET status  = 1 WHERE ID = @SelectCol1

		END
	
	--01st charge
	IF(@CHARGE_01_VALUE != 0)
	BEGIN

		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'INT'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'INT'
			   ,'620037'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] 
				 ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'TAX'  --TAX
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'  --TAX
			   ,'620049'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE != 0)
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@ReversalIdentification = '_')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 ) AS Decimal(18,10))		
			END	
		END
		ELSE IF(@ReversalIdentification = 'R')
		BEGIN
			IF(@DebitCreditStatus = 'D')
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE) AS Decimal(18,10))
			END	
			ELSE IF(@DebitCreditStatus = 'C')		
			BEGIN
				SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,10))		
			END	
		END

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			     ,[TRX_DATE] ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_LODH(LEFT(@Account,8),@Currency,@valueRECCode)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE ,@MTD_DATE)

	END


	--=====================

	END		
	--==================================================================================================================
	
	END --end in while

	END --END BANK



	--END TRY
	--================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_FORWARD]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE  [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_FORWARD]
AS
BEGIN	
	DECLARE @RW_Count_ID int
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(50)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,10)
	DECLARE @Price decimal(18,10)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(25,10)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE date
	DECLARE @Reversal_Status varchar(10)
	DECLARE @MTD_DATE Date
	DECLARE @REF varchar(50)
	DECLARE @VALUE decimal(25,10)
	DECLARE @FEE varchar(10)
	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,10)
	DECLARE @RCount int
	DECLARE @TRDATE date
	DECLARE @CHK_Account nvarchar(50)
	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,10)
	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,10)
	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,10)
	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,10)
	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,10)
	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,10)
	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,10)
	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,10)
	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,10)
	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,10)
	DECLARE @CHARGE_TAX_REF varchar(50)
	DECLARE @CHARGE_TAX_VALUE Decimal(18,10)
	DECLARE @VALUE_01 Decimal(18,10)
	DECLARE @VALUE_02 Decimal(18,10)
	DECLARE @VALUE_03 Decimal(18,10)
	DECLARE @VALUE_04 Decimal(18,10)
	DECLARE @VALUE_05 Decimal(18,10)
	DECLARE @VALUE_06 Decimal(18,10)
	DECLARE @VALUE_07 Decimal(18,10)
	DECLARE @VALUE_08 Decimal(18,10)
	DECLARE @VALUE_09 Decimal(18,10)
	DECLARE @VALUE_10 Decimal(18,10)
	DECLARE @VALUE_TAX Decimal(18,10)	
	DECLARE @VALUE_EX Decimal(25,10)
	DECLARE @F_VALUE_EX Decimal(25,10)
	DECLARE @VALUE_EXCHANGE_GAIN_LOSS Decimal(25,10)
	DECLARE @FINAL_VALUE_EX Decimal(25,10)
	DECLARE @GL_ACC_IDENTIFIER varchar(10)
	DECLARE @FWD_ACC_NUMBER varchar(50)
	DECLARE @KBEW_ID int	
	DECLARE @E_Column varchar(20)
	DECLARE @CONVERT_VALUE_01 Decimal(18,10)	
	DECLARE @EX_ACCOUNT varchar(50)
	DECLARE @EX_DIFF decimal(18,10)


	--=========================================================
	DECLARE @Account2 nvarchar(50)
	DECLARE @SecurityNumber2 nvarchar(50)
	DECLARE @Quantity2 decimal(18,10)
	DECLARE @Price2 decimal(18,10)
	DECLARE @Currency2 nvarchar(50)
	DECLARE @TransactionDate2 date
	DECLARE @Description12 nvarchar(250) -- need to select transaction record
	DECLARE @Description22 nvarchar(250)
	DECLARE @LinkedNumber2 nvarchar(150)	
	DECLARE @DebitCreditStatus2 nvarchar(10)	
	DECLARE @TransactionAmout2 decimal(25,10)
	DECLARE @ValueRECDesc2 varchar(50)
	DECLARE @valueRECCode2 varchar(50)
	DECLARE @BankCode2 varchar(50)
	DECLARE @TOP2 varchar(50) 
	DECLARE @Comments2 nvarchar(250)
	DECLARE @TRX_DATE2 date
	DECLARE @Reversal_Status2 varchar(10)
	DECLARE @MTD_DATE2 Date
	DECLARE @REF2 varchar(50)
	DECLARE @VALUE2 decimal(25,10)
	DECLARE @FEE2 varchar(10)
	DECLARE @TRDATE2 date
	DECLARE @CHK_Account2 nvarchar(50)
	DECLARE @CHARGE_01_REF2 varchar(50)
	DECLARE @CHARGE_01_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_02_REF2 varchar(50)
	DECLARE @CHARGE_02_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_03_REF2 varchar(50)
	DECLARE @CHARGE_03_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_04_REF2 varchar(50)
	DECLARE @CHARGE_04_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_05_REF2 varchar(50)
	DECLARE @CHARGE_05_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_06_REF2 varchar(50)
	DECLARE @CHARGE_06_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_07_REF2 varchar(50)
	DECLARE @CHARGE_07_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_08_REF2 varchar(50)
	DECLARE @CHARGE_08_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_09_REF2 varchar(50)
	DECLARE @CHARGE_09_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_10_REF2 varchar(50)
	DECLARE @CHARGE_10_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_TAX_REF2 varchar(50)
	DECLARE @CHARGE_TAX_VALUE2 Decimal(18,10)
	DECLARE @VALUE2_01 Decimal(18,10)
	DECLARE @VALUE2_02 Decimal(18,10)
	DECLARE @VALUE2_03 Decimal(18,10)
	DECLARE @VALUE2_04 Decimal(18,10)
	DECLARE @VALUE2_05 Decimal(18,10)
	DECLARE @VALUE2_06 Decimal(18,10)
	DECLARE @VALUE2_07 Decimal(18,10)
	DECLARE @VALUE2_08 Decimal(18,10)
	DECLARE @VALUE2_09 Decimal(18,10)
	DECLARE @VALUE2_10 Decimal(18,10)
	DECLARE @VALUE_TAX2 Decimal(18,10)
	DECLARE @VALUE2_EX Decimal(25,10)
	DECLARE @VALUE_EXCHANGE_GAIN_LOSS_2 Decimal(25,10)
	DECLARE @FINAL_VALUE_EX_2 Decimal(25,10)
	DECLARE @GL_ACC_IDENTIFIER2 varchar(10)
	DECLARE @FWD_ACC_NUMBER2 varchar(50)
	DECLARE @KBEW_ID2 int
	DECLARE @RowsToProcess2  int
	DECLARE @CurrentRow2     int
	DECLARE @SelectCol12     int
	DECLARE @CONVERT_VALUE_02 Decimal(18,10)	
	--BEGIN TRY
	--================================ Start TRY ====================================
	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50),TRDate date )  
	INSERT into @table1 (col1,AccID,TRDate) SELECT  min(ID),C,CAST(Z  AS DATE) FROM [dbo].[RAW_DATA] WHERE (P = 'EF' OR P = 'ED') AND A = 'KBEW' AND status = 0 GROUP BY P,Z,C,T  ORDER BY CAST(Z  AS DATE) ASC
	SET @RowsToProcess=@@ROWCOUNT
	SET @CurrentRow=0
	WHILE @CurrentRow<@RowsToProcess
	BEGIN
    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@CHK_Account = AccID,@TRDATE = TRDate FROM @table1 WHERE RowID=@CurrentRow	
	
	IF((RTrim(dbo.Get_Map_Company_From_Bank_Account(@CHK_Account)) = 'CORYELL'))
	BEGIN
	--==============================================================================

	SET @IncVal = @IncVal + dbo.RandFn()

	--==============================================================================
		SET   @TransactionAmout = 0
		SET   @DebitCreditStatus = ''
		SET   @Reversal_Status  = ''
		SET   @Description = ''
		SET   @Description2 = ''
		SET   @Comments = ''
		SET   @ValueRECDesc = ''
		SET   @valueRECCode = ''
		SET   @BankCode = ''
		SET   @FEE = ''
		SET   @MTD_DATE = ''		
		SET   @CHARGE_01_REF  = ''
		SET   @CHARGE_01_VALUE  = 0 
		SET   @CHARGE_02_REF  = ''
		SET   @CHARGE_02_VALUE  = 0
		SET   @CHARGE_03_REF  = ''
		SET   @CHARGE_03_VALUE  = 0
		SET   @CHARGE_04_REF  = ''
		SET   @CHARGE_04_VALUE  = 0
		SET   @CHARGE_05_REF  = ' '
		SET   @CHARGE_05_VALUE  =  0
		SET   @CHARGE_06_REF  = ''
		SET   @CHARGE_06_VALUE  =  0
		SET   @CHARGE_07_REF  = ''
		SET   @CHARGE_07_VALUE  =  0
		SET   @CHARGE_08_REF  = ''
		SET   @CHARGE_08_VALUE  =  0
		SET   @CHARGE_09_REF  = ''
		SET   @CHARGE_09_VALUE  =  0
		SET   @CHARGE_10_REF  = ''
		SET   @CHARGE_10_VALUE  =  0	
		SET   @CHARGE_TAX_REF2 = 0
	    SET   @CHARGE_TAX_VALUE2 = 0	
		SET   @KBEW_ID = 00
		SET   @GL_ACC_IDENTIFIER = ''
		SET   @VALUE_EXCHANGE_GAIN_LOSS = 0
		SET   @VALUE_EX = 0
		SET   @CONVERT_VALUE_01 = 0
		SET   @DebitCreditStatus = ''

		
		SET   @TransactionAmout2 = 0
		SET   @DebitCreditStatus2 = ''
		SET   @Reversal_Status2  = ''
		SET   @Description12 = ''
		SET   @Description22 = ''
		SET   @Comments2 = ''
		SET   @ValueRECDesc2 = ''
		SET   @valueRECCode2 = ''
		SET   @BankCode2 = ''
		SET   @FEE2 = ''
		SET   @MTD_DATE2 = ''		
		SET   @CHARGE_01_REF2  = ''
		SET   @CHARGE_01_VALUE2  = 0 
		SET   @CHARGE_02_REF2  = ''
		SET   @CHARGE_02_VALUE2  = 0
		SET   @CHARGE_03_REF2  = ''
		SET   @CHARGE_03_VALUE2  = 0
		SET   @CHARGE_04_REF2  = ''
		SET   @CHARGE_04_VALUE2  = 0
		SET   @CHARGE_05_REF2  = ' '
		SET   @CHARGE_05_VALUE2  =  0
		SET   @CHARGE_06_REF2  = ''
		SET   @CHARGE_06_VALUE2  =  0
		SET   @CHARGE_07_REF2  = ''
		SET   @CHARGE_07_VALUE2  =  0
		SET   @CHARGE_08_REF2  = ''
		SET   @CHARGE_08_VALUE2  =  0
		SET   @CHARGE_09_REF2  = ''
		SET   @CHARGE_09_VALUE2  =  0
		SET   @CHARGE_10_REF2  = ''
		SET   @CHARGE_10_VALUE2  =  0	
		SET   @CHARGE_TAX_REF2 = 0
	    SET   @CHARGE_TAX_VALUE2 = 0	
		SET   @KBEW_ID2 = 00
		SET   @GL_ACC_IDENTIFIER2 = ''
		SET   @VALUE_EXCHANGE_GAIN_LOSS_2 = 0
		SET   @VALUE2_EX = 0
		SET   @CONVERT_VALUE_02 = 0
		SET   @DebitCreditStatus2 = ''
		--===================================START VALUE SET 01 =====================================================
		--=====================================VALUE SET 01==============================================================

		SELECT @Account = C
				,@SecurityNumber = I
				,@Quantity = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
				,@Price = CASE WHEN (V != ' ') THEN CAST(V  AS Decimal(18,8)) ELSE 0 END
				,@Currency = CASE WHEN ( H != '') THEN CAST(H  AS nvarchar(50)) ELSE '_' END
				,@TransactionDate = CASE WHEN (AA != '00000000') THEN CAST( AA AS DATE)  END
				,@TRX_DATE =  CASE WHEN (Z != '00000000') THEN CAST(Z  AS DATE)  END
				,@LinkedNumber = AK
				,@TransactionAmout = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
				,@DebitCreditStatus = T
				,@Reversal_Status  = U
				,@Description = CASE WHEN (AD != '') THEN CAST(AD AS NVARCHAR(MAX)) ELSE '_' END
				,@Description2 = CASE WHEN (AC != '') THEN CAST(AC AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments = CASE WHEN (AB != '') THEN CAST(AB AS NVARCHAR(MAX)) + ' - ' + CAST(AK AS NVARCHAR(MAX)) ELSE '_' END
				,@ValueRECDesc = A
				,@valueRECCode = CASE WHEN (P != '') THEN CAST(P AS NVARCHAR(MAX)) ELSE '_' END 
				,@BankCode = C
				,@FEE = 'FORWARD'
				,@MTD_DATE = '1900-01-01'
				,@GL_ACC_IDENTIFIER = CASE WHEN (E != '') THEN CAST(E AS NVARCHAR(10)) ELSE '_' END 
				,@E_Column = E

				,@CHARGE_01_REF  = BF
				,@CHARGE_01_VALUE  = CASE WHEN (BG != '') THEN  CAST(BG AS Decimal(18,10)) ELSE 0 END
 
				,@CHARGE_02_REF  = BH
				,@CHARGE_02_VALUE  = CASE WHEN (BI != '') THEN  CAST(BI AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_03_REF  = BJ
				,@CHARGE_03_VALUE  = CASE WHEN (BK != '') THEN   CAST(BK AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_04_REF  = BL
				,@CHARGE_04_VALUE  =  CASE WHEN (BM != '') THEN  CAST(BM AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_05_REF  = BN
				,@CHARGE_05_VALUE  =  CASE WHEN (BO != '') THEN  CAST(BO AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_06_REF  = BP
				,@CHARGE_06_VALUE  =  CASE WHEN (BQ != '') THEN  CAST(BQ AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_07_REF  = BR
				,@CHARGE_07_VALUE  =  CASE WHEN (BS != '') THEN  CAST(BS AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_08_REF  = BT
				,@CHARGE_08_VALUE  =  CASE WHEN (BU != '') THEN  CAST(BU AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_09_REF  = BV
				,@CHARGE_09_VALUE  =  CASE WHEN (BW != '') THEN  CAST(BW AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_10_REF  = BX
				,@CHARGE_10_VALUE  =  CASE WHEN ([BY] != '') THEN  CAST([BY] AS Decimal(18,10)) ELSE 0 END
			
				,@CHARGE_TAX_REF  = '333333'
				,@CHARGE_TAX_VALUE  =  CASE WHEN (AJ != '') THEN  CAST(AJ AS Decimal(18,10)) ELSE 0 END

				,@KBEW_ID = ID

	       FROM dbo.RAW_DATA 
	      WHERE ID = @SelectCol1


	   --=====================================VALUE SET 02==============================================================

	    SELECT @Account2 = C
		      ,@SecurityNumber2 = I
		      ,@Quantity2 = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
		      ,@Price2 = CASE WHEN (V != ' ') THEN CAST(V  AS Decimal(18,8)) ELSE 0 END
		      ,@Currency2 = CASE WHEN ( H != '') THEN CAST(H  AS nvarchar(50)) ELSE '_' END
		      ,@TransactionDate2 = CASE WHEN (AA != '00000000') THEN CAST( AA AS DATE)  END
		      ,@TRX_DATE2 =  CASE WHEN (Z != '00000000') THEN CAST(Z  AS DATE)  END
		      ,@LinkedNumber2 = AK
	          ,@TransactionAmout2 = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END 
			  ,@DebitCreditStatus2 = T
			  ,@Reversal_Status2  = U
			  ,@Description12 = CASE WHEN (AD != '') THEN CAST(AD AS NVARCHAR(MAX)) ELSE '_' END
			  ,@Description22 = CASE WHEN (AC != '') THEN CAST(AC AS NVARCHAR(MAX)) ELSE '_' END
			  ,@Comments2 = CASE WHEN (AB != '') THEN CAST(AB AS NVARCHAR(MAX)) ELSE '_' END
			  ,@ValueRECDesc2 = A
			  ,@valueRECCode2 = CASE WHEN (P != '') THEN CAST(P AS NVARCHAR(MAX)) ELSE '_' END 
			  ,@BankCode2 = C
			  ,@FEE2 = 'FOREX'
			  ,@MTD_DATE2 = '1900-01-01'
			  ,@GL_ACC_IDENTIFIER2 = CASE WHEN (E != '') THEN CAST(E AS NVARCHAR(10)) ELSE '_' END 
		
			  ,@CHARGE_01_REF2  = BF
			  ,@CHARGE_01_VALUE2  = CASE WHEN (BG != '') THEN  CAST(BG AS Decimal(18,10)) ELSE 0 END
 
			  ,@CHARGE_02_REF2  = BH
			  ,@CHARGE_02_VALUE2  = CASE WHEN (BI != '') THEN  CAST(BI AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_03_REF2  = BJ
			  ,@CHARGE_03_VALUE2  = CASE WHEN (BK != '') THEN   CAST(BK AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_04_REF2  = BL
			  ,@CHARGE_04_VALUE2  =  CASE WHEN (BM != '') THEN  CAST(BM AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_05_REF2  = BN
			  ,@CHARGE_05_VALUE2  =  CASE WHEN (BO != '') THEN  CAST(BO AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_06_REF2  = BP
			  ,@CHARGE_06_VALUE2  =  CASE WHEN (BQ != '') THEN  CAST(BQ AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_07_REF2  = BR
			  ,@CHARGE_07_VALUE2  =  CASE WHEN (BS != '') THEN  CAST(BS AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_08_REF2  = BT
			  ,@CHARGE_08_VALUE2  =  CASE WHEN (BU != '') THEN  CAST(BU AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_09_REF2  = BV
			  ,@CHARGE_09_VALUE2  =  CASE WHEN (BW != '') THEN  CAST(BW AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_10_REF2  = BX
			  ,@CHARGE_10_VALUE2  =  CASE WHEN ([BY] != '') THEN  CAST([BY] AS Decimal(18,10)) ELSE 0 END
		
			  ,@CHARGE_TAX_REF2  = '333333'
		      ,@CHARGE_TAX_VALUE2  =  CASE WHEN (AJ != '') THEN  CAST(AJ AS Decimal(18,10)) ELSE 0 END

			  ,@KBEW_ID2 = ID

	     FROM dbo.RAW_DATA 
	    WHERE ID != @SelectCol1
			  AND AK = @LinkedNumber
			  AND A = 'KBEW'
			  AND P = @valueRECCode
			  AND H != @Currency
			  AND T != @DebitCreditStatus
			  AND status = 0

	--===============================================================================================================

	SET @REF =  SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber))
	SET @REF2 =  SUBSTRING(@SecurityNumber2, PATINDEX('%[^0]%', @SecurityNumber2+'.'), LEN(@SecurityNumber2))	

	SELECT @CONVERT_VALUE_01 = dbo.Get_EXCHANGE_RATE_FOREX(@Currency,@TRX_DATE)
	SELECT @CONVERT_VALUE_02 = dbo.Get_EXCHANGE_RATE_FOREX(@Currency2,@TRX_DATE)

	Print '@@@CONVERT_VALUE_01    :'+CAST(@CONVERT_VALUE_01 AS VARCHAR)
	Print '@@@CONVERT_VALUE_02    :'+CAST(@CONVERT_VALUE_02 AS VARCHAR)

	---======================================= INVEQ BLOCK ==========================================================
	
	IF(@TransactionAmout <> 0 AND @TransactionAmout2 <> 0)
	BEGIN

	--print '@@Account2       :'+cast(@Account2 as VARCHAR)
	--============================================= FIRST LINE ======================================================
	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	
	
	--main 
	IF(@Account != '')
	    BEGIN
		    
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

				
		IF(@DebitCreditStatus2 = 'S')
		BEGIN
			SET @VALUE2 = ((@TransactionAmout2 +@CHARGE_01_VALUE2+@CHARGE_02_VALUE2+@CHARGE_03_VALUE2+@CHARGE_04_VALUE2+@CHARGE_05_VALUE2+@CHARGE_06_VALUE2+@CHARGE_07_VALUE2+@CHARGE_08_VALUE2+@CHARGE_09_VALUE2+@CHARGE_10_VALUE2+@CHARGE_TAX_VALUE2) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus2 = 'H')		
		BEGIN
			SET @VALUE2 = (@TransactionAmout2 +@CHARGE_01_VALUE2+@CHARGE_02_VALUE2+@CHARGE_03_VALUE2+@CHARGE_04_VALUE2+@CHARGE_05_VALUE2+@CHARGE_06_VALUE2+@CHARGE_07_VALUE2+@CHARGE_08_VALUE2+@CHARGE_09_VALUE2+@CHARGE_10_VALUE2+@CHARGE_TAX_VALUE2)		
		END	


		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE]
           ,[TRNX_TYPE]
           ,[Description_2]
           ,[Amount_2]
           ,[Currency_2])
     VALUES
           (@TRX_DATE
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,CASE WHEN (@GL_ACC_IDENTIFIER IN ('7010','7011','7013','7014')) THEN '511513'+ @Currency ELSE dbo.Get_Bank_Account(@BankCode,@Currency) END --dbo.Get_Bank_Account(@BankCode,@Currency)
           ,CASE WHEN (@GL_ACC_IDENTIFIER2 IN ('7010','7011','7013','7014')) THEN '511513'+ @Currency2 ELSE dbo.Get_Bank_Account(@BankCode2,@Currency2) END
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE
		   ,@MTD_DATE
		   ,'F'
		   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
		   ,@VALUE2
		   ,@Currency2)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID2

		END
	
	IF(@CHARGE_01_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  01st charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_01
			   ,@Currency2)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  02nd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1)  AS Decimal(18,10))		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_02
			   ,@Currency2)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE <> 0)
	BEGIN
		
	    print 'INSIDE  03rd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
				
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10)) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_03
			   ,@Currency2)


	END

	--04th charge
	IF(@CHARGE_04_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  04h charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_04
			   ,@Currency2)

	END

	--05th charge
	IF(@CHARGE_05_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  05th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_05
			   ,@Currency2)

	END

	--06th charge
	IF(@CHARGE_06_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  06th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)   AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_06
			   ,@Currency2)

	END

	--07th charge
	IF(@CHARGE_07_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  07th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_07
			   ,@Currency2)


	END

	--08th charge
	IF(@CHARGE_08_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  08th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_08
			   ,@Currency2)


	END

	--09th charge
	IF(@CHARGE_09_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  09th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_09
			   ,@Currency2)


	END

	--10th charge
	IF(@CHARGE_10_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  10th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
		       ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_10
			   ,@Currency2)

	END

	--TAX charge
	IF(@CHARGE_TAX_VALUE <> 0)
	BEGIN
				
		print 'INSIDE  TAX charge      :'+cast(@SelectCol1 as VARCHAR)
		
		print 'Inside TAX'
		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,'620049'
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_TAX
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE_TAX2
			   ,@Currency2)

	END	

	
	--EXCHANGE
	IF(@CONVERT_VALUE_01 <> 0 OR @CONVERT_VALUE_02 <> 0)
	BEGIN
			
		SET @RCount = @RCount + 1
		
		SET @EX_DIFF = @CONVERT_VALUE_01 - @CONVERT_VALUE_02

		SET @VALUE_EX = ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02)
		--SET  = ABS(@F_VALUE_EX)

		print 'ABS(@VALUE * @CONVERT_VALUE_01)      :'+CAST(ABS(@VALUE * @CONVERT_VALUE_01) AS VARCHAR)
		print 'ABS(@VALUE2 * @CONVERT_VALUE_02)      :'+CAST(ABS(@VALUE2 * @CONVERT_VALUE_02) AS VARCHAR)
		print 'ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02)      :'+CAST(ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02) AS VARCHAR)
		print '@VALUE_EX      :'+CAST(@VALUE_EX AS VARCHAR)


	    IF((ABS(@VALUE * @CONVERT_VALUE_01) > ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX > 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE  @DebitCreditStatus = S  :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX)	
				SET @FINAL_VALUE_EX_2 = 0
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX > 0 @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX * -1)	
				SET @FINAL_VALUE_EX_2 = 0
			END
		END
		ELSE IF(( ABS(@VALUE * @CONVERT_VALUE_01) > ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX < 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = s :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0	
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX * -1)
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN	
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0	
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX)
			END	
		END	--===========================================================================================
		ELSE IF((ABS(@VALUE * @CONVERT_VALUE_01) < ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX > 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX > 0  @DebitCreditStatus = S :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX)
				SET @FINAL_VALUE_EX_2 = 0	
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX > 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX * -1)
				SET @FINAL_VALUE_EX_2 = 0	
			END	
		END
		ELSE IF((ABS(@VALUE * @CONVERT_VALUE_01) < ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX < 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = S :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX)
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX* -1 )
			END	
		END
		


					
		IF(@VALUE_EX < 0)
		BEGIN
			SET @EX_ACCOUNT = '780001'
		END	
		
		IF(@VALUE_EX > 0)
		BEGIN
			SET @EX_ACCOUNT = '680001'			
		END	



		Print '@@@EX_ACCOUNT    :'+CAST(@EX_ACCOUNT AS VARCHAR)
		 
		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TRX_DATE
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@EX_ACCOUNT
			   ,@EX_ACCOUNT
			   ,@FINAL_VALUE_EX
			   ,'USD'
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@FINAL_VALUE_EX_2
			   ,'USD')

	END	
	
	END -- CHECK Both 2 values are NOT = 0
	END 
	
	END


	--END TRY
	----================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_FOREX]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_FOREX]
AS
BEGIN	
	DECLARE @RW_Count_ID int
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(50)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,10)
	DECLARE @Price decimal(18,10)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(25,10)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE date
	DECLARE @Reversal_Status varchar(10)
	DECLARE @MTD_DATE Date
	DECLARE @REF varchar(50)
	DECLARE @VALUE decimal(25,10)
	DECLARE @FEE varchar(10)
	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,10)
	DECLARE @RCount int
	DECLARE @TRDATE date
	DECLARE @CHK_Account nvarchar(50)
	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,10)
	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,10)
	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,10)
	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,10)
	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,10)
	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,10)
	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,10)
	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,10)
	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,10)
	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,10)
	DECLARE @CHARGE_TAX_REF varchar(50)
	DECLARE @CHARGE_TAX_VALUE Decimal(18,10)
	DECLARE @VALUE_01 Decimal(18,10)
	DECLARE @VALUE_02 Decimal(18,10)
	DECLARE @VALUE_03 Decimal(18,10)
	DECLARE @VALUE_04 Decimal(18,10)
	DECLARE @VALUE_05 Decimal(18,10)
	DECLARE @VALUE_06 Decimal(18,10)
	DECLARE @VALUE_07 Decimal(18,10)
	DECLARE @VALUE_08 Decimal(18,10)
	DECLARE @VALUE_09 Decimal(18,10)
	DECLARE @VALUE_10 Decimal(18,10)
	DECLARE @VALUE_TAX Decimal(18,10)	
	DECLARE @VALUE_EX Decimal(25,10)
	DECLARE @F_VALUE_EX Decimal(25,10)
	DECLARE @VALUE_EXCHANGE_GAIN_LOSS Decimal(25,10)
	DECLARE @FINAL_VALUE_EX Decimal(25,10)
	DECLARE @GL_ACC_IDENTIFIER varchar(10)
	DECLARE @FWD_ACC_NUMBER varchar(50)
	DECLARE @KBEW_ID int	
	DECLARE @E_Column varchar(20)
	DECLARE @CONVERT_VALUE_01 Decimal(18,10)	
	DECLARE @EX_ACCOUNT varchar(50)
	DECLARE @EX_DIFF decimal(18,10)


	--=========================================================
	DECLARE @Account2 nvarchar(50)
	DECLARE @SecurityNumber2 nvarchar(50)
	DECLARE @Quantity2 decimal(18,10)
	DECLARE @Price2 decimal(18,10)
	DECLARE @Currency2 nvarchar(50)
	DECLARE @TransactionDate2 date
	DECLARE @Description12 nvarchar(250) -- need to select transaction record
	DECLARE @Description22 nvarchar(250)
	DECLARE @LinkedNumber2 nvarchar(150)	
	DECLARE @DebitCreditStatus2 nvarchar(10)	
	DECLARE @TransactionAmout2 decimal(25,10)
	DECLARE @ValueRECDesc2 varchar(50)
	DECLARE @valueRECCode2 varchar(50)
	DECLARE @BankCode2 varchar(50)
	DECLARE @TOP2 varchar(50) 
	DECLARE @Comments2 nvarchar(250)
	DECLARE @TRX_DATE2 date
	DECLARE @Reversal_Status2 varchar(10)
	DECLARE @MTD_DATE2 Date
	DECLARE @REF2 varchar(50)
	DECLARE @VALUE2 decimal(25,10)
	DECLARE @FEE2 varchar(10)
	DECLARE @TRDATE2 date
	DECLARE @CHK_Account2 nvarchar(50)
	DECLARE @CHARGE_01_REF2 varchar(50)
	DECLARE @CHARGE_01_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_02_REF2 varchar(50)
	DECLARE @CHARGE_02_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_03_REF2 varchar(50)
	DECLARE @CHARGE_03_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_04_REF2 varchar(50)
	DECLARE @CHARGE_04_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_05_REF2 varchar(50)
	DECLARE @CHARGE_05_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_06_REF2 varchar(50)
	DECLARE @CHARGE_06_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_07_REF2 varchar(50)
	DECLARE @CHARGE_07_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_08_REF2 varchar(50)
	DECLARE @CHARGE_08_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_09_REF2 varchar(50)
	DECLARE @CHARGE_09_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_10_REF2 varchar(50)
	DECLARE @CHARGE_10_VALUE2 Decimal(18,10)
	DECLARE @CHARGE_TAX_REF2 varchar(50)
	DECLARE @CHARGE_TAX_VALUE2 Decimal(18,10)
	DECLARE @VALUE2_01 Decimal(18,10)
	DECLARE @VALUE2_02 Decimal(18,10)
	DECLARE @VALUE2_03 Decimal(18,10)
	DECLARE @VALUE2_04 Decimal(18,10)
	DECLARE @VALUE2_05 Decimal(18,10)
	DECLARE @VALUE2_06 Decimal(18,10)
	DECLARE @VALUE2_07 Decimal(18,10)
	DECLARE @VALUE2_08 Decimal(18,10)
	DECLARE @VALUE2_09 Decimal(18,10)
	DECLARE @VALUE2_10 Decimal(18,10)
	DECLARE @VALUE_TAX2 Decimal(18,10)
	DECLARE @VALUE2_EX Decimal(25,10)
	DECLARE @VALUE_EXCHANGE_GAIN_LOSS_2 Decimal(25,10)
	DECLARE @FINAL_VALUE_EX_2 Decimal(25,10)
	DECLARE @GL_ACC_IDENTIFIER2 varchar(10)
	DECLARE @FWD_ACC_NUMBER2 varchar(50)
	DECLARE @KBEW_ID2 int
	DECLARE @RowsToProcess2  int
	DECLARE @CurrentRow2     int
	DECLARE @SelectCol12     int
	DECLARE @CONVERT_VALUE_02 Decimal(18,10)	
	--BEGIN TRY
	--================================ Start TRY ====================================
	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50),TRDate date )  
	INSERT into @table1 (col1,AccID,TRDate) SELECT  min(ID),C,CAST(Z  AS DATE) FROM [dbo].[RAW_DATA] WHERE (P = 'EB' OR P = 'EA') AND A = 'KBEW' AND status = 0 GROUP BY P,Z,C,T  ORDER BY CAST(Z  AS DATE) ASC --GROUP BY P,AK,Z,C
	SET @RowsToProcess=@@ROWCOUNT
	SET @CurrentRow=0
	WHILE @CurrentRow<@RowsToProcess
	BEGIN
    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@CHK_Account = AccID,@TRDATE = TRDate FROM @table1 WHERE RowID=@CurrentRow	
	
	IF((RTrim(dbo.Get_Map_Company_From_Bank_Account(@CHK_Account)) = 'CORYELL'))
	BEGIN
	--==============================================================================

	SET @IncVal = @IncVal + dbo.RandFn()

	--==============================================================================
		SET   @TransactionAmout = 0
		SET   @DebitCreditStatus = ''
		SET   @Reversal_Status  = ''
		SET   @Description = ''
		SET   @Description2 = ''
		SET   @Comments = ''
		SET   @ValueRECDesc = ''
		SET   @valueRECCode = ''
		SET   @BankCode = ''
		SET   @FEE = ''
		SET   @MTD_DATE = ''		
		SET   @CHARGE_01_REF  = ''
		SET   @CHARGE_01_VALUE  = 0 
		SET   @CHARGE_02_REF  = ''
		SET   @CHARGE_02_VALUE  = 0
		SET   @CHARGE_03_REF  = ''
		SET   @CHARGE_03_VALUE  = 0
		SET   @CHARGE_04_REF  = ''
		SET   @CHARGE_04_VALUE  = 0
		SET   @CHARGE_05_REF  = ' '
		SET   @CHARGE_05_VALUE  =  0
		SET   @CHARGE_06_REF  = ''
		SET   @CHARGE_06_VALUE  =  0
		SET   @CHARGE_07_REF  = ''
		SET   @CHARGE_07_VALUE  =  0
		SET   @CHARGE_08_REF  = ''
		SET   @CHARGE_08_VALUE  =  0
		SET   @CHARGE_09_REF  = ''
		SET   @CHARGE_09_VALUE  =  0
		SET   @CHARGE_10_REF  = ''
		SET   @CHARGE_10_VALUE  =  0	
		SET   @CHARGE_TAX_REF2 = 0
	    SET   @CHARGE_TAX_VALUE2 = 0	
		SET   @KBEW_ID = 00
		SET   @GL_ACC_IDENTIFIER = ''
		SET   @VALUE_EXCHANGE_GAIN_LOSS = 0
		SET   @VALUE_EX = 0
		SET   @CONVERT_VALUE_01 = 0

		
		SET   @TransactionAmout2 = 0
		SET   @DebitCreditStatus2 = ''
		SET   @Reversal_Status2  = ''
		SET   @Description12 = ''
		SET   @Description22 = ''
		SET   @Comments2 = ''
		SET   @ValueRECDesc2 = ''
		SET   @valueRECCode2 = ''
		SET   @BankCode2 = ''
		SET   @FEE2 = ''
		SET   @MTD_DATE2 = ''		
		SET   @CHARGE_01_REF2  = ''
		SET   @CHARGE_01_VALUE2  = 0 
		SET   @CHARGE_02_REF2  = ''
		SET   @CHARGE_02_VALUE2  = 0
		SET   @CHARGE_03_REF2  = ''
		SET   @CHARGE_03_VALUE2  = 0
		SET   @CHARGE_04_REF2  = ''
		SET   @CHARGE_04_VALUE2  = 0
		SET   @CHARGE_05_REF2  = ' '
		SET   @CHARGE_05_VALUE2  =  0
		SET   @CHARGE_06_REF2  = ''
		SET   @CHARGE_06_VALUE2  =  0
		SET   @CHARGE_07_REF2  = ''
		SET   @CHARGE_07_VALUE2  =  0
		SET   @CHARGE_08_REF2  = ''
		SET   @CHARGE_08_VALUE2  =  0
		SET   @CHARGE_09_REF2  = ''
		SET   @CHARGE_09_VALUE2  =  0
		SET   @CHARGE_10_REF2  = ''
		SET   @CHARGE_10_VALUE2  =  0	
		SET   @CHARGE_TAX_REF2 = 0
	    SET   @CHARGE_TAX_VALUE2 = 0	
		SET   @KBEW_ID2 = 00
		SET   @GL_ACC_IDENTIFIER2 = ''
		SET   @VALUE_EXCHANGE_GAIN_LOSS_2 = 0
		SET   @VALUE2_EX = 0
		SET   @CONVERT_VALUE_02 = 0

		--===================================START VALUE SET 01 =====================================================
		--=====================================VALUE SET 01==============================================================

		SELECT @Account = C
				,@SecurityNumber = I
				,@Quantity = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
				,@Price = CASE WHEN (V != ' ') THEN CAST(V  AS Decimal(18,8)) ELSE 0 END
				,@Currency = CASE WHEN ( H != '') THEN CAST(H  AS nvarchar(50)) ELSE '_' END
				,@TransactionDate = CASE WHEN (AA != '00000000') THEN CAST( AA AS DATE)  END
				,@TRX_DATE =  CASE WHEN (Z != '00000000') THEN CAST(Z  AS DATE)  END
				,@LinkedNumber = AK
				,@TransactionAmout = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
				,@DebitCreditStatus = T
				,@Reversal_Status  = U
				,@Description = CASE WHEN (AD != '') THEN CAST(AD AS NVARCHAR(MAX)) ELSE '_' END
				,@Description2 = CASE WHEN (AC != '') THEN CAST(AC AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments = CASE WHEN (AB != '') THEN CAST(AB AS NVARCHAR(MAX))+ ' - ' + CAST(AK AS NVARCHAR(MAX)) ELSE '_' END
				,@ValueRECDesc = A
				,@valueRECCode = CASE WHEN (P != '') THEN CAST(P AS NVARCHAR(MAX)) ELSE '_' END 
				,@BankCode = C
				,@FEE = 'FOREX'
				,@MTD_DATE = '1900-01-01'
				,@GL_ACC_IDENTIFIER = CASE WHEN (E != '') THEN CAST(E AS NVARCHAR(10)) ELSE '_' END 
				,@E_Column = E

				,@CHARGE_01_REF  = BF
				,@CHARGE_01_VALUE  = CASE WHEN (BG != '') THEN  CAST(BG AS Decimal(18,10)) ELSE 0 END
 
				,@CHARGE_02_REF  = BH
				,@CHARGE_02_VALUE  = CASE WHEN (BI != '') THEN  CAST(BI AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_03_REF  = BJ
				,@CHARGE_03_VALUE  = CASE WHEN (BK != '') THEN   CAST(BK AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_04_REF  = BL
				,@CHARGE_04_VALUE  =  CASE WHEN (BM != '') THEN  CAST(BM AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_05_REF  = BN
				,@CHARGE_05_VALUE  =  CASE WHEN (BO != '') THEN  CAST(BO AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_06_REF  = BP
				,@CHARGE_06_VALUE  =  CASE WHEN (BQ != '') THEN  CAST(BQ AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_07_REF  = BR
				,@CHARGE_07_VALUE  =  CASE WHEN (BS != '') THEN  CAST(BS AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_08_REF  = BT
				,@CHARGE_08_VALUE  =  CASE WHEN (BU != '') THEN  CAST(BU AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_09_REF  = BV
				,@CHARGE_09_VALUE  =  CASE WHEN (BW != '') THEN  CAST(BW AS Decimal(18,10)) ELSE 0 END

				,@CHARGE_10_REF  = BX
				,@CHARGE_10_VALUE  =  CASE WHEN ([BY] != '') THEN  CAST([BY] AS Decimal(18,10)) ELSE 0 END
			
				,@CHARGE_TAX_REF  = '333333'
				,@CHARGE_TAX_VALUE  =  CASE WHEN (AJ != '') THEN  CAST(AJ AS Decimal(18,10)) ELSE 0 END

				,@KBEW_ID = ID

	       FROM dbo.RAW_DATA 
	      WHERE ID = @SelectCol1


	   --=====================================VALUE SET 02==============================================================

	    SELECT @Account2 = C
		      ,@SecurityNumber2 = I
		      ,@Quantity2 = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
		      ,@Price2 = CASE WHEN (V != ' ') THEN CAST(V  AS Decimal(18,8)) ELSE 0 END
		      ,@Currency2 = CASE WHEN ( H != '') THEN CAST(H  AS nvarchar(50)) ELSE '_' END
		      ,@TransactionDate2 = CASE WHEN (AA != '00000000') THEN CAST( AA AS DATE)  END
		      ,@TRX_DATE2 =  CASE WHEN (Z != '00000000') THEN CAST(Z  AS DATE)  END
		      ,@LinkedNumber2 = AK
	          ,@TransactionAmout2 = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END 
			  ,@DebitCreditStatus2 = T
			  ,@Reversal_Status2  = U
			  ,@Description12 = CASE WHEN (AD != '') THEN CAST(AD AS NVARCHAR(MAX)) ELSE '_' END
			  ,@Description22 = CASE WHEN (AC != '') THEN CAST(AC AS NVARCHAR(MAX)) ELSE '_' END
			  ,@Comments2 = CASE WHEN (AB != '') THEN CAST(AB AS NVARCHAR(MAX)) ELSE '_' END
			  ,@ValueRECDesc2 = A
			  ,@valueRECCode2 = CASE WHEN (P != '') THEN CAST(P AS NVARCHAR(MAX)) ELSE '_' END 
			  ,@BankCode2 = C
			  ,@FEE2 = 'FOREX'
			  ,@MTD_DATE2 = '1900-01-01'
			  ,@GL_ACC_IDENTIFIER2 = CASE WHEN (E != '') THEN CAST(E AS NVARCHAR(10)) ELSE '_' END 
		
			  ,@CHARGE_01_REF2  = BF
			  ,@CHARGE_01_VALUE2  = CASE WHEN (BG != '') THEN  CAST(BG AS Decimal(18,10)) ELSE 0 END
 
			  ,@CHARGE_02_REF2  = BH
			  ,@CHARGE_02_VALUE2  = CASE WHEN (BI != '') THEN  CAST(BI AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_03_REF2  = BJ
			  ,@CHARGE_03_VALUE2  = CASE WHEN (BK != '') THEN   CAST(BK AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_04_REF2  = BL
			  ,@CHARGE_04_VALUE2  =  CASE WHEN (BM != '') THEN  CAST(BM AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_05_REF2  = BN
			  ,@CHARGE_05_VALUE2  =  CASE WHEN (BO != '') THEN  CAST(BO AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_06_REF2  = BP
			  ,@CHARGE_06_VALUE2  =  CASE WHEN (BQ != '') THEN  CAST(BQ AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_07_REF2  = BR
			  ,@CHARGE_07_VALUE2  =  CASE WHEN (BS != '') THEN  CAST(BS AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_08_REF2  = BT
			  ,@CHARGE_08_VALUE2  =  CASE WHEN (BU != '') THEN  CAST(BU AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_09_REF2  = BV
			  ,@CHARGE_09_VALUE2  =  CASE WHEN (BW != '') THEN  CAST(BW AS Decimal(18,10)) ELSE 0 END

			  ,@CHARGE_10_REF2  = BX
			  ,@CHARGE_10_VALUE2  =  CASE WHEN ([BY] != '') THEN  CAST([BY] AS Decimal(18,10)) ELSE 0 END
		
			  ,@CHARGE_TAX_REF2  = '333333'
		      ,@CHARGE_TAX_VALUE2  =  CASE WHEN (AJ != '') THEN  CAST(AJ AS Decimal(18,10)) ELSE 0 END

			  ,@KBEW_ID2 = ID

	     FROM dbo.RAW_DATA 
	    WHERE ID != @SelectCol1
			  AND AK = @LinkedNumber
			  AND A = 'KBEW'
			  AND P = @valueRECCode
			  --AND H != @Currency
			  AND status = 0

	--===============================================================================================================

	SET @REF =  SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber))
	SET @REF2 =  SUBSTRING(@SecurityNumber2, PATINDEX('%[^0]%', @SecurityNumber2+'.'), LEN(@SecurityNumber2))	

	SELECT @CONVERT_VALUE_01 = dbo.Get_EXCHANGE_RATE_FOREX(@Currency,@TRX_DATE)
	SELECT @CONVERT_VALUE_02 = dbo.Get_EXCHANGE_RATE_FOREX(@Currency2,@TRX_DATE)

	Print '@@@CONVERT_VALUE_01    :'+CAST(@CONVERT_VALUE_01 AS VARCHAR)
	Print '@@@CONVERT_VALUE_02    :'+CAST(@CONVERT_VALUE_02 AS VARCHAR)

	---======================================= INVEQ BLOCK ==========================================================
	
	IF(@TransactionAmout <> 0 AND @TransactionAmout2 <> 0)
	BEGIN

	--print '@@Account2       :'+cast(@Account2 as VARCHAR)
	--============================================= FIRST LINE ======================================================
	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	
	
	--print '@@Account2       :'+cast(@Account2 as VARCHAR)	

	--main 
    IF(@Account != '')
	    BEGIN
		    
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

				
		IF(@DebitCreditStatus2 = 'S')
		BEGIN
			SET @VALUE2 = ((@TransactionAmout2 +@CHARGE_01_VALUE2+@CHARGE_02_VALUE2+@CHARGE_03_VALUE2+@CHARGE_04_VALUE2+@CHARGE_05_VALUE2+@CHARGE_06_VALUE2+@CHARGE_07_VALUE2+@CHARGE_08_VALUE2+@CHARGE_09_VALUE2+@CHARGE_10_VALUE2+@CHARGE_TAX_VALUE2) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus2 = 'H')		
		BEGIN
			SET @VALUE2 = (@TransactionAmout2 +@CHARGE_01_VALUE2+@CHARGE_02_VALUE2+@CHARGE_03_VALUE2+@CHARGE_04_VALUE2+@CHARGE_05_VALUE2+@CHARGE_06_VALUE2+@CHARGE_07_VALUE2+@CHARGE_08_VALUE2+@CHARGE_09_VALUE2+@CHARGE_10_VALUE2+@CHARGE_TAX_VALUE2)		
		END	


		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE]
           ,[TRNX_TYPE]
           ,[Description_2]
           ,[Amount_2]
           ,[Currency_2])
     VALUES
           (@TRX_DATE
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,dbo.Get_Bank_Account(@BankCode2,@Currency2)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE
		   ,@MTD_DATE
		   ,'F'
		   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
		   ,@VALUE2
		   ,@Currency2)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID2

		END

	--01st charge
	IF(@CHARGE_01_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  01st charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_01
			   ,@Currency2)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  02nd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1)  AS Decimal(18,10))		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_02
			   ,@Currency2)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE <> 0)
	BEGIN
		
	    print 'INSIDE  03rd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
				
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10)) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_03
			   ,@Currency2)


	END

	--04th charge
	IF(@CHARGE_04_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  04h charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_04
			   ,@Currency2)

	END

	--05th charge
	IF(@CHARGE_05_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  05th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_05
			   ,@Currency2)

	END

	--06th charge
	IF(@CHARGE_06_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  06th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)   AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_06
			   ,@Currency2)

	END

	--07th charge
	IF(@CHARGE_07_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  07th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_07
			   ,@Currency2)


	END

	--08th charge
	IF(@CHARGE_08_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  08th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_08
			   ,@Currency2)


	END

	--09th charge
	IF(@CHARGE_09_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  09th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_09
			   ,@Currency2)


	END

	--10th charge
	IF(@CHARGE_10_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  10th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
		       ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE2_10
			   ,@Currency2)

	END

	--TAX charge
	IF(@CHARGE_TAX_VALUE <> 0)
	BEGIN
				
		print 'INSIDE  TAX charge      :'+cast(@SelectCol1 as VARCHAR)
		
		print 'Inside TAX'
		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,'620049'
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_TAX
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@VALUE_TAX2
			   ,@Currency2)

	END	

	
	--EXCHANGE
	IF(@CONVERT_VALUE_01 <> 0 OR @CONVERT_VALUE_02 <> 0)
	BEGIN
			
		SET @RCount = @RCount + 1
		
		SET @EX_DIFF = @CONVERT_VALUE_01 - @CONVERT_VALUE_02

		SET @VALUE_EX = ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02)
		--SET  = ABS(@F_VALUE_EX)

		print 'ABS(@VALUE * @CONVERT_VALUE_01)      :'+CAST(ABS(@VALUE * @CONVERT_VALUE_01) AS VARCHAR)
		print 'ABS(@VALUE2 * @CONVERT_VALUE_02)      :'+CAST(ABS(@VALUE2 * @CONVERT_VALUE_02) AS VARCHAR)
		print 'ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02)      :'+CAST(ABS(@VALUE * @CONVERT_VALUE_01) - ABS(@VALUE2 * @CONVERT_VALUE_02) AS VARCHAR)
		print '@VALUE_EX      :'+CAST(@VALUE_EX AS VARCHAR)


	    IF((ABS(@VALUE * @CONVERT_VALUE_01) > ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX > 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE  @DebitCreditStatus = S  :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX)	
				SET @FINAL_VALUE_EX_2 = 0
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX > 0 @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX * -1)	
				SET @FINAL_VALUE_EX_2 = 0
			END
		END
		ELSE IF(( ABS(@VALUE * @CONVERT_VALUE_01) > ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX < 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = s :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0	
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX * -1)
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN	
				print 'INSIDE FIRST VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0	
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX)
			END	
		END	--===========================================================================================
		ELSE IF((ABS(@VALUE * @CONVERT_VALUE_01) < ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX > 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX > 0  @DebitCreditStatus = S :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX)
				SET @FINAL_VALUE_EX_2 = 0	
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX > 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = (@VALUE_EX * -1)
				SET @FINAL_VALUE_EX_2 = 0	
			END	
		END
		ELSE IF((ABS(@VALUE * @CONVERT_VALUE_01) < ABS(@VALUE2 * @CONVERT_VALUE_02)) AND (@VALUE_EX < 0))
		BEGIN
			IF(@DebitCreditStatus = 'S')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = S :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX)
			END
			ELSE IF(@DebitCreditStatus = 'H')
			BEGIN
				print 'INSIDE SECOND VALUE LARGE @VALUE_EX < 0  @DebitCreditStatus = H :'+CAST(@VALUE_EX AS VARCHAR)
				SET @FINAL_VALUE_EX = 0
				SET @FINAL_VALUE_EX_2 = (@VALUE_EX* -1 )
			END	
		END
		


					
		IF(@VALUE_EX < 0)
		BEGIN
			SET @EX_ACCOUNT = '780001'
		END	
		
		IF(@VALUE_EX > 0)
		BEGIN
			SET @EX_ACCOUNT = '680001'			
		END	



		Print '@@@EX_ACCOUNT    :'+CAST(@EX_ACCOUNT AS VARCHAR)
		 
		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE]
			   ,[MTD_DATE]
			   ,[TRNX_TYPE]
			   ,[Description_2]
			   ,[Amount_2]
			   ,[Currency_2])
		 VALUES
			   (@TRX_DATE
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@EX_ACCOUNT
			   ,@EX_ACCOUNT
			   ,@FINAL_VALUE_EX
			   ,'USD'
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE2
			   ,'F'
			   ,CAST((@Description12+' - '+@Description22) AS NVARCHAR)
			   ,@FINAL_VALUE_EX_2
			   ,'USD')

	END	
	

	END -- CHECK Both 2 values are NOT = 0

	END 
	
	END -- BANK ACCOUNT


	--END TRY
	----================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_COUPON]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_COUPON]
AS
BEGIN
	
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(50)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,10)
	DECLARE @Price decimal(18,10)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(18,10)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @AL decimal(18,10)
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE date
	DECLARE @MTD_DATE Date
	DECLARE @TK_Currency varchar(50)
	DECLARE @Temp_Value decimal(18,10)
	DECLARE @Reversal_Status varchar(10)

	DECLARE @REF varchar(50)
	DECLARE @VALUE decimal(18,10)
	DECLARE @FEE varchar(10)
	DECLARE @DC_CLOLUMN int

	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,10)
	DECLARE @RCount int
	DECLARE @CHK_Account nvarchar(50)

	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,10)

	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,10)

	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,10)

	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,10)

	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,10)

	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,10)

	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,10)

	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,10)

	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,10)

	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,10)

    DECLARE @CHARGE_TAX_REF varchar(50)
	DECLARE @CHARGE_TAX_VALUE Decimal(18,10)

	DECLARE @VALUE_01 Decimal(18,10)
	DECLARE @VALUE_02 Decimal(18,10)
	DECLARE @VALUE_03 Decimal(18,10)
	DECLARE @VALUE_04 Decimal(18,10)
	DECLARE @VALUE_05 Decimal(18,10)
	DECLARE @VALUE_06 Decimal(18,10)
	DECLARE @VALUE_07 Decimal(18,10)
	DECLARE @VALUE_08 Decimal(18,10)
	DECLARE @VALUE_09 Decimal(18,10)
	DECLARE @VALUE_10 Decimal(18,10)
	DECLARE @VALUE_TAX Decimal(18,10)


	--BEGIN TRY
	--================================ Start TRY ====================================


	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50) )  

	INSERT into @table1 (col1,AccID) select ID,C from [dbo].[RAW_DATA] where A = 'KBEW' AND  (P = 'PB' OR P = 'TK' OR P = 'PF' OR P = 'SB' OR P = 'EX' OR P = 'NF' OR P = 'MT') AND status = 0 GROUP BY ID,AK,C,Z  ORDER BY   CAST(Z  AS DATE) ASC
	
	SET @RowsToProcess=@@ROWCOUNT

	SET @CurrentRow=0
	WHILE @CurrentRow<@RowsToProcess
	BEGIN
    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@CHK_Account = AccID FROM @table1 WHERE RowID=@CurrentRow
	
	IF((RTrim(dbo.Get_Map_Company_From_Bank_Account(@CHK_Account)) = 'CORYELL'))
	BEGIN
	--==============================================================================
	SET @IncVal = @IncVal + dbo.RandFn()

	print @SelectCol1
		
		SET   @TransactionAmout = 0
		SET   @DebitCreditStatus = ''
		SET   @Description = ''
		SET   @Description2 = ''
		SET   @Comments = ''
		SET   @ValueRECDesc = ''
		SET   @valueRECCode = ''
		SET   @BankCode = ''
		SET   @FEE = ''		
		SET   @CHARGE_01_REF  = ''
		SET   @CHARGE_01_VALUE  = 0 
		SET   @CHARGE_02_REF  = ''
		SET   @CHARGE_02_VALUE  = 0
		SET   @CHARGE_03_REF  = ''
		SET   @CHARGE_03_VALUE  = 0
		SET   @CHARGE_04_REF  = ''
		SET   @CHARGE_04_VALUE  = 0
		SET   @CHARGE_05_REF  = ''
		SET   @CHARGE_05_VALUE  =  0
		SET   @CHARGE_06_REF  = ''
		SET   @CHARGE_06_VALUE  =  0
		SET   @CHARGE_07_REF  = ''
		SET   @CHARGE_07_VALUE  =  0
		SET   @CHARGE_08_REF  = ''
		SET   @CHARGE_08_VALUE  =  0
		SET   @CHARGE_09_REF  = ''
		SET   @CHARGE_09_VALUE  =  0
		SET   @CHARGE_10_REF  = ''
		SET   @CHARGE_10_VALUE  =  0
		SET   @TK_Currency = ''	
		SET   @Temp_Value = 0
		SET   @RCount = 0

    SELECT @DBEWorKBEW = A
		,@Account = C
		,@SecurityNumber = I
		,@Quantity =  CASE WHEN (AL != ' ') THEN  CAST(AL  AS Decimal(18,10)) ELSE 0 END
		--,@Price = CASE WHEN (AL != ' ') AND (S != ' ') THEN CASE WHEN CAST(AL AS Decimal(18,5)) != 0 AND CAST(S AS Decimal(18,5)) != 0 THEN ABS(CAST(S AS Decimal(18,5))/CAST(AL AS Decimal(18,5))) ELSE 0 END ELSE 0 END  
		,@AL = CASE WHEN (AL != ' ') THEN  CAST(AL  AS Decimal(18,10)) ELSE 0 END
		,@Currency = H
		,@TransactionDate = CASE WHEN (AA != '00000000') THEN CAST( AA AS DATE)  END
		,@TRX_DATE =  CASE WHEN (Z != '00000000') THEN CAST(Z  AS DATE)  END
		,@LinkedNumber = AK	
		,@TransactionAmout =  CASE WHEN (S != ' ') THEN CAST(S  AS Decimal(18,10)) ELSE 0 END
		,@DebitCreditStatus = T
		,@Description = CASE WHEN (AD != '') THEN CAST(AD AS NVARCHAR(MAX)) ELSE '_' END
		,@Description2 = CASE WHEN (AC != '') THEN CAST(AC AS NVARCHAR(MAX)) ELSE '_' END
		,@Comments = CASE WHEN (AB != '') THEN CAST(AB AS NVARCHAR(MAX)) ELSE '_' END
		,@ValueRECDesc = A
		,@valueRECCode = P
		,@BankCode = C
		,@FEE = 'CPN'
		,@MTD_DATE = '1900-01-01'
		,@TK_Currency = CASE WHEN (H != '') THEN CAST(H AS NVARCHAR(MAX)) ELSE '_' END
		,@Temp_Value = CASE WHEN (S != ' ') THEN  CAST(S  AS Decimal(18,10)) ELSE 0 END
		,@DC_CLOLUMN = CASE WHEN (DC != '') THEN CAST(DC AS int) ELSE 3333 END
		,@Reversal_Status  = U

		,@CHARGE_01_REF  = BF
		,@CHARGE_01_VALUE  = CASE WHEN (BG != '') THEN  CAST(BG AS Decimal(18,10)) ELSE 0 END
 
		,@CHARGE_02_REF  = BH
		,@CHARGE_02_VALUE  = CASE WHEN (BI != '') THEN  CAST(BI AS Decimal(18,10)) ELSE 0 END

		,@CHARGE_03_REF  = BJ
		,@CHARGE_03_VALUE  = CASE WHEN (BK != '') THEN   CAST(BK AS Decimal(18,10)) ELSE 0 END

		,@CHARGE_04_REF  = BL
		,@CHARGE_04_VALUE  =  CASE WHEN (BM != '') THEN  CAST(BM AS Decimal(18,10)) ELSE 0 END

		,@CHARGE_05_REF  = BN
		,@CHARGE_05_VALUE  =  CASE WHEN (BO != '') THEN  CAST(BO AS Decimal(18,10)) ELSE 0 END

		,@CHARGE_06_REF  = BP
		,@CHARGE_06_VALUE  =  CASE WHEN (BQ != '') THEN  CAST(BQ AS Decimal(18,10)) ELSE 0 END

		,@CHARGE_07_REF  = BR
		,@CHARGE_07_VALUE  =  CASE WHEN (BS != '') THEN  CAST(BS AS Decimal(18,10)) ELSE 0 END

		,@CHARGE_08_REF  = BT
		,@CHARGE_08_VALUE  =  CASE WHEN (BU != '') THEN  CAST(BU AS Decimal(18,10)) ELSE 0 END

		,@CHARGE_09_REF  = BV
		,@CHARGE_09_VALUE  =  CASE WHEN (BW != '') THEN  CAST(BW AS Decimal(18,10)) ELSE 0 END

		,@CHARGE_10_REF  = BX
		,@CHARGE_10_VALUE  =  CASE WHEN ([BY] != '') THEN  CAST([BY] AS Decimal(18,10)) ELSE 0 END

		,@CHARGE_TAX_REF  = '333333'
		,@CHARGE_TAX_VALUE  =  CASE WHEN (AJ != '') THEN  CAST(AJ AS Decimal(18,10)) ELSE 0 END

	FROM dbo.RAW_DATA 
	WHERE ID = @SelectCol1
	
	SET @REF =  SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber))
	SET @Price  = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)/CASE WHEN @Quantity = 0 THEN 1 ELSE @Quantity END)
	
	--==========================================COUPON================================================================
	IF(@valueRECCode = 'PB')
	BEGIN

	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	IF(@DC_CLOLUMN BETWEEN 0 AND 8)
	BEGIN
	
	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,'INI'
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,'INI'
           ,'770003'
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1

		END

	END
	ELSE IF(@DC_CLOLUMN BETWEEN 10 AND 19)
	BEGIN
	
	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,'DIV'
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,'DIV'
           ,'770004'
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1

		END

	END
	ELSE IF(@DC_CLOLUMN BETWEEN 86 AND 89)
	BEGIN
	
	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,'DIV'
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,'DIV'
           ,'770004'
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1

		END

	END
	ELSE
	BEGIN
	
	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,'CPN'
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,'CPN'
           ,'770005'
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1

		END

	END


	
    --01st charge
	IF(@CHARGE_01_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  01st charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  02nd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1)  AS Decimal(18,10))		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE <> 0)
	BEGIN
		
	    print 'INSIDE  03rd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
				
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10)) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  04h charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  05th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  06th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)   AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  07th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  08th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  09th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  10th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
		       ,@Comments
			   ,@TRX_DATE)

	END

	--TAX charge
	IF(@CHARGE_TAX_VALUE <> 0)
	BEGIN
				
		print 'INSIDE  TAX charge      :'+cast(@SelectCol1 as VARCHAR)
		
		print 'Inside TAX'
		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,'620049'
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_TAX
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	END

	--================================================================================================================
	ELSE IF(@valueRECCode = 'TK')
	BEGIN

	SET @Currency = @TK_Currency
	SET @TransactionAmout = @Temp_Value

	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
			,[Comment]
			,[TRX_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'620043'
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1

		END
	

    --01st charge
	IF(@CHARGE_01_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  01st charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  02nd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1)  AS Decimal(18,10))		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE <> 0)
	BEGIN
		
	    print 'INSIDE  03rd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
				
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10)) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  04h charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  05th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  06th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)   AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  07th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  08th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  09th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  10th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
		       ,@Comments
			   ,@TRX_DATE)

	END

	--TAX charge
	IF(@CHARGE_TAX_VALUE <> 0)
	BEGIN
				
		print 'INSIDE  TAX charge      :'+cast(@SelectCol1 as VARCHAR)
		
		print 'Inside TAX'
		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Comments+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,'620049'
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_TAX
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END



	END

	--==========================================CAPITAL GAIN==========================================================
	ELSE IF(@valueRECCode = 'PF')
	BEGIN

	print '@BankCode       :'+cast(@BankCode AS varchar)

	--SET @Currency = @TK_Currency

	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
			,[Comment]
			,[TRX_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,'CAP'
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,'CAP'
           ,'770001'
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1

		END
	
    --01st charge
	IF(@CHARGE_01_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  01st charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  02nd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1)  AS Decimal(18,10))		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE <> 0)
	BEGIN
		
	    print 'INSIDE  03rd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
				
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10)) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  04h charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  05th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  06th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)   AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  07th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  08th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  09th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  10th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
		       ,@Comments
			   ,@TRX_DATE)

	END

	--TAX charge
	IF(@CHARGE_TAX_VALUE <> 0)
	BEGIN
				
		print 'INSIDE  TAX charge      :'+cast(@SelectCol1 as VARCHAR)
		
		print 'Inside TAX'
		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,'620049'
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_TAX
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END


	END

	--==========================================Debit Interest on AC==================================================
	ELSE IF(@valueRECCode = 'SB')
	BEGIN

	SET @Currency = @TK_Currency
	SET @TransactionAmout = @Temp_Value

	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
			,[Comment]
			,[TRX_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'620036'
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1

		END
	

    --01st charge
	IF(@CHARGE_01_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  01st charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  02nd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1)  AS Decimal(18,10))		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE <> 0)
	BEGIN
		
	    print 'INSIDE  03rd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
				
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10)) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  04h charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  05th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  06th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)   AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  07th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  08th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  09th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  10th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
		       ,@Comments
			   ,@TRX_DATE)

	END

	--TAX charge
	IF(@CHARGE_TAX_VALUE <> 0)
	BEGIN
				
		print 'INSIDE  TAX charge      :'+cast(@SelectCol1 as VARCHAR)
		
		print 'Inside TAX'
		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,'620049'
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_TAX
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END


	END

	ELSE IF(@valueRECCode = 'NF')
	BEGIN

	SET @Currency = @TK_Currency
	SET @TransactionAmout = @Temp_Value

	

	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'PROFIT'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'PROFIT'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout +@CHARGE_01_VALUE+@CHARGE_02_VALUE+@CHARGE_03_VALUE+@CHARGE_04_VALUE+@CHARGE_05_VALUE+@CHARGE_06_VALUE+@CHARGE_07_VALUE+@CHARGE_08_VALUE+@CHARGE_09_VALUE+@CHARGE_10_VALUE+@CHARGE_TAX_VALUE)		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
			,[Comment]
			,[TRX_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'770007'
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
	       ,@Comments
		   ,@TRX_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1

		END
	

    --01st charge
	IF(@CHARGE_01_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  01st charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_01_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  02nd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1)  AS Decimal(18,10))		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_02_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_VALUE <> 0)
	BEGIN
		
	    print 'INSIDE  03rd charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
				
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10)) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_03_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--04th charge
	IF(@CHARGE_04_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  04h charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_04_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--05th charge
	IF(@CHARGE_05_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  05th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_05_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--06th charge
	IF(@CHARGE_06_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  06th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1)   AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_06_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END

	--07th charge
	IF(@CHARGE_07_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  07th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1)  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_07_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--08th charge
	IF(@CHARGE_08_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  08th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_08_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)


	END

	--09th charge
	IF(@CHARGE_09_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  09th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_09_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE)


	END

	--10th charge
	IF(@CHARGE_10_VALUE <> 0)
	BEGIN
		
		print 'INSIDE  10th charge      :'+cast(@SelectCol1 as VARCHAR)

		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_FEE_Account(@BankCode,@CHARGE_10_REF)
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
		       ,@Comments
			   ,@TRX_DATE)

	END

	--TAX charge
	IF(@CHARGE_TAX_VALUE <> 0)
	BEGIN
				
		print 'INSIDE  TAX charge      :'+cast(@SelectCol1 as VARCHAR)
		
		print 'Inside TAX'
		SET @RCount = @RCount + 1
						
		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE_TAX = CAST((@CHARGE_TAX_VALUE * -1)  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
		       ,[Comment]
		       ,[TRX_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_TAX_REF)
			   ,'620049'
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_TAX
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
	           ,@Comments
			   ,@TRX_DATE)

	END



	END
	--==========================================MT TRNX===============================================================
	ELSE IF(@valueRECCode = 'MT')
	BEGIN
	print 'INSIDE MT   @SelectCol1   ****************************     :'+Cast(@SelectCol1 AS VARCHAR)

	set @FEE = 'INVEQ'
	SET @Quantity = 0
	SET @IncVal = @IncVal + dbo.RandFn()


	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = ((@TransactionAmout) * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = (@TransactionAmout)		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'220001'+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE
		   ,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1   --DBEW
		--UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID --KBEW
		
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
		END	
		ELSE 		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	END

	--================================================================================================================
	END  -- end bank account check

	END --end in while



	--END TRY
	----================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_BNP]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE_BNP]
AS
BEGIN	
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(255)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,5)
	DECLARE @Price decimal(18,5)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate Date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description1 nvarchar(250)
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(18,5)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE Date
	DECLARE @MTD_DATE Date
	DECLARE @AccID varchar(50)
	DECLARE @FirstCurrency varchar(50)
	DECLARE @TransactionTypeIdentification nvarchar(50)
	DECLARE @BuySellStatus nvarchar(50)
	DECLARE @ReversalIdentification nvarchar(50)
	DECLARE @CurrencyIdentification nvarchar(50)
	DECLARE @ShareIdentification nvarchar(50)
	DECLARE @DebitCreditStatus1 nvarchar(50)
	DECLARE @DebitCreditStatus2 nvarchar(50)
	DECLARE @TEMP_QUANTITY Decimal(18,5)
	DECLARE @AmountTransaction decimal(18,5)
	DECLARE @CPS_Identifier varchar(10)
	DECLARE @REF VARCHAR(50)
	DECLARE @VALUE decimal(18,5)
	DECLARE @FEE varchar(10)
	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,5)
	DECLARE @RCount int
	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,5)
	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,5)
	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,5)
	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,5)
	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,5)
	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,5)
	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,5)
	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,5)
	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,5)
	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,5)
	DECLARE @VALUE_01 Decimal(18,5)
	DECLARE @VALUE_02 Decimal(18,5)
	DECLARE @VALUE_03 Decimal(18,5)
	DECLARE @VALUE_04 Decimal(18,5)
	DECLARE @VALUE_05 Decimal(18,5)
	DECLARE @VALUE_06 Decimal(18,5)
	DECLARE @VALUE_07 Decimal(18,5)
	DECLARE @VALUE_08 Decimal(18,5)
	DECLARE @VALUE_09 Decimal(18,5)
	DECLARE @VALUE_10 Decimal(18,5)	
	--BEGIN TRY
	--================================ Start TRY ====================================
	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50),Currency varchar(50) )  
	INSERT into @table1 (col1,AccID,Currency) select ID,A,N from [dbo].[RAW_DATA_BNP] WHERE Status = 0  order BY convert(varchar ,B, 103) DESC
	SET @RowsToProcess=@@ROWCOUNT
	SET @CurrentRow=0
	WHILE @CurrentRow<@RowsToProcess
	BEGIN
    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@AccID = AccID,@FirstCurrency = Currency FROM @table1 WHERE RowID=@CurrentRow	
	SET @IncVal = @IncVal + dbo.RandFn()
		
		IF((RTrim(dbo.Get_Map_Company_From_Bank_Account(@AccID)) = 'CORYELL') AND @FirstCurrency != ' ')
		BEGIN

		print '@AccID   : '+ CAST(@AccID AS VARCHAR)
		print @FirstCurrency

		  SELECT @Account =  CASE WHEN (A != ' ') THEN CAST(A AS nvarchar) ELSE '_' END
				,@Price =  CASE WHEN (K != ' ') AND (M != ' ') THEN CASE WHEN CAST(M AS Decimal(18,5)) != 0 AND CAST(K AS Decimal(18,5)) != 0 THEN ABS(CAST(M AS Decimal(18,5))/CAST(K AS Decimal(18,5))) ELSE 0 END ELSE 0 END  -- CASE WHEN (K != ' ') AND (M != ' ') THEN CAST(M AS Decimal(18,5))/CAST(K AS Decimal(18,5)) ELSE 0 END
				,@TEMP_QUANTITY = CASE WHEN (K != ' ') THEN CAST(K AS Decimal(18,5)) ELSE 0 END
				,@AmountTransaction = CASE WHEN (M != ' ') THEN CAST(M AS Decimal(18,5)) ELSE 0 END				
				,@TransactionDate = CASE WHEN ( B != ' ') THEN  CONVERT(date, B, 103) ELSE '_' END
				,@TRX_DATE = CASE WHEN ( B != ' ') THEN  CONVERT(date, B, 103)  ELSE '_' END
				,@MTD_DATE = CASE WHEN ( AV != ' ') THEN CONVERT(date, AV, 103)   ELSE '' END
				,@DebitCreditStatus1 = CASE WHEN (BL != ' ') THEN CAST(BL AS nvarchar) ELSE ' ' END
				,@DebitCreditStatus2 = CASE WHEN (BN != ' ') THEN CAST(BN AS nvarchar) ELSE ' ' END
				,@Description1 = CASE WHEN (D != ' ') THEN CAST(D AS NVARCHAR(MAX)) ELSE '_' END
				,@Description2 = CASE WHEN (I != ' ') THEN CAST(I AS NVARCHAR(MAX)) ELSE '_' END
				,@Comments = CASE WHEN (D != ' ') THEN CAST(D AS NVARCHAR(MAX)) ELSE '_' END
				,@valueRECCode = CASE WHEN (D != ' ') THEN D ELSE '_' END      ------------------------------------------------------------> Category Criteria
				,@TransactionTypeIdentification = CASE WHEN (AX != ' ') THEN AX ELSE '_' END       -----------------------------------------> Category Criteria
				,@BuySellStatus = CASE WHEN (C != ' ') THEN C ELSE '_' END       -----------------------------------------> Main Category Criteria
				,@ReversalIdentification = CASE WHEN (P != ' ') THEN P ELSE '_' END
				,@FEE = 'set inside trnx type'
				,@SecurityNumber = CASE WHEN (G != ' ') THEN G ELSE '_' END
				,@CPS_Identifier = CASE WHEN (AK != ' ') THEN LEFT(AK,3) ELSE '_' END -----------------------------------------> CPS/DIV Identifier

				,@CurrencyIdentification = CASE WHEN (N != ' ') THEN CAST(N AS VARCHAR) ELSE '_' END
				,@ShareIdentification =  CASE WHEN (AX != ' ') THEN LEFT(AX,7) ELSE '_' END

				,@CHARGE_01_REF  = 'BRK'
				,@CHARGE_01_VALUE  = CASE WHEN (R != ' ') THEN  CAST(R AS Decimal(18,5)) ELSE 0 END
 
				,@CHARGE_02_REF  = 'TAX'
				,@CHARGE_02_VALUE  = CASE WHEN (T != ' ') THEN CAST(T AS Decimal(18,5)) ELSE 0 END

				,@CHARGE_03_REF  = 'BRK'
				,@CHARGE_03_VALUE  = CASE WHEN (V != ' ') THEN   CAST(V AS Decimal(18,5)) ELSE 0 END

				,@CHARGE_04_REF  = 'TAX'   --- Should COME TAX
				,@CHARGE_04_VALUE  = CASE WHEN (X != ' ') THEN  CAST(X AS Decimal(18,5)) ELSE 0 END

				,@CHARGE_05_REF  = 'STD'   --- Should COME TAX
				,@CHARGE_05_VALUE  =  CASE WHEN (Z != ' ') THEN  CAST(Z AS Decimal(18,5)) ELSE 0 END
				---------------------------------------------------------------------------------------------
				,@CHARGE_06_REF  = 'TAX'
				,@CHARGE_06_VALUE  = CASE WHEN (AB != '') THEN  CAST(AB AS Decimal(18,5)) ELSE 0 END

				,@CHARGE_07_REF  = 'TAX'
				,@CHARGE_07_VALUE  = CASE WHEN (AD != '') THEN  CAST(AD AS Decimal(18,5)) ELSE 0 END

				,@CHARGE_08_REF  = 'TAX'
				,@CHARGE_08_VALUE  = CASE WHEN (AF != '') THEN  CAST(AF AS Decimal(18,5)) ELSE 0 END

				,@CHARGE_09_REF  = 'OTH'
				,@CHARGE_09_VALUE  = CASE WHEN (AH != '') THEN  CAST(AH AS Decimal(18,5)) ELSE 0 END

				,@CHARGE_10_REF  = 'OTH'
				,@CHARGE_10_VALUE  = CASE WHEN (AJ != '') THEN  CAST(AJ AS Decimal(18,5)) ELSE 0 END
	  
			FROM dbo.RAW_DATA_BNP 
			WHERE ID = @SelectCol1

	print '@@@@@CHARGE_02_VALUE =====================> :'+ cast(@CHARGE_02_VALUE as varchar)

    SET @REF =  LEFT(@SecurityNumber,7)  --SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber))
	SET @Currency = @CurrencyIdentification -- dbo.Get_Currency_Code_BNP(@CurrencyIdentification)

	SET @Quantity = CASE WHEN (@TEMP_QUANTITY != 0) THEN  (@TEMP_QUANTITY) ELSE 0 END

	SET @TransactionAmout = @AmountTransaction -- (@Price * @Quantity)
	
	SET @Description = CAST((@Description1 + ' - ' + @Description2) AS NVARCHAR(500)) 
	SET @Comments = CAST((@Description1 + ' - ' + @Description2) AS NVARCHAR(500)) 

	print '@BuySellStatus           :'+CAST((@BuySellStatus + '     AND     ' + @valueRECCode) AS VARCHAR(MAX))

	IF((@BuySellStatus = 'Buy') OR (@BuySellStatus = 'Sell') )
	BEGIN
		
		print '******************************************INVESTMENT***********************************'
		print '@@SecurityNumber  *********************************:'+ cast(@SecurityNumber as varchar)
		print '***************************************************************************************'

		IF(dbo.Get_Investment_Type_BNP(@ShareIdentification) != ' ')---------------------> Equities INVEQ
		BEGIN 

		set @FEE = dbo.Get_Investment_Type_BNP(@ShareIdentification)
		SET @IncVal = @IncVal + dbo.RandFn()


		IF(@BuySellStatus = 'Buy')
		BEGIN		
			SET @TOP = 'BUY'
		END	
		ELSE IF(@BuySellStatus = 'Sell')
		BEGIN
			SET @TOP = 'SELL'
		END	
		
		
	   --MAIN
	   IF(@Account != '_')
	   BEGIN
	
		SET @RCount = 1

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE = @TransactionAmout		
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE =  (@TransactionAmout * -1) 
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE =  (@TransactionAmout * -1) 	 	
		END	

		--=======================================================

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
     VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
           ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE
		   ,@MTD_DATE)

		UPDATE dbo.RAW_DATA_BNP SET status  = 1 WHERE ID = @SelectCol1

		END
	
	   --01st charge
	   IF(@CHARGE_01_VALUE != 0)
	   BEGIN

		SET @RCount = @RCount + 1
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================
				

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --02nd charge
	  IF(@CHARGE_02_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --03rd charge
	  IF(@CHARGE_03_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
				
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --04th charge
	  IF(@CHARGE_04_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================



		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --05th charge
	  IF(@CHARGE_05_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						

						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================




		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --06th charge
	  IF(@CHARGE_06_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --07th charge
	  IF(@CHARGE_07_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --08th charge
	  IF(@CHARGE_08_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --09th charge
	  IF(@CHARGE_09_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --10th charge
	  IF(@CHARGE_10_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
			
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,dbo.Get_Investment_Account_BNP (@ShareIdentification)+@Currency
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	END


	END
	ELSE IF((@BuySellStatus = 'Income') AND (@valueRECCode = 'COUPON - DIVIDEND'))
	BEGIN
		
		print '****************************************COUPON*****************************************'
		print '@@SecurityNumber  *********************************:'+ cast(@SecurityNumber as varchar)
		print '***************************************************************************************'
		
		SET @IncVal = @IncVal + dbo.RandFn()

		SET @TOP = 'PROFIT'
		set @FEE = 'CPN'

		IF(@CPS_Identifier = 'CPS')
		BEGIN

			--MAIN
			IF(@Account != '_')
	        BEGIN
	
			SET @RCount = 1

			--SET @VALUE =  100
			--=======================================================
			IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
			BEGIN		
				SET @VALUE = CAST((@TransactionAmout ) AS DECIMAL(18,5))
			END	
			ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
			BEGIN
				SET @VALUE =  CAST(@TransactionAmout * (-1) AS DECIMAL(18,5))
			END	
			ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
			BEGIN
				SET @VALUE = CAST(@TransactionAmout * (-1) AS DECIMAL(18,5))	
			END	

			--=======================================================
		

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,@FEE
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,@FEE
			   ,'770005'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_BNP SET status  = 1 WHERE ID = @SelectCol1

		END

		END
		ELSE IF(@CPS_Identifier = 'DIV')
		BEGIN
		
		  --MAIN
		  IF(@Account != '_')
	      BEGIN
	
			SET @RCount = 1

			--SET @VALUE =  100
			--=======================================================
			IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
			BEGIN		
				SET @VALUE = CAST((@TransactionAmout ) AS DECIMAL(18,5))
			END	
			ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
			BEGIN
				SET @VALUE =  CAST(@TransactionAmout * (-1) AS DECIMAL(18,5))
			END	
			ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
			BEGIN
				SET @VALUE = CAST(@TransactionAmout * (-1) AS DECIMAL(18,5))	
			END	

			--=======================================================
		

			INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
			VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'DIV'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'DIV'
			   ,'770004'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
			   ,@TRX_DATE
			   ,@MTD_DATE)

			UPDATE dbo.RAW_DATA_BNP SET status  = 1 WHERE ID = @SelectCol1

		END

		END
	
	   --01st charge
	   IF(@CHARGE_01_VALUE != 0)
	   BEGIN

		SET @RCount = @RCount + 1
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================
				

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --02nd charge
	  IF(@CHARGE_02_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --03rd charge
	  IF(@CHARGE_03_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
				
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --04th charge
	  IF(@CHARGE_04_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================



		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --05th charge
	  IF(@CHARGE_05_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						

						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================




		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --06th charge
	  IF(@CHARGE_06_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --07th charge
	  IF(@CHARGE_07_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --08th charge
	  IF(@CHARGE_08_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --09th charge
	  IF(@CHARGE_09_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --10th charge
	  IF(@CHARGE_10_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
			
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END


	END
	ELSE IF((@BuySellStatus = 'Adjustment') AND (@valueRECCode = 'COMMISSIONS'))
	BEGIN
		
		print '****************************************ADJUSTMENT************************************* '
		print '@@SecurityNumber  *********************************:'+ cast(@SecurityNumber as varchar)
		print '***************************************************************************************'

		SET @IncVal = @IncVal + dbo.RandFn()

		SET @TOP = 'PROFIT'
		set @FEE = 'ADJ'

	   --MAIN
	   IF(@Account != '_')
	   BEGIN
	
		SET @RCount = 1

		--SET @VALUE =  100
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE = CAST((@TransactionAmout ) AS DECIMAL(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE =  CAST(@TransactionAmout * (-1) AS DECIMAL(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE = CAST(@TransactionAmout * (-1) AS DECIMAL(18,5))	
		END	

		--=======================================================
		
		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
		VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'620047'
           ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE
		   ,@MTD_DATE)

	
		UPDATE dbo.RAW_DATA_BNP SET status  = 1 WHERE ID = @SelectCol1

		END
	
	   --01st charge
	   IF(@CHARGE_01_VALUE != 0)
	   BEGIN

		SET @RCount = @RCount + 1
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================
				

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --02nd charge
	  IF(@CHARGE_02_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --03rd charge
	  IF(@CHARGE_03_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
				
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --04th charge
	  IF(@CHARGE_04_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================



		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --05th charge
	  IF(@CHARGE_05_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						

						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================




		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --06th charge
	  IF(@CHARGE_06_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --07th charge
	  IF(@CHARGE_07_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --08th charge
	  IF(@CHARGE_08_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --09th charge
	  IF(@CHARGE_09_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --10th charge
	  IF(@CHARGE_10_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
			
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	END
	ELSE IF((@BuySellStatus = 'Fee') AND (@valueRECCode = 'COMMISSIONS'))
	BEGIN
		
		print '****************************************ADJUSTMENT************************************* '
		print '@@SecurityNumber  *********************************:'+ cast(@SecurityNumber as varchar)
		print '***************************************************************************************'

		SET @IncVal = @IncVal + dbo.RandFn()

		SET @TOP = 'PROFIT'
		set @FEE = 'ADJ'

	   --MAIN
	   IF(@Account != '_')
	   BEGIN
	
		SET @RCount = 1

		--SET @VALUE =  100
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE = CAST((@TransactionAmout ) AS DECIMAL(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE =  CAST(@TransactionAmout * (-1) AS DECIMAL(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE = CAST(@TransactionAmout * (-1) AS DECIMAL(18,5))	
		END	

		--=======================================================
		
		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
		VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'620047'
           ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE
		   ,@MTD_DATE)

	
		UPDATE dbo.RAW_DATA_BNP SET status  = 1 WHERE ID = @SelectCol1

		END
	
	   --01st charge
	   IF(@CHARGE_01_VALUE != 0)
	   BEGIN

		SET @RCount = @RCount + 1
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================
				

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --02nd charge
	  IF(@CHARGE_02_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --03rd charge
	  IF(@CHARGE_03_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
				
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --04th charge
	  IF(@CHARGE_04_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================



		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --05th charge
	  IF(@CHARGE_05_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						

						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================




		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --06th charge
	  IF(@CHARGE_06_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --07th charge
	  IF(@CHARGE_07_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --08th charge
	  IF(@CHARGE_08_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --09th charge
	  IF(@CHARGE_09_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --10th charge
	  IF(@CHARGE_10_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
			
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	END
	ELSE IF((@BuySellStatus = 'Withdrawal') AND (@valueRECCode = 'OUTGOING FUNDS'))
	BEGIN
		
		print '****************************************WITHDRAWAL*****************************************'
		print '@@SecurityNumber  *********************************:'+ cast(@SecurityNumber as varchar)
		print '***************************************************************************************'

		print '@@SecurityNumber  *********************************:'+ cast(@Account as varchar)


		SET @IncVal = @IncVal + dbo.RandFn()

		SET @TOP = 'PROFIT'
		set @FEE = ' '

	   --MAIN
	   IF(@Account != '_')
	   BEGIN
	
		SET @RCount = 1

		--SET @VALUE =  100
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE = CAST((@TransactionAmout * (-1) ) AS DECIMAL(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE =  CAST(@TransactionAmout  AS DECIMAL(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE = CAST(@TransactionAmout AS DECIMAL(18,5))	
		END	

		--=======================================================
		
		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE] 
		   ,[MTD_DATE])
		VALUES
           (@TransactionDate
           ,@Description
           ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'800001'
           ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE
		   ,@MTD_DATE)


		UPDATE dbo.RAW_DATA_BNP SET status  = 1 WHERE ID = @SelectCol1

		END
	
	   --01st charge
	   IF(@CHARGE_01_VALUE != 0)
	   BEGIN

		SET @RCount = @RCount + 1
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================
				

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --02nd charge
	  IF(@CHARGE_02_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --03rd charge
	  IF(@CHARGE_03_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
				
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'BRK'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'BRK'
			   ,'620044'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)


	END

	  --04th charge
	  IF(@CHARGE_04_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================



		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --05th charge
	  IF(@CHARGE_05_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						

						
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================




		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'STD'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'STD'
			   ,'620045'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --06th charge
	  IF(@CHARGE_06_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE]
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE
			   ,@MTD_DATE)

	END

	  --07th charge
	  IF(@CHARGE_07_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --08th charge
	  IF(@CHARGE_08_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						
		
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'TAX'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'TAX'
			   ,'620048'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --09th charge
	  IF(@CHARGE_09_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1						

		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END

	  --10th charge
	  IF(@CHARGE_10_VALUE != 0)
	  BEGIN
		
		SET @RCount = @RCount + 1
			
		--=======================================================
		IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 != ' '))
		BEGIN		
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))
		END	
		ELSE IF((@DebitCreditStatus1 != ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))			
		END	
		ELSE IF((@DebitCreditStatus1 = ' ') AND (@DebitCreditStatus2 = ' '))
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE ) AS Decimal(18,5))		
		END	
		--=======================================================


		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE] 
			   ,[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,@Description
			   ,dbo.Get_Bank_Code_BNP(@Account,@Currency)
			   ,'OTH'
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,'OTH'
			   ,'620046'
			   ,dbo.Get_Bank_Account_BNP(@Account,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE 
			   ,@MTD_DATE)


	END



	END
	

	END --end of Bank account 

	END --end in while



	--END TRY
	--================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE]    Script Date: 06/02/2016 09:08:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[GENERATE_GL_RECORDS_FROM_TEXT_FILE]
AS
BEGIN	
	DECLARE @DBEWorKBEW nvarchar(50)
	DECLARE @Account nvarchar(50)
	DECLARE @SecurityNumber nvarchar(50)
	DECLARE @Quantity decimal(18,10)
	DECLARE @MT_Quantity decimal(18,10)
	DECLARE @Price decimal(18,10)
	DECLARE @Currency nvarchar(50)
	DECLARE @TransactionDate date
	DECLARE @Description nvarchar(250) -- need to select transaction record
	DECLARE @Description2 nvarchar(250)
	DECLARE @LinkedNumber nvarchar(150)	
	DECLARE @DebitCreditStatus nvarchar(10)	
	DECLARE @TransactionAmout decimal(25,10)
	DECLARE @ValueRECDesc varchar(50)
	DECLARE @valueRECCode varchar(50)
	DECLARE @BankCode varchar(50)
	DECLARE @TOP varchar(50) 
	DECLARE @Comments nvarchar(250)
	DECLARE @TRX_DATE date
	DECLARE @Reversal_Status varchar(10)
	DECLARE @MTD_DATE Date
	DECLARE @REF int
	DECLARE @VALUE decimal(25,10)
	DECLARE @FEE varchar(10)
	DECLARE @RowsToProcess  int
	DECLARE @CurrentRow     int
	DECLARE @SelectCol1     int
	DECLARE @IncVal decimal(18,10)
	DECLARE @RCount int
	DECLARE @CHK_Account nvarchar(50)
	DECLARE @CHARGE_01_REF varchar(50)
	DECLARE @CHARGE_01_VALUE Decimal(18,10)
	DECLARE @CHARGE_02_REF varchar(50)
	DECLARE @CHARGE_02_VALUE Decimal(18,10)
	DECLARE @CHARGE_03_REF varchar(50)
	DECLARE @CHARGE_03_VALUE Decimal(18,10)
	DECLARE @CHARGE_04_REF varchar(50)
	DECLARE @CHARGE_04_VALUE Decimal(18,10)
	DECLARE @CHARGE_05_REF varchar(50)
	DECLARE @CHARGE_05_VALUE Decimal(18,10)
	DECLARE @CHARGE_06_REF varchar(50)
	DECLARE @CHARGE_06_VALUE Decimal(18,10)
	DECLARE @CHARGE_07_REF varchar(50)
	DECLARE @CHARGE_07_VALUE Decimal(18,10)
	DECLARE @CHARGE_08_REF varchar(50)
	DECLARE @CHARGE_08_VALUE Decimal(18,10)
	DECLARE @CHARGE_09_REF varchar(50)
	DECLARE @CHARGE_09_VALUE Decimal(18,10)
	DECLARE @CHARGE_10_REF varchar(50)
	DECLARE @CHARGE_10_VALUE Decimal(18,10)
	DECLARE @VALUE_01 Decimal(18,10)
	DECLARE @VALUE_02 Decimal(18,10)
	DECLARE @VALUE_03 Decimal(18,10)
	DECLARE @VALUE_04 Decimal(18,10)
	DECLARE @VALUE_05 Decimal(18,10)
	DECLARE @VALUE_06 Decimal(18,10)
	DECLARE @VALUE_07 Decimal(18,10)
	DECLARE @VALUE_08 Decimal(18,10)
	DECLARE @VALUE_09 Decimal(18,10)
	DECLARE @VALUE_10 Decimal(18,10)
	DECLARE @KBEW_ID int	
	DECLARE @K_Column_Validation varchar(50)
	DECLARE @Validation_Account varchar(50)
	--BEGIN TRY
	--================================ Start TRY ====================================
	SET @IncVal = 1
	DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int,AccID varchar(50) )  
	INSERT into @table1 (col1,AccID) select ID,C from [dbo].[RAW_DATA] where A = 'DBEW' AND U != 'A'  AND status = 0  GROUP BY ID,AK,C,Z	 ORDER BY   CAST(Z  AS DATE) ASC
	SET @RowsToProcess=@@ROWCOUNT
	SET @CurrentRow=0
	WHILE @CurrentRow<@RowsToProcess
	BEGIN
    SET @CurrentRow=@CurrentRow+1
    SELECT @SelectCol1 = col1,@CHK_Account = AccID FROM @table1 WHERE RowID=@CurrentRow	
	
	IF((RTrim(dbo.Get_Map_Company_From_Bank_Account(@CHK_Account)) = 'CORYELL'))
	BEGIN
	--==============================================================================
	SET @IncVal = @IncVal + dbo.RandFn()
	--==============================================================================
		SET   @TransactionAmout = 0
		SET   @DebitCreditStatus = ''
		SET   @Reversal_Status  = ''
		SET   @Description = ''
		SET   @Description2 = ''
		SET   @Comments = ''
		SET   @ValueRECDesc = ''
		SET   @valueRECCode = ''
		SET   @BankCode = ''
		SET   @FEE = ''
		SET   @MTD_DATE = ''		
		SET   @CHARGE_01_REF  = ''
		SET   @CHARGE_01_VALUE  = 0 
		SET   @CHARGE_02_REF  = ''
		SET   @CHARGE_02_VALUE  = 0
		SET   @CHARGE_03_REF  = ''
		SET   @CHARGE_03_VALUE  = 0
		SET   @CHARGE_04_REF  = ''
		SET   @CHARGE_04_VALUE  = 0
		SET   @CHARGE_05_REF  = ' '
		SET   @CHARGE_05_VALUE  =  0
		SET   @CHARGE_06_REF  = ''
		SET   @CHARGE_06_VALUE  =  0
		SET   @CHARGE_07_REF  = ''
		SET   @CHARGE_07_VALUE  =  0
		SET   @CHARGE_08_REF  = ''
		SET   @CHARGE_08_VALUE  =  0
		SET   @CHARGE_09_REF  = ''
		SET   @CHARGE_09_VALUE  =  0
		SET   @CHARGE_10_REF  = ''
		SET   @CHARGE_10_VALUE  =  0		
		SET   @KBEW_ID = 00
		SET   @Validation_Account = ''
	--==============================================================================
	SELECT @DBEWorKBEW = A
		  ,@Account = C
		  ,@SecurityNumber = I
		  ,@Quantity = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
		  ,@Price = CASE WHEN (W != ' ') THEN CAST(W  AS Decimal(18,8)) ELSE 0 END
		  ,@Currency = CASE WHEN ( Y != '') THEN CAST(Y  AS nvarchar(50)) ELSE '_' END
		  ,@TransactionDate = CASE WHEN (AA != '00000000') THEN CAST( AA AS DATE) ELSE '' END
		  ,@TRX_DATE =  CASE WHEN (Z != '00000000') THEN CAST(Z  AS DATE) ELSE ''  END 
		  ,@LinkedNumber = AK		  
	FROM dbo.RAW_DATA 
	WHERE ID = @SelectCol1

      SELECT @TransactionAmout = CAST((CASE WHEN @Quantity = 0 THEN 1 ELSE @Quantity END * @Price) AS Decimal(25,10))  -- CAST((@Quantity * @Price) AS Decimal(25,10)) 
			,@DebitCreditStatus = T
			,@Reversal_Status  = U
			,@Description = CASE WHEN (AD != '') THEN CAST(AD AS NVARCHAR(MAX)) ELSE '_' END
			,@Description2 = CASE WHEN (AC != '') THEN CAST(AC AS NVARCHAR(MAX)) ELSE '_' END
			,@Comments = CASE WHEN (AB != '') THEN CAST(AB AS NVARCHAR(MAX)) ELSE '_' END
			,@ValueRECDesc = A
			,@valueRECCode = CASE WHEN (P != '') THEN CAST(P AS NVARCHAR(MAX)) ELSE '_' END 
			,@BankCode = C
			,@FEE = ''
			,@MTD_DATE = '1900-01-01'
			,@K_Column_Validation = CASE WHEN (K != '') THEN CAST(K AS NVARCHAR(5)) ELSE '' END 
			,@MT_Quantity = CASE WHEN (S != ' ') THEN CAST(S AS Decimal(18,8)) ELSE 0 END
		
			,@CHARGE_01_REF  = BF
			,@CHARGE_01_VALUE  = CASE WHEN (BG != '') THEN  CAST(BG AS Decimal(18,10)) ELSE 0 END
 
			,@CHARGE_02_REF  = BH
			,@CHARGE_02_VALUE  = CASE WHEN (BI != '') THEN  CAST(BI AS Decimal(18,10)) ELSE 0 END

			,@CHARGE_03_REF  = BJ
			,@CHARGE_03_VALUE  = CASE WHEN (BK != '') THEN   CAST(BK AS Decimal(18,10)) ELSE 0 END

			,@CHARGE_04_REF  = BL
			,@CHARGE_04_VALUE  =  CASE WHEN (BM != '') THEN  CAST(BM AS Decimal(18,10)) ELSE 0 END

			,@CHARGE_05_REF  = BN
			,@CHARGE_05_VALUE  =  CASE WHEN (BO != '') THEN  CAST(BO AS Decimal(18,10)) ELSE 0 END

			,@CHARGE_06_REF  = BP
			,@CHARGE_06_VALUE  =  CASE WHEN (BQ != '') THEN  CAST(BQ AS Decimal(18,10)) ELSE 0 END

			,@CHARGE_07_REF  = BR
			,@CHARGE_07_VALUE  =  CASE WHEN (BS != '') THEN  CAST(BS AS Decimal(18,10)) ELSE 0 END

			,@CHARGE_08_REF  = BT
			,@CHARGE_08_VALUE  =  CASE WHEN (BU != '') THEN  CAST(BU AS Decimal(18,10)) ELSE 0 END

			,@CHARGE_09_REF  = BV
			,@CHARGE_09_VALUE  =  CASE WHEN (BW != '') THEN  CAST(BW AS Decimal(18,10)) ELSE 0 END

			,@CHARGE_10_REF  = BX
			,@CHARGE_10_VALUE  =  CASE WHEN ([BY] != '') THEN  CAST([BY] AS Decimal(18,10)) ELSE 0 END
		
			,@KBEW_ID = ID

       FROM dbo.RAW_DATA 
	  WHERE (Y = @Currency OR H = @Currency)
	        AND I = @SecurityNumber 
		    AND AK = @LinkedNumber
		    AND A = 'KBEW'
		    AND (P = 'IF' OR P = 'IC' OR P = 'ME' OR P = 'AH'  OR P = 'MN'  OR P = 'MT'  OR P = 'CG'  OR P = 'CI'  OR P = 'AC'  OR P = 'MP'  OR P = 'EG')
		    AND status = 0

	SET @REF =  SUBSTRING(@SecurityNumber, PATINDEX('%[^0]%', @SecurityNumber+'.'), LEN(@SecurityNumber))
	---======================================= INVEQ BLOCK =========================
	
	IF(@valueRECCode = 'IF')
	BEGIN
	print '@@valueRECCode  INSIDE IF        :'+Cast(@valueRECCode AS VARCHAR)

	set @FEE = 'INVEQ'
	SET @IncVal = @IncVal + dbo.RandFn()


	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'220001'+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1   --DBEW
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID --KBEW
		print 'INSIDE IF MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)	
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
		END	
		ELSE 		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	END

	ELSE IF(@valueRECCode = 'IC')
	BEGIN
	print '@@valueRECCode  INSIDE IC       :'+Cast(@valueRECCode AS VARCHAR)

	set @FEE = 'INVEQ'
	SET @IncVal = @IncVal + dbo.RandFn()


	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'220001'+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1   --DBEW
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID --KBEW
		print 'INSIDE IF MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)	
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
		END	
		ELSE 		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	END

	ELSE IF(@valueRECCode = 'ME')
	BEGIN
	print '@@valueRECCode  INSIDE ME        :'+Cast(@valueRECCode AS VARCHAR)

	set @FEE = 'INVEQ'
	SET @IncVal = @IncVal + dbo.RandFn()


	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'220001'+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1   --DBEW
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID --KBEW
		print 'INSIDE IF MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)	
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
		END	
		ELSE 		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	END

	ELSE IF(@valueRECCode = 'AH')
	BEGIN
	print '@@valueRECCode  INSIDE AH        :'+Cast(@valueRECCode AS VARCHAR)

	set @FEE = 'INVEQ'
	SET @IncVal = @IncVal + dbo.RandFn()


	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'220001'+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1   --DBEW
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID --KBEW
		print 'INSIDE IF MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)	
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
		END	
		ELSE 		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	END

	ELSE IF(@valueRECCode = 'MN')
	BEGIN
	print '@@valueRECCode  INSIDE MN        :'+Cast(@valueRECCode AS VARCHAR)

	set @FEE = 'INVEQ'
	SET @IncVal = @IncVal + dbo.RandFn()


	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'220001'+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1   --DBEW
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID --KBEW
		print 'INSIDE IF MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)	
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
		END	
		ELSE 		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,'220001'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	END
	
	--=========================================== INVFN BLOCK ==================================	

    ELSE IF(@valueRECCode = 'CG')
	BEGIN
	print '@@valueRECCode  INSIDE CG        :'+Cast(@valueRECCode AS VARCHAR)

	print 'CG   @Account       :'+CAST(@Account AS VARCHAR)

	set @FEE = 'INVFN'
	SET @IncVal = @IncVal + dbo.RandFn()


	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'220004'+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID
		print 'INSIDE CG MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)
		
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
		END	
		ELSE 		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	END

	ELSE IF(@valueRECCode = 'CI')
	BEGIN 
	print '@@valueRECCode  INSIDE CI        :'+Cast(@valueRECCode AS VARCHAR)

	SET @IncVal = @IncVal + dbo.RandFn()

	set @FEE = 'INVFN'

	--=====================
	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'220004'+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID
		print 'INSIDE CI MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)
		
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE ) AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE )  AS Decimal(18,10))		
		END	
		ELSE	
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 	
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE		
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE)  AS Decimal(18,10))
		END	
		ELSE	
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,'220004'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END


	--=====================

	END

    --=========================================== SHORT TIME INVESTMENT BLOCK ==================
	ELSE IF(@valueRECCode = 'AC')
	BEGIN
	print '@@valueRECCode  INSIDE AC        :'+Cast(@valueRECCode AS VARCHAR)

	SET @IncVal = @IncVal + dbo.RandFn()

	IF(@K_Column_Validation IN ('0','')) --OR (@K_Column_Validation = '            '))
	BEGIN 
		print 'SELECT COLUMN INSIDE AC AND O or NULL    :'+CAST(@SelectCol1 AS VARCHAR)
		set @FEE = 'INVST'
		SET @Validation_Account = '220008'
	END
	ELSE IF(@K_Column_Validation NOT IN ('0','')) --IF((@K_Column_Validation != '0') OR (@K_Column_Validation != '            '))
	BEGIN
		print 'SELECT COLUMN INSIDE AC AND NOT O NOT NULL    :'+CAST(@SelectCol1 AS VARCHAR)
		set @FEE = 'INVEQ'
		SET @Validation_Account = '220001'
	END

	print 'SELECT COLUMN INSIDE AC AND O or NULL   @Validation_Account  :'+CAST(@Validation_Account AS VARCHAR)

	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,@Validation_Account+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1   --DBEW
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID --KBEW
		print 'INSIDE IF MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)	
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
		END	
		ELSE 		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Validation_Account+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	END

	--ELSE IF(@valueRECCode = 'MP')
	--BEGIN
	--print '@@valueRECCode  INSIDE MP        :'+Cast(@valueRECCode AS VARCHAR)

	
	--SET @IncVal = @IncVal + dbo.RandFn()

	--IF(@K_Column_Validation IN ('0','')) --OR (@K_Column_Validation = '            '))
	--BEGIN 
	--	print 'SELECT COLUMN INSIDE MP AND O or NULL    :'+CAST(@SelectCol1 AS VARCHAR)
	--	set @FEE = 'INVST'
	--	SET @Validation_Account = '220008'
	--END
	--ELSE IF(@K_Column_Validation NOT IN ('0','')) --IF((@K_Column_Validation != '0') OR (@K_Column_Validation != '            '))
	--BEGIN
	--	print 'SELECT COLUMN INSIDE MP AND NOT O NOT NULL    :'+CAST(@SelectCol1 AS VARCHAR)
	--	set @FEE = 'INVEQ'
	--	SET @Validation_Account = '220001'
	--END

	
	--print 'SELECT COLUMN INSIDE MP AND O or NULL   @Validation_Account  :'+CAST(@Validation_Account AS VARCHAR)

	--IF(@DebitCreditStatus = 'S')
	--BEGIN		
	--	SET @TOP = 'BUY'
	--END	
	--ELSE IF(@DebitCreditStatus = 'H')		
	--BEGIN
	--	SET @TOP = 'SELL'
	--END	

	----main
	--IF(@Account != '')
	--BEGIN
	
	--	SET @RCount = 1

	--	IF(@DebitCreditStatus = 'S')
	--	BEGIN
	--		SET @VALUE = (@TransactionAmout * -1) 		
	--	END	
	--	ELSE IF(@DebitCreditStatus = 'H')		
	--	BEGIN
	--		SET @VALUE = @TransactionAmout		
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
 --          (DOE
 --          ,[Description]
 --          ,[BNK]
 --          ,[FEE]
 --          ,[PRC]
 --          ,[QTY]
 --          ,[REF]
 --          ,[TOP]
 --          ,[REF_DES]
 --          ,[DebitAccount]
 --          ,[CreditAccount]
 --          ,[Value]
 --          ,[Currency]
 --          ,[REF_ID]
 --          ,[Proirity]
 --          ,[Status]
	--	   ,[Comment]
	--	   ,[TRX_DATE],[MTD_DATE])
 --    VALUES
 --          (@TransactionDate
 --          ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
 --          ,dbo.Get_Bank_Code(@BankCode,@Currency)
 --          ,@FEE
 --          ,@Price
 --          ,@Quantity 
 --          ,@REF
 --          ,@TOP
 --          ,@FEE
 --          ,@Validation_Account+@Currency
 --          ,dbo.Get_Bank_Account(@BankCode,@Currency)
 --          ,@VALUE
 --          ,@Currency
 --          ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
 --          ,@RCount
 --          ,0
	--	   ,@Comments
	--	   ,@TRX_DATE,@MTD_DATE)

	--	UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1   --DBEW
	--	UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID --KBEW
	--	print 'INSIDE IF MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)	
	--	END
	
	----01st charge
	--IF(@CHARGE_01_REF != '')
	--BEGIN

	--	SET @RCount = @RCount + 1

	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
	--	END	
	--	ELSE 
	--	BEGIN
	--		SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_01
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)


	--END

	----02nd charge
	--IF(@CHARGE_02_REF != '')
	--BEGIN
		
	--	SET @RCount = @RCount + 1

	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
	--	END	
	--	ELSE 		
	--	BEGIN
	--		SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_02
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)

	--END

	----03rd charge
	--IF(@CHARGE_03_REF != '')
	--BEGIN
		
	--	SET @RCount = @RCount + 1
				
	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
	--	END	
	--	ELSE 
	--	BEGIN
	--		SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_03
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)


	--END

	----04th charge
	--IF(@CHARGE_04_REF != '')
	--BEGIN
		
	--	SET @RCount = @RCount + 1
						
	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
	--	END	
	--	ELSE
	--	BEGIN
	--		SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_04
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)

	--END

	----05th charge
	--IF(@CHARGE_05_REF != '')
	--BEGIN
		
	--	SET @RCount = @RCount + 1
						
	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
	--	END	
	--	ELSE 
	--	BEGIN
	--		SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_05
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)

	--END

	----06th charge
	--IF(@CHARGE_06_REF != '')
	--BEGIN
		
	--	SET @RCount = @RCount + 1
						
	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
	--	END	
	--	ELSE 
	--	BEGIN
	--		SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_06
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)

	--END

	----07th charge
	--IF(@CHARGE_07_REF != '')
	--BEGIN
		
	--	SET @RCount = @RCount + 1
						
	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
	--	END	
	--	ELSE 
	--	BEGIN
	--		SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_07
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)


	--END

	----08th charge
	--IF(@CHARGE_08_REF != '')
	--BEGIN
		
	--	SET @RCount = @RCount + 1
						
	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
	--	END	
	--	ELSE 	
	--	BEGIN
	--		SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_08
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)


	--END

	----09th charge
	--IF(@CHARGE_09_REF != '')
	--BEGIN
		
	--	SET @RCount = @RCount + 1
						
	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
	--	END	
	--	ELSE
	--	BEGIN
	--		SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_09
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)


	--END

	----10th charge
	--IF(@CHARGE_10_REF != '')
	--BEGIN
		
	--	SET @RCount = @RCount + 1
						
	--	IF(@Reversal_Status = '1')
	--	BEGIN
	--		SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
	--	END	
	--	ELSE 		
	--	BEGIN
	--		SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
	--	END	

	--	INSERT INTO [dbo].[RAWGLARECORDS]
	--		   (DOE
	--		   ,[Description]
	--		   ,[BNK]
	--		   ,[FEE]
	--		   ,[PRC]
	--		   ,[QTY]
	--		   ,[REF]
	--		   ,[TOP]
	--		   ,[REF_DES]
	--		   ,[DebitAccount]
	--		   ,[CreditAccount]
	--		   ,[Value]
	--		   ,[Currency]
	--		   ,[REF_ID]
	--		   ,[Proirity]
	--		   ,[Status]
	--		   ,[Comment]
	--		   ,[TRX_DATE],[MTD_DATE])
	--	 VALUES
	--		   (@TransactionDate
	--		   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
	--		   ,dbo.Get_Bank_Code(@BankCode,@Currency)
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
	--		   ,@Price
	--		   ,@Quantity 
	--		   ,@REF
	--		   ,@TOP
	--		   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
	--		   ,@Validation_Account+@Currency
	--		   ,dbo.Get_Bank_Account(@BankCode,@Currency)
	--		   ,@VALUE_10
	--		   ,@Currency
	--		   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
	--		   ,@RCount
	--		   ,0
	--		   ,@Comments
	--	       ,@TRX_DATE,@MTD_DATE)

	--END

	--END

	ELSE IF(@valueRECCode = 'EG')
	BEGIN
	print '@@valueRECCode  INSIDE EG        :'+Cast(@valueRECCode AS VARCHAR)

	set @FEE = 'INVST'
	SET @IncVal = @IncVal + dbo.RandFn()


	IF(@DebitCreditStatus = 'S')
	BEGIN		
		SET @TOP = 'BUY'
	END	
	ELSE IF(@DebitCreditStatus = 'H')		
	BEGIN
		SET @TOP = 'SELL'
	END	

	--main
	IF(@Account != '')
	BEGIN
	
		SET @RCount = 1

		IF(@DebitCreditStatus = 'S')
		BEGIN
			SET @VALUE = (@TransactionAmout * -1) 		
		END	
		ELSE IF(@DebitCreditStatus = 'H')		
		BEGIN
			SET @VALUE = @TransactionAmout		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
           (DOE
           ,[Description]
           ,[BNK]
           ,[FEE]
           ,[PRC]
           ,[QTY]
           ,[REF]
           ,[TOP]
           ,[REF_DES]
           ,[DebitAccount]
           ,[CreditAccount]
           ,[Value]
           ,[Currency]
           ,[REF_ID]
           ,[Proirity]
           ,[Status]
		   ,[Comment]
		   ,[TRX_DATE],[MTD_DATE])
     VALUES
           (@TransactionDate
           ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
           ,dbo.Get_Bank_Code(@BankCode,@Currency)
           ,@FEE
           ,@Price
           ,@Quantity 
           ,@REF
           ,@TOP
           ,@FEE
           ,'220008'+@Currency
           ,dbo.Get_Bank_Account(@BankCode,@Currency)
           ,@VALUE
           ,@Currency
           ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
           ,@RCount
           ,0
		   ,@Comments
		   ,@TRX_DATE,@MTD_DATE)

		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @SelectCol1   --DBEW
		UPDATE dbo.RAW_DATA SET status  = 1 WHERE ID = @KBEW_ID --KBEW
		print 'INSIDE IF MAIN CLOUSE AFTER UPDATE RAW DATA STATUS @KBEW_ID      :'+CAST(@SelectCol1 AS VARCHAR) +' with_connected '+CAST(@KBEW_ID AS VARCHAR)	
		END
	
	--01st charge
	IF(@CHARGE_01_REF != '')
	BEGIN

		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE) AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_01 = CAST((@CHARGE_01_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_01_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_01
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--02nd charge
	IF(@CHARGE_02_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1

		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE)  AS Decimal(18,10))		
		END	
		ELSE 		
		BEGIN
			SET @VALUE_02 = CAST((@CHARGE_02_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_02_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_02
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--03rd charge
	IF(@CHARGE_03_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
				
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE ) AS Decimal(18,10)) 		
		END	
		ELSE 
		BEGIN
			SET @VALUE_03 = CAST((@CHARGE_03_VALUE * -1 ) AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_03_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_03
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--04th charge
	IF(@CHARGE_04_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE  )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_04 = CAST((@CHARGE_04_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_04_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_04
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--05th charge
	IF(@CHARGE_05_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_05 = CAST((@CHARGE_05_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_05_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_05
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--06th charge
	IF(@CHARGE_06_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_06 = CAST((@CHARGE_06_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_06_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_06
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	--07th charge
	IF(@CHARGE_07_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE )  AS Decimal(18,10))
		END	
		ELSE 
		BEGIN
			SET @VALUE_07 = CAST((@CHARGE_07_VALUE * -1 )  AS Decimal(18,10))		
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_07_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_07
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--08th charge
	IF(@CHARGE_08_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE )  AS Decimal(18,10))
		END	
		ELSE 	
		BEGIN
			SET @VALUE_08 = CAST((@CHARGE_08_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_08_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_08
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--09th charge
	IF(@CHARGE_09_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE )  AS Decimal(18,10))
		END	
		ELSE
		BEGIN
			SET @VALUE_09 = CAST((@CHARGE_09_VALUE * -1 )  AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_09_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_09
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)


	END

	--10th charge
	IF(@CHARGE_10_REF != '')
	BEGIN
		
		SET @RCount = @RCount + 1
						
		IF(@Reversal_Status = '1')
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE  )  AS Decimal(18,10))
		END	
		ELSE 		
		BEGIN
			SET @VALUE_10 = CAST((@CHARGE_10_VALUE * -1 )   AS Decimal(18,10))
		END	

		INSERT INTO [dbo].[RAWGLARECORDS]
			   (DOE
			   ,[Description]
			   ,[BNK]
			   ,[FEE]
			   ,[PRC]
			   ,[QTY]
			   ,[REF]
			   ,[TOP]
			   ,[REF_DES]
			   ,[DebitAccount]
			   ,[CreditAccount]
			   ,[Value]
			   ,[Currency]
			   ,[REF_ID]
			   ,[Proirity]
			   ,[Status]
			   ,[Comment]
			   ,[TRX_DATE],[MTD_DATE])
		 VALUES
			   (@TransactionDate
			   ,CAST((@Description2+' - '+@Description) AS NVARCHAR)
			   ,dbo.Get_Bank_Code(@BankCode,@Currency)
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,@Price
			   ,@Quantity 
			   ,@REF
			   ,@TOP
			   ,dbo.Get_FEE_Value(@BankCode,@CHARGE_10_REF)
			   ,'220008'+@Currency
			   ,dbo.Get_Bank_Account(@BankCode,@Currency)
			   ,@VALUE_10
			   ,@Currency
			   ,CONVERT(NVARCHAR(32),HashBytes('MD5', CAST(GETDATE()+@IncVal AS VARCHAR)),2)
			   ,@RCount
			   ,0
			   ,@Comments
		       ,@TRX_DATE,@MTD_DATE)

	END

	END
	
	--=========================================================================================
	END -- end bank account check

	END --end in while



	--END TRY
	----================================ END TRY ====================================
	--BEGIN CATCH
	--		SELECT
	--			 ERROR_NUMBER() AS ErrorNumber
	--			,ERROR_SEVERITY() AS ErrorSeverity
	--			,ERROR_STATE() AS ErrorState
	--			,ERROR_PROCEDURE() AS ErrorProcedure
	--			,ERROR_LINE() AS ErrorLine
	--			,ERROR_MESSAGE() AS ErrorMessage;


	--END CATCH
END
GO
