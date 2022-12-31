#!/bin/bash
#************************************************************************************************************************************
# Company    : Epam 
# Created by : Luis Mendez
# Desciption : Script to fetch info from all the project.
# Info       : Project Name,Project ID,BAP,Environment,Project Owner EID,Project Owner Email,Technical owner EID,Technical owner Email,Project Creation Date,Atos_Onboarding,Atos_Onboarding_Date,Project_Country,GCE Used?,GAE Used?,Dataproc,Dataflow,kafka,GKE,Cloud SQL,Cloud Function,PubSub,Cloud Storage,BigQuery,Cloud Run.
#************************************************************************************************************************************
echo "**************************"
version=8
echo "Version :"$version

WORKINGDIR=$(pwd)
MISCDIR=$WORKINGDIR/Fetch_Summary
GITHUBDIR=$WORKINGDIR/core-gcp-env


if [[ $2 != "" ]] ; then
	VARAGV=$2	
else
	VARAGV=$(date | awk '{print $2"_"$3"_"$4}')
fi

FILEAGV=$1


SumFile="Summary_"$VARAGV".csv"
OUTPUTCSVHOST="Host_Info_"$VARAGV".csv"
echo "OutputFile : "$SumFile
echo "Host File : "$OUTPUTCSVHOST
echo "**************************"

download_git () {
rm -rf $GITHUBDIR
git clone git@github.com:mckesson/core-gcp-env.git
}

SummaryStart () {
	if [ ! -d $MISCDIR ]; then					# Log Folder Check
		mkdir $MISCDIR
	fi
echo "Project Name,Project ID,BAP,Environment,Project Owner EID,Project Owner Email,Technical owner EID,Technical owner Email,Project Creation Date,Atos_Onboarding,Atos_Onboarding_Date,Project_Country,GCE Used?,GAE Used?,Dataproc,Dataflow,kafka,GKE,Cloud SQL,Cloud Function,PubSub,Cloud Storage,BigQuery,Cloud Run" > $SumFile
GAEInfo="N/A"
GCEInfo="N/A"
POWNER="XXXX"
TOWNER="YYYY"




echo "Project ID,name,status,zone,internal_ip,external_ip,bap_number(if any)" > $OUTPUTCSVHOST
}


	GCPService () {								# Collects information on which API service is enable
		gcloud services list --project=$Project --format="csv[no-heading](NAME)" > $MISCDIR/"GCPService"
	}

