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