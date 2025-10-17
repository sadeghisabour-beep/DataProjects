--select NEWID(),N'جمع دارایی غیر جاری'

--declare @listOfIDs table (id int)
--declare @lid int, @i int
--insert @listOfIDs (id)
--SELECT distinct BudgetItemId
--FROM        BudgetDetails
--WHERE        (FormId = 84) 

--select @lid=count(id) from @listOfIDs
--select @lid
--CLOSE vendor_cursor;  
--DEALLOCATE vendor_cursor; 
DECLARE @vendor_id int, @Stock nvarchar(50),  
    @message varchar(80), @product nvarchar(50);  
  
PRINT '-------- Vendor Products Report --------';  
  
DECLARE vendor_cursor CURSOR FOR   
SELECT DISTINCT Budgets.BudgetId, BudgetItems.Stock
FROM            Budgets INNER JOIN
                         BudgetItems ON Budgets.BudgetId = BudgetItems.BudgetId
WHERE        (Budgets.Year = 1395) AND (BudgetItems.Stock <> 0)
ORDER BY Budgets.BudgetId
  
OPEN vendor_cursor  
  
FETCH NEXT FROM vendor_cursor   
INTO @vendor_id,@Stock
WHILE @@FETCH_STATUS = 0  
BEGIN  

	INSERT        
INTO              BudgetItems(BudgetId, Scenario, Version, Stock, VersionDate, VersionDateShamsi, Enabled, PeriodMonth, PeriodDay)
VALUES        (@vendor_id, N'عملکرد 3 ماهه 1395', 1,@Stock, GETDATE(), N'1395/4/27', 1, 3, 93) 
select @vendor_id,@Stock, N'done'
FETCH NEXT FROM vendor_cursor   
    INTO @vendor_id,@Stock
end

CLOSE vendor_cursor;  
DEALLOCATE vendor_cursor; 