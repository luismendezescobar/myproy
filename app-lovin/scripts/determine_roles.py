import google.auth
from google.auth.transport.requests import Request
from google.cloud import iam

# Set the project ID
project_id = "blocks-2"

# Create a client for the IAM service
client = iam.Client()

# Define the list of permissions
permissions = ["appengine.services.list"]

# Iterate through the permissions and display the roles that have them
for permission in permissions:
    roles = client.list_roles(permissions_filter=permission, parent=f"projects/{project_id}")
    print(f"The role(s) that have the permission {permission} are:")
    for role in roles:
        print(role.name)
