# -*- coding: utf-8 -*-
"""
Created on Tue Jul  8 19:50:43 2025

@author: Admin
"""

from kafka import KafkaProducer
import json
import hmac
import hashlib

message ={
    "event":"Alerta roja2",
    "detail":"CPU Sobrecargada"
}

payload = {
    "data": message
}

producer = KafkaProducer(
    bootstrap_servers='localhost:29092',
    value_serializer= lambda v: json.dumps(v).encode('utf-8')
)
producer.send('demo',payload)
producer.flush()