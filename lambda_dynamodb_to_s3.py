import json
import boto3

s3 = boto3.client('s3',region_name='ap-south-1')
BUCKET_NAME = "weatherupdate-bucket-karthi"

def lambda_handler(event, context):

    for record in event['Records']:
    new_image = record['dynamodb']['NewImage']

    item = {
    "city": new_image['city']['S'],
    "time": new_image['time']['S'],
    "temperature": new_image['temperature']['S'],
    "description": new_image['description']['S']
}

file_name = f"{item['city']}_{item['time']}.json"

s3.put_object(
    Bucket=BUCKET_NAME,
    Key=file_name,
    Body=json.dumps(item)
)
return {
    "statusCode": 200,
    "body": "Data sent to S3"
}






