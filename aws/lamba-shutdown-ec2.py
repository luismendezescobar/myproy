#https://hands-on.cloud/boto3-ec2-tutorial/#h-listing-ec2-instances

import boto3
import logging

#setup simple logging for INFO
logger = logging.getLogger()
logger.setLevel(logging.INFO)

#define the connection
ec2 = boto3.resource('ec2')

def lambda_handler(event, context):
    # Use the filter() method of the instances collection to retrieve
    # all running EC2 instances.
    filters = [
#        {
#            'Name': 'tag.Name',
#            'Values': ['vm']
#        },

        {
            'Name': 'instance-state-name',
            'Values': ['running']
        }
    ]

    #filter the instances
    instances = ec2.instances.filter(Filters=filters)

    #locate all running instances
    RunningInstances = [instance.id for instance in instances]
    print('print all properties')
#    for instance in instances:
#        print(instance.id)
    for instance in instances:
        print("Instance ID:", instance.id)
        print("Instance State:", instance.state['Name'])
        print("tag", instance.tags[1]['Value'])
        if instance.tags[1]['Value']=='':
            RunningInstances.append(instance.id)
    
        # Get the list of attribute names dynamically
        #attribute_names = dir(instance)
        #for attribute_name in attribute_names:
        #    if not attribute_name.startswith('_'):
        #        print(f"Attribute: {attribute_name}")
    
        #print("---")


    print ("print the instances for logging purposes")
    print (RunningInstances)

    #make sure there are actually instances to shut down.
    if len(RunningInstances) > 0:
        #perform the shutdown
        #shuttingDown = ec2.instances.filter(InstanceIds=RunningInstances).stop()
        #print (shuttingDown)
        print("a vm was shutdown")
    else:
        print ("Nothing to see here")