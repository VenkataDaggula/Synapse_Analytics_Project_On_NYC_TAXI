IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'trip_data_green_agg_copy' AND O.TYPE = 'U' AND S.NAME = 'dwh')
CREATE TABLE dwh.trip_data_green_agg_copy
	(
	 [pu_location_id] int,
	 [do_location_id] int,
	 [total_trip_count] bigint,
	 [total_fare_amount] float
	)
WITH
	(
	DISTRIBUTION = ROUND_ROBIN,
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO


COPY INTO dwh.trip_data_green_agg_copy
FROM 'https://synsacpro.dfs.core.windows.net/nyc-taxi-data/gold/trip_data_green_agg'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
	,COMPRESSION = 'snappy'
)

GO

SELECT TOP 100 * FROM dwh.trip_data_green_agg_copy
GO