#!/usr/bin/env python
from locust import User, task, between, HttpUser
from datetime import datetime

class MyUser(HttpUser):
    wait_time = between(1,2)
    host = 'https://pt-api.peoplefungames-dev.com'
    @task
    def my_task(self):
        headers = {'Content-Type': 'application/json'}
        data = {
                "deviceIds": {
                    "androidId": "12345-678901-23456-78901",
                    "installId": "23456-232342-32423-23423"
                },
                "deviceDetails":{
                    "appVersion": "1.0.0-beta123",
                    "appPlatform":"android",
                    "osVersion":"1.0.0",
                    "deviceModel":"SGS22"
                },
                "createAccount": "IF_NOT_EXISTS",
                "appId": "testappid"
                }
        with self.client.post('/identity/v1/device/login', json=data, headers=headers,name='Identity',catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            else:                
                response.failure('failed')           #this will log the error in the locust console

