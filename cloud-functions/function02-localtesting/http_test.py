from unittest.mock import Mock

import main

def test_print_name():
    name = 'test'
    data={'message':name}
    req=Mock(get_json=Mock(return_value=data), args=data)

    assert main.hello_http(req) == 'Greetings from Linux Academy, {}!'.format(name)


def test_print_hello_world():
    data={}
    req=Mock(get_json=Mock(return_value=data),args=data)

    #Call tested function
    assert main.hello_http(req) =='Greetings from Linux Academy, everyone!'


