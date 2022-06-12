-----------------------------------------------------------------------
-- Generation of dynamic inserts for all the columns of table @Table --
-----------------------------------------------------------------------
DECLARE @Table VARCHAR(max)='MySchema.MyTable'

DECLARE @ColumnsList VARCHAR(max)=''
DECLARE @ColumnsList4Values VARCHAR(max)=''
DECLARE @SQL as VARCHAR(max)=''

SELECT @ColumnsList= STUFF ((
    SELECT ', [' + name + ']'
    FROM syscolumns
    WHERE id = OBJECT_ID(''+@Table+'') AND name <> 'me'
    FOR XML PATH('')), 1, 1, '')
-- print @ColumnsList

SELECT @ColumnsList4Values= STUFF ((
    SELECT ','''''' + ISNULL(TRY_CAST([' + name + '] AS varchar),'''') + '''''' '
    FROM syscolumns
    WHERE id = OBJECT_ID(''+@Table+'') AND name <> 'me'
    FOR XML PATH('')), 1, 1, '')
-- print @ColumnsList4Values

-- Create final SQL query that generates inserts ----------
SELECT @SQL=
        'SELECT ''INSERT INTO ' + @table + ' ('+
        @ColumnsList +
        ') ' +
        'VALUES (' +
        @ColumnsList4Values+
        ')'' Inserts FROM ' + @table 
-- print @SQL

select @SQL Query -- Query2 Insert values
exec (@SQL)
-- END 
-- Explanation: https://www.dataprix.com/es/blog-it/carlos/script-generar-automaticamente-inserts-datos-una-tabla-sql-server