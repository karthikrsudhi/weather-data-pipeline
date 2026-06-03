CREATE DATABASE weather_db;
USE DATABASE weather_db;

CREATE OR REPLACE FILE FORMAT weather_json
TYPE = 'JSON';

CREATE TABLE weather_data (
    data VARIANT
);