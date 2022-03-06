import os
import uuid

import requests

def test_no_args():
    BASE_URL = os.getenv
    assert BASE_URL is not None

    res = requests.get('{}/hello_http'.format(BASE_URL))
    assert res.text == 'Hello, World!'


def test_args():
    BASE_URL=os.getenv('BASE_URL')
    assert BASE_URL is not None

    name=str(uuid.uuid4())
    res=requests.post(
        '{}/hello_http'.format(BASE_URL),
        json={'name':name}
    )
    assert res.text == 'Hello, {}'.format(name)
    



