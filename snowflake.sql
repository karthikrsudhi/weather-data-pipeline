CREATE DATABASE weather_db;
USE DATABASE weather_db;

CREATE OR REPLACE FILE FORMAT weather_json
TYPE = 'JSON';

CREATE TABLE weather_data (
    data VARIANT
);

CREATE OR REPLACE STAGE my_s3_stage
URL = 's3://weatherupdate-bucket-karthi/'
FILE_FORMAT = weather_json;

-- Credentials managed securely using environment variables
-- AWS_ACCESS_KEY = os.getenv("AWS_ACCESS_KEY")
-- AWS_SECRET_KEY = os.getenv("AWS_SECRET_KEY")

LIST @my_s3_stage;

COPY INTO weather_data
FROM @my_s3_stage
FILE_FORMAT = (TYPE = 'JSON'); 

SELECT * FROM weather_data;

SELECT * FROM TABLE(INFORMATION_SCHEMA.COPY_HISTORY(
    TABLE_NAME=>'WEATHER_DATA',
    START_TIME=>DATEADD(HOURS,-1,CURRENT_TIMESTAMP())
));

CREATE OR REPLACE PIPE my_pipe
AUTO_INGEST = FALSE
AS
COPY INTO weather_data
FROM @my_s3_stage
FILE_FORMAT = (TYPE = 'JSON');

ALTER PIPE my_pipe REFRESH;

COPY INTO weather_data
FROM @my_s3_stage
FILE_FORMAT = (TYPE = 'JSON')
FORCE = TRUE;
