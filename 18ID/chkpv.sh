#!/bin/bash
#
# jma 2019-03
# Check PV activity and save pv value changes to log file
# syntax:
# chkpv -t internal -f filename pvname
# if no filename specified, pvname.log will be used
#
#
PRE_OUTPUT="0"
OUTPUT="1"
INTERVAL=0.05
FILENAME=""
PVNAME=${*: -1:1}

while getopts ":t:f:h" opt; do
    case "$opt" in
        t) INTERVAL=$OPTARG ;;
        f) FILENAME=$OPTARG ;;
        h) echo "Usage: chkpv [OPTION...] [SECTION] PVNAME"
           echo "  -t, input time interval between each check"
           echo "  -f, specify filename for the log file, if not specified, PVNAME.log will be used"
           echo "  -h, help"
           echo "  PVNAME, specify pvname to be checked"
           exit 1
           ;;
    esac
done

if [ "${PVNAME}" == "" ]; then
    echo "No PVNAME input, quit..."
    exit 1
fi

if [ "${FILENAME}" == "" ]; then
    FILENAME="${PVNAME}.log"
fi

echo "Interval: $INTERVAL sec, pvname: $PVNAME, filename: "$FILENAME""
echo "Interval: $INTERVAL sec, pvname: $PVNAME, filename: "$FILENAME"" >> "${FILENAME}"

while true
do
    # direct caget to OUTPUT
    OUTPUT="$(caget "${PVNAME}" 2>&1)"
    # compare with old output
    if [ "${OUTPUT}" != "${PRE_OUTPUT}" ]; then
        echo "[$(date)] ${OUTPUT}"
        echo "[$(date)] ${OUTPUT}" >> "${FILENAME}"
        PRE_OUTPUT=${OUTPUT}
    fi
    sleep ${INTERVAL}
done

