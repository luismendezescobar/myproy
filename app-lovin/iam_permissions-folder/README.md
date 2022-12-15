# IAM Module to apply permissions for all the projects in GCP for peoplefun.com environment.

1)First create a new file in the **files-iam** folder. 
the name of the file must be the same as the **project_id** of the project where you want to apply the permissions with the **.json** extension. 
- Example. If you want to apply IAM permissions in a project with the name **my-project-8412-3623** then the file to be created needs to be named:  **my-project-8412-3623.json**
- If you don't add the .json the file won't be taken into account.
- Also if you specify a file name for a project that doesn't exit , then it won't be taken into account.

2)The next step is to fill out the file with required permissions. There is a template file called **template** in the files-iam folder that you can copy and then modify to your permissions requirements accordingly.
Below is an example on how to fill it out.
### Notes
- It's a Json file, therefore you must pay attention to the commas and signs.
- In the **project_binding** section is where you apply the required roles to the groups, users or service accounts.
- In the **map_to_sa** section you can add a member to a service account to run as the other account, in the example below we area adding 3 members (a user,a group and a service account) to the service account called: my-service-account@prod-project-4617.iam.gserviceaccount.com with the permission of: roles/iam.serviceAccountUser
```sh
{
    "project_bindings": {
        "roles/analyticshub.viewer": [
            "serviceAccount:sa-for-myproject@my-project-8412-3623.iam.gserviceaccount.com",
            "user:test@luismendeze.com"
        ],
        "roles/appengine.appViewer": [
            "group:gcp-devops-group@luismendeze.com"
        ]
    },
    "map_to_sa": [
        {
            "sa":"sa-for-myproject@my-project-8412-3623.iam.gserviceaccount.com",	
            "role": "roles/iam.serviceAccountUser",	
            "members": [	
                    "user:devops-user01@luismendeze.com",
                    "group:gcp-devops-group@luismendeze.com",
                    "serviceAccount:my-service-account@prod-project-4617.iam.gserviceaccount.com"	
                ]	
        }
    ]
}
```
3)Next step is to save, commit and push your changes to your own branch.
4)Next step is to pull request your changes to the develop branch so that the pipeline validates your changes and look for errors.
5)Next step is to pull request your changes to the main branch, the pipeline will kickoff and apply the permissions in the gcp project.
6)Finally validate that the permissions have been applied into the gcp console.
