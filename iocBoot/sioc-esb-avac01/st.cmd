#!../../bin/linux-x86_64/aVac

epicsEnvSet( "STREAM_PROTOCOL_PATH","../../aVacApp/Db:.")

< envPaths

cd ${TOP}

dbLoadDatabase "dbd/aVac.dbd"
aVac_registerRecordDeviceDriver pdbbase

epicsEnvSet("N",         "01")
epicsEnvSet("P",         "ESB:AVAC$(N)")
epicsEnvSet("PROTOFILE", "aVac.proto")
epicsEnvSet("LOC",       "B062-08-13R")
epicsEnvSet("DELAY0",    "0.0")
epicsEnvSet("DELAY1",    "0.0")

save_restoreSet_status_prefix( "")
save_restoreSet_IncompleteSetsOk( 1)
save_restoreSet_DatedBackupFiles( 1)
set_savefile_path( "/nfs/slac/g/testfac/esb/$(IOC)","autosave")
set_pass0_restoreFile( "aVac.sav")
set_pass1_restoreFile( "aVac.sav")

drvAsynIPPortConfigure ("L0","ts-esb-02:2001",0,0,0)

#asynSetTraceMask("L0",-1,0x9)
#asynSetTraceIOMask("L0",-1,0x6)

dbLoadRecords("db/aVac$(N).db","IOC=$(IOC),P=$(P),PROTOFILE=$(PROTOFILE),LOC=$(LOC),DELAY0=$(DELAY0),DELAY1=$(DELAY1),PORT=L0")
dbLoadRecords("db/asynRecord.db","P=$(P):,R=asyn,PORT=L0,ADDR=0,OMAX=0,IMAX=0")

cd ${TOP}/iocBoot/${IOC}
iocInit()

create_monitor_set( "aVac.req",30,"P=$(P)")

