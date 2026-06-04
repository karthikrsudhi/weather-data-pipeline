# Weather Data Pipeline

## Project Overview

This project demonstrates an end-to-end weather data pipeline using AWS and Snowflake.

The pipeline fetches real-time weather data from the OpenWeatherMap API, stores it in DynamoDB, transfers it to Amazon S3, and loads it into Snowflake for analysis.

---

## Architecture

OpenWeather API → AWS Lambda → DynamoDB → DynamoDB Streams → AWS Lambda → Amazon S3 → Snowflake

---

## Technologies Used

* Python
* AWS Lambda
* Amazon DynamoDB
* DynamoDB Streams
* Amazon S3
* Snowflake
* OpenWeatherMap API
* Git & GitHub

---

## Project Workflow

### Step 1: Fetch Weather Data

The `lambda_fetch_api.py` function:

* Retrieves weather data from OpenWeatherMap API
* Extracts temperature and weather description
* Stores data in DynamoDB

### Step 2: DynamoDB Stream Trigger

Whenever a new record is inserted into DynamoDB:

* DynamoDB Streams captures the event
* Triggers the second Lambda function

### Step 3: Transfer Data to S3

The `lambda_dynamodb_to_s3.py` function:

* Reads records from DynamoDB Streams
* Converts data into JSON format
* Uploads JSON files to Amazon S3

### Step 4: Load Data into Snowflake

Snowflake:

* Connects to the S3 bucket
* Loads weather data using COPY INTO
* Stores JSON data in a VARIANT column
* Enables analytics using SQL queries

---

## Project Structure

weather-data-pipeline/

├── lambda/

│   ├── lambda_fetch_api.py

│   └── lambda_dynamodb_to_s3.py

├── snowflake.sql

├── requirements.txt

├── .gitignore

└── README.md

---

## Security

Sensitive credentials are not stored in the repository.

Environment variables are used for:

* AWS Access Keys
* AWS Secret Keys
* OpenWeather API Key

The `.env` file is excluded from Git tracking using `.gitignore`.

---

## Sample Analytics Query

```sql
SELECT
    data:city::STRING AS city,
    data:temperature::FLOAT AS temperature,
    data:description::STRING AS description,
    data:time::TIMESTAMP AS report_time
FROM weather_data;
```

---

## Future Improvements

* Automate ingestion using Snowpipe Auto-Ingest
* Create dashboards using Power BI or Tableau
* Add weather forecasting support
* Implement monitoring with CloudWatch

---
