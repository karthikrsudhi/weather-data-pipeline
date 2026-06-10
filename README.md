# 🌦️ Real-Time Weather Data Pipeline

## 📖 Project Overview

The Real-Time Weather Data Pipeline is an end-to-end cloud data engineering project that automatically collects live weather data from the OpenWeatherMap API, processes it using AWS serverless services, stores it in Amazon S3, and loads it into Snowflake for analytics.

This project demonstrates modern data engineering concepts including API integration, event-driven architecture, cloud storage, data warehousing, and automated data ingestion.

---

## 🎯 Project Objectives

* Collect real-time weather data from OpenWeatherMap API
* Store weather records in Amazon DynamoDB
* Automate data movement using DynamoDB Streams
* Store processed data in Amazon S3
* Load weather data into Snowflake
* Perform cloud-based analytics using SQL
* Demonstrate an end-to-end AWS data pipeline

---

## 🛠️ Technologies Used

| Technology         | Purpose                    |
| ------------------ | -------------------------- |
| Python             | Application Development    |
| AWS Lambda         | Serverless Data Processing |
| Amazon DynamoDB    | NoSQL Data Storage         |
| DynamoDB Streams   | Event Triggering           |
| Amazon S3          | Data Lake Storage          |
| Snowflake          | Cloud Data Warehouse       |
| OpenWeatherMap API | Weather Data Source        |
| Git & GitHub       | Version Control            |

---

## ☁️ Architecture Flow

```text
OpenWeatherMap API
        ↓
AWS Lambda (Fetch Weather Data)
        ↓
Amazon DynamoDB
        ↓
DynamoDB Streams
        ↓
AWS Lambda (DynamoDB to S3)
        ↓
Amazon S3
        ↓
Snowflake
```

---

## 📂 Project Structure

```text
weather-data-pipeline/
│
├── lambda/
│   ├── lambda_fetch_api.py
│   └── lambda_dynamodb_to_s3.py
│
├── snowflake.sql
├── requirements.txt
├── README.md
├── .gitignore
└── .env
```

---

## 🔄 Project Workflow

### Step 1 – Fetch Weather Data

The first Lambda function retrieves live weather data from OpenWeatherMap API.

Collected Data:

* City Name
* Temperature
* Weather Description
* Timestamp

### Step 2 – Store Data in DynamoDB

Weather records are stored in DynamoDB for fast and scalable storage.

### Step 3 – Trigger DynamoDB Streams

Whenever a new weather record is inserted:

* DynamoDB Streams captures the event
* Automatically triggers the second Lambda function

### Step 4 – Transfer Data to Amazon S3

The second Lambda function:

* Reads DynamoDB stream events
* Converts weather records into JSON
* Uploads files to Amazon S3

### Step 5 – Load Data into Snowflake

Snowflake reads JSON files from S3 and stores them for analytics.

---

## 📄 File Documentation

### 1. lambda_fetch_api.py

**Purpose**

Fetches weather data from OpenWeatherMap API and stores it in DynamoDB.

### 2. lambda_dynamodb_to_s3.py

**Purpose**

Transfers weather data from DynamoDB Streams to Amazon S3.

### 3. snowflake.sql

**Purpose**

Creates Snowflake resources and loads weather data from Amazon S3.

### 4. requirements.txt

**Purpose**

Contains all Python dependencies required by the project.

### 5. .gitignore

**Purpose**

Prevents sensitive files and unnecessary folders from being uploaded to GitHub.

---

## 🔍 Code Usage and Explanation

### lambda_fetch_api.py

#### Import Libraries

```python
import json
import urllib.request
import boto3
from datetime import datetime
```

Purpose:

* json → Parse API responses
* urllib.request → Make API requests
* boto3 → Connect AWS services
* datetime → Generate timestamps

#### Weather API Request

```python
response = urllib.request.urlopen(url)
data = json.loads(response.read())
```

Purpose:

* Retrieves live weather information
* Converts JSON response into Python format

#### DynamoDB Connection

```python
dynamodb = boto3.resource('dynamodb')
```

Purpose:

* Connects AWS Lambda to DynamoDB

#### Store Data

```python
table.put_item(Item=item)
```

Purpose:

* Saves weather records into DynamoDB

---

### lambda_dynamodb_to_s3.py

#### Connect to Amazon S3

```python
s3 = boto3.client('s3')
```

Purpose:

* Connects Lambda to Amazon S3

#### Process Stream Records

```python
for record in event['Records']:
```

Purpose:

* Reads newly inserted DynamoDB records

#### Upload Files to S3

```python
s3.put_object(...)
```

Purpose:

* Stores weather data as JSON files in Amazon S3

---

### snowflake.sql

#### Create Database

```sql
CREATE DATABASE weather_db;
```

Purpose:

* Creates Snowflake database

#### Create Stage

```sql
CREATE OR REPLACE STAGE my_s3_stage;
```

Purpose:

* Connects Snowflake to Amazon S3

#### Create Table

```sql
CREATE TABLE weather_data (
    data VARIANT
);
```

Purpose:

* Stores semi-structured weather data

#### Load Data

```sql
COPY INTO weather_data
FROM @my_s3_stage;
```

Purpose:

* Loads weather files from S3 into Snowflake

---

## 🗄️ Data Schema

| Field       | Description               |
| ----------- | ------------------------- |
| city        | City Name                 |
| temperature | Current Temperature       |
| description | Weather Condition         |
| time        | Data Collection Timestamp |

---

## 📊 Sample Analytics Query

```sql
SELECT
    data:city::STRING AS city,
    data:temperature::FLOAT AS temperature,
    data:description::STRING AS description,
    data:time::TIMESTAMP AS report_time
FROM weather_data;
```

---

## 🔒 Security Features

Sensitive credentials are stored using environment variables.

Example:

```env
OPENWEATHER_API_KEY=your_api_key
AWS_ACCESS_KEY=your_access_key
AWS_SECRET_KEY=your_secret_key
```

The `.env` file is excluded from Git tracking using `.gitignore`.

---

## 🔧 Troubleshooting Guide

### OpenWeatherMap API Error

**Error**

```text
401 Unauthorized
```

**Solution**

* Verify API key
* Check OpenWeatherMap account status

---

### Lambda Function Failure

**Solution**

* Verify IAM permissions
* Check CloudWatch logs
* Validate environment variables

---

### DynamoDB Records Not Appearing

**Solution**

* Verify Lambda execution
* Check DynamoDB table name
* Review CloudWatch logs

---

### S3 Files Not Created

**Solution**

* Ensure DynamoDB Streams is enabled
* Verify stream trigger configuration

---

### Snowflake Data Not Loading

**Solution**

* Verify S3 stage configuration
* Check COPY INTO command
* Confirm JSON files exist in S3

---

## 📈 Future Enhancements

* Snowpipe Auto-Ingest
* Real-Time Streaming Pipeline
* Power BI Dashboard
* Tableau Dashboard
* Weather Forecast Analytics
* AWS Glue Integration

---

## 👨‍💻 Author

**Karthik Sudhi**

Aspiring Data Engineer | AWS | Snowflake | Python | Data Engineering
