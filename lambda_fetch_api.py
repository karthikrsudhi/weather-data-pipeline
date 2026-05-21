import json
import urllib.request
import boto3
from datetime import datetime  

def lambda_handler(event, context):

api_key = "YOUR_API_KEY"
city = "Kochi"   

url = f"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&units=metric"

response = urllib.request.urlopen(url)
data = json.loads(response.read())  

print(data)  

if "main" not in data:
    return {
        "statusCode": 400,
        "body": json.dumps(data)
    }

dynamodb = boto3.resource('dynamodb',region_name='ap-south-1')
table = dynamodb.Table('weather_table')

item = {
    "city": city,
    "time": datetime.now().isoformat(),
    "temperature": str(data["main"]["temp"]),
    "description": data["weather"][0]["description"]
}  

table.put_item(Item=item)