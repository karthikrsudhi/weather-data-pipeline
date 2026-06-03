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