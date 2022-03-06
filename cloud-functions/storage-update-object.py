import ndjson
import json



from google.cloud import storage

def main():

    # Read the data from Google Cloud Storage
    read_storage_client = storage.Client()

    # Set buckets and filenames
    bucket_name = "all_alerts_7_21"   #I'm  using project: cops-cloudmonus-nonprod-563b in mckesson's gcp
    filename = "sample_json.json"

    # get bucket with name
    bucket = read_storage_client.get_bucket(bucket_name)

    # get bucket data as blob
    blob = bucket.get_blob(filename)

    # convert to string
    json_data_string = blob.download_as_string()
    #print(json_data_string)
    json_data = ndjson.loads(json_data_string)
    #print(json_data)
    #json_data = json.loads(json_data_string)
    list = []
    for item in json_data:
        list.append(item)
        #print(item)
        #print(item['Website'])

    list1 = list[0:len(list)]
    print(list1)


    #removing something
    list_less=[]
    for item in list1:
        if item["Website"]!="Yandex":
            list_less.append(item)




    result = ""
    for item in list_less:
        item2=json.dumps(item)
        result = result + str(item2) + "\n"
    
    #adding something else
    #item={"Website": "Yandex", "URL": "Yandex.com", "ID": 4}
    #item2=json.dumps(item)
    #result = result + str(item2) + "\n"
    
   



    print(result)

    #result_json=json.dumps(result)
    #print(result_json)

    # Write the data to Google Cloud Storage
    """
    write_storage_client = storage.Client()

    write_storage_client.get_bucket(bucket_name) \
        .blob(filename) \
        .upload_from_string(result)
    """


# This is the standard boilerplate that calls the main() function.
if __name__ == '__main__':
    main()