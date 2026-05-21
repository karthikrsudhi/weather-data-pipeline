import json
import boto3

s3 = boto3.client('s3',region_name='ap-south-1')
BUCKET_NAME = "weatherupdate-bucket-karthi"