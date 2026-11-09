IF NOT EXISTS(SELECT TOP(1) 1
              FROM dw.DimDate)
 BEGIN
	BEGIN TRAN 
		DECLARE @startdate DATE = '2016-01-01',
				@enddate   DATE = '2019-01-01';
		DECLARE @datelist TABLE(full_date DATE);

	IF @startdate IS NULL
		BEGIN
			SELECT TOP 1 
				   @startdate = full_date
			FROM dw.DimDate 
			ORDER By date_key ASC;
		END

	WHILE (@startdate <= @enddate)
	BEGIN 
		INSERT INTO @datelist(full_date)
		SELECT @startdate

		SET @startdate = DATEADD(dd,1,@startdate);
	END

	 INSERT INTO dw.DimDate(date_key
							,full_date 
							,day_number_of_week 
							,day_name_of_week 
							,day_number_of_month 
							,day_number_of_year 
							,week_number_of_year 
							,month_name 
							,month_number_of_year 
							,calendar_quarter 
							,calendar_year 
							,calendar_semester)

	SELECT date_key           = CONVERT(INT,CONVERT(VARCHAR,dl.full_date,112))
		  ,full_date          = dl.full_date
		  ,day_number_of_week   = DATEPART(dw,dl.full_date)
		  ,day_name_of_week     = DATENAME(WEEKDAY,dl.full_date) 
		  ,day_number_of_month  = DATEPART(d,dl.full_date)
		  ,day_number_of_year   = DATEPART(dy,dl.full_date)
		  ,week_number_of_year  = DATEPART(wk, dl.full_date)
		  ,month_name       = DATENAME(MONTH,dl.full_date) 
		  ,month_number_of_year = MONTH(dl.full_date)
		  ,calendar_quarter   = DATEPART(qq, dl.full_date)
		  ,calendar_year      = YEAR(dl.full_date)
		  ,calendar_semester  = CASE DATEPART(qq, dl.full_date)
										WHEN 1 THEN 1
										WHEN 2 THEN 1
										WHEN 3 THEN 2
										WHEN 4 THEN 2
								  END
		FROM @datelist              dl 
		LEFT OUTER JOIN dw.DimDate dd ON (dl.full_date = dd.full_date)
		WHERE dd.full_date IS NULL;
	COMMIT TRAN
END
GO