from flask import escape

def greetings_http(request):

    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text or any set of values that can be turned into a
        Response object using
        `make_response <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>`.
    """
    request_json = request.get_json(silent=True)    
    request_args=request.args
    if request_json and 'name' in request_json:
        #print('passed second if')
        name= request_json['name']        
    elif request_args and 'name' in request_args:
        name = request_args['name']
    else:
        message='my friend'
    
    return '<h1 style="margin:20px auto;width:800px;">Greetings from Linux Academy, {}!</h1>'.format(name)
