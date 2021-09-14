#!/bin/bash

## Update Kapsul model v1.2 -> v1.3

sed -i 's/"systems"/"ibmiSystems"/g' $1

sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonCPUMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonCPUMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonDiskMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonDiskMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonDiskUnitsMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonDiskUnitsMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonJobMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonJobMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonJobQMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonJobQMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonLockedJobsMonitor/capsule\.actors\.monitors\.managed\.centreon\.CentreonLockedJobsMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonMemoryPoolMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonMemoryPoolMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonPing/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonPing/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonProblemsReportMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonProblemsReportMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonSubsystemMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonSubsystemMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonASPMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonASPMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonCommandCallMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonCommandCallMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonMessageQueueMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonMessageQueueMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonDataAreaMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonDataAreaMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonLibrarySizeMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonLibrarySizeMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonJobExecutionTimeMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonJobExecutionTimeMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonObjectsCountMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonObjectsCountMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonSqlQueryMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonSqlQueryMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.centreon\.CentreonCompletedJobStatusMonitor/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonCompletedJobStatusMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.evea\.EveaBackupJobLogsMonitor/capsule\.actors\.monitors\.managed\.ibmi\.specific\.evea\.EveaBackupJobLogsMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.evea\.EveaBackupJobsMonitor/capsule\.actors\.monitors\.managed\.ibmi\.specific\.evea\.EveaBackupJobsMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.evea\.EveaBackupPolicyMonitor/capsule\.actors\.monitors\.managed\.ibmi\.specific\.evea\.EveaBackupPolicyMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.evea\.EveaBackupSummaryMonitor/capsule\.actors\.monitors\.managed\.ibmi\.specific\.evea\.EveaBackupSummaryMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.m3\.CentreonM3ApplicationsMonitor/capsule\.actors\.monitors\.managed\.centreon\.software\.m3\.CentreonM3ApplicationsMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.m3\.CentreonM3JobsMonitor/capsule\.actors\.monitors\.managed\.centreon\.software\.m3\.CentreonM3JobsMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.m3\.CentreonM3MonitorJVMs/capsule\.actors\.monitors\.managed\.centreon\.software\.m3\.CentreonM3MonitorJVMs/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.m3\.CentreonM3MonitorServices/capsule\.actors\.monitors\.managed\.centreon\.software\.m3\.CentreonM3MonitorServices/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.m3\.CentreonM3NodesMonitor/capsule\.actors\.monitors\.managed\.centreon\.software\.m3\.CentreonM3NodesMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.m3\.M3GridApplicationsMonitor/capsule\.actors\.monitors\.managed\.software\.m3\.M3GridApplicationsMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.m3\.M3GridNodesMonitor/capsule\.actors\.monitors\.managed\.software\.m3\.M3GridNodesMonitor/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.m3\.M3InfluxDBJVMData/capsule\.actors\.monitors\.managed\.software\.m3\.M3InfluxDBJVMData/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.m3\.M3Monitors/capsule\.actors\.monitors\.managed\.software\.m3\.M3Monitors/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.quickedh\.CentreonQuickEDHLicence/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonQuickEDHLicence/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.specific\.software\.quickedh\.CentreonQuickEDHStatus/capsule\.actors\.monitors\.managed\.centreon\.ibmi\.CentreonQuickEDHStatus/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prometheus\.SystemStatus/capsule\.actors\.monitors\.managed\.prometheus\.ibmi\.SystemStatus/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prometheus\.LockedJobs/capsule\.actors\.monitors\.managed\.prometheus\.ibmi\.LockedJobs/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prometheus\.SqlMetrics/capsule\.actors\.monitors\.managed\.prometheus\.ibmi\.SqlMetrics/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prometheus\.CommandsCall/capsule\.actors\.monitors\.managed\.prometheus\.ibmi\.CommandsCall/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prometheus\.IFSFileStats/capsule\.actors\.monitors\.managed\.prometheus\.ibmi\.IFSFileStats/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prometheus\.MessageQueueMetrics/capsule\.actors\.monitors\.managed\.prometheus\.ibmi\.MessageQueueMetrics/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prometheus\.CombinedStatus/capsule\.actors\.monitors\.managed\.prometheus\.ibmi\.CombinedStatus/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgSystemStatus/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgSystemStatus/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgMessageQueueStatus/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgMessageQueueStatus/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgSubsystems/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgSubsystems/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgCombined/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgCombined/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgTopLibraries/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgTopLibraries/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgLockedJobs/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgLockedJobs/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgFileRecordsCount/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgFileRecordsCount/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgDataArea/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgDataArea/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgJobExecution/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgJobExecution/g' $1
sed -i 's/capsule\.actors\.monitors\.managed\.prtg\.PrtgJobCompletion/capsule\.actors\.monitors\.managed\.prtg\.ibmi\.PrtgJobCompletion/g' $1
