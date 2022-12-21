# First, install the necessary libraries:
#   pip install google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client

# Import the necessary modules
from google.oauth2.credentials import credentials
from googleapiclient.discovery import build

# Set the project ID and service account email
project_id = 'central-tech-gcp-resources'
service_account_email = 'centraltech-gcp-iam-pipeline@central-tech-gcp-resources.iam.gserviceaccount.com'

# Use the service account credentials to authenticate
creds = credentials.from_authorized_user_info({
    'project_id': project_id,
    'client_email': service_account_email,
    'token_uri': 'https://oauth2.googleapis.com/token',
    'private_key': 'my-private-key'
})

# Build the IAM service client
iam_service = build('iam', 'v1', credentials=creds)

# List all users in the project
response = iam_service.projects().serviceAccounts().list(name='projects/' + project_id).execute()
users = response['accounts']

# Print the email addresses of all users
for user in users:
    print(user['email'])