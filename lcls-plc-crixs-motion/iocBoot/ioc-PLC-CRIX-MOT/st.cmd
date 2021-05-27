#!c:/Repos/ads-ioc/R0.4.1///bin/rhel7-x86_64/adsIoc
###### AUTO-GENERATED DO NOT EDIT ##############

< envPaths

epicsEnvSet("ADS_IOC_TOP", "$(TOP)" )

epicsEnvSet("ENGINEER", "tjohnson" )
epicsEnvSet("LOCATION", "PLC:PLC_CRIX_MOT" )
epicsEnvSet("IOCSH_PS1", "$(IOC)> " )
epicsEnvSet("ACF_FILE", "$(ADS_IOC_TOP)/iocBoot/templates/unrestricted.acf")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(ADS_IOC_TOP)/dbd/adsIoc.dbd")
adsIoc_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("ASYN_PORT",        "ASYN_PLC")
epicsEnvSet("IPADDR",           "172.21.140.46")
epicsEnvSet("AMSID",            "172.21.140.46.1.1")
epicsEnvSet("AMS_PORT",         "851")
epicsEnvSet("ADS_MAX_PARAMS",   "10000")
epicsEnvSet("ADS_SAMPLE_MS",    "50")
epicsEnvSet("ADS_MAX_DELAY_MS", "100")
epicsEnvSet("ADS_TIMEOUT_MS",   "1000")
epicsEnvSet("ADS_TIME_SOURCE",  "0")

# adsAsynPortDriverConfigure(portName, ipaddr, amsaddr, amsport,
#    asynParamTableSize, priority, noAutoConnect, defaultSampleTimeMS,
#    maxDelayTimeMS, adsTimeoutMS, defaultTimeSource)
# portName            Asyn port name
# ipAddr              IP address of PLC
# amsaddr             AMS Address of PLC
# amsport             Default AMS port in PLC (851 for first PLC)
# paramTableSize      Maximum parameter/variable count. (1000)
# priority            Asyn priority (0)
# noAutoConnect       Enable auto connect (0=enabled)
# defaultSampleTimeMS Default sample of variable (PLC ams router
#                     checks if variable changed, if changed then add to send buffer) (50ms)
# maxDelayTimeMS      Maximum delay before variable that has changed is sent to client
#                     (Linux). The variable can also be sent sooner if the ams router
#                     send buffer is filled (100ms)
# adsTimeoutMS        Timeout for adslib commands (1000ms)
# defaultTimeSource   Default time stamp source of changed variable (PLC=0):
#                     PLC=0: The PLC time stamp from when the value was
#                         changed is used and set as timestamp in the EPICS record
#                         (if record TSE field is set to -2=enable asyn timestamp).
#                         This is the preferred setting.
#                     EPICS=1: The time stamp will be made when the updated data
#                         arrives in the EPICS client.
adsAsynPortDriverConfigure("$(ASYN_PORT)", "$(IPADDR)", "$(AMSID)", "$(AMS_PORT)", "$(ADS_MAX_PARAMS)", 0, 0, "$(ADS_SAMPLE_MS)", "$(ADS_MAX_DELAY_MS)", "$(ADS_TIMEOUT_MS)", "$(ADS_TIME_SOURCE)")

cd "$(ADS_IOC_TOP)/db"


epicsEnvSet("MOTOR_PORT",     "PLC_ADS")
epicsEnvSet("PREFIX",         "PLC:PLC_CRIX_MOT:")
epicsEnvSet("NUMAXES",        "22")
epicsEnvSet("MOVE_POLL_RATE", "200")
epicsEnvSet("IDLE_POLL_RATE", "1000")

EthercatMCCreateController("$(MOTOR_PORT)", "$(ASYN_PORT)", "$(NUMAXES)", "$(MOVE_POLL_RATE)", "$(IDLE_POLL_RATE)")

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#define ASYN_TRACE_WARNING   0x0020
#define ASYN_TRACE_INFO      0x0040
asynSetTraceMask("$(ASYN_PORT)", -1, 0x41)

#define ASYN_TRACEIO_NODATA 0x0000
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
asynSetTraceIOMask("$(ASYN_PORT)", -1, 2)

#define ASYN_TRACEINFO_TIME 0x0001
#define ASYN_TRACEINFO_PORT 0x0002
#define ASYN_TRACEINFO_SOURCE 0x0004
#define ASYN_TRACEINFO_THREAD 0x0008
asynSetTraceInfoMask("$(ASYN_PORT)", -1, 5)

#define AMPLIFIER_ON_FLAG_CREATE_AXIS  1
#define AMPLIFIER_ON_FLAG_WHEN_HOMING  2
#define AMPLIFIER_ON_FLAG_USING_CNEN   4

