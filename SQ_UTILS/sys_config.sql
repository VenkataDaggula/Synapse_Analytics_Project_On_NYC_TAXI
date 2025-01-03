select * from sys.dm_external_data_processed

select * from sys.configurations
where name like 'data Processed %'

sp_set_data_processed_limit
    @type=N'monthly',
    @limit_tb=2;
sp_set_data_processed_limit
    @type=N'weekly',
    @limit_tb=1;
sp_set_data_processed_limit
    @type=N'daily',
    @limit_tb=1;