Summary () {
	#GAE
		if [[ $(grep -i "appengine.googleapis.com" $MISCDIR/"GCPService" ) == "appengine.googleapis.com" ]] || [[ $(grep -i "appengineflex.googleapis.com" $MISCDIR/"GCPService" ) == "appengineflex.googleapis.com" ]] ; then
			echo "appengine"
			gcloud app services list --format="csv[no-heading](SERVICE)" --project=$Project > $MISCDIR/"AppInfo" 
			cat $MISCDIR/"AppInfo"
			if [[ $(cat $MISCDIR/"AppInfo" | head -1 )  == "" ]]; then
					GAEInfo="N"
			else
					GAEInfo="Y"
			fi
		else
		GAEInfo="N"
		fi
		

		
	#GCE
		dataproc=0
		dataflow=0
		kafka=0
		gke=0
#        GCPComputeService=$(gcloud services list --format="value(NAME)" --project=$Project --filter="NAME:compute.googleapis.com")
#        if [[ $GCPComputeService == "compute.googleapis.com" ]] ; then
				gcloud compute instances list --project=$Project --format="csv[no-heading](NAME,STATUS,ZONE,MACHINE_TYPE,INTERNAL_IP,EXTERNAL_IP,creationTimestamp)" > $MISCDIR/"Temp.Temp"
                        if [[ $(cat $MISCDIR/"Temp.Temp" | head -1 ) != "" ]] ; then
                                count=$(cat $MISCDIR/"Temp.Temp" | grep -v TERMINATED | wc -l )
								dataproc=$(cat $MISCDIR/"Temp.Temp" | grep -v TERMINATED | grep dataproc | wc -l )
								dataflow=$(cat $MISCDIR/"Temp.Temp" | grep -v TERMINATED | grep dataflow | wc -l )
								kafka=$(cat $MISCDIR/"Temp.Temp" | grep -v TERMINATED | grep kafka | wc -l )
								gke=$(cat $MISCDIR/"Temp.Temp" | grep -v TERMINATED | grep gke | wc -l )
                                GCEInfo=$count
#								for i in $(cat $MISCDIR/"Temp.Temp");
#								do
#									echo "$Project,$i" >> $OUTPUTCSVHOST
#								done
                         else
                                GCEInfo="0"
#								echo "$Project,N/A" >> $OUTPUTCSVHOST
                        fi
#        else
#                        GCEInfo="N"
#                fi
#       fi
	
	#SQL
	if [[ $(grep -i "sqladmin.googleapis.com" $MISCDIR/"GCPService" ) == "sqladmin.googleapis.com" ]] || [[ $(grep -i "sql-component.googleapis.com" $MISCDIR/"GCPService" ) == "sql-component.googleapis.com" ]]; then
		echo "SQL"
		gcloud sql instances list --project=$Project --format="csv[no-heading](NAME,DATABASE_VERSION,LOCATTION,TIER)" > $MISCDIR/"CSQLinfo"
			cat $MISCDIR/"CSQLinfo"
			if [[ $(cat $MISCDIR/"CSQLinfo" | head -1 )  == "" ]]; then
				CSQLinfo="N"
			else
				CSQLinfo="Y"
		fi
	else
		CSQLinfo="N"
	fi
	
	#Function
	if [[ $(grep -i "cloudfunctions.googleapis.com" $MISCDIR/"GCPService" ) == "cloudfunctions.googleapis.com" ]] ; then
			echo "cloudfunctions"
		gcloud functions list --project=$Project --format="csv[no-heading](NAME,STATUS)" > $MISCDIR/"Cfunction"
		cat $MISCDIR/"Cfunction"
			if [[ $(cat $MISCDIR/"Cfunction" | head -1 )  == "" ]]; then
				Cfunction="N"
			else
				Cfunction="Y"
			fi
	else
		Cfunction="N"
	fi
	
	#PubSub
	if [[ $(grep -i "pubsub.googleapis.com" $MISCDIR/"GCPService" ) == "pubsub.googleapis.com" ]] ; then
	echo "pubsub"
		gcloud pubsub topics list --project=$Project --format="csv[no-heading](name)" > $MISCDIR/"Cpubsub"
		cat $MISCDIR/"Cpubsub"
			if [[ $(cat $MISCDIR/"Cpubsub" | head -1 )  == "" ]]; then
				Cpubsub="N"
			else
				Cpubsub="Y"
			fi
	else
		Cpubsub="N"
	fi
	
	#CloudStorage
	if [[ $(grep -i "storage-component.googleapis.com" $MISCDIR/"GCPService" ) == "storage-component.googleapis.com" ]] ; then
		echo "Storage"
		gsutil ls -p $Project > $MISCDIR/"Cstorageinfo"
			cat $MISCDIR/"Cstorageinfo"
		if [[ $(cat $MISCDIR/"Cstorageinfo" | head -1 )  == "" ]]; then
			Cstorageinfo="N"
		else
			Cstorageinfo="Y"
		fi
	else
		Cstorageinfo="N"
	fi
	
	#BigQuery
	if [[ $(grep -i "bigquery.googleapis.com" $MISCDIR/"GCPService" ) == "bigquery.googleapis.com" ]] ; then
			echo "bigquery"
		bq ls --project_id $Project > $MISCDIR/"BigQuery"
		cat $MISCDIR/"BigQuery"
		if [[ $(cat $MISCDIR/"BigQuery" | head -1 )  == "" ]]; then
			BigQuery="N"
		else
			BigQuery="Y"
		fi
	else
		BigQuery="N"
	fi
		
	#CloudRun
	if [[ $(grep -i "run.googleapis.com" $MISCDIR/"GCPService" ) == "run.googleapis.com" ]] ; then
			echo "run"
		gcloud run services list --platform managed --project=$Project --format="csv[no-heading](SERVICE,REGION,URL)" > $MISCDIR/"CRun"
			cat $MISCDIR/"CRun"
		if [[ $(cat $MISCDIR/"CRun" | head -1 )  == "" ]]; then
			CRun="N"
		else
			CRun="Y"
		fi
	else
		CRun="N"
	fi
	
	#END

        ABC=$(gcloud projects describe $Project --format="csv[no-heading](name,projectId,labels.bap-number,labels.env,labels.project-owner,labels.tech-owner,createTime)")
		ABC2=$(gcloud projects describe $Project --format="csv[no-heading](labels.atos_onboarding,labels.atos_onboarding_date,labels.country)")
		#,labels.atos_onboarding,labels.atos_onboarding_date,labels.county
		peid=$(echo $ABC | awk -F, '{print $5}')
		teid=$(echo $ABC | awk -F, '{print $6}')
	 
        ABC1=$(echo $ABC | awk -F, '{print $1","$2","$3","$4}')
        Project_name=$(echo $Project | awk -F- '{print $1"-"$2"-"$3}')
        POWNER=$peid
        TOWNER=$teid
		#A_Onboarding=""
		#Country=""
        if [[ $(cat $GITHUBDIR/$Project_name | head -1 ) != "" ]] ; then
                POWNER=$(grep owner_email $GITHUBDIR/$Project_name | awk -F'"' '{print $2}')
                TOWNER=$(grep tech_email $GITHUBDIR/$Project_name | awk -F'"' '{print $2}')
				#A_Onboarding=$(grep -E -o "non_prod|completed|non_iaas|mckesson_internal" $GITHUBDIR/$Project_name)
				#Country=$(grep country | tr ',' '\n' | grep country | awk -F\" '{print $(NF-1)}' $GITHUBDIR/$Project_name)
        else
                POWNER=$(echo $ABC | awk -F, '{print $5"_No_Env_File"}')
                TOWNER=$(echo $ABC | awk -F, '{print $6"_No_Env_File"}')
				#A_Onboarding="No_Env_File"
				#Country="No_Env_File"
				
        fi



        CABC=$(echo $ABC | awk -F, '{print $NF}' | awk -FT '{print $1}' )
		#BigQuery,Cloud Run"
        echo "$ABC1,$peid,$POWNER,$teid,$TOWNER,$CABC,$ABC2,$GCEInfo,$GAEInfo,$dataproc,$dataflow,$kafka,$gke,$CSQLinfo,$Cfunction,$Cpubsub,$Cstorageinfo,$BigQuery,$CRun" >> $SumFile
        echo "$FileLen : $Project : Service************************************* : $ABC2,$GCEInfo,$GAEInfo,$dataproc,$dataflow,$kafka,$gke,$CSQLinfo,$Cfunction,$Cpubsub,$Cstorageinfo,$BigQuery,$CRun : END"
}


main () {
		echo $version
		if [[ $FILEAGV != "" ]] ; then
			cat $FILEAGV > GcpProjectID.txt		
		else
			gcloud projects list --format="csv[no-heading](PROJECT_ID)" > GcpProjectID.txt
		fi
		
        download_git
        SummaryStart
		
        FileLen=$(cat GcpProjectID.txt | wc -l)
        for Project in $(cat GcpProjectID.txt)
        do
                #echo "Remaining Project : $FileLen : $Project "
				echo "$FileLen : $Project : START"
				GCPService
                Summary
                ((FileLen=FileLen-1))
        done
        echo "***********************************************"
        cat Summary.csv
        echo "File Name : Summary.csv"
        echo "***********************************************"
		rm -rf $MISCDIR
        rm AppInfo
        rm Temp.Temp
        rm GcpProjectID.txt
        rm -rf $GITHUBDIR
        #************************************************************************************************************************************
}

#************************************************************************************************************************************
main $1
#************************************************************************************************************************************
