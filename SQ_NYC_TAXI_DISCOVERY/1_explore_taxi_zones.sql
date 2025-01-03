SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'abfss://demo@synsacpro.dfs.core.windows.net/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW=TRUE,
        FIELDTERMINATOR=',',
        ROWTERMINATOR='\n'
    ) AS [result]

exec sp_describe_first_result_set N'SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''abfss://demo@synsacpro.dfs.core.windows.net/taxi_zone.csv'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW=TRUE
        
    ) AS [result]'

SELECT
    max(len(LocationID)) as len_loactionid
FROM
    OPENROWSET(
        BULK 'abfss://demo@synsacpro.dfs.core.windows.net/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW=TRUE,
        FIELDTERMINATOR=',',
        ROWTERMINATOR='\n'
    ) AS [result]


SELECT *
    FROM
    OPENROWSET(
        BULK 'abfss://demo@synsacpro.dfs.core.windows.net/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW=TRUE,
        FIELDTERMINATOR=',',
        ROWTERMINATOR='\n'
    ) WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(50)

    )
    AS [result]


exec sp_describe_first_result_set N'SELECT *
FROM
    OPENROWSET(
        BULK ''abfss://demo@synsacpro.dfs.core.windows.net/taxi_zone.csv'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW=TRUE,
        FIELDTERMINATOR='','',
        ROWTERMINATOR=''\n''
    ) WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(50)

    )
    AS [result]'

    SELECT name,collation_name from sys.databases;

    
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://demo@synsacpro.dfs.core.windows.net/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW=TRUE,
        FIELDTERMINATOR=',',
        ROWTERMINATOR='\n'
    ) WITH(
        LocationID SMALLINT,
        Borough VARCHAR(15) COLLATE Latin1_General_100_CI_AI_SC_UTF8,
        Zone VARCHAR(50) COLLATE Latin1_General_100_CI_AI_SC_UTF8,
        service_zone VARCHAR(50) COLLATE Latin1_General_100_CI_AI_SC_UTF8
    )
    AS [result]

    CREATE DATABASE nyc_taxi_discovery;

    USE nyc_taxi_discovery;

    ALTER DATABASE nyc_taxi_discovery COLLATE Latin1_General_100_CI_AI_SC_UTF8;

    --create external data source

    CREATE EXTERNAL DATA SOURCE  nyc_taxi_data_raw
    WITH(
        location='abfss://nyc-taxi-data@synsacpro.dfs.core.windows.net/raw'
    )
    SELECT *
    FROM
    OPENROWSET(
        BULK 'taxi_zone.csv',
        DATA_SOURCE='nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        ROWTERMINATOR='\n'
    ) WITH(
        LocationID SMALLINT 1,
        Borough VARCHAR(15) 2,
        Zone VARCHAR(50) 3,
        service_zone VARCHAR(50) 4
     )
    AS [result]
    
    SELECT name,location from sys.external_data_sources
