#!/usr/bin/env python3.8
#import flask
import argparse

def greetings_http(request,name=""):
    #request_json = request.get_json(silent=True)
    request_json= ""
    request_args = ""
    if request_json and 'name' in request_json:
        name = request_json['name']
    elif name:
        name = name
    else:
        name = 'my friend'
    #return '<h1 style="margin:20px auto;width:800px;">Greetings from Linux Academy, {}!</h1>'.format(escape(name))
    return 'Greetings from Linux Academy, {}'.format(name)






def main():    
    parser=argparse.ArgumentParser(description='simple parameter example')
    parser.add_argument('any_url',help='any url that you want to provide')    
    parser.add_argument('-name',default='',help='any name that you want to provide')    

    args=parser.parse_args()   
    if args.any_url == None:
            print("Error: neither request nor word was provided")
            sys.exit(1)
    else:          
       print(greetings_http(args.any_url,args.name))
    



if __name__ == '__main__':
    main()