epicsEnvSet("AXIS_NO",         "1")
epicsEnvSet("MOTOR_PREFIX",    "CRIX:DPL:MMS:")
epicsEnvSet("MOTOR_NAME",      "X")
epicsEnvSet("DESC",            "Main.stDPXMotor / Axis 1 - Diagnostic Paddle X")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "2")
epicsEnvSet("MOTOR_PREFIX",    "CRIX:DPL:MMS:")
epicsEnvSet("MOTOR_NAME",      "Y")
epicsEnvSet("DESC",            "Main.stDPYMotor / Axis 2 - Diagnostic Paddle Y")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "3")
epicsEnvSet("MOTOR_PREFIX",    "CRIX:DPL:MMS:")
epicsEnvSet("MOTOR_NAME",      "Z")
epicsEnvSet("DESC",            "Main.stDPZMotor / Axis 3 - Diagnostic Paddle Z")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "4")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:4:-:Objectives:X")
epicsEnvSet("DESC",            "Main.stOBJXMotor / Axis 4 - Objectives X")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "5")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:5:-:Objectives:Y")
epicsEnvSet("DESC",            "Main.stOBJYMotor / Axis 5 - Objectives Y")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "6")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:6:-:Objectives:Z")
epicsEnvSet("DESC",            "Main.stOBJZMotor / Axis 6 - Objectives Z")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "7")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:7:-:Point:Detector:Y")
epicsEnvSet("DESC",            "Main.stPDYMotor / Axis 7 - Point Detector Y")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "8")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:8:-:Point:Detector:Rotation")
epicsEnvSet("DESC",            "Main.stPDRotMotor / Axis 8 - Point Detector Rotation")
epicsEnvSet("EGU",             "Degree")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "9")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:9:-:Illumination:X")
epicsEnvSet("DESC",            "Main.stILMXMotor / Axis 9 - Illumination X")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "10")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:10:-:Illumination:Y")
epicsEnvSet("DESC",            "Main.stILMYMotor / Axis 10 - Illumination Y")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "11")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:11:-:Illumination:Z")
epicsEnvSet("DESC",            "Main.stILMZMotor / Axis 11 - Illumination Z")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "12")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:12:-:Questar:X")
epicsEnvSet("DESC",            "Main.stQSTXMotor / Axis 12 - Questar X")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "13")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:13:-:Questar:Y")
epicsEnvSet("DESC",            "Main.stQSTYMotor / Axis 13 - Questar Y")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "16")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:16:-:SDS:Injector:X")
epicsEnvSet("DESC",            "Main.stSDSXMotor / Axis 16 - SDS Injector X")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "17")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:17:-:SDS:Injectory:Y")
epicsEnvSet("DESC",            "Main.stSDSYMotor / Axis 17 - SDS Injectory Y")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "18")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:18:-:SDS:Injector:Z")
epicsEnvSet("DESC",            "Main.stSDSZMotor / Axis 18 - SDS Injector Z")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "19")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:19:-:SDS:Rotation:Y")
epicsEnvSet("DESC",            "Main.stSDSRotMotor / Axis 19 - SDS Rotation Y")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "20")
epicsEnvSet("MOTOR_PREFIX",    "PLC:PLC_CRIX_MOT:")
epicsEnvSet("MOTOR_NAME",      "Axis:20:-:SDS:Shroud:Rotation")
epicsEnvSet("DESC",            "Main.stSDSShroudMotor / Axis 20 - SDS Shroud Rotation")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")


dbLoadRecords("iocSoft.db", "IOC=PLC:PLC_CRIX_MOT")
dbLoadRecords("save_restoreStatus.db", "P=PLC:PLC_CRIX_MOT:")
dbLoadRecords("caPutLog.db", "IOC=${IOC}")

## TwinCat System Databse files ##
dbLoadRecords("TwinCAT_TaskInfo.db", "PORT=ASYN_PLC, PREFIX=PLC:PLC_CRIX_MOT")
dbLoadRecords("TwinCAT_AppInfo.db", "PORT=ASYN_PLC, PREFIX=PLC:PLC_CRIX_MOT")

cd "$(IOC_TOP)"

## Database files ##
< "$(IOC_TOP)/load_plc_databases.cmd"


# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(IOC_TOP)/autosave" )

save_restoreSet_status_prefix( "PLC:PLC_CRIX_MOT:" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "info_positions.sav" )
set_pass1_restoreFile( "info_settings.sav" )

cd "$(IOC_TOP)/autosave"
makeAutosaveFiles()
cd "$(IOC_TOP)"

# Create the archiver file
makeArchiveFromDbInfo("$(IOC_DATA)/$(IOC)/archive/$(IOC).archive", "archive")

# Configure access security: this is required for caPutLog.
asSetFilename("$(ACF_FILE)")

# Initialize the IOC and start processing records
iocInit()

# Enable logging
iocLogInit()

# Configure and start the caPutLogger after iocInit
epicsEnvSet(EPICS_AS_PUT_LOG_PV, "${IOC}:caPutLog:Last")

# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CAPUTLOG_HOST}:${EPICS_CAPUTLOG_PORT}", 0)

# Start autosave backups
create_monitor_set( "info_positions.req", 10, "" )
create_monitor_set( "info_settings.req", 60, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
