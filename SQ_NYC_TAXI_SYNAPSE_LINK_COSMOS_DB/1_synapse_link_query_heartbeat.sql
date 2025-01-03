IF (NOT EXISTS(SELECT * FROM sys.credentials WHERE name = 'cosmos-syn'))

    CREATE CREDENTIAL [cosmos-syn]
    WITH IDENTITY = 'SHARED ACCESS SIGNATURE', SECRET = 'Cwjnr9GyIN8UcBi9VPviP7p5u6mD8NQq0BUSeKgh55rJeGdpDQIWqC9h3zPW5uppAiS8lUNpen5zACDbNJwNjw=='
GO

SELECT TOP 100 *
FROM OPENROWSET(​PROVIDER = 'CosmosDB',
                CONNECTION = 'Account=cosmos-syn;Database=nyctaxidb',
                OBJECT = 'Heartbeat',
                SERVER_CREDENTIAL = 'cosmos-syn'
) AS [Heartbeat]
