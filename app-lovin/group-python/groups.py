from google.oauth2 import service_account
import googleapiclient.discovery

SCOPES = ['https://www.googleapis.com/auth/cloud-identity.groups']
SERVICE_ACCOUNT_FILE = './service-account-file.json'

def create_service():
  credentials = service_account.Credentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE, scopes=SCOPES)
  delegated_credentials = credentials.with_subject('luis@luismendeze.com')

  service_name = 'cloudidentity'
  api_version = 'v1'
  service = googleapiclient.discovery.build(
    service_name,
    api_version,
    credentials=delegated_credentials)

  return service


from urllib.parse import urlencode

def search_google_groups(service, customer_id):
  search_query = urlencode({
          "query": "parent=='customerId/{}' && 'cloudidentity.googleapis.com/groups.discussion_forum' in labels".format(customer_id)
  })
  search_group_request = service.groups().search()
  param = "&" + search_query
  search_group_request.uri += param
  response = search_group_request.execute()

  return response



service= create_service()
print(service)

#response=search_google_groups(service,"C04hqny6x")

#print(response)
