IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dw].[DimDate]
			  WHERE [date_key] = 0)
BEGIN

    INSERT INTO [dw].[DimDate]
               ([date_key]
               ,[full_date]
               ,[day_number_of_week]
               ,[day_name_of_week]
               ,[day_number_of_month]
               ,[day_number_of_year]
               ,[week_number_of_year]
               ,[month_name]
               ,[month_number_of_year]
               ,[calendar_quarter]
               ,[calendar_year]
               ,[calendar_semester])
         VALUES
               (0
               ,GETDATE()
               ,0
               ,''
               ,0
               ,0
               ,1
               ,''
               ,0
               ,0
               ,0
               ,0);
END
GO