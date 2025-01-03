create schema staging

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'parquet_file_format') 
	CREATE EXTERNAL FILE FORMAT parquet_file_format 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'nyc_taxi_data_src') 
	CREATE EXTERNAL DATA SOURCE [nyc_taxi_data_src] 
	WITH (
		LOCATION = 'abfss://nyc-taxi-data@synsacpro.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE staging.ext_trip_data_green_agg (
	[pu_location_id] int,
	[do_location_id] int,
	[total_trip_count] bigint,
	[total_fare_amount] float
	)
	WITH (
	LOCATION = 'gold/trip_data_green_agg',
	DATA_SOURCE = [nyc_taxi_data_src],
	FILE_FORMAT = parquet_file_format
	)
GO


SELECT TOP 100 * FROM staging.ext_trip_data_green_agg
GO

create schema dwh
go

create table dwh.trip_data_green_agg
WITH
(
	clustered columnstore index,
	DISTRIBUTION = ROUND_ROBIN
) AS select * from staging.ext_trip_data_green_agg
GO

select * from dwh.trip_data_green_agg