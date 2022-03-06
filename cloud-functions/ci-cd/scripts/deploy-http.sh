#! /bin/bash

gcloud functions deploy la-repo-function-1 --entry-point greetings_http --runtime python38 --trigger-http --allow-unauthenticated 


#args: ['functions','deploy','la-repo-function-1','--trigger-http','--runtime','python37','--entry-point','greetings_http']