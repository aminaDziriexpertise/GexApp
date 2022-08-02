import json
import requests

api_url = 'http://127.0.0.1:5000'
r = requests.get(url=api_url)
print(r.status_code)
print(r.reason)
print(r.text)
