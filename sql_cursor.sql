-- Cursor example.. reads list of specific records, 
-- creates an insert statement for each record 

DECLARE @RecordId varchar(200)
DECLARE @FullName varchar(200)
DECLARE @CityName varchar(200)

DECLARE db_cursor CURSOR FOR
SELECT pt.RecordId,pt.FullName,at.CityName FROM PersonTable pt
INNER JOIN AddressTable at ON pt.AddressID = at.AddressID

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @RecordId,@FullName,@CityName

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'INSERT INTO TestTable (RecordId,FullName,CityName) VALUES (' + @RecordId + ',''' + @FullName + ''',''' + RTRIM(@CityName) + ''');'
	FETCH NEXT FROM db_cursor INTO @RecordId,@FullName,@CityName
END
CLOSE db_cursor
DEALLOCATE db_cursor